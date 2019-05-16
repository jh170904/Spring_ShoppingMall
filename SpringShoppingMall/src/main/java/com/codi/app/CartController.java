package com.codi.app;

import java.net.URLDecoder;
import java.util.Iterator;
import java.util.List;

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

import com.codi.dao.CartDAO;
import com.codi.dao.ProductDetailDAO;
import com.codi.dto.CartDTO;
import com.codi.dto.MemberDTO;
import com.codi.util.MyUtil;

@Controller("cartController")
public class CartController {
	
	@Autowired
	@Qualifier("cartDAO")//Bean 객체 생성 
	CartDAO dao;
	
	@Autowired
	@Qualifier("productDetailDAO")//Bean 객체 생성 
	ProductDetailDAO productDetailDAO;

	@Autowired
	MyUtil myUtil;//Bean 객체 생성
	
    //장바구니 리스트
	@RequestMapping(value = "/cart/cartList.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String cartList(CartDTO dto, HttpServletRequest request, HttpServletResponse response) {
		String cp = request.getContextPath();
		HttpSession session=request.getSession();
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo");
		String userId = info.getUserId();

		List<CartDTO> lists = dao.getReadData(userId);
		int totalItemCount = dao.getTotalItemCount(userId);
		int totalItemPrice = dao.getTotalItemPrice(userId);
		int totalItemCountYes = dao.getTotalItemCountYes(userId);
		
		//상품별 상품옵션 읽어오기
		Iterator<CartDTO> it = lists.iterator();
		while(it.hasNext()){
			CartDTO vo = (CartDTO)it.next();
			List<String> colorList = productDetailDAO.getColorList(vo.getSuperProduct());
			List<String> sizeList = productDetailDAO.getProductSizeList(vo.getSuperProduct());
			vo.setColorList(colorList);
			vo.setSizeList(sizeList);
		}		
		// 이미지파일경로
		String imagePath = cp + "/upload/list";
		
		request.setAttribute("imagePath", imagePath);
		request.setAttribute("lists", lists);
		request.setAttribute("totalItemCount", totalItemCount);
		request.setAttribute("totalItemPrice", totalItemPrice);
		request.setAttribute("totalItemCountYes", totalItemCountYes);
		return "cart/cartList";
	}
	
	//장바구니 아이템 등록
	@RequestMapping(value = "/cart/cartAdd_ok.action", method = {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public boolean cartAddItem(CartDTO dto, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session=request.getSession();
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo");
		String userId = info.getUserId();
		if(userId==null) {
			return false;
		} else {
			dto.setUserId(userId);
		}
		dto.setProductId(dao.getProductId(dto.getProductName(), dto.getProductSize(), dto.getColor()));

		//장바구니내 동일상품 등록여부 검색		
		if(dao.searchBeforeProductId(dto)!=0) {
			//동일상품 있을시 장바구니 수랑추가
			dao.updateCartItemAmountAdd(dto);
		}else {
			//장바구니 입력
			dao.insertCartItem(dto);
		}
		return true; 
	}
	
	//장바구니 아이템 삭제
	@RequestMapping(value = "/cart/deleteCartItem.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String deleteCartItem(String productId, HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo");
		String userId = info.getUserId();

		//장바구니 삭제
		dao.deleteCartItem(productId, userId);		
		return "redirect:/cart/cartList.action";
	}
	
	//장바구니 주문아이템 선택
	@RequestMapping(value = "/cart/amendToOrderSelect.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String amendToOrderSelect(String productId, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo");
		String userId = info.getUserId();

		//장바구니 주문체크 확인
		String beforeOrderSelect = dao.checkOrderSelect(productId, userId);
		//장바구니 주문체크 변경 
		if(beforeOrderSelect.equals("yes")) {
			dao.amendOrderSelect(productId, userId, "no");
		}else{
			dao.amendOrderSelect(productId, userId, "yes");
		}
		return "redirect:/cart/cartList.action";
	}
	
	//장바구니 옵션 변경
	@RequestMapping(value = "/cart/amendProductOption.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String amendProductOption(CartDTO dto, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo");
		String userId = info.getUserId();
		dto.setUserId(userId);
		
		//기존 아이템 삭제용
		String beforeProductId= dto.getProductId();
		//신규 아이템 입력용
		dto.setProductId(dao.getProductId(dto.getProductName(), dto.getProductSize(), dto.getColor()));
		
		//장바구니내 동일상품 등록여부 검색		
		if(dao.searchBeforeProductId(dto)==0) {
			//장바구니 옵션 삭제 후 입력
			dao.deleteCartItem(beforeProductId, userId);
			dao.insertCartItem(dto);
		}else {
			//장바구니 수랑변경
			dao.updateCartItemAmount(dto);
		}
		return "redirect:/cart/cartList.action";
	}
	
	//바로주문하기
	@RequestMapping(value = "/cart/cartAdd_directOrder.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String cartAdd_directOrder(CartDTO dto, HttpServletRequest request, HttpServletResponse response) {
		
		//장바구니 상품추가
		cartAddItem(dto, request, response);
		//리다이렉트
		return "redirect:/order/orderList.action";
	}
	
}
