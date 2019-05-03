package com.codi.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.CommunityDTO;

@Component("communityDAO")
public class CommunityDAO {	@Autowired
	
	private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}
	
	public int getDataCount(){
		
		int result = 0;

		result = sessionTemplate.selectOne("commuMapper.getDataCount");

		System.out.println(result);
		
		return result;
	}	

	public List<CommunityDTO> getLists(int start, int end){

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("start", start);
		params.put("end",end);
		

		List<CommunityDTO> lists = 
				sessionTemplate.selectList("commuMapper.getLists",params);
		
		System.out.println(lists);

		return lists;
	}
	
}
