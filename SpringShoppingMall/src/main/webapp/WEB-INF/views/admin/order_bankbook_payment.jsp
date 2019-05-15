<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../layout/top.jsp"  %>

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

<div class="ap_contents product detail" style="padding-left: 70px;">

	<div style="width:1100px;margin:30px auto;text-align:left;">
		<div style="width: 1100px; padding-left:20px;height:40px;text-align:left;line-height:40px;" class="btn_sm_bordered">
		무통장입금 관리 (admin)	
		</div>
		
		<div style="padding: 10px 0px; float: right;">
			<form action="" method="post" name="search">
			<input type="text;" style="width: 200px; text-align: left;" class="btn_sm_bordered" name="searchOrderName">
			<button class="btn_sm_bordered" onclick="searchOrderName()">검색</button>
			</form>
		</div>
		
		<div style="width: 1100px;">
			<table class="ui_table_striped data_table thead_colored align_center @table-striped-apply" >
			
				<colgroup>
					<col width="15%">
					<col width="10%">
					<col width="35%">
					<col width="10%">
					<col width="15%">
					<col width="15%">
				</colgroup>
				
				<thread>
				<tr>
					<th scope="col" bgcolor="#F2F2F2">주문번호</th>
					<th scope="col" bgcolor="#F2F2F2">예금주</th>
					<th scope="col" bgcolor="#F2F2F2">상품명</th>
					<th scope="col" bgcolor="#F2F2F2">가격</th>
					<th scope="col" bgcolor="#F2F2F2">상품 보기</th>
					<th scope="col" bgcolor="#F2F2F2">입금완료</th>
				</tr>
				</thread>
				
				<tbody id="paging">
					<c:forEach var="dto" items="${adminPaymentCheckList }">
						<tr align="center">
							<td width="100" height="30" style="vertical-align: top;">${dto.orderNum }</td>
							<td style="vertical-align: top;">${dto.userName }</td>
							<td align="left" style="vertical-align: top;">&nbsp;&nbsp;&nbsp;${dto.productName }
								<p id="${dto.orderNum }" style="display: none; font-size: 13px;" >
								<c:forEach var="vo" items="${adminPaymentCheck2List }">
									<c:if test="${dto.orderNum eq vo.orderNum }">
										<br/>&nbsp;&nbsp;&nbsp;${vo.productName }&nbsp;&nbsp;(${vo.amount }개)
									</c:if>
								</c:forEach>
								</p>
							</td>
							<td style="vertical-align: top;">
								<c:forEach var="vo" items="${adminDiscountPrice }">
									<c:if test="${dto.orderNum eq vo.orderNum }">
										<fmt:formatNumber value="${vo.price }" type="number"/>원
									</c:if>
								</c:forEach>
							</td>	
							<td style="vertical-align: top;">
								<button onclick="showOrder('${dto.orderNum }')" class="btn_sm_bordered">상품보기</button>
							</td>
							<td style="vertical-align: top;">
								<a href="<%=cp%>/admin/without_bankbook_paymentYes.action?orderNum=${dto.orderNum}&price=${dto.price}" class="btn_sm_bordered">입금완료</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div style="font-size:12pt; clear:both;	height:32px;line-height:32px;margin-top:5px;text-align:center;">
				<p>
					<c:if test="${dataCount!=0 }">
						<font style="font-size: 20px">${pageIndexList}</font>
					</c:if>
					<c:if test="${dataCount==0 }">
						무통장 입금 내역이 없습니다.
					</c:if>
				</p>
			</div>

		</div>
	</div>

</div>
	
<%@include file="../layout/footer.jsp"  %>