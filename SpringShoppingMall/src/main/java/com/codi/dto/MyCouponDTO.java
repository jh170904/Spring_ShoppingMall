package com.codi.dto;

public class MyCouponDTO {
	private String userId;
	private String issueDate;
	private int couponKey;
	private String couponName;
	private String couponStartDate;
	private String couponEndDate;
	private int discount;
	private int couponScore;
	private String used;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getIssueDate() {
		return issueDate;
	}
	public void setIssueDate(String issueDate) {
		this.issueDate = issueDate;
	}
	public int getCouponKey() {
		return couponKey;
	}
	public void setCouponKey(int couponKey) {
		this.couponKey = couponKey;
	}
	public String getCouponName() {
		return couponName;
	}
	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}
	public String getCouponStartDate() {
		return couponStartDate;
	}
	public void setCouponStartDate(String couponStartDate) {
		this.couponStartDate = couponStartDate;
	}
	public String getCouponEndDate() {
		return couponEndDate;
	}
	public void setCouponEndDate(String couponEndDate) {
		this.couponEndDate = couponEndDate;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public int getCouponScore() {
		return couponScore;
	}
	public void setCouponScore(int couponScore) {
		this.couponScore = couponScore;
	}
	public String getUsed() {
		return used;
	}
	public void setUsed(String used) {
		this.used = used;
	}
	
}
