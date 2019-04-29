<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String cp1 = request.getContextPath();
%>
<!-- mypage sitemap -->
<div class="mypage_map">
	<ul style="height: 222px;">
		<li style="width: 240px;"><span class="bottom_menu">나의 주문 관리</span> <!-- 메뉴 선택시 selected 클래스 -->
			<ul class="total_menu_wrap">
				<li><a href="<%=cp1%>/order/myOrderLists.do">주문 조회</a></li>
				<!-- 메뉴 선택시 selected 클래스 -->
			</ul></li>
		<li style="width: 240px;"><span class="bottom_menu">나의 혜택 관리</span>
			<ul class="total_menu_wrap">
				<li><a href="<%=cp1%>/coupon/myCouponList.do">나의 쿠폰</a></li>
			</ul></li>
		<li style="width: 240px;"><span class="bottom_menu">나의 활동 관리</span>
			<ul class="total_menu_wrap">
				<li><a href="<%=cp1%>/review/list.do">나의 구매 후기</a></li>
			</ul></li>
		<li style="width: 240px;"><span class="bottom_menu">나의 지역 관리</span>
			<ul class="total_menu_wrap">
				<li><a href="<%=cp1%>/dest/list.do">배송지 관리</a></li>
				<li><a href="<%=cp1%>/shop/list.do">단골매장 관리</a></li>
			</ul></li>
		<li style="width: 240px;"><span class="bottom_menu">나의 정보 관리</span>
			<ul class="total_menu_wrap">
				<li><a href="<%=cp1%>/con/update.action">개인정보 수정</a></li>
				<li><div><a href="#loginmodal" class="flatbtn" id="modaltrigger">회원 탈퇴</a></div></li>
			</ul></li>
	</ul>
</div>

<%-- <%@ include file="../member/delete.jsp"  %> --%>