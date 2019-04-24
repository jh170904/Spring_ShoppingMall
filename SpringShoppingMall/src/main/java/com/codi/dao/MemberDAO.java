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
	
	public int idcheck(String userId) {
		
		int count=sessionTemplate.selectOne("memberMapper.idcheck",userId);
		
		return count;
	}


}



































