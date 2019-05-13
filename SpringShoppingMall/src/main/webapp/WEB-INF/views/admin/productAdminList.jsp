<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="../layout/top.jsp"  %>

	<div class="ap_contents product detail" style="padding-left: 70px;">

	<div style="width:1100px;margin:30px auto;text-align:left;">
		<div style="border:1px solid ; width: 1100px; padding-left:20px;height:40px;text-align:left;line-height:40px;margin-bottom:30px;">
		상품관리 (admin)
		</div>
	
		<div id="bbsList_header" style="height:30px;">
			<div style="float:right;width:600px;text-align:right;" >
			<form action="" name="searchForm" method="post">
	 			<button type="button" onclick="javascript:location.href='<%=cp %>/productAdminCreate.action';" style="padding:5px 5px 5px 5px; color:#AD8EDB; border:1px solid #AD8EDB;">
				상품등록
				</button>
			</form>
			</div>
		</div>
		<div style="width: 1100px;">
			<table border="1" >
				<tr align="center">
					<td width="100" height="30">상품ID</td>
					<td width="100">상품카테고리</td>
					<td width="150">상품명</td>
					<td width="100">상품사이즈</td>
					<td width="150">판매처</td>
					<td width="150">판매처 URL</td>
					<td width="100">판매상태</td>
					<td width="100">가격</td>
					<td width="100">등록일자</td>
					<td width="60">삭제</td>		
				</tr>
				<c:forEach var="dto" items="${lists }">
				<tr align="center">
					<td width="100" height="30">${dto.productId }</td>
					<td >${dto.productCategory }</td>
					<td >${dto.productName }</td>
					<td >${dto.productSize }</td>
					<td >${dto.storeName }</td>
					<td >${dto.storeUrl }</td>
					<td >${dto.state }</td>
					<td >${dto.price}</td>	
					<td >${dto.productDate }</td>				
					<td >
					<a href="<%=cp %>/productAdminUpdate.action?productId=${dto.productId}">수정</a>
					<a href="<%=cp %>/productAdminDelete.action?productId=${dto.productId}&originalName=${dto.originalName}">삭제</a>
					</td>
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