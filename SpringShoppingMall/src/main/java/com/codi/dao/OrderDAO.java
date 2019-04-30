package com.codi.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.DestinationDTO;
import com.codi.dto.OrderDTO;
import com.codi.dto.OrderListDTO;
import com.codi.dto.ReviewDTO;

@Component("orderDAO")
public class OrderDAO {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;

	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}	
	
	public DestinationDTO getOrderDest(String userId) {
		DestinationDTO dto = sessionTemplate.selectOne("orderMapper.getOrderDest",userId);
		return dto;
	}
	
	public List<DestinationDTO> getAllDest(String userId){
		List<DestinationDTO> lists = sessionTemplate.selectList("orderMapper.getAllDest",userId);
		return lists;
	}
	
	public int getMemberPoint(String userId) {
		int result = sessionTemplate.selectOne("orderMapper.getMemberPoint",userId);
		return result;
	}
	
	public List<OrderListDTO> getOrderList(String userId) {
		List<OrderListDTO> lists = sessionTemplate.selectList("orderMapper.getOrderList",userId);
		return lists;
	}
	
	public int getOrderCount(String userId) {
		int result = sessionTemplate.selectOne("orderMapper.getOrderCount",userId);
		return result;
	}
/*	
	public List<CouponDTO> getUserCoupon(String userId, int couponScore){
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("couponScore", couponScore);
		
		List<CouponDTO> lists = sessionTemplate.selectList("orderMapper.getUserCoupon",params);
		return lists;
	}
*/
	
	public int getMaxNum() {
		int result = sessionTemplate.selectOne("orderMapper.getMaxNum");
		return result;
	}
	
	public void insertOrderDataProduct(OrderDTO dto) {
		sessionTemplate.insert("orderMapper.insertOrderDataProduct",dto);
	}
	
	public void updateOrderDataProduct(String userId, String orderNum) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("orderNum", orderNum);
		sessionTemplate.update("orderMapper.updateOrderDataProduct",params);
	}
/*	
	public void useCouponUpdate(String userId, String couponKey) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("couponKey", couponKey);
		
		sessionTemplate.update("orderMapper.useCouponUpdate",params);
	}
*/	
	public void deleteCartProduct(String userId,String productId) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("productId", productId);
		
		sessionTemplate.delete("orderMapper.deleteCartProduct",params);
	}
	
	public void updateMemberPoint(String userId,int point) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("point", point);
		
		sessionTemplate.update("orderMapper.updateMemberPoint",params);
	}
	
	public List<OrderDTO> getCompleteOrder(String userId, String orderNum) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("orderNum", orderNum);
		
		List<OrderDTO> lists = sessionTemplate.selectList("orderMapper.getCompleteOrder",params);
		return lists;
	}
	
	public void insertReview(ReviewDTO reviewDTO) {
		sessionTemplate.insert("orderMapper.insertReview",reviewDTO);
	}
	
	public List<OrderDTO> getUserOrderLists(String userId, int num, String searchPeriod,int start, int end){
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("num", num);
		params.put("searchPeriod", searchPeriod);
		params.put("start", start);
		params.put("end", end);
		
		List<OrderDTO> lists = sessionTemplate.selectList("orderMapper.getUserOrderLists",params);
		return lists;
	}
	
	public int getNumUserOrderLists(String userId,int num, String searchPeriod) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("num", num);
		params.put("searchPeriod", searchPeriod);
		int result = sessionTemplate.selectOne("orderMapper.getNumUserOrderLists",params);
		return result;
	}
	
}
