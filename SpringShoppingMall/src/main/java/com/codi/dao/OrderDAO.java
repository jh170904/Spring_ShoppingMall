package com.codi.dao;

import java.awt.image.RescaleOp;
import java.util.HashMap;
import java.util.List;

import javax.naming.spi.DirStateFactory.Result;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.AdminPaymentDTO;
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
	
	public int getMaxNum() {
		int result = sessionTemplate.selectOne("orderMapper.getMaxNum");
		return result;
	}
	
	public void insertOrderDataProduct(OrderDTO dto) {
		sessionTemplate.insert("orderMapper.insertOrderDataProduct",dto);
	}
	
	public void insertOrderPayment(String orderNum,String userId,int totalPrice,int discount) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("orderNum", orderNum);
		params.put("userId", userId);
		params.put("totalPrice", totalPrice);
		params.put("discount", discount);
		
		sessionTemplate.insert("orderMapper.insertOrderPayment",params);
	}

	public void updateProductAcount(int amount, String superProduct) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("amount", amount);
		params.put("superProduct", superProduct);
		sessionTemplate.update("orderMapper.updateProductAcount",params);
	}
	
	public String searchUserId(String orderNum) {
		String result = sessionTemplate.selectOne("orderMapper.searchUserId",orderNum);
		return result;
	}
	
	public void updateOrderDataProduct(String userId, String orderNum) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("orderNum", orderNum);
		sessionTemplate.update("orderMapper.updateOrderDataProduct",params);
	}

	public List<OrderDTO> getOrderNumData(String orderNum) {
		List<OrderDTO> lists = sessionTemplate.selectList("orderMapper.getOrderNumData",orderNum);
		return lists;
	}
	
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
	
	public void updateMemberPointUse(String userId,int point) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("point", point);
		
		sessionTemplate.update("orderMapper.updateMemberPointUse",params);
	}
	
	public List<OrderDTO> getCompleteOrder(String userId, String orderNum) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("orderNum", orderNum);
		
		List<OrderDTO> lists = sessionTemplate.selectList("orderMapper.getCompleteOrder",params);
		return lists;
	}
	
	public int reviewCount() {
		int result = sessionTemplate.selectOne("orderMapper.reviewCount");
		return result;
	}
	
	public void insertReview(ReviewDTO reviewDTO) {
		sessionTemplate.insert("orderMapper.insertReview",reviewDTO);
	}
	
	public List<OrderDTO> getUserOrderLists(String userId, int num, String searchPeriod, int start, int end){
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("num", num);
		params.put("searchPeriod", searchPeriod);
		params.put("start", start);
		
		List<OrderDTO> lists = sessionTemplate.selectList("orderMapper.getUserOrderLists",params);
		return lists;
	}
	
	public List<String> getUserOrderNum(String userId,int num,String searchPeriod,int start,int end) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("num", num);
		params.put("searchPeriod", searchPeriod);
		params.put("start", start);
		params.put("end", end);
		
		List<String> orderNum = sessionTemplate.selectList("orderMapper.getUserOrderNum",params);
		return orderNum;
	}
	
	public int getNumUserOrderLists(String userId,int num, String searchPeriod) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("num", num);
		params.put("searchPeriod", searchPeriod);
		int result = sessionTemplate.selectOne("orderMapper.getNumUserOrderLists",params);
		return result;
	}
	
	public int gradePoint(String userId) {
		int result = sessionTemplate.selectOne("orderMapper.gradePoint",userId);
		return result;
	}
	
	public void updateGrade(String userId, String userGrade) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("userGrade", userGrade);
		sessionTemplate.update("orderMapper.updateGrade",params);
	}
	
	public List<AdminPaymentDTO> adminPaymentCheck(int start, int end, String searchOrderName){
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("end", end);
		params.put("searchOrderName", searchOrderName);
		List<AdminPaymentDTO> lists = sessionTemplate.selectList("orderMapper.adminPaymentCheck",params);
		return lists;
	}
	
	public List<AdminPaymentDTO> adminPaymentCheck2(){
		List<AdminPaymentDTO> lists = sessionTemplate.selectList("orderMapper.adminPaymentCheck2");
		return lists;
	}
	
	public int adminPaymentCheckCount(String orderNum){
		int restult = sessionTemplate.selectOne("orderMapper.adminPaymentCheckCount",orderNum);
		return restult;
	}
	
	public int adminPaymentCheckCountAll(String searchOrderName){
		int restult = sessionTemplate.selectOne("orderMapper.adminPaymentCheckCountAll",searchOrderName);
		return restult;
	}
	
	public String adminPaymentCheckProduct(String orderNum){
		String restult = sessionTemplate.selectOne("orderMapper.adminPaymentCheckProduct",orderNum);
		return restult;
	}
	
	public List<AdminPaymentDTO> adminDiscountPrice(){
		List<AdminPaymentDTO> lists = sessionTemplate.selectList("orderMapper.adminDiscountPrice");
		return lists;
	}
}
