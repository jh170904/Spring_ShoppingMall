package com.codi.app;

import java.net.URLDecoder;
import java.util.List;
import java.util.ListIterator;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.codi.dao.CommunityDAO;
import com.codi.dto.CommunityDTO;
import com.codi.dto.MemberDTO;
import com.codi.dto.ProductDTO;
import com.codi.util.MyUtil;


@Controller
public class CommunityController {
	
	@Autowired
	@Qualifier("communityDAO")
	CommunityDAO dao;
	
	@Autowired
	MyUtil myUtil;
	
	@RequestMapping(value = "pr/commuList.action", method = RequestMethod.GET)
	public String commuMain(HttpServletRequest req) {
		
		String cp = req.getContextPath();

		String pageNum = req.getParameter("pageNum");

		int currentPage = 1;

		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		int dataCount = dao.getDataCount();

		int numPerPage = 9;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		List<CommunityDTO> lists = dao.getLists(start, end);		
		
		//각각의 dto에 reviewCount 와 reviewRate 추가
		

		// 페이징을 위한 값들 보내주기
		String listUrl = cp + "/pr/commuList.action";

		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);

		req.setAttribute("listUrl", listUrl);
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("pageNum", pageNum);

		System.out.println(lists);
		
		return "/community/commuList";
	}

}
