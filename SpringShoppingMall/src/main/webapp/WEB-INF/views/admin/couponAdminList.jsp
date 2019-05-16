<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="../layout/adminNav.jsp"  %>

	<div class="ap_contents product detail" style="padding-left: 70px;">

	<div style="width:920px;margin:30px auto;text-align:left;">
		<div style="border:1px solid ; width: 920px; padding-left:20px;height:40px;text-align:left;line-height:40px;margin-bottom:30px;">
		쿠폰관리 (admin)
		</div>
	
		<div id="bbsList_header" style="height:30px;">
			<div style="float:right;width:600px;text-align:right;" >
				<button type="button" onclick="javascript:location.href='<%=cp %>/admin/couponAdminCreated.action';" style="padding:5px 5px 5px 5px; color:#f54a7e; border:1px solid #f54a7e;">
				상품등록
				</button>
			</form>
			</div>
		</div>
		
		<div style="width: 920px;">
			<table border="1" >
				<tr align="center">
					<td width="100" height="30">쿠폰키</td>
					<td width="150">쿠폰 이름</td>
					<td width="100">할인 금액</td>
					<td width="100">적용되는 금액</td>
					<td width="150">적용되는 등급</td>
					<td width="200">기간</td>
					<td width="60">수정</td>
					<td width="60">삭제</td>		
				</tr>
				<c:forEach var="dto" items="${lists }">
				<tr align="center">
					<td width="100" height="30">${dto.couponKey }</td>
					<td >${dto.couponName }</td>
					<td >${dto.discount }</td>
					<td >${dto.couponScore }</td>
					<td >${dto.couponGrade }</td>
					<td >${dto.couponStartDate}~${dto.couponEndDate }</td>	
					<td ><a href="${updateUrl}?couponKey=${dto.couponKey }">수정</a></td>
					<td ><a href="${deleteUrl}?couponKey=${dto.couponKey }">삭제</a></td>
				</tr>
			</c:forEach>
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