package com.codi.app;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.codi.dao.ProductDAO;
import com.codi.dao.ProductDetailDAO;
import com.codi.dao.ReviewDAO;
import com.codi.dto.MemberDTO;
import com.codi.dto.ProductDTO;
import com.codi.dto.ProductDetailDTO;
import com.codi.util.MyUtil;

@Controller
public class ProductController {

	@Autowired
	@Qualifier("productDAO")
	ProductDAO dao;
	
	@Autowired
	@Qualifier("reviewDAO")
	ReviewDAO reviewDAO;

	@Autowired
	@Qualifier("productDetailDAO")
	ProductDetailDAO productDetailDAO;
	
	@Autowired
	MyUtil myUtil;// Bean 객체 생성
	
	//스토어홈 메인페이지
	@RequestMapping(value = "pr/storeMain.action", method = RequestMethod.GET)
	public String storeMain(HttpServletRequest req, HttpSession session) {
		
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo"); 

		List<String> good = null;


		if(info!=null) {
			good = dao.storeHeartList(info.getUserId());
		}
		
		String cp = req.getContextPath();

		List<ProductDTO> lists = dao.getListOrder(1, 4, "amount desc");
		
		List<ProductDTO> codiBestlists = dao.getListOrder(1, 4, "codiCount desc");
		

		//각각의 dto에 reviewCount 와 reviewRate 추가
		ListIterator<ProductDTO> it = lists.listIterator();
		
		while(it.hasNext()){
			ProductDTO vo = (ProductDTO)it.next();
			
			//dao.getReviewCount(vo.productId)
			int reviewCount =  reviewDAO.getProductDataCount(vo.getSuperProduct());
			//dao.getReviewRate(vo.productId)
			float avgReviewRate = (float) (Math.round(reviewDAO.productGetList_heart(vo.getSuperProduct())*10)/10.0);
			
			vo.setReviewCount(reviewCount);
			vo.setReviewRate(avgReviewRate);
		}

		// 이미지저장 경로 보내주기
		String imagePath = req.getSession().getServletContext().getRealPath("/upload");

		req.setAttribute("good", good);
		req.setAttribute("imagePath", imagePath);
		req.setAttribute("lists", lists);
		req.setAttribute("codiBestlists", codiBestlists);
		
		return "storeMain";
	}

	@RequestMapping(value = "pr/listNew.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String listNew(HttpServletRequest req, HttpSession session) throws IOException {
		
		
		 MemberDTO info = (MemberDTO) session.getAttribute("customInfo"); 
		 
		 List<String> good = null;
		 
		 if(info!=null) {
			 good = dao.storeHeartList(info.getUserId());
		 }
		 

		String order = req.getParameter("order");
		if (order != null) {
			order = URLDecoder.decode(req.getParameter("order"), "UTF-8");
		}else {
			order="null";
		}

		String cp = req.getContextPath();

		String pageNum = req.getParameter("pageNum");

		int currentPage = 1;

		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		int dataCount = dao.getDataCount();

		int numPerPage = 12;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		List<ProductDTO> lists;

		if (order != null && !order.equals("")) {
			lists = dao.getListOrder(start, end, order);
		}else {
			lists = dao.getList(start, end);
		}
		
		
		//각각의 dto에 reviewCount 와 reviewRate 추가
		
		ListIterator<ProductDTO> it = lists.listIterator();
		
		while(it.hasNext()){
			ProductDTO vo = (ProductDTO)it.next();

			//dao.getReviewCount(vo.productId)
			int reviewCount =  reviewDAO.getProductDataCount(vo.getSuperProduct());
			//dao.getReviewRate(vo.productId)
			float avgReviewRate = (float) (Math.round(reviewDAO.productGetList_heart(vo.getSuperProduct())*10)/10.0);
			int heartCount = dao.storeHeartCount2(vo.getSuperProduct());
			
			vo.setReviewCount(reviewCount);
			vo.setReviewRate(avgReviewRate);
			vo.setHeartCount(heartCount);
		}
		
		

		// 이미지저장 경로 보내주기
		String imagePath = req.getSession().getServletContext().getRealPath("/upload");

		// String imagePath =
		// req.getSession().getServletContext().getRealPath("/WEB-INF/files");

		// 페이징을 위한 값들 보내주기
		String listUrl = cp + "/pr/listNew.action";

		String pageIndexList = myUtil.listPageIndexList(currentPage, totalPage, listUrl, order);

		req.setAttribute("listUrl", listUrl);
		req.setAttribute("imagePath", imagePath);
		req.setAttribute("lists", lists);
		req.setAttribute("good", good);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("pageNum", pageNum);

		return "list/listNew";
	}

