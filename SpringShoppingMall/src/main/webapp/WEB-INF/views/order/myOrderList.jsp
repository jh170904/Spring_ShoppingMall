<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../layout/top.jsp" %>
<%@ include file="../layout/mypage.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>

<style>

.inLine_myOrder { 
	display: inline;
}

.order_on {
	background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;
}

.button_payment {
	display:inline-block; 
	padding:0 10px; 
	vertical-align: middle; 
	text-align: center; 
	line-height:1 !important;
	font-size:14px; 
	min-width:80px; 
	height:30px;
	background:#8080ff; 
	border:1px solid #8080ff; 
	color:#ffffff;
}

</style>

<script>
	function showOrderList(order) {

		var content = document.getElementById(order);

		if(content.style.display == "none"){
			content.style.display = "block";
		}else{
			content.style.display = "none";
		}
	}
</script>

<div class="page_title_area">

	<div class="page_title">
		<h2 class="h_title page">주문/배송조회</h2>
		<p class="text font_lg"></p>
	</div>
</div>

<div class="ap_contents mypage coupon">

	<!-- tab menu wrap -->
	<div class="ui_tab prd_detail_tap">
		<!-- tab menu -->
		<div style="margin-left: 12px;">
			<dl>
				<dd class="inLine_myOrder"><button onclick="javascript:location.href='<%=cp%>/order/myOrderLists.action?period=week';" 
					style="<c:if test='${period eq "week"}'>background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;</c:if>" 
					class="btn_sm_bordered_review">1주일</button>
				</dd>
				<dd class="inLine_myOrder"><button onclick="javascript:location.href='<%=cp%>/order/myOrderLists.action?period=month';" 
					style="<c:if test='${period eq "month"}'>background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;</c:if>" 
					class="btn_sm_bordered_review">1개월</button>
				</dd>
				<dd class="inLine_myOrder"><button onclick="javascript:location.href='<%=cp%>/order/myOrderLists.action?period=3month';" 
					style="<c:if test='${period eq "3month"}'>background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;</c:if>" 
					class="btn_sm_bordered_review">3개월</button>
				</dd>
				<dd class="inLine_myOrder"><button onclick="javascript:location.href='<%=cp%>/order/myOrderLists.action?period=6month';" 
					style="<c:if test='${period eq "6month"}'>background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;</c:if>" 
					class="btn_sm_bordered_review">6개월</button>
				</dd>
				<dd class="inLine_myOrder"><button onclick="javascript:location.href='<%=cp%>/order/myOrderLists.action?period=year';" 
					style="<c:if test='${period eq "year"}'>background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;</c:if>" 
					class="btn_sm_bordered_review">12개월</button>
				</dd>
			</dl>
		</div>
	</div>

	<div class="ui_tab">
	
		<div id="tab-1" class="tab-content">		
		<div class="tab_cont">
			<div class="panel benefit_panel_list">
			
				<table class="ui_table_striped data_table thead_colored align_center @table-striped-apply" id="shpiTable" style="margin-left: -33px;">

					<colgroup>
						<col width="20%">
						<col width="40%">
						<col width="10%">
						<col width="15%">
						<col width="15%">
					</colgroup>

					<thread>
						<tr>
							<th scope="col" bgcolor="#F2F2F2">주문번호</th>
							<th scope="col" bgcolor="#F2F2F2">상품정보</th>
							<th scope="col" bgcolor="#F2F2F2">결제금액</th>
							<th scope="col" bgcolor="#F2F2F2">상품보기</th>
							<th scope="col" bgcolor="#F2F2F2">진행상태</th>
						</tr>
					</thread>
				
					<c:if test="${!empty userOrderlist }">	
					<tbody id="paging">
						<c:set var= "number" value="0"/>
						<c:set var= "productNum" value="0"/>
						<c:forEach var="orderNum" items="${userOrderNum }">
						<c:set var= "price" value="0"/>
						<tr>
							<td class="check_wrap check_only" style="vertical-align: top;">
								${orderNum }<br/><p style="color: #8080ff">(${orderDateYMD[number] })</p>
							</td>
							
							<td style="vertical-align: top; text-align: left;">
								${userOrderlist[productNum].productName } 외
								<div style="margin-bottom: 10px; display: none;" id="${orderNum }">
								<br/>
								<c:forEach var="dto" items="${userOrderlist }">
									<c:if test="${dto.orderNum eq orderNum }">
										<c:set var= "price" value="${price + dto.amount * dto.price}"/>
										<div style="margin-bottom: 10px;">
											<a href="<%=cp%>/pr/detail.action?superProduct=${dto.superProduct}">
											<img alt="" src="${imagePath }/${dto.saveFileName }" height="50px;">
											</a>&nbsp;&nbsp;<a href="<%=cp%>/pr/detail.action?superProduct=${dto.superProduct}">${dto.productName }</a>
											${dto.amount }&nbsp;개 &nbsp;&nbsp;<fmt:formatNumber value="${dto.price }" type="number"/>&nbsp;원<br/>
											<c:set var= "productNum" value="${productNum+1 }"/>
										</div>
									</c:if>
								</c:forEach>
								</div>
							</td>
							<td style="vertical-align: top;">
								<fmt:formatNumber value="${price}" type="number"/>원
							</td>
							<td style="vertical-align: top;">
								<button onclick="showOrderList('${orderNum}')" class="btn_sm_bordered_review">상품보기</button>
							</td>
							<td style="vertical-align: top;">
								<c:if test="${userOrderlist[productNum-1].payment eq 'no'}">
									<button class="button_payment">입금대기</button>
								</c:if>
								
								<c:if test="${userOrderlist[productNum-1].payment eq 'yes'}">
									<button class="btn_sm_bordered_review">결제완료</button>
								</c:if>				
							</td>
							<c:set var= "number" value="${number+1 }"/>
							</tr>
						</c:forEach>
						</c:if>	
						
						<c:if test="${empty userOrderlist }">
							<tr><td colspan="5"><div style="text-align: center; font-size: 30px; margin-top: 50px; margin-bottom: 50px;">조회된 내용이 없습니다.</div></td></tr>
						</c:if>	
					
					</tbody>
				</table>
			</div>
		</div>
		
		<div align="center">
			<font style="font-size: 15px;">${pageIndexList}</font>
		</div>
		</div>
	</div>
	
</div>

<%@include file="../layout/footer.jsp"  %>
</body>

</html>