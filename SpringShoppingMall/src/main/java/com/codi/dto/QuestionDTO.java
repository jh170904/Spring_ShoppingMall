package com.codi.dto;

import java.util.ArrayList;

public class QuestionDTO {
	
	private int qNum;
	private String qSubject;
	private String qContent;
	private String userId;
	private String originalName;
	private String saveFileName;
	private String qDate;
	private int qHitCount;
	private String qHashTag;
	
	private ArrayList<String> qHash;//hashtag 끊어서 여기에 List로 저장
	private String mImage;
	private int replyCount;
	
	private String mode;
	

	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public ArrayList<String> getqHash() {
		return qHash;
	}
	public void setqHash(ArrayList<String> qHash) {
		this.qHash = qHash;
	}
	public String getmImage() {
		return mImage;
	}
	public void setmImage(String mImage) {
		this.mImage = mImage;
	}
	public String getqDate() {
		return qDate;
	}
	public void setqDate(String qDate) {
		this.qDate = qDate;
	}
	public int getqNum() {
		return qNum;
	}
	public void setqNum(int qNum) {
		this.qNum = qNum;
	}
	public String getqSubject() {
		return qSubject;
	}
	public void setqSubject(String qSubject) {
		this.qSubject = qSubject;
	}
	public String getqContent() {
		return qContent;
	}
	public void setqContent(String qContent) {
		this.qContent = qContent;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getOriginalName() {
		return originalName;
	}
	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}
	public String getSaveFileName() {
		return saveFileName;
	}
	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}
	public int getqHitCount() {
		return qHitCount;
	}
	public void setqHitCount(int qHitCount) {
		this.qHitCount = qHitCount;
	}
	public String getqHashTag() {
		return qHashTag;
	}
	public void setqHashTag(String qHashTag) {
		this.qHashTag = qHashTag;
	}
	
	
	
}
