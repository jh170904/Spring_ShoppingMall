package com.codi.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.CommunityDTO;
import com.codi.dto.OrderDTO;

@Component("instarDAO")
public class InstarDAO {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}	
	
	public int getDataCount() {
		int result = sessionTemplate.selectOne("instarMapper.getDataCount");
		return result;
	}
	
	public void insertInstar(CommunityDTO dto) {
		sessionTemplate.insert("instarMapper.insertInstar",dto);
	}
		
}
