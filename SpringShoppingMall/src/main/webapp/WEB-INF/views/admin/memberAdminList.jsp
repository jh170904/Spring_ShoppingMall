<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../layout/adminNav.jsp"  %>

<style>

.insertButton {
	padding:5px 10px; 
	color:#000000; 
	border:1px solid #000000;
	font-size: 15px;
}

.insertButton:hover {
	color:#ffffff; 
	background-color: #000000;	
}

.allButton {
	float:right;
	padding:10px 10px; 
	color:#000000; 
	border:1px solid #000000;
	font-size: 15px;
}

.allButton:hover {
	color:#ffffff; 
	background-color: #000000;	
}

</style>

<script>
	function showOrder(order) {

		var content = document.getElementById(order);

		if(content.style.display == "none"){
			content.style.display = "block";
		}else{
			content.style.display = "none";
		}
	}
	
	function searchOrderName() {
		
		var searchOrderName = document.search.searchOrderName.value.trim();
		
		searchOrderName.action = "<%=cp%>/admin/bankbookPaymentAdmin.action";
		searchOrderName.submit();
		
	}
</script>

<div class="ap_contents product detail">

	<div style="width:1200px;margin:30px auto;text-align:center;">
		<div style="width: 1200px; height:100px; text-align:center; line-height:50px; font-size: 30px; color:#000000; border: none">
			회원 관리
		</div>
		
		<div style="padding: 10px 0px; margin-bottom: 15px;">
			
			<div style="float: left;">
			<!-- <form action="" method="post" name="search">
				<input type="text" style="width: 200px; text-align: left;" class="btn_sm_bordered" name="searchUserId">
				<button class="btn_sm_bordered" onclick="searchOrderName()">검색</button>
			</form> -->
			</div>
			
			<div style="padding-right: 20px;">
				<button type="button" class="allButton" onclick="javascript:location.href='<%=cp %>/admin/sendEmail.action?email=all&userName=all';">전체발송</button>						
			</div>
			
		</div>
		
		<div style="width: 1200px;">
			<table class="ui_table_striped data_table thead_colored align_center @table-striped-apply" >
			
				<colgroup>
					<col width="5%">
					<col width="25%">
					<col width="10%">
					<col width="10%">
					<col width="15%">
					<col width="10%">
					<col width="15%">
					<col width="10%">
				</colgroup>
				
				<thread>
				<tr>
					<th scope="col" bgcolor="#F2F2F2">프로필</th>
					<th scope="col" bgcolor="#F2F2F2">메세지</th>		
					<th scope="col" bgcolor="#F2F2F2">아이디</th>
					<th scope="col" bgcolor="#F2F2F2">이름</th>
					<th scope="col" bgcolor="#F2F2F2">이메일</th>
					<th scope="col" bgcolor="#F2F2F2">포인트</th>
					<th scope="col" bgcolor="#F2F2F2">등급</th>		
					<th scope="col" bgcolor="#F2F2F2">메일발송</th>				
				</tr>
				</thread>
				<div id="bbsList_header" style="height:30px;">
		</div>
				<tbody id="paging">
					<c:forEach var="dto" items="${memberList }">
						<tr align="center">
							<td><img src="../upload/profile/${dto.mImage }" style="border-radius: 50%; height: 50px; width: 50px;"></td>
							<td style="text-align: left;">${dto.mMessage }</td>
							<td>${dto.userId }</td>
							<td>${dto.userName }</td>
							<td style="text-align: left;">${dto.email }</td>
							<td>${dto.point }</td>
							<td>${dto.userGrade }</td>
							<td>
								<button type="button" class="insertButton" onclick="javascript:location.href='<%=cp %>/admin/sendEmail.action?email=${dto.email }&userName=${dto.userId }';">메일발송</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

		</div>
	</div>

</div>
	
<%@include file="../layout/footer.jsp"  %>