package com.codi.dto;

import java.util.List;

public class CommunityDTO {

	private int iNum;
	private String iSubject;
	private String iContent;
	private String userId;
	private String iImage;
	private String iDate;
	private int iHitCount;
	private String iHashTag;
	private int iHeart;
	private int iComment;
	private int heartCount;
	
	
	
	public int getHeartCount() {
		return heartCount;
	}
	public void setHeartCount(int heartCount) {
		this.heartCount = heartCount;
	}
	public int getiNum() {
		return iNum;
	}
	public void setiNum(int iNum) {
		this.iNum = iNum;
	}
	public String getiSubject() {
		return iSubject;
	}
	public void setiSubject(String iSubject) {
		this.iSubject = iSubject;
	}
	public String getiContent() {
		return iContent;
	}
	public void setiContent(String iContent) {
		this.iContent = iContent;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getiImage() {
		return iImage;
	}
	public void setiImage(String iImage) {
		this.iImage = iImage;
	}
	public String getiDate() {
		return iDate;
	}
	public void setiDate(String iDate) {
		this.iDate = iDate;
	}
	public int getiHitCount() {
		return iHitCount;
	}
	public void setiHitCount(int iHitCount) {
		this.iHitCount = iHitCount;
	}
	public String getiHashTag() {
		return iHashTag;
	}
	public void setiHashTag(String iHashTag) {
		this.iHashTag = iHashTag;
	}
	public int getiHeart() {
		return iHeart;
	}
	public void setiHeart(int iHeart) {
		this.iHeart = iHeart;
	}
	public int getiComment() {
		return iComment;
	}
	public void setiComment(int iComment) {
		this.iComment = iComment;
	}
	
}
