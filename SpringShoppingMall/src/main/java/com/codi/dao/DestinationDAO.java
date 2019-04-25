package com.codi.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.DestinationDTO;

@Component("destinationDAO")
public class DestinationDAO {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;

	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}
	
	public void insertData(DestinationDTO dto) {
		sessionTemplate.insert("destMapper.insertData",dto);
	}
	
	public List<DestinationDTO> getList(String userId){
		List<DestinationDTO> lists = sessionTemplate.selectList("destMapper.getList",userId);
		return lists;
	}
	
	public DestinationDTO getReadData(String userId, String destNickname){
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("destNickname", destNickname);
		
		DestinationDTO dto = sessionTemplate.selectOne("destMapper.getReadData",params);
		return dto;
	}
	
	public int getDataCount(String userId){
		int result = sessionTemplate.selectOne("destMapper.getDataCount",userId);
		return result;
	}
	
	public List<DestinationDTO> selectDestNickname(String userId, String destNickname){
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("destNickname", destNickname);
		
		List<DestinationDTO> lists = sessionTemplate.selectList("destMapper.selectDescNickname",params);
		return lists;
	}
	
	public void changeAddrkeyNo(String userId) {
		sessionTemplate.update("destMapper.changeAddrkeyNo",userId);
	}
	
	public void changeAddrkeyYes(String userId, String destNickname) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("destNickname", destNickname);
		sessionTemplate.update("destMapper.changeAddrkeyYes",params);
	}
	
	public void updateData(DestinationDTO dto) {
		sessionTemplate.update("destMapper.updateData",dto);
	}
	
	public void deleteData(String userId, String destNickname) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("destNickname", destNickname);
		sessionTemplate.delete("destMapper.deleteData",params);
	}

}
