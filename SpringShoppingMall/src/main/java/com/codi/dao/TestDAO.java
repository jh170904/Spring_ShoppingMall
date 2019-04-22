package com.codi.dao;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.codi.dto.TestDTO;

public class TestDAO {
	
	private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}

	public int getMaxNum(){
		int maxNum = 0;
		maxNum = sessionTemplate.selectOne("boardMapper.maxNum");
		return maxNum;
	}
	
	public void insertData(TestDTO dto){
		sessionTemplate.insert("boardMapper.insertData",dto);
	}
	
	public List<TestDTO> getList(int start, int end,String searchKey, String searchValue){
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("end", end);
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		
		List<TestDTO> lists = sessionTemplate.selectList("boardMapper.getLists",params);
		return lists;
	}
	
	public int getDataCount(String searchKey,String searchValue){
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
	
		int result = sessionTemplate.selectOne("boardMapper.getDataCount",params);
		return result;
	}
	
	public void updateHitCount(int num){
		sessionTemplate.update("boardMapper.updateHitCount",num);
	}
	
	public TestDTO getReadData(int num){
		TestDTO dto = sessionTemplate.selectOne("boardMapper.getReadData", num);	
		return dto;
	}
	
	public void deleteData(int num){
		sessionTemplate.delete("boardMapper.deleteData",num);
	}
	
	public void updateData(TestDTO dto){
		sessionTemplate.update("boardMapper.updateData",dto);
	}
	
}