package com.codi.app;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

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
import com.codi.dto.CommunityDTO;
import com.codi.dto.MemberDTO;
import com.codi.dto.ReviewDTO;
import com.codi.util.MyUtil;

@Controller("instarController")
public class InstarController {
	
	@Autowired
	@Qualifier("instarDAO")
	InstarDAO dao;
	
	@Autowired
	MyUtil myUtil;
	
	@RequestMapping(value = "/myPage/instarWrited.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String instarWrited(HttpServletRequest req) {
		
		return "instar/instarWrited";
		
	}
	
	@RequestMapping(value = "/myPage/instarWrited_ok.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String instarWrited_ok(CommunityDTO dto, MultipartHttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes, HttpSession session) throws Exception {
		
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo");
		
		dto.setUserId(info.getUserId());
		dto.setiImage("");
		dto.setiNum(dao.getDataCount()+1);

		Date date = new Date();
		SimpleDateFormat today = new SimpleDateFormat("yyyymmdd24hhmmss");
		String time = today.format(date);
		
		String path = request.getSession().getServletContext().getRealPath("/upload/instar");
		
		MultipartFile file = request.getFile("instarImage");
		
		if(file!=null && file.getSize()>0) {
			try {
					
				String saveName = time + file.getOriginalFilename();
					
				File saveFile = new File(path,saveName); 
				file.transferTo(saveFile);
					
				dto.setiImage(saveName);

			} catch (Exception e) {
				System.out.println(e.toString());
			}
		}
		
		//2. DB¿¡ ³Ö±â
		dao.updateInstar(dto);
		
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
		
		int numPerPage = 12;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		
		if(currentPage>totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<CommunityDTO> lists = dao.selectUserInstar(info.getUserId(), start, end);
		
		String listUrl = cp + "/myPage/myInstarLists.action";
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		request.setAttribute("lists", lists);
		request.setAttribute("imagePath", "../upload/instar");
		request.setAttribute("pageIndexList", pageIndexList);
		request.setAttribute("pageNum", pageNum);
		
		return "instar/myInstarLists";
		
	}
	
	@RequestMapping(value = "/pr/instarView.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String instarView(CommunityDTO dto, HttpServletRequest request, HttpServletResponse response) {
		
		int iNum = Integer.parseInt(request.getParameter("iNum"));
		
		dto = dao.getOneInstar(iNum);
		dao.updateHitCount(iNum);
		
		dto.setiContent(dto.getiContent().replaceAll("\n", "<br/>"));
		String[] hashTag = dto.getiHashTag().split("#");
		List<String> list = new ArrayList<String>(); 
		Collections.addAll(list, hashTag); 
		list.remove(0);
		
		request.setAttribute("dto", dto);
		request.setAttribute("hashTag", list);
		request.setAttribute("imagePath", "../upload/instar");
		
		return "instar/instar";
		
	}
	
	
	
}
