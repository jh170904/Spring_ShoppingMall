package com.codi.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.ProductDetailDTO;

@Component("productDetailDAO")
public class ProductDetailDAO {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	//단일상품조회
	public ProductDetailDTO getReadData(String productId){
		ProductDetailDTO dto = sessionTemplate.selectOne("productDetailMapper.getReadData", productId);	
		return dto;
	}
	
	//색상옵션
	public List<String> getColorList(String superProduct){
		List<String> lists = sessionTemplate.selectList("productDetailMapper.getColorList", superProduct);
		return lists;
	}
	
	//사이즈옵션
	public List<String> getProductSizeList(String superProduct){
		List<String> lists = sessionTemplate.selectList("productDetailMapper.getProductSizeList", superProduct);
		return lists;
	}
	

}
