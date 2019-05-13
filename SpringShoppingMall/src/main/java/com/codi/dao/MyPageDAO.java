package com.codi.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.MemberDTO;
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
		return lists;
	}
	
	//팔로워 : 나를 팔로우 한 사람 userId = myFreindId인 myId값
	public int follower(String userId){
		int result = 0;

		result = sessionTemplate.selectOne("mypageMapper.follower",userId);

		return result;
	}
	
	//팔로잉 : 내가 팔로우 한 사람 userId = myId인 myFreind인값
	public int following(String userId){
		int result = 0;

		result = sessionTemplate.selectOne("mypageMapper.following",userId);

		return result;
	}
	
	public List<MemberDTO> followingList(int start, int end,String userId){

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("start", start);
		params.put("end",end);
		params.put("userId",userId);
		
		List<MemberDTO> lists = 
				sessionTemplate.selectList("mypageMapper.followingList",params);
		
		return lists;
	}
	
	public List<MemberDTO> followerList(int start, int end,String userId){

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("start", start);
		params.put("end",end);
		params.put("userId",userId);
		
		List<MemberDTO> lists = 
				sessionTemplate.selectList("mypageMapper.followerList",params);
		
		return lists;
	}
}
