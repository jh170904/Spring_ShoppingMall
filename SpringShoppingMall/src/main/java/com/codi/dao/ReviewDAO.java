package com.codi.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.ReviewDTO;

@Component("reviewDAO")
public class ReviewDAO {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;

	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}
	
	public List<ReviewDTO> getList(String userId, String writed, int start, int end, String orderBy){
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("writed", writed);
		params.put("start", start);
		params.put("end", end);
		params.put("orderBy", orderBy);
		
		List<ReviewDTO> lists = sessionTemplate.selectList("reviewMapper.getList",params);
		return lists;
	}
	
	public int getDataCount(String userId, String writed) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("writed", writed);
		
		int result = sessionTemplate.selectOne("reviewMapper.getDataCount",params);
		return result;
	}
	
	public ReviewDTO getProductList(String userId, String productId, String reviewDate) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("productId", productId);
		params.put("reviewDate", reviewDate);
		ReviewDTO dto = sessionTemplate.selectOne("reviewMapper.getProductList",params);
		return dto;		
	}
	
	public void insertData(ReviewDTO dto) {
		sessionTemplate.insert("reviewMapper.insertData",dto);
	}
	
	public String getSaveFile(String userId, String productId, String reviewDate) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("productId", productId);
		params.put("reviewDate", reviewDate);
		
		String result = sessionTemplate.selectOne("reviewMapper.getSaveFile",params);
		return result;
	}
	
	public void deleteData(String userId, String productId, String reviewDate) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("productId", productId);
		params.put("reviewDate", reviewDate);
		
		sessionTemplate.delete("reviewMapper.deleteData",params);
	}
	
	public int getProductDataCount(String productName) {
		int result = sessionTemplate.selectOne("reviewMapper.getProductDataCount",productName);
		return result;
	}
	
	public List<ReviewDTO> productGetList(String productName, String start, String end){
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("productName", productName);
		params.put("start", start);
		params.put("end", end);
		
		List<ReviewDTO> lists = sessionTemplate.selectList("reviewMapper.productGetList",params);
		return lists;
	}
	
	public int getProductDataCountHeart(String productName, int rate) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("productName", productName);
		params.put("rate", rate);
		
		int result = sessionTemplate.selectOne("reviewMapper.getProductDataCountHeart",params);
		return result;
	}
	
}