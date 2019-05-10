package com.codi.app;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codi.dao.MemberDAO;
import com.codi.dto.MemberDTO;
import com.codi.util.MyUtil;


@Controller("memberController")
public class MemberController {
	
	@Autowired
	@Qualifier("memberDAO")//Bean 객체 생성 
	MemberDAO dao;
	
	@Autowired
	MyUtil myUtil;//Bean 객체 생성
	
	//메일전송에 필요
	@Autowired 
	private JavaMailSender mailSender;
	private String from = "codi@codi.com"; 
	private String subject	= "[내일의 코디북] 임시 비밀번호 발급 안내"; 
	
	
	@RequestMapping(value = "/mem/signup.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String signup() {
		return "mem/signup";
	}
	
	@RequestMapping(value = "/mem/signup_ok.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String signup_ok(MemberDTO dto) {

		dto.setEmail(dto.getEmail1()+"@"+dto.getEmail2());
		dao.insertData(dto);
		
		return "redirect:/mem/signup_com.action";
	}
	
	//새로고침할때 오류
	@RequestMapping(value = "/mem/signup_com.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String signup_com(MemberDTO dto) {		
		return "mem/signup_ok";
	}

	//로그인 인터셉터 이전페이지 url저장
	@RequestMapping(value = "/mem/login", method = RequestMethod.GET)
	public String loginPage(HttpServletRequest request){
		
		//이 경우에 직접 주소창에 쳐서들어가는경우 null값이 반환된다.
	    String referrer = request.getHeader("Referer");
	    
	    //주소창 들어가는경우는 null이니까 main페이지로 가게
	    if(referrer==null||referrer==""||referrer.contains("/mem")) {
	    	referrer="/pr/commuMain.action";
	    }
	    
	    request.getSession().setAttribute("prevPage", referrer);
	    return "mem/login";
	}
	
