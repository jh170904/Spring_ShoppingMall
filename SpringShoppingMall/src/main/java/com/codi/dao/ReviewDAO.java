package com.codi.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.ReviewDTO;

@Component("reviewDAO")
public class ReviewDAO {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}
	
	public List<ReviewDTO> getList(String userId, String writed, int start, int end, String orderBy){
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("writed", writed);
		params.put("start", start);
		params.put("end", end);
		params.put("orderBy", orderBy);
		
		List<ReviewDTO> lists = sessionTemplate.selectList("reviewMapper.getList",params);
		return lists;
	}
	
	public int getDataCount(String userId, String writed) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("writed", writed);
		
		int result = sessionTemplate.selectOne("reviewMapper.getDataCount",params);
		return result;
	}
	
	public ReviewDTO getProductList(int reviewNum) {
		ReviewDTO dto = sessionTemplate.selectOne("reviewMapper.getProductList",reviewNum);
		return dto;		
	}
	
	public void insertData(ReviewDTO dto) {
		sessionTemplate.insert("reviewMapper.insertData",dto);
	}
	
	public String getSaveFile(String userId, String productId, String reviewDate) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("productId", productId);
		params.put("reviewDate", reviewDate);
		
		String result = sessionTemplate.selectOne("reviewMapper.getSaveFile",params);
		return result;
	}
	
	public void deleteData(int reviewNum) {		
		sessionTemplate.delete("reviewMapper.deleteData",reviewNum);
	}
	
	public int getProductDataCount(String superProduct) {
		int result = sessionTemplate.selectOne("reviewMapper.getProductDataCount",superProduct);
		return result;
	}
	
	public List<ReviewDTO> productGetList(String superProduct, int start, int end,String orderBy){
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("superProduct", superProduct);
		params.put("start", start);
		params.put("end", end);
		params.put("orderBy", orderBy);
		
		List<ReviewDTO> lists = sessionTemplate.selectList("reviewMapper.productGetList",params);
		return lists;
	}
	
	public float productGetList_heart(String superProduct){
		float result = sessionTemplate.selectOne("reviewMapper.productGetList_heart",superProduct);
		return result;
	}
	
	public int getProductDataCountHeart(String superProduct, int rate) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("superProduct", superProduct);
		params.put("rate", rate);
		
		int result = sessionTemplate.selectOne("reviewMapper.getProductDataCountHeart",params);
		return result;
	}

	//도움이 돼요 클릭시 필요
	public int reviewGoodCount(String reviewNum,String userId) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("reviewNum", reviewNum);
		params.put("userId",userId);
		
		int result = sessionTemplate.selectOne("reviewMapper.reviewGoodCount",params);
		return result;
	}
	
	public void insertReviewGood(String reviewNum,String userId) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("reviewNum", reviewNum);
		params.put("userId",userId);
		
		sessionTemplate.insert("reviewMapper.insertReviewGood",params);

	}

	public void deleteReviewGood(String reviewNum,String userId) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("reviewNum", reviewNum);
		params.put("userId",userId);
		
		sessionTemplate.delete("reviewMapper.deleteReviewGood",params);
	
	}
	
	public List<String> reviewGoodList(String userId){
		List<String> lists = sessionTemplate.selectList("reviewMapper.reviewGoodList",userId);
		return lists;		
	}
	
	public int reviewAllCount(int reviewNum) {
		int lists = sessionTemplate.selectOne("reviewMapper.reviewAllCount",reviewNum);
		return lists;
	}
	
	//후기 신고에서 필요
	public int reviewReportCount(String reviewNum,String userId) {
			
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("reviewNum", reviewNum);
		params.put("userId",userId);
		
		int result = sessionTemplate.selectOne("reviewMapper.reviewReportCount",params);
		return result;
	}
		
	public void insertReviewReport(String reviewNum,String userId,String reportContent) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("reviewNum", reviewNum);
		params.put("userId",userId);
		params.put("reportContent",reportContent);
		
		sessionTemplate.insert("reviewMapper.insertReviewReport",params);

	}

	public void deleteReviewReport(String reviewNum,String userId) {
			
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("reviewNum", reviewNum);
		params.put("userId",userId);
			
		sessionTemplate.delete("reviewMapper.deleteReviewReport",params);
		
	}
		
	public List<String> reviewReportList(String userId){
		List<String> lists = sessionTemplate.selectList("reviewMapper.reviewReportList",userId);
		return lists;		
	}
		
	public int reviewReportAllCount(int reviewNum) {
		int lists = sessionTemplate.selectOne("reviewMapper.reviewReportAllCount",reviewNum);
		return lists;
	}
	
	//관리자에서 필요
	public int countReportReview() {
		int result = sessionTemplate.selectOne("reviewMapper.countReportReview");
		return result;
	}
	
	public List<ReviewDTO> reviewNumAndCount(int start, int end) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("end", end);
		
		List<ReviewDTO> lists = sessionTemplate.selectList("reviewMapper.reviewNumAndCount",params);
		return lists;
	}
	
	public List<ReviewDTO> reportedReview(){
		List<ReviewDTO> lists = sessionTemplate.selectList("reviewMapper.reportedReview");
		return lists;
	}
	
	public void deleteReviewAdmin(int reviewNum) {
		sessionTemplate.delete("reviewMapper.deleteReviewAdmin",reviewNum);		
	}
	
}