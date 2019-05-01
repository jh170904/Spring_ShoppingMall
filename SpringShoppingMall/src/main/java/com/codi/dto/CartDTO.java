package com.codi.dto;

import java.util.List;

public class CartDTO {

	private String userId;
	private String productId;
	private String productName;
	private String color;
	private String productSize;
	private String originalName;
	private String saveFileName;
	private int amount;
	private int price;
	private String superProduct;
	private String orderSelect;	
	
	//페이지 출력용
	private List<String> sizeList;
	private List<String> colorList;
	
	public List<String> getSizeList() {
		return sizeList;
	}
	public void setSizeList(List<String> sizeList) {
		this.sizeList = sizeList;
	}
	public List<String> getColorList() {
		return colorList;
	}
	public void setColorList(List<String> colorList) {
		this.colorList = colorList;
	}
	public String getSuperProduct() {
		return superProduct;
	}
	public void setSuperProduct(String superProduct) {
		this.superProduct = superProduct;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getProductSize() {
		return productSize;
	}
	public void setProductSize(String productSize) {
		this.productSize = productSize;
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
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
	public String getOrderSelect() {
		return orderSelect;
	}
	public void setOrderSelect(String orderSelect) {
		this.orderSelect = orderSelect;
	}
	
}
