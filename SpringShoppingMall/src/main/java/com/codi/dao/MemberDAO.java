package com.codi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSource;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.MemberDTO;

@Component("memberDAO")
public class MemberDAO {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;

//	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
//		this.sessionTemplate = sessionTemplate;
//	}
	
	public void insertData(MemberDTO dto){
		
		sessionTemplate.insert("memberMapper.insertData",dto);
	}
	
	public MemberDTO getReadData(String userId){

		MemberDTO dto = sessionTemplate.selectOne("memberMapper.getReadData",userId);
		
		return dto;
	}
	
	public String originalProfile(String userId){

		String name = sessionTemplate.selectOne("mypageMapper.originalProfile",userId);
		
		return name;
	}
	
	public int idcheck(String userId) {
		
		int count=sessionTemplate.selectOne("memberMapper.idcheck",userId);
		
		return count;
	}
	
	public String findId(MemberDTO dto) {
		
		String userId=sessionTemplate.selectOne("memberMapper.findId",dto);
		
		return userId;
	}
	
	//비밀번호 찾기
	public String findPwd(MemberDTO dto) {
		
		String userPwd=sessionTemplate.selectOne("memberMapper.findPwd",dto);
		
		return userPwd;
	}
	
	//비밀번호 찾기(이메일)
	public String findPwdTemp(MemberDTO dto) {
		
		String email=sessionTemplate.selectOne("memberMapper.findPwdTemp",dto);
		
		return email;
	}
	
	//로그인 Ajax검사
	public int loginChk(MemberDTO dto) {
		
		int count=sessionTemplate.selectOne("memberMapper.loginChk",dto);
		
		return count;
	}
	//정보수정 Pwd
	public void updatePwd(MemberDTO dto){
		
		sessionTemplate.update("memberMapper.updatePwd",dto);
		
	}
	
	//정보수정 Data
	public void updateData(MemberDTO dto){
		
		sessionTemplate.update("memberMapper.updateData",dto);
		
	}
	
	//follow
	public int myFollow(String myId,String myFriendId){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("myId", myId);
		params.put("myFriendId",myFriendId);
		
		int result = sessionTemplate.selectOne("commuMapper.myFollow",params);
		
		return result;
	}
	
	//follow
	public void insertFollow(String myId,String myFriendId){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("myId", myId);
		params.put("myFriendId",myFriendId);
		
		sessionTemplate.insert("memberMapper.insertFollow",params);
		
	}
	
	//follow
	public void deleteFollow(String myId,String myFriendId){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("myId", myId);
		params.put("myFriendId",myFriendId);
		
		sessionTemplate.insert("memberMapper.deleteFollow",params);
		
	}
	
	public int countMember(String searchUserName) {
		
		int count=sessionTemplate.selectOne("memberMapper.countMember",searchUserName);
		
		return count;
	}
	
	public List<MemberDTO> getAllData(String searchUserName,int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("searchUserName", searchUserName);
		params.put("start",start);
		params.put("end",end);
		
		List<MemberDTO> lists = sessionTemplate.selectList("memberMapper.getAllData",params);
		
		return lists;
	}
	
	//전체 메일 발송시 필요
	public List<String> allEmail(){
		
		List<String> lists = sessionTemplate.selectList("memberMapper.allEmail");
	
		return lists;
	}


}



































