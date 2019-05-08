package com.codi.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.CodiDTO;

@Component("codiDAO")
public class CodiDAO {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}
	
	public int getDataCount(){
		int result = 0;

		result = sessionTemplate.selectOne("codiMapper.getDataCount");

		return result;
	}
	
	public int getDataCountSel(String category){
		int result = 0;

		result = sessionTemplate.selectOne("codiMapper.getDataCountSel");

		return result;
	}	
	
	public List<CodiDTO> getList(int start, int end){

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("start", start);
		params.put("end",end);
		

		List<CodiDTO> lists = 
				sessionTemplate.selectList("codiMapper.getLists",params);

		return lists;
	}
	
	public List<CodiDTO> getListCtg(String category){
		
		List<CodiDTO> lists = 
				sessionTemplate.selectList("codiMapper.getListsSelect",category);

		return lists;
	}
	
	//codilist 테이블에 insert
	public void insertCodi(int inum, String array,String iimage,String userid){

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("inum", inum);
		params.put("productId",array);
		params.put("iimage",iimage);
		params.put("userid",userid);

		sessionTemplate.insert("codiMapper.insertCodi",params);
	}
	
	//inum가져옴
	public int getMaxNum(){
			
		int maxNum = 0;
			
		maxNum=sessionTemplate.selectOne("codiMapper.maxNum");
		
		return maxNum;
		
	}
	

}
