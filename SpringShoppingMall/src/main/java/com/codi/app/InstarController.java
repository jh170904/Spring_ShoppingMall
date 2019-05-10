package com.codi.app;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codi.dao.InstarDAO;
import com.codi.dao.ReviewDAO;
import com.codi.dto.CommunityDTO;
import com.codi.dto.MemberDTO;
import com.codi.dto.ProductDTO;
import com.codi.util.MyUtil;

@Controller("instarController")
public class InstarController {
	
	@Autowired
	@Qualifier("instarDAO")
	InstarDAO dao;
	
	@Autowired
	@Qualifier("reviewDAO")
	ReviewDAO reviewDAO;
	
	@Autowired
	MyUtil myUtil;
	
	@RequestMapping(value = "/myPage/instarWrited.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String instarWrited(HttpServletRequest request ,HttpServletResponse response) {
		
		request.setAttribute("iNum", Integer.parseInt(request.getParameter("iNum")));
		request.setAttribute("iImage", request.getParameter("iImage")+ ".png");
		request.setAttribute("imagePath", "../upload/makecodi");

		return "instar/instarWrited";
		
	}
	
	@RequestMapping(value = "/myPage/instarWrited_ok.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String instarWrited_ok(CommunityDTO dto,RedirectAttributes redirectAttributes) throws Exception {
		
		dao.updateInstar(dto);
		String hashTag[] = dto.getiHashTag().split("#");

		for(int i=1;i<hashTag.length;i++) {
			dao.deleteHashtag(dto.getiNum(), hashTag[i]);
		}
		
		for(int i=1;i<hashTag.length;i++) {
			dao.insertHashtag(dto.getiNum(), hashTag[i]);
		}
		
		return "redirect:/myPage/myInstarLists.action";
	}
	
	@RequestMapping(value = "/myPage/myInstarLists.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String myInstarLists(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes, HttpSession session) {
		
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo");
		String cp = request.getContextPath();
		
		String pageNum = request.getParameter("pageNum");
		
		int currentPage = 1;
		
		if(pageNum!=null)
			currentPage = Integer.parseInt(pageNum);
		
		int dataCount = dao.countUserInstar(info.getUserId());
		
		int numPerPage = 9;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		
		if(currentPage>totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		MemberDTO memberInfo = dao.getUserInfo(info.getUserId());
		
		List<CommunityDTO> lists = dao.selectUserInstar(info.getUserId(), start, end);
		
		String listUrl = cp + "/myPage/myInstarLists.action";
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		request.setAttribute("userId", info.getUserId());
		request.setAttribute("lists", lists);
		request.setAttribute("imagePath", "../upload/makecodi");
		request.setAttribute("memberPath", "../upload/profile");
		request.setAttribute("memberInfo", memberInfo);
		request.setAttribute("pageIndexList", pageIndexList);
		request.setAttribute("dataCount", dataCount);
		request.setAttribute("pageNum", pageNum);
		
		return "instar/myInstarLists";
		
	}
	
	@RequestMapping(value = "/myPage/myCodiHeartists.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String mycodiHeartists(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes, HttpSession session) {
		
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo");
		String cp = request.getContextPath();
		
		String pageNum = request.getParameter("pageNum");
		
		int currentPage = 1;
		
		if(pageNum!=null)
			currentPage = Integer.parseInt(pageNum);
		
		int dataCount = dao.getUserCodiHeartCount(info.getUserId());
		
		int numPerPage = 9;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		
		if(currentPage>totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		MemberDTO memberInfo = dao.getUserInfo(info.getUserId());
		List<CommunityDTO> lists = dao.getUserCodiHeart(info.getUserId(), start, end);
		
		String listUrl = cp + "/myPage/myCodiHeartists.action";
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		request.setAttribute("userId", info.getUserId());
		request.setAttribute("lists", lists);
		request.setAttribute("imagePath", "../upload/makecodi");
		request.setAttribute("memberPath", "../upload/profile");
		request.setAttribute("memberInfo", memberInfo);
		request.setAttribute("pageIndexList", pageIndexList);
		request.setAttribute("dataCount", dataCount);
		request.setAttribute("pageNum", pageNum);
		
		return "instar/myCodiHeartLists";
		
	}
	
	@RequestMapping(value = "/myPage/myStoreHeartLists.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String myStoreHeartLists(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes, HttpSession session) {
		
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo");
		String cp = request.getContextPath();
		
		String pageNum = request.getParameter("pageNum");
		
		int currentPage = 1;
		
		if(pageNum!=null)
			currentPage = Integer.parseInt(pageNum);
		
		int dataCount = dao.countUserStoreHeart(info.getUserId());
		
		int numPerPage = 9;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		
		if(currentPage>totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		MemberDTO memberInfo = dao.getUserInfo(info.getUserId());
		
		List<ProductDTO> lists = dao.userStoreHeart(info.getUserId(), start, end);
		
		ListIterator<ProductDTO> productList = lists.listIterator();
		
		while(productList.hasNext()) {
			ProductDTO dto = productList.next();
			
			dto.setReviewCount(reviewDAO.getProductDataCount(dto.getSuperProduct()));
			dto.setReviewRate(reviewDAO.productGetList_heart(dto.getSuperProduct()));
		}
		
		String listUrl = cp + "/myPage/myStoreHeartLists.action";
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		request.setAttribute("userId", info.getUserId());
		request.setAttribute("lists", lists);
		request.setAttribute("imagePath", "../upload/list");
		request.setAttribute("memberPath", "../upload/profile");
		request.setAttribute("memberInfo", memberInfo);
		request.setAttribute("pageIndexList", pageIndexList);
		request.setAttribute("dataCount", dataCount);
		request.setAttribute("pageNum", pageNum);
		
		return "instar/myStoreHeartLists";
		
	}
	
	
}
