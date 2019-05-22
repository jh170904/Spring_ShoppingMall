package com.codi.dto;

import java.util.List;

public class CodiHashTagDTO {
	
	private int iNum;
	private String iImage;
	private String productId;
	private String iDate;
	private String iHashTag;
	private String Decoding_HashTag;
	
	//코디 좋아요
	private int heartCount;
	
	//코디 구성 상품
	public List<ProductDetailDTO> itemLists;

	
	public String getDecoding_HashTag() {
		return Decoding_HashTag;
	}

	public void setDecoding_HashTag(String decoding_HashTag) {
		Decoding_HashTag = decoding_HashTag;
	}
	public int getiNum() {
		return iNum;
	}

	public void setiNum(int iNum) {
		this.iNum = iNum;
	}

	public String getiImage() {
		return iImage;
	}

	public void setiImage(String iImage) {
		this.iImage = iImage;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getiDate() {
		return iDate;
	}

	public void setiDate(String iDate) {
		this.iDate = iDate;
	}

	public String getiHashTag() {
		return iHashTag;
	}

	public void setiHashTag(String iHashTag) {
		this.iHashTag = iHashTag;
	}

	public int getHeartCount() {
		return heartCount;
	}

	public void setHeartCount(int heartCount) {
		this.heartCount = heartCount;
	}

	public List<ProductDetailDTO> getItemLists() {
		return itemLists;
	}

	public void setItemLists(List<ProductDetailDTO> itemLists) {
		this.itemLists = itemLists;
	}
	
	
	
}
