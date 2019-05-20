<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="../layout/adminNav.jsp"  %>

<style>

.insertButton {
	padding:10px 20px; 
	margin-bottom:15px; 
	color:#000000; 
	border:1px solid #000000;
	font-size: 15px;
}

.insertButton:hover {
	color:#ffffff; 
	background-color: #000000;	
}

.buttonStyle {
	padding: 5px 10px;
	text-align: center;
	vertical-align: middle;
	border: 1px solid #000000;
	font-size: 15px;
	color: #000000;
}

.buttonStyle:hover {
	color:#ffffff; 
	background-color: #000000;	
}

</style>

	<div class="ap_contents product detail">

	<div style="width:1200px;margin:30px auto; text-align: center;">
		<div style="width: 1200px; height:100px; text-align:center; line-height:50px; font-size: 30px; color:#000000; border: none">
			쿠폰관리
		</div>
	
		<div id="bbsList_header" style="height:30px;">
			<div style="float:right;width:600px;text-align:right;" >
				<button type="button" onclick="javascript:location.href='<%=cp %>/admin/couponAdminCreated.action';" class="insertButton">
				상품등록
				</button>
			</div>
		</div>
		
		<div style="width: 1200px;">
			<table class="ui_table_striped data_table thead_colored align_center @table-striped-apply" >
				
				<colgroup>
					<col width="50">
					<col width="150">
					<col width="100">
					<col width="150">
					<col width="150">
					<col width="500">
					<col width="100">
					<col width="100">
				</colgroup>
				
				<thread>
				<tr>
					<th scope="col" bgcolor="#F2F2F2">쿠폰키</th>
					<th scope="col" bgcolor="#F2F2F2">쿠폰 이름</th>
					<th scope="col" bgcolor="#F2F2F2">할인 금액</th>
					<th scope="col" bgcolor="#F2F2F2">적용되는 금액</th>
					<th scope="col" bgcolor="#F2F2F2">적용되는 등급</th>
					<th scope="col" bgcolor="#F2F2F2">기간</th>
					<th scope="col" bgcolor="#F2F2F2">수정</th>
					<th scope="col" bgcolor="#F2F2F2">삭제</th>
				</tr>
				</thread>
				
				<tbody id="paging">
					<c:forEach var="dto" items="${lists }">
						<tr align="center">
							<td width="100" height="30">${dto.couponKey }</td>
							<td>${dto.couponName }</td>
							<td>${dto.discount }</td>
							<td>${dto.couponScore }</td>
							<td>${dto.couponGrade }</td>
							<td>${dto.couponStartDate}~${dto.couponEndDate }</td>	
							<td><a href="${updateUrl}?couponKey=${dto.couponKey }" class="buttonStyle">수정</a></td>
							<td ><a href="${deleteUrl}?couponKey=${dto.couponKey }" class="buttonStyle">삭제</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div style="font-size:12pt; clear:both;	height:32px;line-height:32px;margin-top:5px;text-align:center;">
				<p>
					<c:if test="${dataCount!=0 }">
						${pageIndexList }
					</c:if>
					<c:if test="${dataCount==0 }">
						등록된 게시물이 없습니다
					</c:if>
				</p>
			</div>

		</div>
	</div>

</div>
	
<%@include file="../layout/footer.jsp"  %>