	@RequestMapping(value = "pr/listCategory.action", method = RequestMethod.GET)
	public String listCategory(HttpServletRequest req,HttpSession session) throws IOException {

		MemberDTO info = (MemberDTO) session.getAttribute("customInfo"); 

		List<String> good = null;

		if(info!=null) {
			good = dao.storeHeartList(info.getUserId());
		}
		
		String order = req.getParameter("order");
		if (order != null) {
			order = URLDecoder.decode(req.getParameter("order"), "UTF-8");
		}else {
			order="null";
		}

		String productCategory = req.getParameter("productCategory");
		if (productCategory != null) {
			productCategory = URLDecoder.decode(req.getParameter("productCategory"), "UTF-8");
		}

		String cp = req.getContextPath();

		String pageNum = req.getParameter("pageNum");

		int currentPage = 1;

		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		int dataCount = dao.getDataCountCategory(productCategory);

		int numPerPage = 12;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		List<ProductDTO> lists;

		if (order != null && !order.equals("")) {
			lists = dao.getListsCategoryOrder(start, end, productCategory, order);
		} else {
			lists = dao.getListsCategory(start, end, productCategory);
		}


		//각각의 dto에 reviewCount 와 reviewRate 추가
		
		ListIterator<ProductDTO> it = lists.listIterator();
		
		while(it.hasNext()){
			ProductDTO vo = (ProductDTO)it.next();
			
			//dao.getReviewCount(vo.productId)
			int reviewCount =  reviewDAO.getProductDataCount(vo.getSuperProduct());
			//dao.getReviewRate(vo.productId)
			float avgReviewRate = (float) (Math.round(reviewDAO.productGetList_heart(vo.getSuperProduct())*10)/10.0);
			int heartCount = dao.storeHeartCount2(vo.getSuperProduct());
			
			vo.setReviewCount(reviewCount);
			vo.setReviewRate(avgReviewRate);
			vo.setHeartCount(heartCount);
		}
		
		
		
		// 이미지저장 경로 보내주기
		String imagePath = req.getSession().getServletContext().getRealPath("/upload");

		// String imagePath =
		// req.getSession().getServletContext().getRealPath("/WEB-INF/files");

		// 페이징을 위한 값들 보내주기
		String listUrl = cp + "/pr/listCategory.action?productCategory=" + productCategory;

		String pageIndexList = myUtil.listPageIndexList(currentPage, totalPage, listUrl, order);

		if (productCategory != null) {
			productCategory = URLEncoder.encode(productCategory, "UTF-8");
		}

		req.setAttribute("good", good);
		req.setAttribute("listUrl", listUrl);
		req.setAttribute("productCategory", productCategory);
		req.setAttribute("imagePath", imagePath);
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("pageNum", pageNum);

		return "list/listCategory";
	}

