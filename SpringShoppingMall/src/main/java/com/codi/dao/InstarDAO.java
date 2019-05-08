package com.codi.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.CommunityDTO;

@Component("instarDAO")
public class InstarDAO {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;

	public int getDataCount() {
		int result = sessionTemplate.selectOne("instarMapper.getDataCount");
		return result;
	}
	
	public void insertInstar(CommunityDTO dto) {
		sessionTemplate.insert("instarMapper.insertInstar",dto);
	}
	
	public int countUserInstar(String userId) {
		int result = sessionTemplate.selectOne("instarMapper.countUserInstar",userId);
		return result;
	}
	
	public List<CommunityDTO> selectUserInstar(String userId,int start, int end){
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("start", start);
		params.put("end", end);
		
		List<CommunityDTO> lists = sessionTemplate.selectList("instarMapper.selectUserInstar",params);
		return lists;
		
	}
	
	public CommunityDTO getOneInstar(int iNum) {
		CommunityDTO dto = sessionTemplate.selectOne("instarMapper.getOneInstar",iNum);
		return dto;
	}
	
	public void updateHitCount(int iNum) {
		sessionTemplate.update("instarMapper.updateHitCount",iNum);
	}
		
}
