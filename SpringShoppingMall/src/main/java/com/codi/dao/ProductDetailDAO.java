package com.codi.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.ProductDTO;
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
	
	//단일상품조회
	public ProductDetailDTO getUpdateData(String productId){
		ProductDetailDTO dto = sessionTemplate.selectOne("productDetailMapper.getUpdateData", productId);	
		return dto;
	}
	
	//Admin상품정보수정
	public void updateData(ProductDTO dto){
		sessionTemplate.update("productDetailMapper.updateData", dto);	
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
	
	//상세이미지등록
	public void insertData(ProductDetailDTO dto) {
		 sessionTemplate.insert("productDetailMapper.insertData", dto);
	}
	
	//상위상품검색
	public String searchSuperProduct(String productName) {
		 return sessionTemplate.selectOne("productDetailMapper.getSuperProduct", productName);
	}
	
	//상세사진리스트
	public List<ProductDetailDTO> getDetailImageList(String superProduct) {
		 return sessionTemplate.selectList("productDetailMapper.getDetailImageList", superProduct);
	}
	
	
}
