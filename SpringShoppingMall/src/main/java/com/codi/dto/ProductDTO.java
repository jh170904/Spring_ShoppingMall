package com.codi.dto;

import java.util.List;

public class ProductDTO {

	private String productId;
	private String productCategory;
	private String productName;

	private String productSize;
	private int price;
	private String productDate;
	private int amount;
	private String color;
	private String state;
	private String originalName;
	private String saveFileName;
	private String storeName;
	private String storeUrl;
	
	//실제 옵션 값이 저장되 있는 컬럼
	private String productOption;
	
	//리스트 용도 인지 아닌지 확인하기 위한 컬럼
	private String fileCategory;
	public String getFileCategory() {
		return fileCategory;
	}
	public void setFileCategory(String fileCategory) {
		this.fileCategory = fileCategory;
	}
	
	//옵션들을 넣어놀 리스트변수(컬럼x)
	private List<String> optionList;
	public List<String> getOptionList() {
		return optionList;
	}
	public void setOptionList(List<String> optionList) {
		this.optionList = optionList;
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
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductSize() {
		return productSize;
	}
	public void setProductSize(String productSize) {
		this.productSize = productSize;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getProductDate() {
		return productDate;
	}
	public void setProductDate(String productDate) {
		this.productDate = productDate;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
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
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public String getStoreUrl() {
		return storeUrl;
	}
	public void setStoreUrl(String storeUrl) {
		this.storeUrl = storeUrl;
	}
	public String getProductOption() {
		return productOption;
	}
	public void setProductOption(String productOption) {
		this.productOption = productOption;
	}
}
