<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../layout/top.jsp" %>
<%@ include file="../layout/mypage.jsp" %>


<table class="page_title_area" style="margin-top: 80px; margin-bottom: 50px;">
<tr class="page_title">
	<td colspan="2" align="center">
		<h2 class="h_title page">나의 쿠폰</h2>
		<p class="text font_lg"></p>
	</td>
</tr>
</table>

	<div class="ap_contents">
	
		<div class="ui_tab">
			<div class="tab_menu equally">
				<ul>
					<li class="on"><a href="#">사용 가능한 쿠폰</a></li>
					<li><a href="<%=cp %>/coupon/myUsedCouponList.action">사용/만료 쿠폰</a></li>
				</ul>
			</div>
		</div>
		
	</div>

<div class="ap_contents mypage">
<div class="address_list">


<table class="ui_table_striped data_table thead_colored align_center @table-striped-apply" id="shpiTable">
	
	<colgroup>
		<col>
		<col>
		<col>
		<col>
		<col>
		<col>
		<col>
	</colgroup>
	
	<thread>
	<tr>
		<th scope="col" bgcolor="#F2F2F2">취득일</th>
		<th scope="col" bgcolor="#F2F2F2">쿠폰명</th>
		<th scope="col" bgcolor="#F2F2F2">혜택</th>
		<th scope="col" bgcolor="#F2F2F2">유효기간</th>
	</tr>
	</thread>
	
	<tbody id="paging">
	<c:forEach var="dto" items="${lists }">
		<c:if test="${dto.used == 'N' }">
			<tr>
				<td>${dto.issueDate }</td>
				<td>${dto.couponName }</td>
				<td><font color="#8080FF">${dto.discount}원 할인</font></td>
				<td>${dto.issueDate }&nbsp;~&nbsp;${dto.couponEndDate }</td>
			</tr>
		</c:if>
	</c:forEach>
	</tbody>
	
</table>

</div>
</div>

<%@ include file="../layout/footer.jsp" %>