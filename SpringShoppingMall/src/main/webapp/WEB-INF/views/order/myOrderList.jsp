<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../layout/top.jsp" %>
<%@ include file="../layout/mypage.jsp" %>
<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>

<style>

.inLine_myOrder { 
	display: inline;
}

.order_on {
	background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;
}

</style>

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
				<dd class="inLine_myOrder"><button onclick="javascript:location.href='order/myOrderLists.action?period=week';" 
					style="<c:if test='${period eq "week"}'>background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;</c:if>" 
					class="btn_sm_bordered_review">1주일</button>
				</dd>
				<dd class="inLine_myOrder"><button onclick="javascript:location.href='order/myOrderLists.action?period=month';" 
					style="<c:if test='${period eq "month"}'>background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;</c:if>" 
					class="btn_sm_bordered_review">1개월</button>
				</dd>
				<dd class="inLine_myOrder"><button onclick="javascript:location.href='order/myOrderLists.action?period=3month';" 
					style="<c:if test='${period eq "3month"}'>background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;</c:if>" 
					class="btn_sm_bordered_review">3개월</button>
				</dd>
				<dd class="inLine_myOrder"><button onclick="javascript:location.href='order/myOrderLists.action?period=6month';" 
					style="<c:if test='${period eq "6month"}'>background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;</c:if>" 
					class="btn_sm_bordered_review">6개월</button>
				</dd>
				<dd class="inLine_myOrder"><button onclick="javascript:location.href='order/myOrderLists.action?period=year';" 
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
				<c:if test="${empty userOrderlist }">
					<div style="text-align: center; font-size: 30px; margin-top: 20px;">조회된 내용이 없습니다.</div>
				</c:if>	
				
				<c:if test="${!empty userOrderlist }">	
				<table class="ui_table_striped data_table thead_colored align_center @table-striped-apply" id="shpiTable" style="margin-left: -33px;">

					<colgroup>
						<col width="15%">
						<col width="5%">
						<col width="30%">
						<col width="50%">
					</colgroup>

					<thread>
					<tr>
						<th scope="col" bgcolor="#F2F2F2">구매일</th>
						<th scope="col" bgcolor="#F2F2F2" colspan="2">상품</th>
						<th scope="col" bgcolor="#F2F2F2">배송지</th>
					</tr>
					</thread>

					<tbody id="paging">
						<c:forEach var="dto" items="${userOrderlist }">
							<tr>
								<td class="check_wrap check_only">${dto.orderDate }
									<br/>${dto.orderNum }
								</td>
								<td style="vertical-align: top; text-align: left;">
									<a href="pr/detail.action?superProduct=${dto.superProduct}">
										<img alt="" src="${imagePath }/${dto.saveFileName }" height="50px;">
									</a>
								</td>
								<td style="vertical-align: top; text-align: left;">
									<a href="pr/detail.action?superProduct=${dto.superProduct}">${dto.productName }</a>
									${dto.amount }&nbsp;개 &nbsp;&nbsp;${dto.price }&nbsp;원 
									<br/>(총합&nbsp;&nbsp;:&nbsp;&nbsp;${dto.amount * dto.price }) &nbsp;&nbsp;&nbsp;&nbsp;
								</td>
								<td style="text-align: left;">
									[${dto.zip }] ${dto.addr1 } ${dto.addr2 }
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</c:if>	
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