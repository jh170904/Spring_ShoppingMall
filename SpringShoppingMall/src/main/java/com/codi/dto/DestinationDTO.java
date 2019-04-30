package com.codi.dto;

public class DestinationDTO {
	
	private String userId;
	private String destNickname;
	private String destNickname2;
	private String ex_destNickname;
	private String destName;
	private String destPhone;
	private String destTel;
	private String zip;
	private String addr1;
	private String addr2;
	private String addrKey;
	
	//전체 주소
	private String destAddr;
	private String userEmail;

	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getDestNickname() {
		return destNickname;
	}
	public void setDestNickname(String destNickname) {
		this.destNickname = destNickname;
	}
	
	public String getDestNickname2() {
		return destNickname2;
	}
	public void setDestNickname2(String destNickname2) {
		this.destNickname2 = destNickname2;
	}
	
	public String getEx_destNickname() {
		return ex_destNickname;
	}
	public void setEx_destNickname(String ex_destNickname) {
		this.ex_destNickname = ex_destNickname;
	}
	
	public String getDestName() {
		return destName;
	}
	public void setDestName(String destName) {
		this.destName = destName;
	}
	
	public String getDestPhone() {
		return destPhone;
	}
	public void setDestPhone(String destPhone) {
		this.destPhone = destPhone;
	}
	
	public String getDestTel() {
		return destTel;
	}
	public void setDestTel(String destTel) {
		this.destTel = destTel;
	}
	
	public String getZip() {
		return zip;
	}
	public void setZip(String string) {
		this.zip = string;
	}
	
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	
	public String getAddrKey() {
		return addrKey;
	}
	public void setAddrKey(String addrKey) {
		this.addrKey = addrKey;
		
		if(addrKey==null)
			addrKey="no";
		else
			addrKey="yes";
	}
	
	public String getDestAddr() {
		return destAddr;
	}
	public void setDestAddr(String destAddr) {
		this.destAddr = destAddr;
	}
	
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	
}