	@RequestMapping(value = "pr/listBest.action", method = RequestMethod.GET)
	public String listBest(HttpServletRequest req,HttpSession session) throws IOException {
		
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo"); 

		List<String> good = null;


		if(info!=null) {
			good = dao.storeHeartList(info.getUserId());
		}
		
		String cp = req.getContextPath();

		String pageNum = req.getParameter("pageNum");

		int currentPage = 1;

		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		int dataCount = dao.getDataCount();

		int numPerPage = 12;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		List<ProductDTO> lists;

		lists = dao.getListOrder(start, end, "amount desc");
		
		

		//각각의 dto에 reviewCount 와 reviewRate 추가
		
		ListIterator<ProductDTO> it = lists.listIterator();
		
		while(it.hasNext()){
			ProductDTO vo = (ProductDTO)it.next();
			//dao.getReviewCount(vo.productId)
			int reviewCount =  reviewDAO.getProductDataCount(vo.getSuperProduct());
			//dao.getReviewRate(vo.productId)
			float avgReviewRate = (float) (Math.round(reviewDAO.productGetList_heart(vo.getSuperProduct())*10)/10.0);
			int heartCount = dao.storeHeartCount2(vo.getSuperProduct());
			
			vo.setReviewCount(reviewCount);
			vo.setReviewRate(avgReviewRate);
			vo.setHeartCount(heartCount);
		}
		
		
		

		// 이미지저장 경로 보내주기
		String imagePath = req.getSession().getServletContext().getRealPath("/upload");

		// String imagePath =
		// req.getSession().getServletContext().getRealPath("/WEB-INF/files");

		// 페이징을 위한 값들 보내주기
		String listUrl = cp + "/pr/listBest.action";

		String pageIndexList = myUtil.listPageIndexList(currentPage, totalPage, listUrl, "amount desc");

		req.setAttribute("good", good);
		req.setAttribute("listUrl", listUrl);
		req.setAttribute("imagePath", imagePath);
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("pageNum", pageNum);

		return "list/listBest";
	}

	@RequestMapping(value = "pr/listCodiBest.action", method = RequestMethod.GET)
	public String listCodiBest(HttpServletRequest req,HttpSession session) throws IOException {
		
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo"); 

		List<String> good = null;


		if(info!=null) {
			good = dao.storeHeartList(info.getUserId());
		}
		
		String cp = req.getContextPath();

		String pageNum = req.getParameter("pageNum");

		int currentPage = 1;

		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		int dataCount = dao.getDataCount();

		int numPerPage = 12;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		List<ProductDTO> lists;

		lists = dao.getListOrder(start, end, "codiCount desc");
		
		

		//각각의 dto에 reviewCount 와 reviewRate 추가
		
		ListIterator<ProductDTO> it = lists.listIterator();
		
		while(it.hasNext()){
			ProductDTO vo = (ProductDTO)it.next();

			//dao.getReviewCount(vo.productId)
			int reviewCount =  reviewDAO.getProductDataCount(vo.getSuperProduct());
			//dao.getReviewRate(vo.productId)
			float avgReviewRate = (float) (Math.round(reviewDAO.productGetList_heart(vo.getSuperProduct())*10)/10.0);
			int heartCount = dao.storeHeartCount2(vo.getSuperProduct());
			
			vo.setReviewCount(reviewCount);
			vo.setReviewRate(avgReviewRate);
			vo.setHeartCount(heartCount);
		}
		
		
		

		// 이미지저장 경로 보내주기
		String imagePath = req.getSession().getServletContext().getRealPath("/upload");

		// String imagePath =
		// req.getSession().getServletContext().getRealPath("/WEB-INF/files");

		// 페이징을 위한 값들 보내주기
		String listUrl = cp + "/pr/listCodiBest.action";

		String pageIndexList = myUtil.listPageIndexList(currentPage, totalPage, listUrl, "codiCount desc");

		req.setAttribute("good", good);
		req.setAttribute("listUrl", listUrl);
		req.setAttribute("imagePath", imagePath);
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("pageNum", pageNum);

		return "list/listCodiBest";
	}
	
