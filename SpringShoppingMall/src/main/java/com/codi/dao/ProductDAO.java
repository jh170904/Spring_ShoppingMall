package com.codi.dao;

import java.util.HashMap;
import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.ProductDTO;
import com.codi.dto.TestDTO;

@Component("productDAO")
public class ProductDAO {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}
	
	public int getDataCount(){
		int result = 0;

		result = sessionTemplate.selectOne("productMapper.getDataCount");

		return result;
	}	
	
	public List<ProductDTO> getList(int start, int end){

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("start", start);
		params.put("end",end);
		

		List<ProductDTO> lists = 
				sessionTemplate.selectList("productMapper.getLists",params);

		return lists;
	}
	
	public void insertData(ProductDTO dto){
		sessionTemplate.insert("productMapper.insertData",dto);
	}
	
	public List<ProductDTO> getAdminLists(){

		List<ProductDTO> lists = 
				sessionTemplate.selectList("productMapper.getAdminLists");

		return lists;
	}
	
	public void productAdminDelete(String productId){

		sessionTemplate.delete("productMapper.productAdminDelete", productId);

	}
	
	
}
