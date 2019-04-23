<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">

<link rel="shortcut icon" href="/kr/ko/favicon.ico">

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/font.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/ui.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/board.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/layout.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/layer.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/member.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/cs.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/mypage.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/search.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/product.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/cart.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/brand.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/event.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/beautylife.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/policy.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/modify-my-info.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/coupon.css">

<link href="<%=cp %>/project/member/css/layout.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=cp %>/project/member/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=cp %>/project/member/js/jquery.leanModal.min.js"></script>


<style type="text/css">
.
#fonts-loaded body { /* 웹 폰트 다운로드 전에는 화면을 보여주지 않음 */
	display: none;
}

.wf-notosanskrregular-n4-active body {
	/* 웹 폰트 사용이 가능하면 화면을 보여주고 웹 폰트 속성 적용 */
	display: block;
	font-family: 'Noto Sans Korean', 'NotoSansKR-Regular', sans-serif;
}
</style>


<script type="text/javascript" src="https://www.youtube.com/iframe_api"></script>


</head>
<body>
	<script type="text/javascript">

		$(document).ready(function() {
			$('#slide').click(function() {
				if ($("#bottom_menu:first").is(":hidden")) {
					$("#bottom_menu").show("slow");
				} else {
					$("#bottom_menu").slideUp();
				}
			});
		});
	</script>


	<div class="ap_wrapper">
	
		<header id="header" class="ap_header">

		<div class="inner_wrap">
			<ul class="header_menu">
				<li>
					<c:choose>
						<c:when test="${empty sessionScope.customInfo.userId }">
						<a href="<%=cp %>/member/login.do"  class="log">로그인</a>
						</c:when>
						<c:otherwise>
						<a href="<%=cp %>/member/logout.do"  class="log">로그아웃</a>
						</c:otherwise>
					</c:choose>
				</li>
				<li>
				<c:choose>
						<c:when test="${empty sessionScope.customInfo.userId }">
						<a href="<%=cp %>/member/created.do" class="join">회원가입</a>
						</c:when>
						<c:otherwise>
						<a href="<%=cp %>/member/mypage.do" class="join">마이페이지</a>
						</c:otherwise>
				</c:choose>
				</li>
				<li><a href="<%=cp%>/order/myOrderLists.do" class="order">주문조회
					<span class="num" style="display: none;"></span>
					</a>
				</li>
				<li><a href="<%=cp %>/cart/cartList.do" class="cart">장바구니
					<span class="num" style="display: none;"></span>
					</a></li>
			</ul>
			<h1 class="logo">
				<a href="../product/main.do">
					<img alt="ETUDEHOUSE" src="<%=cp %>/project/image/img_logo.png"/>
				</a>
			</h1>
		</div>


		<div class="gnb_area">
			<div class="inner_wrap" style="font-size: 13pt;">
				<button type="button" class="btn_category" id="slide">카테고리</button>
				<ul class="gnb">
					<li><a href="<%=cp %>/product/listNew.do">신상품</a></li>
					<li><a href="<%=cp %>/product/listBest.do">베스트</a></li>
					<li><a href="<%=cp%>/event/list.do">이벤트</a></li>
					<li><a href="<%=cp %>/coupon/couponAllList.do">쿠폰/혜택</a></li>
					
					<!-- 어드민페이지 -->
					<c:if test="${sessionScope.customInfo.userId eq 'admin' }">
						<li><a href="<%=cp %>/pr/adminList.do">상품관리</a></li>
						<li><a href="<%=cp %>/event/adminlist.do">이벤트관리</a></li>
						<li><a href="<%=cp %>/coupon/adminList.do">쿠폰관리</a></li>
					</c:if>
				</ul>
			</div>
			
						<%@ include file="./category.jsp"  %>
		</div>

		</header>
