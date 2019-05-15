<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../layout/storeNav.jsp"  %>
<style>
.btn_sm_neutral{
	color:#8080ff; 
	background:#fff;
}

.total_money_list{
	border-top: 1px solid #D2D2D2;
	border-bottom:1px solid #D2D2D2;
}

.cart_list>dl>dt.on{
	border-top: 1px solid #D2D2D2;
	border-bottom:1px solid #D2D2D2;
}

.btn_basket_delete{
	background:#fff; 
	border:1px solid #333; 
	color:#333;
	font-size: 14px;
    min-width: 80px;
    height: 30px;
}

.selectItem{
	background-color:#eee;  
	width: 150px; 
	height: 25px; 
	font-size: 10pt; 
	padding: 2px 2px; 
	border: 1px solid #d9d9d9;
}
</style>

<script type="text/javascript">
	function sendList() {
		var f = document.sendListForm;
		f.action = "<%=cp%>/order/orderList.action";
		f.submit();
	}
	
	function sendMain() {
		var f = document.sendListForm;
		f.action = "<%=cp%>/pr/listNew.action";
		f.submit();
	}
	
 	$(function(){
 		//장바구니 아이템 삭제
	 	$('.btn_basket_delete').each(function(i){ 		
			$(this).click(function(e){
				e.preventDefault();
				var params = "productId=" + $(this).val();
				location.href = '<%=cp%>/cart/deleteCartItem.action?'+params;
			});
	 	});
 		
		//장바구니 주문여부 선택
	 	$('.btn_basket_orderSelect').each(function(i){
			$(this).click(function(e){
				e.preventDefault();
				var cnt = $(this).val();
				var params = "productId="+$('#amendItem_productId_'+cnt).val();
				location.href = '<%=cp%>/cart/amendToOrderSelect.action?'+ params;
			});
		}); 
<%-- 	
		$('.btn_basket_orderSelect').each(function(i){	
			$(this).click(function(e){
				var cnt = $(this).val();
				var params = "productId="+$('#amendItem_productId_'+cnt).val();
				$.ajax({
					url:"<%=cp%>/cart/amendToOrderSelect.action",
					data: params,
					success:function(args){
						if(args=="no"){
							$("#btn_basket_orderSelect_img_"+cnt).html("<img alt='' src='/app/resources/image/checkmark_no.png' height='25px;' >");
							//$("#btn_basket_orderSelect_img_"+cnt).attr("src","/app/resources/image/checkmark_no.png");
						}else{
							$("#btn_basket_orderSelect_img_"+cnt).html("<img alt='' src='/app/resources/images/member/ico_join_complete.png' height='25px;' >");
							//$("#btn_basket_orderSelect_img_"+cnt).attr("src","/app/resources/images/member/ico_join_complete.png");
						}
					},
					error:function(e){
						alert(e.responseText);
					}	
				}); 
			});
		}); 
 --%>
		//장바구니 옵션 변경
	 	$('.btn_sm_primary').each(function(i){
			$(this).click(function(e){
				e.preventDefault();
				var cnt = $(this).val();
				var productId = $('#amendItem_productId_'+cnt).val();
				var productSize = $('#amendItem_productSize_'+cnt).val();
				var color = $('#amendItem_color_'+cnt).val();
				var amount = $('#amendItem_amount_'+cnt).val();
				var productName = $('#amendItem_productName_'+cnt).text();
				var price = $('#amendItem_price_'+cnt).val();
				//location.href = 'amendProductOption.action?'+ params;
				
				//보내기전에 실행되는 함수
				function showRequest(){
					var selectedProductSize = $.trim(productSize);
					var selectedColor = $.trim(color);
					var selectedAmount = $.trim(amount);
					
					if(!selectedProductSize){
						alert("\n사이즈를 선택하세요.");
						$("#amendItem_productSize_"+cnt).focus();
						return false;//null이므로 진행 중단
					}
					if(!selectedColor){
						alert("\n컬러를 선택하세요.");
						$("#amendItem_color_"+cnt).focus();
						return false;//null이므로 진행 중단
					}
					if(!selectedAmount){
						alert("\n수량을 선택하세요.");
						$("#amendItem_amount_"+cnt).focus();
						return false;//null이므로 진행 중단
					}
					return true;
				}

	 			$.post({
					url:"<%=cp%>/cart/amendProductOption.action",
					data:{ 
						productId:productId,
						productSize:productSize,
						color:color,
						amount:amount,
						productName:productName,
						price:price
					},
					success:function(args){
						location.href = '<%=cp%>/cart/cartList.action';					
					},
					beforeSend:showRequest,
					error:function(e){
						alert(e.responseText);
					}	
				}); 
			});
		});
	}); 

</script>

<!-- page title -->
<div class="page_title">
	<h2 class="h_title page">장바구니</h2>
	<p class="text font_lg"></p>
</div>
<!-- // page title -->

