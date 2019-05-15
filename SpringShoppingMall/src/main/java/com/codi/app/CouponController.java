package com.codi.app;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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

import com.codi.dao.CouponDAO;
import com.codi.dto.CouponDTO;
import com.codi.dto.IssueDTO;
import com.codi.dto.MemberDTO;
import com.codi.dto.MyCouponDTO;
import com.codi.dto.ProductDTO;
import com.codi.util.MyUtil;

@Controller
public class CouponController {
	
	@Autowired
	@Qualifier("couponDAO")//Bean 객체 생성 
	CouponDAO dao;
	
	@Autowired
	MyUtil myUtil;// Bean 객체 생성
			
	@RequestMapping(value = "couponA/couponAllList.action", method = RequestMethod.GET)
	public String couponAllList(HttpServletRequest req) {
		
		List<CouponDTO> lists = dao.getList();

		req.setAttribute("lists", lists);
		
		return "coupon/couponAllList";
	}
	
	@RequestMapping(value = "/coupon/couponIssue_ok.action", method = RequestMethod.POST)
	public String couponIssue_ok(HttpServletRequest req,HttpServletResponse response,HttpSession session,CouponDTO coupondto) throws IOException{
		
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo"); 
		
		//alter창을 띄어주기 위한 설정
		response.setCharacterEncoding("utf-8"); 
		PrintWriter writer = response.getWriter();
		
		//쿠폰리스트 보내주기
		List<CouponDTO> lists2 = dao.getList();
		req.setAttribute("lists", lists2);
		
		//등급검사
		if(!coupondto.getCouponGrade().equals(info.getUserGrade())){
			writer.println("<script type='text/javascript'>");
			writer.println("alert('등급이 다릅니다.');");
			writer.println("history.back();");
			writer.println("</script>");
			writer.flush();

			return "coupon/couponAllList";
		}
		
		//미리받은것인지 검사
		List<IssueDTO> lists = dao.couponGetLists();
		Iterator<IssueDTO> it = lists.iterator();
		
        while (it.hasNext()){
			IssueDTO dto = it.next();

			if(dto.getUserId().equals(info.getUserId())&&dto.getCouponKey()==coupondto.getCouponKey()){
				writer.println("<script type='text/javascript'>");
				writer.println("alert('이미 발급받은 쿠폰입니다');");
				writer.println("history.back();");
				writer.println("</script>");
				writer.flush();
				
				return "coupon/couponAllList";
			}
        }
		
        //쿠폰발급테이블에 insert
		IssueDTO issuedto = new IssueDTO();
		
		issuedto.setCouponKey(coupondto.getCouponKey());
		issuedto.setUserId(info.getUserId());

		dao.couponInsertData(issuedto);
		
		writer.println("<script type='text/javascript'>");
		writer.println("alert('쿠폰발급이 완료되었습니다.');");
		writer.println("history.back();");
		writer.println("</script>");
		writer.flush();
		
		return "coupon/couponAllList";
	}
	
	@RequestMapping(value = "/coupon/couponMyList.action", method = RequestMethod.GET)
	public String couponMyList(HttpServletRequest req,HttpServletResponse response,HttpSession session,CouponDTO coupondto) throws IOException{
		
		List<CouponDTO> lists = dao.getList();

		req.setAttribute("lists", lists);
		
		return "coupon/couponMyList";
	}
	
	@RequestMapping(value = "/coupon/myCouponList.action", method = RequestMethod.GET)
	public String myCouponList(HttpServletRequest req,HttpServletResponse response,HttpSession session){
		
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo"); 
		
		List<MyCouponDTO> lists = dao.couponGetList(info.getUserId());
		
		req.setAttribute("lists", lists);
		
		return "coupon/myCouponList";
	}
	
	@RequestMapping(value = "/coupon/myUsedCouponList.action", method = RequestMethod.GET)
	public String myUsedCouponList(HttpServletRequest req,HttpServletResponse response,HttpSession session){
		
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo"); 
		
		List<MyCouponDTO> lists = dao.couponGetList(info.getUserId());
		
		//날짜비교
		SimpleDateFormat dateFormat = new  SimpleDateFormat("yyyy-MM-dd", java.util.Locale.getDefault());
		long now = System.currentTimeMillis();
		Date date = new Date(now);
		//현재날짜
	    String strDate = dateFormat.format(date);
	    Date date1 = null;
	    
	    //날짜확인해서 만기인지 아닌지 넣어주기(만기이면 used에 'M'넣기)
	    //date1이 만기날짜
	    //date2가 현재날짜
	    //만기날짜가 현재날짜보다 이후이면 true = 아직 만기가 안됨
		Iterator<MyCouponDTO> it = lists.iterator();
		
        while (it.hasNext()){

        	MyCouponDTO dto = it.next();

	        try {
				date1 = dateFormat.parse(dto.getCouponEndDate());
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        
	        Date date2 = null;
			try {
				date2 = dateFormat.parse(strDate);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        boolean re = date1.after(date2);
	        
	        if(re!=true){
	        	dao.couponInsertM(dto.getCouponKey(),info.getUserId());
	        }
        }
		

		List<MyCouponDTO> lists2 = dao.couponGetList(info.getUserId());
		
		req.setAttribute("lists", lists2);
		
		return "coupon/myUsedCouponList";
	}
}
