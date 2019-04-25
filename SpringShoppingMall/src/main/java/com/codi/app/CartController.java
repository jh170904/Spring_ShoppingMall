package com.codi.app;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.codi.dao.CartDAO;
import com.codi.dto.CartDTO;
import com.codi.util.MyUtil;

@Controller("cartController")
public class CartController {
	
	@Autowired
	@Qualifier("cartDAO")//Bean 객체 생성 
	CartDAO dao;
	
	@Autowired
	MyUtil myUtil;//Bean 객체 생성
	
	@RequestMapping(value = "/cartList.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String cartList(CartDTO dto, HttpServletRequest request, HttpServletResponse response) {
		String cp = request.getContextPath();
		String userId= "aaa";
		List<CartDTO> lists = dao.getReadData(userId);
		int totalItemCount = dao.getTotalItemCount(userId);
		int totalItemPrice = dao.getTotalItemPrice(userId);
		int totalItemCountYes = dao.getTotalItemCountYes(userId);
		
		// 이미지파일경로
		String imagePath = cp + "/upload/list";
		
		//삭제
		String deleteUrl = cp + "/cart/cartDelete_ok.do?productId=";
		String updateUrl = cp + "/cart/cartUpdated_ok.do?productId=";
		
		request.setAttribute("imagePath", imagePath);
		request.setAttribute("lists", lists);
		request.setAttribute("deleteUrl", deleteUrl);
		request.setAttribute("updateUrl", updateUrl);
		request.setAttribute("totalItemCount", totalItemCount);
		request.setAttribute("totalItemPrice", totalItemPrice);
		request.setAttribute("totalItemCountYes", totalItemCountYes);
		
		return "cart/cartList";
	}
}
