package com.codi.interceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.codi.dto.MemberDTO;

public class Interceptor extends HandlerInterceptorAdapter{

	private static final Logger logger = LoggerFactory.getLogger(Interceptor.class);


	static final String[] EXCLUDE_URL_LIST = {//로그인 페이지, 회원가입 페이지 등은 인터셉터 적용 제외 페이지
			"/login","/mem"
	};

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		String reqUrl = request.getRequestURL().toString(); 


		/** 로그인체크 제외 리스트 */

		for( String target : EXCLUDE_URL_LIST ){

			if(reqUrl.indexOf(target)>-1){ //indexOf 이용 URL주소에 로그인체크 제외 주소가 포함되어 있는지 확인

				return true;

			}

		}

		HttpSession session = request.getSession();

		MemberDTO info = (MemberDTO)session.getAttribute("customInfo");

		if(info==null){

			logger.info(">> interceptor catch!!! userId is null.. ");

			session.invalidate();

			response.sendRedirect(request.getContextPath() + "/mem/login.action");

			return false;

		}

		return true;

	}

}