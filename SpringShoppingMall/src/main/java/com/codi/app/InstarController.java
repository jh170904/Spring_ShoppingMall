package com.codi.app;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

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
		dao.insertInstar(dto);
		
		return "redirect:/myPage/myInstarLists.action";
	}
	
	@RequestMapping(value = "/myPage/myInstarLists.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String myInstarLists(HttpServletRequest req) {
		
		return "instar/myInstarLists";
		
	}
	
}
