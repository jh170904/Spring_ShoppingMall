<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="./adminHeader.jsp"  %>

<%
	String cp1 = request.getContextPath();	
%>

<style>

.myPageCategory{ 
	width : 840px;
	margin-left: auto; 
	margin-right: auto;
	margin-top: 20px;
}

#myPageMenu {
	height:40px;  
	margin-left: auto; 
	margin-right: auto;
	text-align:center;
}

.myPageCategory ul li {
	list-style:none;
	float:left;
	color:#000000;
	line-height:30px;
	vertical-align:middle;
	text-align:center;	
}

.myPageCategory .menuLink {
	text-decoration:none;
	display:block; 
	width:130px;
	font-size:16px;
}

.myPageCategory .menuLink:hover { 
	color:#8080ff;
	font-weight: bold; 
	
}
</style>

<script>
	$(document).ready( function(){
    	  
    	  var f = location.pathname;
          var url = f.split('/');
          var option = url[3];

    	  var x = document.getElementById(eval("'" + option + "'"));
    	 
    	  x.style.color="#8080ff";
    	  x.style.fontWeight="bold";
    	  
	 });
	
</script>

<div class="myPageCategory">
	<nav id="myPageMenu"> 
		<ul> 
			<li>
				<a class="menuLink" href="<%=cp1%>/admin/memberList.action" id="memberList.action">회원관리</a>
			</li> 
			<li>
				<a class="menuLink" href="<%=cp1%>/admin/productAdminList.action" id="productAdminList.action">상품관리</a>
			</li> 
			
			<li>
				<a class="menuLink" href="<%=cp1%>/admin/reviewAdmin.action" id="reviewAdmin.action">리뷰관리</a>
			</li> 
			
			<li>
				<a class="menuLink" href="<%=cp1%>/admin/couponAdminList.action" id="couponAdminList.action">쿠폰관리</a>
			</li> 
			
			<li>
				<a class="menuLink" href="<%=cp1%>/admin/bankbookPaymentAdmin.action" id="bankbookPaymentAdmin.action">주문관리</a>
			</li>
			
			<li>
				<a class="menuLink" href="#" id="con">이벤트관리</a>
			</li> 
			 
		</ul> 
	</nav>
</div>

</div>
