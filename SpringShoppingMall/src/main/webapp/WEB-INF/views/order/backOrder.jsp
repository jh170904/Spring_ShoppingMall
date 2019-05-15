<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<script>
	function closeWindow() {  
		window.opener.location.href="<%=cp%>/order/orderComplete.action?orderNum=${dto.orderNum}&discountAll=${dto.discount}&zip=${dto.zip}&addr1=${dto.addr1}&addr2=${dto.addr2}&addrKey=${dto.addrKey}&eMail=${dto.eMail}&userName=${dto.userName}&totalPrice=${dto.price}&mode=card&totalPoint=${dto.point}";
		window.close();
	}  
	
	window.onload = closeWindow();
	
</script>