<!-- page contents -->
<div class="ap_contents cart">
	<div class="ui_step">
		<ul>
			<!--<li th:class="current"><i class="ico"></i><span class="num">1</span>장바구니<span class="sr_only">선택됨</span></li>-->
			<li class="current"><i class="ico"></i><span class="num">1</span>장바구니</li>
			<li><i class="ico"></i><span class="num">2</span>결제하기</li>
			<li><i class="ico"></i><span class="num">3</span>주문완료</li>
		</ul>
	</div>
	<div class="cart_list">
		<dl>
			<dt class="on" style="padding-left:10px; color: #333; margin-bottom: 10px;">
				<span class="check_wrap">
					총 장바구니 상품 ${totalItemCount }개
				</span>
			</dt>
			<!-- 장바구니 상품 내역 -->
			<c:if test="${empty lists }" >
			<div align="center" style="padding: 20px 20px 20px 20px; font-weight: bold; font-size: 20pt;">장바구니에 담긴 상품이 없습니다.</div>
			</c:if>
			<c:forEach var="dto" items="${lists }" varStatus="status">
				<div align="center">
				<table border="0" style="margin-top: 10px;">
				<tr style="widows: 1200px; height: 70px;" align="center">
					<!-- 주문상품 체크 -->
					<td class="check_wrap check_only" rowspan="2" width="50">
						<c:if test="${dto.orderSelect=='no'}">
							<button class="btn_basket_orderSelect" value="${status.count}">
							<div id="btn_basket_orderSelect_img_${status.count}">
							<img alt="" src="<%=cp%>/resources/image/checkmark_no.png" height="25px;" >
							</div>
							</button>
						</c:if> 
						<c:if test="${dto.orderSelect=='yes' }">
							<button class="btn_basket_orderSelect" value="${status.count}">
							<div id="btn_basket_orderSelect_img_${status.count}">
							<img alt="" src="<%=cp%>/resources/images/member/ico_join_complete.png" height="25px;">
							</div>
							</button>
						</c:if>						
					</td>
					<!-- 상품이미지 -->
					<td width="160px" rowspan="2">
						<img src="../upload/list/${dto.originalName}" width="140" height="140" style="margin-right: 10px; border-radius: 10px;" >
					</td>
					
					<td width="640px" style="padding-left: 30px;font-size: 20px;color: #000;" align="left" >
						<a href="<%=cp%>/pr/detail.action?superProduct=${dto.superProduct}">
						<span id="amendItem_productName_${status.count}">${dto.productName }</span>
						</a>
					</td>
					
					<td width="100px">
					</td>
					
					<td width="100px">
						<span style="color: #000;font-size: 20px;font-weight: bold;">
						<fmt:formatNumber value="${dto.price * dto.amount}" groupingUsed="true"/> 원
						</span>
					</td>
					
					<td width="200px">
						<button class="btn_basket_delete" value="${dto.productId}" >삭&nbsp;&nbsp;제</button>
					</td>
				</tr>
				
					<tr align="center" bgcolor="#eeeeee" height="60px" style="padding-left: 80px;">
						<!-- 상품 옵션 -->
						<td align="left" style="padding-left: 30px; color: #000;">
							<table border="0">
							<tr height="30">
								<td width="50" align="center">사이즈</td>
								<td width="200" style="padding-left: 20px;">
								<select name="productSize" class="selectItem" id="amendItem_productSize_${status.count}">
									<c:forEach var="option" items="${dto.sizeList }">
									<option <c:if test="${option==dto.productSize}">selected='selected'</c:if> value="${option }">${option }</option>
									</c:forEach>
								</select>
								</td>
							</tr>
							<tr height="30">
								<td width="50" align="center">색상</td>
								<td width="200" style="padding-left: 20px;">
								<select name="color" class="selectItem" id="amendItem_color_${status.count}">
									<c:forEach var="option" items="${dto.colorList }">
									<option <c:if test="${option==dto.color}">selected='selected'</c:if> value="${option }">${option }</option>
									</c:forEach>
								</select>
								</td>
							</tr>
							</table>
						</td>
						<td>
							<b>
							<select name="amount" class="selectItem" id="amendItem_amount_${status.count}" style="width: 60px;">
								<c:forEach var="cnt"  begin="1" end="30" step="1"> 
									<option <c:if test="${cnt==dto.amount}">selected='selected'</c:if> value="${cnt}">
										${cnt}
									</option>
								</c:forEach>
							</select>개
							</b>
						</td>
						<td>
							<b style="color: #333;font-weight: 500;}">
							<input type="hidden" value="${dto.productId}"  id="amendItem_productId_${status.count}">
							<input type="hidden" value="${dto.price}"  id="amendItem_price_${status.count}">
							<fmt:formatNumber value="${dto.price}" groupingUsed="true"/> 원
							</b>
						</td>
						<td>
							<button class="btn_sm_primary" value="${status.count}" >옵션 변경</button>
						</td>
					</tr>
				</table>
				</div>
			</c:forEach>
		</dl>
	</div>
	
	<!-- 총구매개수, 구매액 -->
	<dl class="total_money_list" id="calculationResult" style="margin-top: 10px;" >
		<dt class="on" style="font-size: 16px;">
			총 상품 구매금액(${totalItemCountYes }개) 
			<span style="float: right;font-style: normal; font-size: 24px;font-weight: 700;">
				<em style="color:#8080ff; padding-right: 20px;"><fmt:formatNumber value="${totalItemPrice}" groupingUsed="true"/>원</em>
			</span>
		</dt>
	</dl>
	
	<!-- 버튼 -->
	<form name="sendListForm">
	<div class="page_btns">
		<button class="btn_lg_bordered" id="btnMain" onclick="sendMain();" style="margin-right:20px; border-color: #8080ff; color: #8080ff;">계속 쇼핑하기</button>
		<button class="btn_lg_primary" id="btnCheckOrder" onclick="sendList();">주문 결제하기</button>
	</div>
	</form>
</div>

<%@include file="../layout/footer.jsp"  %>
