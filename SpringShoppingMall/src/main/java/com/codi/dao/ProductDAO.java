package com.codi.dao;

import java.util.HashMap;
import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.ProductDTO;

@Component("productDAO")
public class ProductDAO {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}
	
	//listNew/Best dataCount
	public int getDataCount(){
		int result = 0;

		result = sessionTemplate.selectOne("productMapper.getDataCount");

		return result;
	}	
	
	//Category dataCount
	public int getDataCountCategory(String productCategory){
		int result = 0;

		result = sessionTemplate.selectOne("productMapper.getDataCountCategory",productCategory);

		return result;
	}
	
	//Search dataCount
	public int getDataCountSearch(String searchHeader, String searchCategory){
		int result = 0;
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("searchHeader", searchHeader);
		params.put("searchCategory",searchCategory);
		
		result = sessionTemplate.selectOne("productMapper.getDataCountSearch",params);

		return result;
	}
	
	//listNew list 
	public List<ProductDTO> getList(int start, int end){

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("start", start);
		params.put("end",end);
		

		List<ProductDTO> lists = 
				sessionTemplate.selectList("productMapper.getLists",params);

		return lists;
	}
	
	//listNew 정렬
	public List<ProductDTO> getListOrder(int start, int end,String order){

		HashMap<String, Object> params = new HashMap<String, Object>();

		List<ProductDTO> lists= null;
		
		params.put("start", start);
		params.put("end",end);
		params.put("order",order);

		if(order.equals("storeheart")) {
			lists = sessionTemplate.selectList("productMapper.getListsOrderHeart",params);
		}else if(order.equals("review")){
			lists = sessionTemplate.selectList("productMapper.getListsOrderReview",params);
		}else if(order.equals("rate")){
			lists = sessionTemplate.selectList("productMapper.getListsOrderRate",params);
		}else {
			lists = sessionTemplate.selectList("productMapper.getListsOrder",params);
		}

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
	
	//listCategory 정렬 / listBest 
	public List<ProductDTO> getListsCategoryOrder(int start, int end, String productCategory,String order) {

		List<ProductDTO> lists = null;
		
		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("start", start);
		params.put("end",end);
		params.put("productCategory",productCategory);
		params.put("order",order);
		
		if(order.equals("storeHeart")) {
			lists = sessionTemplate.selectList("productMapper.getListsCategoryOrderHeart",params);
		}else if(order.equals("review")){
			lists = sessionTemplate.selectList("productMapper.getListsCategoryOrderReview",params);
		}else if(order.equals("rate")){
			lists = sessionTemplate.selectList("productMapper.getListsCategoryOrderRate",params);
		}else {
			lists = sessionTemplate.selectList("productMapper.getListsCategoryOrder",params);
		}
		

		return lists;
	}
	
	//listSearch 
	public List<ProductDTO> getListsSearch(int start, int end, String searchHeader , String searchCategory) {

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("end",end);
		params.put("searchHeader",searchHeader);
		params.put("searchCategory",searchCategory);
		
		List<ProductDTO> lists = 
				sessionTemplate.selectList("productMapper.getListsSearch",params);
		

		return lists;
	}
	
	//storeHeartCount
	public int storeHeartCount(String superProduct,String userId){
		

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("superProduct", superProduct);
		params.put("userId",userId);

		int result = 
				sessionTemplate.selectOne("productMapper.storeHeartCount",params);

		return result;
	}
	
	//storeHeartCount2 : 하나의 상품이 받은 하트수
	public int storeHeartCount2(String superProduct){
		
		int result = 
				sessionTemplate.selectOne("productMapper.storeHeartCount2",superProduct);
		
		return result;
	}
	
	//insertHeart
	public void insertHeart(String superProduct,String userId){
		

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("superProduct", superProduct);
		params.put("userId",userId);
		
		sessionTemplate.insert("productMapper.insertHeart",params);
	}
	
	//deleteHeart
	public void deleteHeart(String superProduct,String userId){

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("superProduct", superProduct);
		params.put("userId",userId);
		
		sessionTemplate.delete("productMapper.deleteHeart", params);

	}

	//storeHeartList
	public List<String> storeHeartList(String userId){
	
		List<String> lists = 
				sessionTemplate.selectList("productMapper.storeHeartList",userId);
	
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
