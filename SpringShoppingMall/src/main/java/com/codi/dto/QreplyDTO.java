package com.codi.dto;

public class QreplyDTO {
	
	private int replyNum;
	private String userId;
	private String userName;
	private int qNum;
	private String content;
	private String replyDate;
	private String mImage;
	
	public String getmImage() {
		return mImage;
	}
	public void setmImage(String mImage) {
		this.mImage = mImage;
	}
	public int getReplyNum() {
		return replyNum;
	}
	public void setReplyNum(int replyNum) {
		this.replyNum = replyNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getqNum() {
		return qNum;
	}
	public void setqNum(int qNum) {
		this.qNum = qNum;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(String replyDate) {
		this.replyDate = replyDate;
	}
	


}
