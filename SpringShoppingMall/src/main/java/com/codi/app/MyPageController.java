package com.codi.app;

import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.codi.dao.InstarDAO;
import com.codi.dao.MyPageDAO;
import com.codi.dao.ReviewDAO;
import com.codi.dto.CommunityDTO;
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
	
	@Autowired
	@Qualifier("instarDAO")
	InstarDAO instardao;

	@RequestMapping(value = "myPage/myPageMain.action", method = RequestMethod.GET)
	public String mypageMain(HttpServletRequest req,HttpSession session) {
		
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo"); 
		
		String userId="";

		if(info!=null) {
			userId = info.getUserId();
		}
		
		int userInstarCount = instardao.countUserInstar(userId);
		int userCodiHeartCount = instardao.getUserCodiHeartCount(userId);

		MemberDTO memberInfo = instardao.getUserInfo(info.getUserId());		
		
		List<CommunityDTO> instarList = instardao.selectUserInstar(userId, 1, 4);
		List<CommunityDTO> codiHeartList = instardao.getUserCodiHeart(userId, 1, 4);
		
		//나를 팔루우한 사람
		int follower = dao.follower(info.getUserId());
		//내가 팔로우한 사람
		int following = dao.following(info.getUserId());

		req.setAttribute("follower", follower);
		req.setAttribute("following", following);
		req.setAttribute("userId", userId);
		req.setAttribute("userInstarCount", userInstarCount);
		req.setAttribute("memberPath", "../upload/profile");
		req.setAttribute("memberInfo", memberInfo);
		req.setAttribute("instarList", instarList);
		req.setAttribute("userCodiHeartCount", userCodiHeartCount);
		req.setAttribute("codiHeartList", codiHeartList);
		req.setAttribute("imagePath", "../upload/makecodi");

		
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
		
		// 페이징을 위한 값들 보내주기
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
	
	@RequestMapping(value = "myPage/following.action", method = RequestMethod.GET)
	public String following(HttpServletRequest req,HttpSession session) {
		
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

		int dataCount = dao.following(userId);

		int numPerPage = 2;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		//팔로잉들의 프로필과 아이디
		List<MemberDTO> lists = dao.followingList(start, end,userId);
		//내프로필과 상메
		MemberDTO userInfo = instardao.getUserInfo(userId);
		//나를 팔루우한 사람
		int follower = dao.follower(info.getUserId());
		//내가 팔로우한 사람
		int following = dao.following(info.getUserId());
		
		// 페이징을 위한 값들 보내주기
		String listUrl = cp + "/myPage/following.action";

		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);

		req.setAttribute("listUrl", listUrl);
		req.setAttribute("lists", lists);
		req.setAttribute("follower", follower);
		req.setAttribute("following", following);
		req.setAttribute("userInfo", userInfo);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("pageNum", pageNum);
		
		return "mypage/following";
	}
	
}
