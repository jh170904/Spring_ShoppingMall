package com.codi.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.CouponDTO;
import com.codi.dto.IssueDTO;
import com.codi.dto.MyCouponDTO;


@Component("couponDAO")
public class CouponDAO {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}
	
	public void insertData(CouponDTO dto){
		
		sessionTemplate.insert("couponMapper.insertData",dto);
	}
	
	public int getMaxNum(){
		int result = 0;

		result = sessionTemplate.selectOne("couponMapper.getMaxNum");

		return result;
	}	
	
	public int getDataCount(){
		int result = 0;

		result = sessionTemplate.selectOne("couponMapper.getDataCount");

		return result;
	}	
	
	public List<CouponDTO> getList(int start, int end){

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("start", start);
		params.put("end",end);
		

		List<CouponDTO> lists = 
				sessionTemplate.selectList("couponMapper.getLists",params);

		return lists;
	}
	
	public List<CouponDTO> getList(){

		List<CouponDTO> lists = 
				sessionTemplate.selectList("couponMapper.getList");

		return lists;
	}
	
	public List<IssueDTO> couponGetLists(){

		List<IssueDTO> lists = 
				sessionTemplate.selectList("couponMapper.couponGetLists");

		return lists;
	}
	
	public void couponInsertData(IssueDTO dto){
		
		sessionTemplate.insert("couponMapper.couponInsertData",dto);
		
	}
	
	public List<MyCouponDTO> couponGetList(String userId){
		List<MyCouponDTO> lists = 
				sessionTemplate.selectList("couponMapper.couponGetList",userId);

		return lists;
	}
	
	public void couponInsertM(int couponKey,String userId){
		
		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("couponKey", couponKey);
		params.put("userId",userId);
		
		sessionTemplate.update("couponMapper.couponInsertM",params);
	}
}
