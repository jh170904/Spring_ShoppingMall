package com.codi.app;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.codi.dao.MemberDAO;
import com.codi.dto.MemberDTO;
import com.codi.util.MyUtil;


@Controller
public class MemberController {
	
	@Autowired
	@Qualifier("memberDAO")//Bean 객체 생성 
	MemberDAO dao;
	
	@Autowired
	MyUtil myUtil;//Bean 객체 생성
	
	@RequestMapping(value = "/main.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String footer() {
		return "main";
	}
	
	@RequestMapping(value = "/signup.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String signup() {
		return "mem/signup";
	}
	
	@RequestMapping(value = "/signup_ok.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String signup_ok(MemberDTO dto) {

		dto.setEmail(dto.getEmail1()+"@"+dto.getEmail2());
		dao.insertData(dto);
		
		return "redirect:/signup_com.action";
	}
	
	//새로고침할때 오류
	@RequestMapping(value = "/signup_com.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String signup_com(MemberDTO dto) {		
		return "mem/signup_ok";
	}

	@RequestMapping(value = "/login.action", method = RequestMethod.GET)
	public String login() {
		return "mem/login";
	}
	
	@RequestMapping(value = "/login_ok.action", method = RequestMethod.GET)
	public ModelAndView login_ok(HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav=new ModelAndView("mem/loginSuccess");//성공하면 여기로감
		
        String userId=request.getParameter("userId");
        String userPwd=request.getParameter("userPwd");
        Cookie cookie=null;
        String id_rem=request.getParameter("id_ck");
    	
        MemberDTO dto=dao.getReadData(userId);
        
        //dto가 null이면 아이디가 틀린것(id가없어서 오라클에서 return값이 null)
        //패스워드 비교해서 틀리면 패스워드가 틀린것
        if(dto==null||!dto.getUserPwd().equals(userPwd)){

        	request.setAttribute("message", "false");
        	mav.setViewName("mem/login");	//실패시
        }

        //session도 out.print처럼 jsp에는 그냥 사용가능한데
        //java에서는 요청을 한뒤 써야한다.
        HttpSession session=request.getSession();
        try {
		
        	//CustomInfo안쓰고 MemberDTO 사용!
            session.setAttribute("customInfo", dto);
            
            if(id_rem!=null&&id_rem.trim().equals("on")){
               cookie=new Cookie("userId",URLEncoder.encode(userId,"UTF-8"));
           	 cookie.setMaxAge(60*60);//1시간
               response.addCookie(cookie);
            }else{
               cookie=new Cookie("userId",null);
               cookie.setMaxAge(0);
               response.addCookie(cookie);
            }
            
		} catch (Exception e) {
			
		}
        
        mav.addObject("msg","로그인에 성공하였습니다.");
        
		return mav;
	}
	
	@RequestMapping(value = "/idcheck.action",method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public Map<Object, Object> idcheck(@RequestBody String userid) {
        
        int count = 0;
        Map<Object, Object> map = new HashMap<Object, Object>();
 
        count = dao.idcheck(userid);
        map.put("cnt", count);
 
        return map;
    }
	
	
	/*
	@RequestMapping(value = "/created.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String created(HttpServletRequest request, HttpServletResponse response) throws Exception{
			
		return "bbs/created";
	}
	*/

}
