package com.codi.dto;

public class ReviewDTO {
	
	//리뷰 작성시 필요한 데이터
	private int reviewNum;
	private String userId;
	private String productId;
	private String productCategory;
	private String productName;
	private String productSize;
	private String color;
	
	//리뷰 확인시 필요
	private String pageNum;
	private String reviewDate_view;
	private String order;
	
	//리뷰 등록시 필요
	private int rate;
	private String subject;
	private String content;
	private String reviewDate;
	private String originalName;
	private String savefileName;
	private String writed;
	
	//상품 이동시 필요
	private String superProduct;
	
	//도움이 돼요 출력시 필요
	private int goodCount;
	
	//신고에서 필요
	private String reportContent;
	private int reportCount;
	
	//관리자에서 필요
	private String reportedUserId;
	
	public int getReviewNum() {
		return reviewNum;
	}
	public void setReviewNum(int reviewNum) {
		this.reviewNum = reviewNum;
	}
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	
	public String getProductCategory() {
		return productCategory;
	}
	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}
	
	public String getProductSize() {
		return productSize;
	}
	public void setProductSize(String productSize) {
		this.productSize = productSize;
	}
	
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	
	public String getPageNum() {
		return pageNum;
	}
	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}
	
	public String getReviewDate_view() {
		return reviewDate_view;
	}
	public void setReviewDate_view(String reviewDate_view) {
		this.reviewDate_view = reviewDate_view;
	}

	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	
	public int getRate() {
		return rate;
	}
	public void setRate(int rate) {
		this.rate = rate;
	}
	
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(String reviewDate) {
		this.reviewDate = reviewDate;
	}
	
	public String getOriginalName() {
		return originalName;
	}
	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}
	
	public String getSavefileName() {
		return savefileName;
	}
	public void setSavefileName(String savefileName) {
		this.savefileName = savefileName;
	}
	
	public String getWrited() {
		return writed;
	}
	public void setWrited(String writed) {
		this.writed = writed;
	}
	
	public String getSuperProduct() {
		return superProduct;
	}
	public void setSuperProduct(String superProduct) {
		this.superProduct = superProduct;
	}
	
	public int getGoodCount() {
		return goodCount;
	}
	public void setGoodCount(int goodCount) {
		this.goodCount = goodCount;
	}
	
	public String getReoprtContent() {
		return reportContent;
	}
	public void setReoprtContent(String reportContent) {
		this.reportContent = reportContent;
	}
	
	public int getReportCount() {
		return reportCount;
	}
	public void setReportCount(int reportCount) {
		this.reportCount = reportCount;
	}
	
	public String getReportedUserId() {
		return reportedUserId;
	}
	public void setReportedUserId(String reportedUserId) {
		this.reportedUserId = reportedUserId;
	}
	

}
