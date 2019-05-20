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

	<div style="width:1200px;margin:30px auto;text-align:center;">
		<div style="width: 1200px; height:100px; text-align:center; line-height:50px; font-size: 30px; color:#000000; border: none">
			상품관리
		</div>
	
		<div id="bbsList_header" style="height:30px;">
			<div style="float:right;width:600px;text-align:right;" >
			<form action="" name="searchForm" method="post">
	 			<button type="button" class="insertButton" onclick="javascript:location.href='<%=cp %>/admin/productAdminCreate.action';">
				상품등록
				</button>
			</form>
			</div>
		</div>
		<div style="width: 1200px;">
			<table class="ui_table_striped data_table thead_colored align_center @table-striped-apply" >
			
				<colgroup>
					<col width="50">
					<col width="120">
					<col width="150">
					<col width="100">
					<col width="150">
					<col width="150">
					<col width="100">
					<col width="100">
					<col width="120">
					<col width="160">
				</colgroup>
				
				<thread>
				<tr style="font-size: 15px;">
					<th scope="col" bgcolor="#F2F2F2">상품ID</th>
					<th scope="col" bgcolor="#F2F2F2">상품카테고리</th>
					<th scope="col" bgcolor="#F2F2F2">상품명</th>
					<th scope="col" bgcolor="#F2F2F2">상품사이즈</th>
					<th scope="col" bgcolor="#F2F2F2">판매처</th>
					<th scope="col" bgcolor="#F2F2F2">판매처 URL</th>
					<th scope="col" bgcolor="#F2F2F2">판매상태</th>
					<th scope="col" bgcolor="#F2F2F2">가격</th>
					<th scope="col" bgcolor="#F2F2F2">등록일자</th>
					<th scope="col" bgcolor="#F2F2F2">삭제</th>		
				</tr>
				</thread>
	
				<tbody id="paging">
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
						<a href="<%=cp %>/admin/productAdminUpdate.action?productId=${dto.productId}" class="buttonStyle">수정</a>
						<a href="<%=cp %>/admin/productAdminDelete.action?productId=${dto.productId}&originalName=${dto.originalName}" class="buttonStyle">삭제</a>
						</td>
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