	@RequestMapping(value = "/pr/listSearch.action", method = RequestMethod.GET)
	public String listSearch(String searchHeader, HttpServletRequest req,HttpSession session) throws IOException {
		
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo"); 
		
		List<String> good = null;	
		
		String searchCategory = searchHeader;
		//DB 카테고리
		String arrCategory[] = {"OUTER","TOP","BOTTOM","DRESS","SHOES","BAG","ACC"};
		//분류용 카테고리
		String arrCompareCategory[][] = {
				//OUTER
				{"자켓","외투","겉옷","아우터"},
				//TOP
				{"상의","탑"},
				//BOTTOM
				{"하의","바지","팬츠","청바지","레깅스"},
				//DRESS
				{"원피스","스커트","치마","드레스"},
				//SHOES
				{"신발","슈즈"},
				//BAG
				{"가방"},
				//ACC
				{"악세서리","악세사리","쥬얼리","장신구"}
			};
		
		//카테고리 매칭
		for(int i=0; i<arrCategory.length; i++) {
			for(int j=0;j<arrCompareCategory[i].length;j++) {
				if(searchHeader.equals(arrCompareCategory[i][j])) {
					//System.out.println( "인덱스 i:"+i+"j:"+j+ ", 매칭카테고리" + arrCategory[i]);
					searchCategory = arrCategory[i];
				}
			}	
		}

		if(info!=null) {
			good = dao.storeHeartList(info.getUserId());
		}
		
		String cp = req.getContextPath();

		String pageNum = req.getParameter("pageNum");

		int currentPage = 1;

		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		int dataCount = dao.getDataCountSearch(searchHeader, searchCategory);

		int numPerPage = 12;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		List<ProductDTO> lists;

		lists = dao.getListsSearch(start, end, searchHeader, searchCategory);
		
		//각각의 dto에 reviewCount 와 reviewRate 추가
		
		ListIterator<ProductDTO> it = lists.listIterator();
		
		while(it.hasNext()){
			ProductDTO vo = (ProductDTO)it.next();
			
			//dao.getReviewCount(vo.productId)
			int reviewCount =  reviewDAO.getProductDataCount(vo.getSuperProduct());
			//dao.getReviewRate(vo.productId)
			float avgReviewRate = (float) (Math.round(reviewDAO.productGetList_heart(vo.getSuperProduct())*10)/10.0);
			
			vo.setReviewCount(reviewCount);
			vo.setReviewRate(avgReviewRate);
		}
		
		// 이미지저장 경로 보내주기
		String imagePath = req.getSession().getServletContext().getRealPath("/upload");


		// 페이징을 위한 값들 보내주기
		String listUrl = cp + "/pr/listSearch.action?searchHeader="+searchHeader;

		String pageIndexList = myUtil.listPageIndexList(currentPage, totalPage, listUrl, "amount desc");

		req.setAttribute("searchHeader", searchHeader);
		req.setAttribute("good", good);
		req.setAttribute("listUrl", listUrl);
		req.setAttribute("imagePath", imagePath);
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("pageNum", pageNum);

		return "list/listSearch";
	}
	
	
	@RequestMapping(value = "/storeGoodOneItem.action", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<Object, Object> goodOneItem(@RequestBody String superProduct, HttpSession session) {

		MemberDTO info = (MemberDTO) session.getAttribute("customInfo");

		// if storeHeart테이블에서 userId랑 superProduct가 같은게 있으면 입력 : 테이블에서 입력하고 cnt = 0

		// 현재 클릭한 상품이 현재 로그인한 아이디가 좋아요 누른 상품이면 1 아니면 0
		int result = dao.storeHeartCount(superProduct, info.getUserId());
		int count = 0;

		if (result == 0) {
			dao.insertHeart(superProduct, info.getUserId());
			count = 0;
		} else {
			dao.deleteHeart(superProduct, info.getUserId());
			count = 1;
		}

		Map<Object, Object> map = new HashMap<Object, Object>();

		map.put("cnt", count);

		return map;
	}

	

	@RequestMapping(value = "/storeGood.action", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<Object, Object> good(@RequestBody String superProduct, HttpSession session) {

		MemberDTO info = (MemberDTO) session.getAttribute("customInfo");

		// if storeHeart테이블에서 userId랑 superProduct가 같은게 있으면 입력 : 테이블에서 입력하고 cnt = 0

		// 현재 클릭한 상품이 현재 로그인한 아이디가 좋아요 누른 상품이면 1 아니면 0
		int result = dao.storeHeartCount(superProduct, info.getUserId());
		
		if (result == 0) {
			dao.insertHeart(superProduct, info.getUserId());
		} else {
			dao.deleteHeart(superProduct, info.getUserId());
		}

		Map<Object, Object> map = new HashMap<Object, Object>();
		
		int count = dao.storeHeartCount2(superProduct);

		map.put("cnt", count);
		map.put("result", result);

		return map;
	}

}
