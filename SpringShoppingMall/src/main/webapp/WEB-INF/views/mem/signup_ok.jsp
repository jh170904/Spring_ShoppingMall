<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/member-join.css">

</head>
<body>
	<div class="ap_wrapper">

		<div id="ap_container" class="ap_container">
			<div class="page_title_area">
				<h1>내일의 코디북 통합 회원가입</h1>
			</div>

			<div class="ap_contents member_join">
				<div class="complete">
					<span class="icon"></span>
					<p class="text message">
						<b>가입이<br>완료되었습니다.
						</b>
					</p>
					<p class="text">
						새로운 가족이 되신 회원님께 할인쿠폰을 보내드립니다.<br>마이 페이지 &gt; 나의 쿠폰에서 확인하세요.
					</p>
				</div>
				<div class="page_btns">
					<button class="btn_lg_primary" onclick="location.replace('<%=cp%>/pr/commuMain.action')" type="button">홈으로
						이동</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

































