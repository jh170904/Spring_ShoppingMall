package com.codi.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.ProductDTO;


@Component("myPageDAO")
public class MyPageDAO {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}
	
	
	public int getDataCount(String userId){
		int result = 0;

		result = sessionTemplate.selectOne("mypageMapper.getDataCount",userId);

		return result;
	}	
	
	public List<ProductDTO> getList(int start, int end,String userId){

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("start", start);
		params.put("end",end);
		params.put("userId",userId);
		
		List<ProductDTO> lists = 
				sessionTemplate.selectList("mypageMapper.getLists",params);

		
		System.out.println(lists);

		return lists;
	}
	
}
