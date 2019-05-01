package com.codi.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.CartDTO;

@Component("cartDAO")
public class CartDAO {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;

	//장바구니리스트
	public List<CartDTO> getReadData(String userId){
		return sessionTemplate.selectList("cartMapper.getReadData", userId);	
	}
	
	//장바구니아이템갯수
	public int getTotalItemCount(String userId){
		return sessionTemplate.selectOne("cartMapper.getTotalItemCount", userId);	
	}
	
	//장바구니총액
	public int getTotalItemPrice(String userId){
		return sessionTemplate.selectOne("cartMapper.getTotalItemPrice", userId);	
	}
	
	//장바구니 주문여부
	public int getTotalItemCountYes(String userId){
		return sessionTemplate.selectOne("cartMapper.getTotalItemCountYes", userId);	
	}
	
	//productId찾기
	public String getProductId(String productName, String productSize, String color){
		HashMap<String, String> hMap = new HashMap<String, String>();
		hMap.put("productName", productName);
		hMap.put("productSize", productSize);
		hMap.put("color", color);
		return sessionTemplate.selectOne("cartMapper.getProductId", hMap);	
	}
	
	//장바구니내 기존상품존재여부 확인
	public int searchBeforeProductId(CartDTO dto){
		return sessionTemplate.selectOne("cartMapper.searchBeforeItem", dto);	
	}
	
	//장바구니 상품추가
	public void insertCartItem(CartDTO dto){
		sessionTemplate.insert("cartMapper.insertCartItem", dto);
	}
	
	//장바구니 수량추가
	public void updateCartItemAmountAdd(CartDTO dto){
		sessionTemplate.update("cartMapper.updateCartItemAddAmount", dto);
	}
	
	//장바구니 상품삭제
	public void deleteCartItem(String productId, String userId) {
		HashMap<String, String> hMap = new HashMap<String, String>();
		hMap.put("productId", productId);
		hMap.put("userId", userId);
		sessionTemplate.delete("cartMapper.deleteCart", hMap);
	}
	
	//장바구니 주문여부 확인
	public String checkOrderSelect(String productId, String userId) {
		HashMap<String, String> hMap = new HashMap<String, String>();
		hMap.put("productId", productId);
		hMap.put("userId", userId);
		return sessionTemplate.selectOne("cartMapper.getOrderSelectData", hMap);
	}
	
	//장바구니 주문여부 수정
	public void amendOrderSelect(String productId, String userId, String orderSelect) {
		HashMap<String, String> hMap = new HashMap<String, String>();
		hMap.put("productId", productId);
		hMap.put("userId", userId);
		hMap.put("orderSelect", orderSelect);
		sessionTemplate.update("cartMapper.updateOrderSelectData", hMap);
	}
	
	//장바구니 사이즈/컬러 옵션 변경 입력
	public void updateCartItemSizeOrColor(CartDTO dto){	
		sessionTemplate.update("cartMapper.updateCartItemSizeOrColor", dto);
	}
	
	//장바구니 수량변경
	public void updateCartItemAmount(CartDTO dto){
		sessionTemplate.update("cartMapper.updateCartItemAmount", dto);
	}
}
