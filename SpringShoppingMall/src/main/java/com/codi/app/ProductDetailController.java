package com.codi.app;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.codi.dao.ProductDetailDAO;
import com.codi.dao.ReviewDAO;
import com.codi.dto.ProductDetailDTO;
import com.codi.dto.ReviewDTO;
import com.codi.util.MyUtil;

@Controller
public class ProductDetailController {

	@Autowired
	@Qualifier("productDetailDAO")//Bean 객체 생성 
	ProductDetailDAO dao;
	
	@Autowired
	@Qualifier("reviewDAO")
	ReviewDAO reviewDAO;
	
	@Autowired
	MyUtil myUtil;//Bean 객체 생성
	
	@RequestMapping(value = "/pr/detail.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String detail(String superProduct, HttpServletRequest request, HttpServletResponse response) {
		String cp = request.getContextPath();
		ProductDetailDTO dto = dao.getReadData(superProduct);
		List<String> colorList = dao.getColorList(dto.getSuperProduct());
		List<String> sizeList = dao.getProductSizeList(dto.getSuperProduct());
		
		// 이미지파일경로
		String imagePath = cp + "/upload/list";
		request.setAttribute("imagePath", imagePath);
		String detailImagePath = cp + "/upload/productDetail";
		request.setAttribute("detailImagePath", detailImagePath);
		
		
		List<ProductDetailDTO> detailImagelists = dao.getDetailImageList(superProduct);
		
		String order = request.getParameter("order");	
		
		if(order==null)
			order="recent";		

		int dataCount_yes = reviewDAO.getProductDataCount(superProduct);
		
		request.setAttribute("dataCount_yes", dataCount_yes);
		request.setAttribute("detailImagelists", detailImagelists);
		request.setAttribute("dto", dto);
		request.setAttribute("order", order);
		request.setAttribute("superProduct", superProduct);
		request.setAttribute("colorList", colorList);
		request.setAttribute("sizeList", sizeList);
		
		return "product/detail";
	}
	
	@RequestMapping(value = "/pr/detailReview.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String detailReview(HttpServletRequest request, HttpServletResponse response) {
		
		String cp = request.getContextPath();
		String superProduct = request.getParameter("superProduct");
		ProductDetailDTO dto = dao.getReadData(superProduct);
		
		String order = request.getParameter("order");	
		
		if(order==null)
			order="recent";
		
		String orderBy;
		if(order.equals("recent"))
			orderBy = "reviewDate desc";
		else if(order.equals("worst"))
			orderBy = "rate";
		else
			orderBy = "rate desc";
		
		// 이미지파일경로
		String imagePath = cp + "/pds/productImageFile";
		request.setAttribute("imagePath", imagePath);
		
		//상세페이지 / 리뷰
		String pageNum = request.getParameter("pageNum");
		
		int currentPage = 1;
		
		if(pageNum!=null)
			currentPage = Integer.parseInt(pageNum);

		int dataCount_yes = reviewDAO.getProductDataCount(superProduct);
		
		if(dataCount_yes!=0){
			
			int numPerPage = 7;
			int totalPage = myUtil.getPageCount(numPerPage, dataCount_yes);

			if(currentPage>totalPage)
				currentPage = totalPage;

			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;
			
			List<ReviewDTO> lists = reviewDAO.productGetList(superProduct, start, end,orderBy);
			

			//평점 별 리뷰 개수
		 	int rate[] = {reviewDAO.getProductDataCountHeart(superProduct, 5),reviewDAO.getProductDataCountHeart(superProduct, 4),
		 			reviewDAO.getProductDataCountHeart(superProduct, 3),reviewDAO.getProductDataCountHeart(superProduct, 2),reviewDAO.getProductDataCountHeart(superProduct, 1)}; 
		 	
			//평점 평균 
		 	float avgReviewRate = reviewDAO.productGetList_heart(superProduct);
		 	
			String pageIndexList = myUtil.reviewPageIndexList(currentPage, totalPage,order);
			String imagePath_review = "./upload/review";

			//포워딩 데이터
			request.setAttribute("lists", lists);
			request.setAttribute("order", order);
			request.setAttribute("pageNum", pageNum);	
			request.setAttribute("pageIndexList", pageIndexList);
			request.setAttribute("imagePath_review", imagePath_review);
			request.setAttribute("avgReviewRate", avgReviewRate);
			request.setAttribute("rate", rate);
		}
		request.setAttribute("dataCount_yes", dataCount_yes);
		
		request.setAttribute("dto", dto);
		
		return "product/productReview";
	}
	
}
