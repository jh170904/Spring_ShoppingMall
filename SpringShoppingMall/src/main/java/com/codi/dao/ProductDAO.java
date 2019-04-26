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
	
	//listNew(카테고리 ALL) dataCount
	public int getDataCount(){
		int result = 0;

		result = sessionTemplate.selectOne("productMapper.getDataCount");

		return result;
	}	
	
	//listNew(카테고리 ALL) dataCount
	public int getDataCountCategory(String productCategory){
		int result = 0;

		result = sessionTemplate.selectOne("productMapper.getDataCountCategory",productCategory);

		return result;
	}	
	
	//listNew(카테고리 ALL) list
	public List<ProductDTO> getList(int start, int end){

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("start", start);
		params.put("end",end);
		

		List<ProductDTO> lists = 
				sessionTemplate.selectList("productMapper.getLists",params);

		return lists;
	}
	
	//listNew(카테고리 ALL) list
	public List<ProductDTO> getListOrder(int start, int end,String order){

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("start", start);
		params.put("end",end);
		params.put("order",order);
		

		List<ProductDTO> lists = 
				sessionTemplate.selectList("productMapper.getListsOrder",params);

		return lists;
	}
	
	//listCategory list
	public List<ProductDTO> getListsCategory(int start, int end, String productCategory) {

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("start", start);
		params.put("end",end);
		params.put("productCategory",productCategory);
		

		List<ProductDTO> lists = 
				sessionTemplate.selectList("productMapper.getListsCategory",params);
		

		return lists;
	}
	
	//listCategoryOrder list
	public List<ProductDTO> getListsCategoryOrder(int start, int end, String productCategory,String order) {

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("start", start);
		params.put("end",end);
		params.put("productCategory",productCategory);
		params.put("order",order);
		
		

		List<ProductDTO> lists = 
				sessionTemplate.selectList("productMapper.getListsCategoryOrder",params);
		


		return lists;
	}
	
	//productAdminCreate
	public void insertData(ProductDTO dto){
		sessionTemplate.insert("productMapper.insertData",dto);
	}
	
	//productAdminList
	public List<ProductDTO> getAdminLists(){

		List<ProductDTO> lists = 
				sessionTemplate.selectList("productMapper.getAdminLists");

		return lists;
	}
	
	//productAdminDelete
	public void productAdminDelete(String productId){

		sessionTemplate.delete("productMapper.productAdminDelete", productId);

	}
	
	
}
