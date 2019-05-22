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
	private int replyCount;


	private String[] arrHashTag;
	
	private List<ReplyDTO> replydto;
	
	private String mImage;
	private String mMessage;
	
	private String productId;	
	
	private String myId;
	private String myFriendId;
	
	
	
	public String[] getArrHashTag() {
		return arrHashTag;
	}
	public void setArrHashTag(String[] arrHashTag) {
		this.arrHashTag = arrHashTag;
	}
	public List<ReplyDTO> getReplydto() {
		return replydto;
	}
	public void setReplydto(List<ReplyDTO> replydto) {
		this.replydto = replydto;
	}
	public String getMyId() {
		return myId;
	}
	public void setMyId(String myId) {
		this.myId = myId;
	}
	public String getMyFriendId() {
		return myFriendId;
	}
	public void setMyFriendId(String myFriendId) {
		this.myFriendId = myFriendId;
	}
	
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	
	public String getmImage() {
		return mImage;
	}
	public void setmImage(String mImage) {
		this.mImage = mImage;
	}
	public String getmMessage() {
		return mMessage;
	}
	public void setmMessage(String mMessage) {
		this.mMessage = mMessage;
	}
	
	public int getHeartCount() {
		return heartCount;
	}
	public void setHeartCount(int heartCount) {
		this.heartCount = heartCount;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
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
