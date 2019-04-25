package com.codi.dao;

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
	
	public int getTotalItemCount(String userId){
		return sessionTemplate.selectOne("cartMapper.getTotalItemCount", userId);	
	}
	
	public int getTotalItemPrice(String userId){
		return sessionTemplate.selectOne("cartMapper.getTotalItemPrice", userId);	
	}
	
	public int getTotalItemCountYes(String userId){
		return sessionTemplate.selectOne("cartMapper.getTotalItemCountYes", userId);	
	}
	
}