	//로그인 DB판별 Ajax
	@RequestMapping(value = "/mem/loginAjax.action",method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public Map<Object, Object> loginAjax(@RequestBody MemberDTO dto ) {
        
        int count=0;
        Map<Object, Object> map = new HashMap<Object, Object>();
 
        count = dao.loginChk(dto);
        
        map.put("cnt", count);
 
        return map;
    }
	
	@RequestMapping(value = "/mem/login_ok.action", method = RequestMethod.GET)
	public String login_ok(HttpSession session, HttpServletRequest request, HttpServletResponse response) {

        Cookie cookie=null;
        String userId=request.getParameter("userId");
        String id_rem=request.getParameter("id_ck");
        
        MemberDTO dto=dao.getReadData(userId);
        
        //CustomInfo안쓰고 MemberDTO 사용!
        session.setAttribute("customInfo", dto);
        
        try { 
            if(id_rem!=null&&id_rem.trim().equals("on")){
               cookie=new Cookie("userId", URLEncoder.encode(userId,"UTF-8"));
           	   cookie.setMaxAge(60*60);//1시간
               response.addCookie(cookie);
            }else{
               cookie=new Cookie("userId",null);
               cookie.setMaxAge(0);
               response.addCookie(cookie);
            }
		} catch (Exception e) {
			System.out.println(e.toString());
		}
        
        String redirectUrl = (String) session.getAttribute("prevPage");
        //System.out.println(redirectUrl);
        
		return "redirect:"+redirectUrl;
	}
	
	//아이디 중복확인
	@RequestMapping(value = "/mem/idcheck.action",method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public Map<Object, Object> idcheck(@RequestBody String userid) {
        
        int count = 0;
        Map<Object, Object> map = new HashMap<Object, Object>();
 
        count = dao.idcheck(userid);
        map.put("cnt", count);
 
        return map;
    }
	
	//id 찾기 페이지 띄워주기
	@RequestMapping(value = "/mem/searchid.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String searchid(HttpServletRequest request, HttpServletResponse response) {
		
		return "mem/searchid";
	}
	
	@RequestMapping(value = "/mem/searchid_ok.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String searchid_ok(MemberDTO dto, HttpServletRequest request, HttpServletResponse response) {
	
		dto.setEmail(dto.getEmail1()+"@"+dto.getEmail2());
		String userId = dao.findId(dto);
		request.setAttribute("userId", userId);
		
		return "mem/searchid_com";
	}
	
	//Id 찾기 DB판별 Ajax
	@RequestMapping(value = "/mem/idAjax.action",method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public Map<Object, Object> idAjax(@RequestBody MemberDTO dto ) {
        
        String userId="";
        Map<Object, Object> map = new HashMap<Object, Object>();
 
        userId = dao.findId(dto);
        
        map.put("cnt", userId);
 
        return map;
    }

	//비밀번호찾기
	@RequestMapping(value = "/mem/searchpw.action", method = RequestMethod.GET)
	public String searchpw(HttpServletRequest request, HttpServletResponse response) {
		
		return "mem/searchpw";
	}
	
	@RequestMapping(value = "/mem/searchpw_ok.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String searchpw_ok(MemberDTO dto, HttpServletRequest request, HttpServletResponse response) {

		dto.setEmail(dto.getEmail1()+"@"+dto.getEmail2());
		String email = dao.findPwdTemp(dto);
		
		System.out.println(email);
		
		//메일부분
        try {
        	
			MimeMessage message = mailSender.createMimeMessage(); 
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setTo(email);
			
	        String pw = "";
	        for(int i = 0; i < 8; i++){
	        	
	         //char upperStr = (char)(Math.random() * 26 + 65);
	         char lowerStr = (char)(Math.random() * 26 + 97);
	         if(i%2 == 0){
	        	 pw += (int)(Math.random() * 10);
	         }else{
	        	 pw += lowerStr;
	         }
	        }
		
	        String html = "<div align='center' style='border:1px solid black; font-family:verdana'>";
	        
	        html+="<br/>안녕하세요. <strong>내일의 코디북</strong> 입니다. ";
	        html+="저희 쇼핑몰을 방문해 주셔서 감사드립니다.<br/>";
	        html+="<h3 style='color:blue;'><strong>"+dto.getUserId();
	        html+="님</strong>의 임시 비밀번호 입니다. 로그인 후 비밀번호를 변경하세요.</h3>";
	        html+="<p>임시 비밀번호 : <strong>"+pw+"</strong></p><br/>";
	        html+="</div>";

	        messageHelper.setText(html, true);

			messageHelper.setFrom(from); 
			messageHelper.setSubject(subject);	//메일제목은 생략 가능

			System.out.println(from);
			
			
			mailSender.send(message);

			// 비밀번호 변경
    		dto.setUserPwd(pw);
    		dao.updatePwd(dto);

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return "redirect:/mem/searchpw_com.action?email="+email;
	}
	
	@RequestMapping(value = "/mem/searchpw_com.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String searchpw_com(HttpServletRequest request, HttpServletResponse response) {

		String email = request.getParameter("email");
		request.setAttribute("email", email);
		
		return "mem/searchpw_com";
	}

	//Id 찾기 DB판별 Ajax
	@RequestMapping(value = "/mem/pwdAjax.action",method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public Map<Object, Object> pwdAjax(@RequestBody MemberDTO dto ) {
        
        String userPwd="";
        Map<Object, Object> map = new HashMap<Object, Object>();
 
        userPwd = dao.findPwd(dto);

        map.put("cnt", userPwd);
 
        return map;
    }
	
	@RequestMapping(value = "/mem/logout.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String logout(HttpSession session) {
		
		session.removeAttribute("customInfo");
		session.invalidate();//변수도 지운다.
		
		return "redirect:/pr/commuMain.action";
	}
	
	@RequestMapping(value = "/con/mypage.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String mypage() {
		return "mem/mypage_content";
	}
	
	@RequestMapping(value = "/con/update.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String update(MemberDTO dto, HttpServletRequest request) {
		
		return "mem/update";
	}
	
	@RequestMapping(value = "/con/update_ok.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String update_ok(HttpSession session, HttpServletRequest request) {
		
		MemberDTO info=(MemberDTO)session.getAttribute("customInfo");
		MemberDTO dto=dao.getReadData(info.getUserId());
		request.setAttribute("dto", dto);
		
		return "mem/update_member";
	}
	
	@RequestMapping(value = "/con/update_ok_pwd.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String update_ok_pwd(HttpSession session, HttpServletRequest request) {
		
		MemberDTO info=(MemberDTO)session.getAttribute("customInfo");
		MemberDTO dto=dao.getReadData(info.getUserId());
		request.setAttribute("dto", dto);
		
		return "mem/update_pwd";
	}
	
	//비밀번호 수정
	@RequestMapping(value = "/con/update_pwd.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String update_pwd(HttpSession session, MemberDTO dto, HttpServletRequest request, HttpServletResponse response) {
		
		MemberDTO info=(MemberDTO)session.getAttribute("customInfo");
		
		dto.setUserPwd(request.getParameter("pass1"));
		dto.setUserId(info.getUserId());
		
		dao.updatePwd(dto);
		
        session.setAttribute("customInfo", dto);
        
		return "redirect:/con/update_ok.action";
	}
	
	//개인정보수정
	@RequestMapping(value = "/con/update_data.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String update_data(HttpSession session, MemberDTO dto, MultipartHttpServletRequest request, HttpServletResponse response) {
	
		String path = request.getSession().getServletContext().getRealPath("/upload/profile");
		
		MultipartFile file = request.getFile("imageUpdate");
		

		MemberDTO info=(MemberDTO)session.getAttribute("customInfo");
		
		
		//파일이 존재한다면 업로드 하기
		
		if(file!=null && file.getSize()>0) {

			System.out.println(file);
			
			try {
				
				Date date = new Date();
				SimpleDateFormat today = new SimpleDateFormat("yyyymmdd24hhmmss");
				String time = today.format(date);

				String fimeName = time + file.getOriginalFilename();
				
				File saveFile = new File(path,fimeName);
				file.transferTo(saveFile);

				dto.setmImage(fimeName);
				
				
				//기존 물리적 파일에 있는 이미지 삭제
				//1.기존 물리적 파일의 이미지 가져오기(id로) - dao생성
				//물리적 파일의 이미지 이름이 default.jpg가 아니면 물리적 파일 삭제
				System.out.println(info.getUserId());
				
				String deleteImage = dao.originalProfile(info.getUserId());
				
				System.out.println(deleteImage);
				
				if(!deleteImage.equals("default.jpg")) {					
					String deleteFile = path + "/" + deleteImage;
					File deletefile = new File(deleteFile);
			        deletefile.delete();
				}
				
			} catch (Exception e){ 
				System.out.println(e.toString()); 
			}

		}else {
			dto.setmImage("default.jpg");
		}

		dto.setmMessage(request.getParameter("mMessage"));
		dto.setEmail(request.getParameter("email"));
		dto.setUserId(info.getUserId());
		
		dao.updateData(dto);
		
        session.setAttribute("customInfo", dto);
        
		return "redirect:/con/update_ok.action";
	}
	


}
