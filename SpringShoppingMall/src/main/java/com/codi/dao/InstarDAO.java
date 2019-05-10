package com.codi.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.CommunityDTO;
import com.codi.dto.MemberDTO;
import com.codi.dto.ProductDTO;

@Component("instarDAO")
public class InstarDAO {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;

	public List<MemberDTO> getUserInfo(String userId){
		List<MemberDTO> lists = sessionTemplate.selectList("instarMapper.getUserInfo",userId);
		return lists;
	}
	
	public int getDataCount() {
		int result = sessionTemplate.selectOne("instarMapper.getDataCount");
		return result;
	}
	
	public void updateInstar(CommunityDTO dto) {
		sessionTemplate.update("instarMapper.updateInstar",dto);
	}
	
	public void insertHashtag(int iNum, String tagContent) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("iNum", iNum);
		params.put("tagContent", tagContent);
		sessionTemplate.insert("instarMapper.insertHashtag",params);
		
	}
	
	public void deleteHashtag(int iNum, String tagContent) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("iNum", iNum);
		params.put("tagContent", tagContent);
		sessionTemplate.delete("instarMapper.deleteHashtag",params);
		
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
	
	public int getUserCodiHeartCount(String userId) {
		int result = sessionTemplate.selectOne("instarMapper.getUserCodiHeartCount",userId);
		return result;
	}
	
	public List<CommunityDTO> getUserCodiHeart(String userId,int start, int end){
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("start", start);
		params.put("end", end);
		
		List<CommunityDTO> lists = sessionTemplate.selectList("instarMapper.getUserCodiHeart",params);
		return lists;
	}
	
	public int countUserStoreHeart(String userId) {
		int result = sessionTemplate.selectOne("instarMapper.countUserStoreHeart",userId); 
		return result;	
	}
	
	public List<ProductDTO> userStoreHeart(String userId,int start, int end){		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("start", start);
		params.put("end", end);
		
		List<ProductDTO> lists = sessionTemplate.selectList("instarMapper.userStoreHeart",params);
		return lists;
	}
}
