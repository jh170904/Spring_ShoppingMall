package com.codi.dto;

public class CouponDTO {

	private int couponKey;
	private String couponName;
	private String couponStartDate;
	private String couponEndDate;
	private int discount;
	private String couponGrade;
	private int couponScore;
	
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
	public String getCouponGrade() {
		return couponGrade;
	}
	public void setCouponGrade(String couponGrade) {
		this.couponGrade = couponGrade;
	}
	public int getCouponScore() {
		return couponScore;
	}
	public void setCouponScore(int couponScore) {
		this.couponScore = couponScore;
	}
	
	
}
