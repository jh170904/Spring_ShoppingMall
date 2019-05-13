package com.codi.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.CommunityDTO;
import com.codi.dto.ProductDTO;

@Component("communityDAO")
public class CommunityDAO {	@Autowired
	
	private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}
	
	public int getDataCount(){
		
		int result = 0;

		result = sessionTemplate.selectOne("commuMapper.getDataCount");
		
		return result;
	}	

	public List<CommunityDTO> getLists(int start, int end){

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("start", start);
		params.put("end",end);
		

		List<CommunityDTO> lists = 
				sessionTemplate.selectList("commuMapper.getLists",params);

		return lists;
	}
	
	//myCodiHeart
	public int myCodiHeart(int iNum,String userId){
		

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("iNum", iNum);
		params.put("userId",userId);

		int result = 
				sessionTemplate.selectOne("commuMapper.myCodiHeart",params);

		return result;
	}
	
	//myCodiHeartList
	public List<String> myCodiHeartList(String userId){
	
		List<String> lists = 
				sessionTemplate.selectList("commuMapper.myCodiHeartList",userId);
	
		return lists;
	}
	
	//myCodiHeartList
	public int heartCount(int iNum){
	
		int heartCount = 
				sessionTemplate.selectOne("commuMapper.heartCount",iNum);
	
		return heartCount;
	}
	
	//insertHeart
	public void insertHeart(int iNum,String userId){
		

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("iNum", iNum);
		params.put("userId",userId);
		
		sessionTemplate.insert("commuMapper.insertHeart",params);
	}
	
	//deleteHeart
	public void deleteHeart(int iNum,String userId){

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("iNum", iNum);
		params.put("userId",userId);
		
		sessionTemplate.delete("commuMapper.deleteHeart", params);

	}
	
	//myFriendList
	public List<String> myFollowList(String userId){
	
		List<String> lists = 
				sessionTemplate.selectList("commuMapper.myFollowList",userId);
		
		return lists;
	}
	
	//commuHome.jsp ºÎºÐ
	public CommunityDTO commuMain(){
		CommunityDTO dto = sessionTemplate.selectOne("commuMapper.commuMain");
		return dto;
	}
	
	
	public List<CommunityDTO> selectTodayCodi(){
		List<CommunityDTO> lists = sessionTemplate.selectList("commuMapper.selectTodayCodi");
		return lists;
	}
	
	public List<CommunityDTO> followNews(String myId){
		List<CommunityDTO> lists = sessionTemplate.selectList("commuMapper.followNews",myId);
		return lists;
	}
}
