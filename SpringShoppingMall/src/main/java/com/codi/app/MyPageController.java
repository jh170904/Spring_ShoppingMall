package com.codi.app;

import java.util.List;
import java.util.ListIterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.codi.dao.MyPageDAO;
import com.codi.dao.ReviewDAO;
import com.codi.dto.MemberDTO;
import com.codi.dto.ProductDTO;
import com.codi.util.MyUtil;

@Controller
public class MyPageController {
	
	@Autowired
	MyUtil myUtil;
	
	@Autowired
	@Qualifier("reviewDAO")
	ReviewDAO reviewDAO;
	
	@Autowired
	@Qualifier("myPageDAO")
	MyPageDAO dao;

	@RequestMapping(value = "myPage/myPageMain.action", method = RequestMethod.GET)
	public String mypageMain(HttpServletRequest req,HttpSession session) {
		
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo"); 
		
		String userId="";

		if(info!=null) {
			userId = info.getUserId();
		}
		
		req.setAttribute("userId", userId);

		return "mypage/mypageMain";
	}
	
	@RequestMapping(value = "myPage/storeGood.action", method = RequestMethod.GET)
	public String storeGood(HttpServletRequest req,HttpSession session) {
		
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo"); 
		
		String userId="";

		if(info!=null) {
			userId = info.getUserId();
		}
		
		String cp = req.getContextPath();

		String pageNum = req.getParameter("pageNum");

		int currentPage = 1;

		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		int dataCount = dao.getDataCount(userId);

		int numPerPage = 6;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		List<ProductDTO> lists;

		lists = dao.getList(start, end,userId);
		
		ListIterator<ProductDTO> it = lists.listIterator();
		
		while(it.hasNext()){
			ProductDTO vo = (ProductDTO)it.next();
			
			//dao.getReviewCount(vo.productId)
			int reviewCount =  reviewDAO.getProductDataCount(vo.getSuperProduct());
			//dao.getReviewRate(vo.productId)
			float avgReviewRate = reviewDAO.productGetList_heart(vo.getSuperProduct());
			
			vo.setReviewCount(reviewCount);
			vo.setReviewRate(avgReviewRate);
		}
		
		// ����¡�� ���� ���� �����ֱ�
		String listUrl = cp + "/myPage/storeGood.action";

		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);

		req.setAttribute("listUrl", listUrl);
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("userId", userId);
		
		return "mypage/storeGood";
	}
	
}