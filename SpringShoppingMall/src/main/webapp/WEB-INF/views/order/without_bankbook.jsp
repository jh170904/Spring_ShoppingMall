<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../layout/storeNav.jsp"  %>

<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>

<script>

function sendMain() {
	
	var f = document.orderCompleteFoem;
	
	f.action = "pr/listNew.action";
	
	f.submit();
	
}

</script>

<!-- page title -->
<div class="page_title">
	<h2 class="h_title page">주문완료</h2>
	<p class="text font_lg"></p>
</div>
<!-- // page title -->

<!-- page contents -->
<div class="ap_contents cart">

	
	<div class="ui_step">
		<ul>
			<li><i class="ico"></i><span class="num">1</span>장바구니</li>
			<li><i class="ico"></i><span class="num">2</span>결제하기</li>
			<li class="current"><i class="ico"></i><span class="num">3</span>주문완료</li>
		</ul>
	</div>
	
	<form class="order-validate" id="order-recept-info" name="orderCompleteFoem" method="post">
	<div class="ui_accordion cart_list ＠accordion-apply">		
		<div class="cont">
			<span style="font-size: 30px; font-weight: bolder; color: black; padding-left: 500px;">주문 확인</span>
			<div style="border-bottom: 1px solid #cacaca; margin-top: 50px; margin-bottom: 50px;"></div>
					
			<div style="padding: 0px 20px;">
				<table style="width: 1000px;">
					<tr style="height: 50px;">
						<td style="width: 250px;">주문 일자</td>
						<td style="text-align: left;">${orderDate }</td>
					</tr>	
					<tr style="height: 50px;">
						<td style="text-align: left;">받는 사람 정보</td>
						<td>${userName }</td>
					</tr>
					<tr style="height: 50px;">
						<td style="text-align: left;">배송지</td>
						<td>${orderDest}</td>
					</tr>
					<tr style="height: 50px">
						<td colspan="2">상품목록</td>
					</tr>
					<c:forEach var="orderList" items="${orderList }">
					<tr style="height: 50px;">
						<td>
							<img alt="" src="${imagePath }/${orderList.saveFileName }" height="100px" width="100px">
						</td>
						<td valign="top">
							<span style="text-align: left;">
								${orderList.productName }&nbsp;<fmt:formatNumber value="${orderList.price }" type="number"/> 원 
							</span>
							<span style="text-align: right; float: right;" >
								${orderList.amount }개(<fmt:formatNumber value="${orderList.amount * orderList.price }" type="number"/>)원
							</span>							
						</td>
					</tr>	
					</c:forEach>
					<c:if test="${discount !=0 }">
					<tr style="height: 50px;">
						<td></td>
						<td style="text-align: right;">(할인&nbsp;&nbsp;<fmt:formatNumber value="${discount }" type="number"/>원 )</td>
					</tr>
					</c:if>
					<tr style="height: 50px;">
						<td></td>
						<td style="text-align: right;">${totalAmount }개 (총 <fmt:formatNumber value="${totalPrice }" type="number"/>원 )</td>
					</tr>
					<tr style="height: 50px; padding-top: 50px;">
						<td colspan="2">입금완료시 배송이 시작됩니다.</td>
					</tr>
					<tr style="height: 50px;">
						<td colspan="2">하나은행 : 620-228851-752(오예린)</td>
					</tr>
				</table>
			</div>
			
			<div style="border-bottom: 1px solid #cacaca; margin-top: 50px;"></div>
		</div>
	</div>
	
	<!-- 버튼 -->
	<div class="page_btns">
		<button type="button" class="btn_lg_primary" id="orderPayment" onclick="sendMain();">쇼핑계속하기</button>
	</div>
	</form>
	
	

</div>
	
<!-- // page contents -->



<%@include file="../layout/footer.jsp"  %>
