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

<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/font.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/ui.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/board.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/layout.css?ver=2">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/layer.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/member.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/cs.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/mypage.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/search.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/product.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/cart.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/brand.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/event.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/beautylife.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/policy.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/modify-my-info.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/coupon.css">

<script type="text/javascript" src="<%=cp%>/resources//js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resources//js/jquery-ui.js"></script>

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
.searchHeader {
	text-rendering: auto;
    color: initial;
    letter-spacing: normal;
    word-spacing: normal;
    text-transform: none;
    text-indent: 0px;
    text-shadow: none;
    display: inline-block;
    text-align: start;
    margin: 0em;
    font-size: 14px;
    letter-spacing: 1px;
    padding-bottom: 10px;
    padding-top: 10px;
    padding-left: 35px;
    width: 420px;
    background: url(//s1.codibook.net/images/header/search.png) no-repeat 5px 50%;
    background-size: 24px 24px;
    border: 0;
    border: 1.5px solid #8080FF;
    outline: 0;
    transition: width 150ms cubic-bezier(.165,.84,.44,1),opacity 150ms cubic-bezier(.165,.84,.44,1);

}
.menuLink{
	padding-top: 20px;
	color: #333;
	font-weight: 900; 
	font-size: 16px;
	display:block; position:relative; margin:0 auto 7px; text-align: center; height: 50px; vertical-align: bottom;  padding-top: 15px; margin-left: 25px;
	cursor:pointer;
}

.gnb>li:hover {
	background-color: #DAD9FF;
	border-color: #DAD9FF;
	border-radius: 4px;
}

.gnb>li{width: 135px;text-align: center;}
.menuLink.active{color: #8080ff; background-color: #fff;}
#smallMenu1{width: 1200px; margin-left: auto; margin-right: auto;}
#smallMenu2{width: 1200px; margin-left: auto; margin-right: auto;}
</style>


<script type="text/javascript" src="https://www.youtube.com/iframe_api"></script>
<script type="text/javascript">

function goSearch(){
	f = document.searchForm;
	str = f.searchHeader.value;
	str = str.trim();
	if(str=="" || !str){
		alert("\n 검색어를 입력해주세요.");
		f.searchHeader.focus();
		return;
	}
	if(str.length<2){
		alert("\n 검색어를 두글자이상 입력해주세요.");
		f.searchHeader.focus();
		return;
	}
	f.action = "<%=cp %>/pr/listSearch.action";
	f.submit();
}

$(function(){
	
	var currentURL = $(location).attr('href');
	var arrayStoreURL =new Array("/pr/storeMain.action", "/pr/listNew.action", "/pr/listBest.action", "/pr/listCodiBest.action" ,"/couponA/couponAllList.action");
	var menuFlag = false;
	
	for(var i in arrayStoreURL){
		
		if(currentURL.indexOf(arrayStoreURL[i]) != -1){
			menuFlag=true;
		}
	}
	
	if(menuFlag){
		$(".menuLink").removeClass("active");
		$("#store").addClass("active");	
		$('#smallMenu2').attr('style','display:none');
		$("#smallMenu1").attr('style','display:block');
	}else{
		$('#smallMenu1').attr('style','display:none');
		$("#smallMenu2").attr('style','display:block');
	}

	$('.menuLink').mouseenter(function(){
		
		$(".menuLink").removeClass("active"); 		
		$(this).addClass("active");				

		var menuName = $(this).attr("id");
		
		if(menuName=="community"){
			$('#smallMenu1').attr('style','display:none');
			$("#smallMenu2").attr('style','display:block');
		}else{
			$('#smallMenu2').attr('style','display:none');
			$("#smallMenu1").attr('style','display:block');
		}
	});

});

</script>

</head>
<body>
	<div class="ap_wrapper">
	
		<div id="header" class="ap_header" style="height: 142px;">

		<div class="inner_wrap">
			<ul class="header_menu">
				
				<li style="margin-left: 0;">
				<div onclick="location.href='<%=cp %>/pr/commuMain.action'" style="width: 230px; text-align: center; float: left;">
					<img style="width: 230px; height: 55px;" alt="" src="<%=cp %>/resources/image/logo3.png"/>
				</div>
				</li>
				<li style="margin-left: 5px;">
					<div onclick="location.href='<%=cp %>/pr/commuMain.action'" class="menuLink active" id="community">커뮤니티</div>
				</li>
				<li style="margin-left: 15px;">
					<div onclick="location.href='<%=cp %>/pr/storeMain.action'" class="menuLink" id="store">스토어</div>
				</li>
				<li>
					<form name="searchForm" onsubmit="return false">
					<input class="searchHeader" name="searchHeader" placeholder="검색어를 입력하세요" autocomplete="off" value="" onkeypress="if( event.keyCode==13 ){goSearch();}" >
					</form>
				</li>
				<li>
					<c:choose>
						<c:when test="${empty sessionScope.customInfo.userId }">
						<a href="<%=cp %>/mem/login.action"  class="log">로그인</a>
						</c:when>
						<c:otherwise>
						<a href="<%=cp %>/mem/logout.action"  class="log">로그아웃</a>
						</c:otherwise>
					</c:choose>
				</li>
				<li>
				<c:choose>
						<c:when test="${empty sessionScope.customInfo.userId }">
						<a href="<%=cp %>/mem/signup.action" class="join">회원가입</a>
						</c:when>
						<c:otherwise>
						<a href="<%=cp %>/myPage/myPageMain.action" class="join">마이페이지</a>
						</c:otherwise>
				</c:choose>
				</li>
				<li><a href="<%=cp%>/order/myOrderLists.action" class="order">주문조회
					<span class="num" style="display: none;"></span>
					</a>
				</li>
				<li><a href="<%=cp %>/cart/cartList.action" class="cart">장바구니
					<span class="num" style="display: none;"></span>
					</a>
				</li>
			</ul>
			
		</div>
		<div style="border-bottom: 1px solid #ebebeb;" ></div>	
		
		<!-- 스토어메인 -->
		<table style="display: none;" id="smallMenu1" >
			<tr>
			<td>
				<div class="gnb_area">
					<ul class="gnb" >
						<li><a href="<%=cp %>/pr/storeMain.action">스토어&nbsp;홈</a></li>
						<li><a href="<%=cp %>/pr/listNew.action">카&nbsp;테&nbsp;고&nbsp;리</a></li>
						<li><a href="<%=cp %>/pr/listBest.action">랭&nbsp;&nbsp;킹</a></li>
						<li><a href="<%=cp %>/pr/listCodiBest.action">코디속&nbsp;BEST</a></li>
						<li><a href="<%=cp %>/couponA/couponAllList.action">쿠&nbsp;&nbsp;폰</a></li>
					</ul>
				</div>
				</td>
			</tr>
		</table>
		
		<!-- 커뮤니티메인 -->
		<table style="display: none;"  id="smallMenu2">
			<tr>
			<td>
				<div class="gnb_area">
					<ul class="gnb" >
						<li><a href="<%=cp %>/pr/commuMain.action">커뮤니티&nbsp;홈</a></li>
						<li><a href="<%=cp %>/pr/commuList.action">코&nbsp;&nbsp;디</a></li>
						<li><a href="<%=cp %>/pr/codiHashTagList.action">테&nbsp;&nbsp;마</a></li>
						<li><a href="<%=cp%>/qna/questionMain.action">질문과&nbsp;답변</a></li>
					</ul>
				</div>
				</td>
			</tr>
		</table>

	</div>