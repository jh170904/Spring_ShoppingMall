<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../layout/storeNav.jsp"  %>

<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script src="http://code.jquery.com/jquery-1.4.4.min.js"></script>

<style>

.order_inputBox {
	background-color: #f5f5f5;
	border: 0px;
	color : #000000;
	width: 600px;
}

.payment_div {
	display: inline-block;
	padding: 5px 30px;
	border: 1px black solid;
}

.active {
	background-color: #8080ff;
}

</style>

<script>

	var point = 0;
	var couponPrice = 0 ;
	
	function thousandSeparatorCommas(number){ 		
		//문자변환
		var string = "" + number;
		//±기호와 소수점, 숫자들만 남기고 전부 지우기.
		string = string.replace( /[^-+\.\d]/g, "" )   
		//정규식 
		var regExp = /^([-+]?\d+)(\d{3})(\.\d+)?/;  
		//쉼표 삽입	
		while ( regExp.test( string ) ) string = string.replace( regExp, "$1" + "," + "$2" + "$3" );  
		return string; 
	}

	function showOrder(order) {

		var content = document.getElementById(order);

		if(content.style.display == "none"){
			content.style.display = "block";
		}else{
			content.style.display = "none";
		}
	}
	
	function sendOrderList() {
		    
		var f = document.orderForm;
		
		var str = f.userEmail.value;
		str = str.trim();
		if(!str) {
			alert("이메일을 입력해주세요.");
			f.userEmail.focus();
			return;
		}
		
		f.action = "payReq.action";
		f.submit();
		
	}
	
	$(document).ready(function(){
		var totalPrice = document.getElementById('totalPriceDelivery').value;
		if(totalPrice>=50000){
			var deliveryFee = 0;
			document.getElementById('deliveryFee').value = thousandSeparatorCommas(deliveryFee);
		}
		else{
			document.getElementById('totalOrderPriceMain').value = thousandSeparatorCommas(${totalPrice}+${deliveryFee});
		}
		
	});
	
	function addPoind() {
		
		point = document.orderForm.beauty_point.value;
		var memberPoint = ${memberPoint};
		var totalPrice 
		if(point<1000){
			alert("1000포인트부터 사용할 수 있습니다.");
			f.beauty_point.focus();
			return;
		}
		if(point>memberPoint){
			alert("보유하신 포인트보다 많은 포인트는 사용할 수 없습니다.");
			f.beauty_point.focus();
			return;
		}
		
		var total = ${totalPrice} + ${deliveryFee} - point - couponPrice;
			
		document.orderForm.discount.value = point;
		document.getElementById('totalPriceDelivery').value = ${totalPrice} + ${deliveryFee} - point - couponPrice;
		document.getElementById('totalOrderPriceMain').value = thousandSeparatorCommas(total);
		document.getElementById('totalOrderPrice').value = thousandSeparatorCommas(total);
		document.getElementById('totalOrderPoint').value = thousandSeparatorCommas(total*0.01);
		document.getElementById('totalPoint').value = total*0.01;
		
	}
	
	function removePoind() {

		var total = ${totalPrice} + ${deliveryFee} - couponPrice ;
		
		document.orderForm.beauty_point.value="";
		document.orderForm.discount.value = "0";
		document.getElementById('totalPriceDelivery').value = ${totalPrice} + ${deliveryFee} - point - couponPrice;
		document.getElementById('totalOrderPriceMain').value = thousandSeparatorCommas(total);
		document.getElementById('totalOrderPrice').value = thousandSeparatorCommas(total);
		document.getElementById('totalOrderPoint').value = thousandSeparatorCommas(total*0.01);
		document.getElementById('totalPoint').value = total*0.01;
		//var totalPrice = document.orderForm.totalPricePoint.value = ${totalPrice} - point;
		
	}
		
    function closeCoupon() {
        // iframe을 넣은 element를 안보이게 한다.
        document.getElementById('layer').style.display = 'none';
    }
    
    function couponLayer() {
        
        document.getElementById('layer').style.display = 'block';
        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

	function initLayerPosition(){
        var width = 500; //우편번호서비스가 들어갈 element의 width
        var height = 700; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 1; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        document.getElementById('layer').style.width = width + 'px';
        document.getElementById('layer').style.height = height + 'px';
        document.getElementById('layer').style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        document.getElementById('layer').style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        document.getElementById('layer').style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px'; 
    }
	
	function couponUse(price,name,key){
		
		couponPrice = price;
		var couponName = name;
		var couponKey = key;
		
		document.getElementById('layer').style.display = 'none';
		document.orderForm.couponDiscount.value = couponPrice;
		
		var total1 = ${totalPrice} + ${deliveryFee} - point - couponPrice ;
		document.orderForm.discount.value = point;
		document.orderForm.couponName.value = couponName;		
		document.orderForm.useCouponKey.value = key;
		
		document.getElementById('totalPriceDelivery').value = ${totalPrice} + ${deliveryFee} - point - couponPrice;
		document.getElementById('totalOrderPriceMain').value = thousandSeparatorCommas(total1);
		document.getElementById('totalOrderPrice').value = thousandSeparatorCommas(total1);
		document.getElementById('totalOrderPoint').value = thousandSeparatorCommas(total1*0.01);
		document.getElementById('totalPoint').value = total*0.01;
		
		
	}
	
	//배송지 정보 조회
	function destClose() {
        // iframe을 넣은 element를 안보이게 한다.
        document.getElementById('destLayer').style.display = 'none';
    }
    
    function destLayer() {
        
        document.getElementById('destLayer').style.display = 'block';
        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        var width = 700; //우편번호서비스가 들어갈 element의 width
        var height = 700; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 1; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        document.getElementById('destLayer').style.width = width + 'px';
        document.getElementById('destLayer').style.height = height + 'px';
        document.getElementById('destLayer').style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        document.getElementById('destLayer').style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        document.getElementById('destLayer').style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px'; 
    }

	
	function destUse(destName,destPhone,zip,addr1,addr2,addrKey){
		
		
		document.getElementById('destLayer').style.display = 'none';
		
		document.orderForm.destName1.value = destName;
		document.orderForm.destName2.value = destName;
		document.orderForm.destAddr.value = '[' + zip + '] ' + addr1 + addr2;	
		document.orderForm.destPhone1.value = destPhone;
		document.orderForm.destPhone2.value = destPhone;
		
		document.orderForm.zip.value = zip;
		document.orderForm.addr1.value = addr1;
		document.orderForm.addr2.value = addr2;
		document.orderForm.addrKey.value = addrKey;
		
	}
	
	//배송지 입력
	function destInsertClose() {
        // iframe을 넣은 element를 안보이게 한다.
        document.getElementById('destInsert').style.display = 'none';
    }
    
    function destInsert() {
        
        document.getElementById('destInsert').style.display = 'block';
        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        var width = 700; //우편번호서비스가 들어갈 element의 width
        var height = 700; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 1; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        document.getElementById('destInsert').style.width = width + 'px';
        document.getElementById('destInsert').style.height = height + 'px';
        document.getElementById('destInsert').style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        document.getElementById('destInsert').style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        document.getElementById('destInsert').style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px'; 
    }

	
	function destInsertNew(destName,destPhone,zip,addr1,addr2){
			
		document.getElementById('destInsert').style.display = 'none';
		
		document.orderForm.destName1.value = destName;
		document.orderForm.destName2.value = destName;
		document.orderForm.destAddr.value = '[' + zip + '] ' + addr1 + ' ' + addr2;	
		document.orderForm.destPhone1.value = destPhone;
		document.orderForm.destPhone2.value = destPhone;
		
		document.orderForm.zip.value = zip;
		document.orderForm.addr1.value = addr1;
		document.orderForm.addr2.value = addr2;
		document.orderForm.addrKey.value = 'no';
		
	}
	
	
	
</script>

<!-- 배송지 입력 -->
<div id="destInsert" style="display:none;position:fixed; overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch; background-color: #ffffff;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="destInsertClose()" alt="닫기 버튼">
<%@include file="./orderDestInsert.jsp"  %>
</div>


<!-- 배송지 페이지 -->
<div id="destLayer" style="display:none;position:fixed; overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch; background-color: #ffffff;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="destClose()" alt="닫기 버튼">

<table class="ui_table_striped data_table thead_colored align_center @table-striped-apply" id="shpiTable">
	
	<colgroup>
		<col>
		<col>
		<col>
	</colgroup>
	
	<thread>
	<tr>
		<th scope="col" bgcolor="#F2F2F2">변경</th>
		<th scope="col" bgcolor="#F2F2F2">배송지이름</th>
		<th scope="col" bgcolor="#F2F2F2">배송지</th>
	</tr>
	</thread>
	
	<tbody id="paging">
	<c:forEach var="destAllDto" items="${destAllList }">
		<tr>
			<td>
				<button type="button" class="btn_sm_neutral" id="dest_mobileVoucher" name="${destAllDto.destNickname }" 
					onclick="destUse('${destAllDto.destName}','${destAllDto.destPhone }','${destAllDto.zip }','${destAllDto.addr1 }','${destAllDto.addr2 }','${destAllDto.addrKey }');">
				변경</button>
			</td>
			<td align="center">${destAllDto.destNickname }</td>
			<td align="left">[${destAllDto.zip }] ${destAllDto.addr1 } ${destAllDto.addr2 }</td>
		</tr>
	</c:forEach>
	</tbody>
	
</table>

</div>

<!-- 쿠폰 페이지 -->
<div id="layer" style="display:none;position:fixed; overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch; background-color: #ffffff;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeCoupon()" alt="닫기 버튼">

<table class="ui_table_striped data_table thead_colored align_center @table-striped-apply" id="shpiTable">
	
	<colgroup>
		<col>
		<col>
		<col>
	</colgroup>
	
	<thread>
	<tr>
		<th scope="col" bgcolor="#F2F2F2">사용</th>
		<th scope="col" bgcolor="#F2F2F2">쿠폰명</th>
		<th scope="col" bgcolor="#F2F2F2">혜택</th>
	</tr>
	</thread>
	
	<tbody id="paging">
	<c:forEach var="couponDto" items="${couponList }">
		<tr>
			<td>
				<button type="button" class="btn_sm_neutral" id="b_mobileVoucher" name="${couponDto.couponKey }" value="${couponDto.couponKey }" 
					onclick="couponUse('${couponDto.discount}','${couponDto.couponName }','${couponDto.couponKey }');">사용</button>
			</td>
			<td>${couponDto.couponName }</td>
			<td><font color="#f54a7e">${couponDto.discount}원 할인</font></td>
		</tr>
	</c:forEach>
	</tbody>
	
</table>

</div>


<!-- page title -->
<div class="page_title">
	<h2 class="h_title page">결제하기</h2>
	<p class="text font_lg"></p>
</div>
<!-- // page title -->

<!-- page contents -->
<div class="ap_contents cart">

	
	<div class="ui_step">
		<ul>
			<!--<li th:class="current"><i class="ico"></i><span class="num">1</span>장바구니<span class="sr_only">선택됨</span></li>-->
			<li><i class="ico"></i><span class="num">1</span>장바구니</li>
			<li class="current"><i class="ico"></i><span class="num">2</span>결제하기</li>
			<li><i class="ico"></i><span class="num">3</span>주문완료</li>
		</ul>
	</div>
	
	<form class="order-validate" id="order-recept-info" name="orderForm" method="post">
	<div class="ui_accordion cart_list ＠accordion-apply">		
		<dl>
			<dt>
				<span>주문 상품 확인&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(<font color="#8080ff" style="font-weight: bolder;">${totalAmount }개</font>)</span>			
				<button type="button" onclick="showOrder('1')" ><span class="sr_only">닫기</span>
					<img alt="" src="<%=cp%>/resources/image/orderButton.PNG" height="20px;">
				</button>
			</dt>
			<dd class="on" id = "1" style="display: none">
				<div class="cont">
					<span style="font-size: 25px; font-weight: bolder; color: black;">쇼핑상품(<font color="#8080ff" style="font-weight: bolder;">${totalOrderCount }개</font>)</span>
					<div style="border-bottom: 1px solid #cacaca; margin-top: 20px;"></div>
					
					<c:forEach var="orderListDto" items="${orderList }">
					<table style="width: 1118px; margin: 20px 0px 0px 0px;" class="panel_cont">
						<tr>
							<td style="padding: 20px 0px; width: 20%">
								<img alt="" src="${imagePath }/${orderListDto.saveFileName}" height="150px;">
							</td>
							<td style="padding: 20px 0px;" valign="top">
								<b style="color: black; font-size: 20px;">${orderListDto.productName}</b>
							</td>
							<td style="padding: 20px 0px;" align="right">
								<span style="font-weight: bolder; color: black; font-size: 18px;">
									${orderListDto.amount }개 &nbsp;&nbsp; <fmt:formatNumber value="${orderListDto.amount * orderListDto.price }" type="number"/>원
								</span>
							</td>
						</tr>						
					</table>
					
					<table style="width: 1118px; margin: 20px 0px 50px 0px; background-color: #f5f5f5" class="panel_cont">
						<tr>
							<td style="padding: 20px 40px;" rowspan="2" width="15%">
								<img alt="" src="${imagePath }/${orderListDto.saveFileName}" height="50px;">
							</td>
							<td align="left">
								<b style="color: black">사이즈 : ${orderListDto.productSize }</b>
							</td>
							<td style="padding: 20px 40px;" align="right" rowspan="2">
								<span>${orderListDto.amount }개</span>
							</td>
						</tr>	
						<tr>
							<td align="left"><b style="color: black"> 색 : ${orderListDto.color }</b></td>
						</tr>					
					</table>
					<div style="border-bottom: 1px solid #cacaca; margin-top: 20px;"></div>
					</c:forEach>
				</div>
			</dd>			
		</dl>	
	
		<dl>
			<dt>
				<span>배송 정보 입력</span>
				<button type="button" onclick="showOrder('2')"><span class="sr_only">닫기</span>
					<img alt="" src="<%=cp%>/resources/image/orderButton.PNG" height="20px;">
				</button>
			</dt>
			<dd class="on" id = "2" style="display: block">
				<div class="cont delivery_info">
					<span style="font-size: 25px; font-weight: bolder; color: black;">배송정보</span>
					<span style="float: right; margin-right: 10px;"><button type="button" class="btn_sm_neutral" id="dest_mobileVoucher" onclick="destLayer();">배송지 조회</button></span>
					<span style="float: right; margin-right: 10px;"><button type="button" class="btn_sm_neutral" id="destInsert_mobileVoucher" onclick="destInsert();">배송지 입력</button></span>
					
					<div style="border-bottom: 1px solid #cacaca; margin-top: 20px;"></div>
					
					<table style="border: 1px solid #cacaca; width: 1118px; margin: 20px 0px 50px 0px; background-color: #f5f5f5" class="panel_cont">
						<tr>
							<td style="padding: 20px 40px; width: 20%"><b style="color: black">이름</b></td>
							<td style="padding: 20px 40px;">
								<span><input type="text" value="${destDto.destName}" id="destName1" readonly="readonly" class="order_inputBox" name="destName""></span>
							</td>
						</tr>
						<tr>
							<td style="padding: 20px 40px;"><b style="color: black">주소</b></td>
							<td style="padding: 20px 40px;">
								<span><input type="text" value="[${destDto.zip}] ${destDto.addr1 } ${destDto.addr2 }" id="destAddr" readonly="readonly" class="order_inputBox" name="destAddr"></span>
							</td>
						</tr>
						<tr>
							<td style="padding: 20px 40px;"><b style="color: black">휴대폰 번호</b></td>
							<td style="padding: 20px 40px;">
								<span><input type="text" value="${destDto.destPhone}" id="destPhone1" readonly="readonly" class="order_inputBox" name="destPhone"></span>
								<input type="hidden" name="zip" value="${destDto.zip }">
								<input type="hidden" name="addr1" value="${destDto.addr1 }">
								<input type="hidden" name="addr2" value="${destDto.addr2 }">
								<input type="hidden" name="addrKey" value="${destDto.addrKey }">
							
							</td>
						</tr>						
					</table>
					
					<span style="font-size: 25px; font-weight: bolder; color: black;">주문자 고객 정보</span>
					<div style="border-bottom: 1px solid #cacaca; margin-top: 20px;"></div>
					
					<table style="border: 1px solid #cacaca; width: 1118px; margin-top: 20px; background-color: #f5f5f5" class="panel_cont">
						<tr>
							<td style="padding: 20px 40px; width: 20%"><b style="color: black">이름</b></td>
							<td style="padding: 20px 40px;">
								<span><input type="text" value="${destDto.destName}" id="destName2" readonly="readonly" class="order_inputBox"></span>
							</td>
						</tr>
						<tr>
							<td style="padding: 20px 40px;"><b style="color: black">휴대폰 번호</b></td>
							<td style="padding: 20px 40px;">
								<span><input type="text" value="${destDto.destPhone}" id="destPhone2" readonly="readonly" class="order_inputBox"></span>
							</td>
						</tr>
						<tr>
							<td style="padding: 20px 40px;"><b style="color: black">이메일</b><b style="color: #8080ff">필수</b></td>
							<td style="padding: 20px 40px;">
								<span class="input_wrap w70p">
									<input type="text" name="userEmail" placeholder="이메일을 입력하세요"> 			
								</span>
							</td>
						</tr>						
					</table>
				</div>
			</dd>
		</dl>
	
		<dl>
			<dt>
				<span>쿠폰/포인트 혜택 사용</span>
				<button type="button" onclick="showOrder('3')"><span class="sr_only">닫기</span>
					<img alt="" src="<%=cp%>/resources/image/orderButton.PNG" height="20px;">	
				</button>
			</dt>
			<dd class="on" id = "3" style="display: none">
				<div class="cont">
					<div class="pqyment">
						<table style="border: 1px solid #cacaca; width: 1118px;" class="panel_cont">
							<tr>
								<td style="padding: 40px; border-bottom: 1px dotted #cacaca"><b>사용쿠폰</b></td>
								<td style="padding: 40px; border-bottom: 1px dotted #cacaca" align="right">
									<span>
										<input type="text" readonly="readonly" style="text-align: right; background-color: #ffffff; border:0" name="couponName" value="">
										&nbsp;&nbsp;&nbsp;
									</span>
									<button type="button" class="btn_sm_neutral" id="b_mobileVoucher" onclick="couponLayer();">쿠폰조회</button>
								</td>
							</tr>
							<tr>
								<td style="padding: 40px 0px 0px 40px;"><b>뷰티포인트</b></td>
								<td style="padding: 40px 40px 0px 40px;" class="point" align="right">
									<span class="input_wrap bpoint">
										<input type="number" id="beauty_point" name="beauty_point" size="5">
									</span>
									<b>P</b>
									<span>/보유 ${memberPoint }P</span>
									<button type="button" class="btn_sm_neutral" id="b_mobileVoucher" onclick="addPoind();">적용하기</button>
									<button type="button" class="btn_sm_neutral" onclick="removePoind();">적용취소</button>
								</td>
							</tr>
							<tr>
								<td colspan="2" style="padding: 0px 0px 40px 40px;" class="text_notice light">
									<img alt="" src="<%=cp%>/resources/image/ico.PNG" height="20px;">
									뷰티포인트 전용 제품구매시 자동으로 보유 포인트 중 사용액이 설정됩니다.
								</td>
							</tr>							
						</table>
					</div>
				</div>
			</dd>
		</dl>

<!-- 
						<table style="border: 1px solid #cacaca; width: 1118px;" class="panel_cont">
							<tr>
								<td style="padding: 40px; border-bottom: 1px dotted #cacaca"><b>모바일 상품권</b></td>
								<td style="padding: 40px; border-bottom: 1px dotted #cacaca" align="right">
									<span class="price">0원</span>
									<button type="button" class="btn_sm_neutral" id="b_mobileVoucher">등록/사용</button>
								</td>
							</tr>
							<tr>
								<td style="padding: 40px;"><b>PINK MONEY</b></td>
								<td style="padding: 40px;" align="right">
									<span class="price">0원</span>
									<button type="button" class="btn_sm_neutral" id="b_mobileVoucher">조회</button>
								</td>
							</tr>
						</table>
 -->
		<dl>
			<dt> 
				<span>결제수단 선택</span>
				<button type="button" onclick="showOrder('4')"><span class="sr_only">닫기</span>
					<img alt="" src="<%=cp%>/resources/image/orderButton.PNG" height="20px;">
				</button>
			</dt>
			<dd class="on" id = "4" style="display: none">
				<div class="cont">
					<div class="pqyment">
						<div class="payment_div">	
						<input type="radio" value="creditCard" checked="checked" name="order_payment" id="order_payment_creditCard">		
						<label class="creditCard " for="order_payment_creditCard">
							<div><img alt="" src="<%=cp%>/resources/image/credit_card.png" height="100px"></div>
							<div class="creditCard">신용카드</div>
						</label>
						</div>
						
						<div class="payment_div">	
						<input type="radio" value="without_bankbook" name="order_payment" id="order_payment_without_bankbook"> 
						<label class="without_bankbook" for="order_payment_without_bankbook">
							<div><img alt="" src="<%=cp%>/resources/image/without_bankbook.png" height="100px"></div>
							<div class=payment_without_bankbook>무통장 입금</div>
						</label>
						</div>
					</div>
				</div>
			</dd>	
		</dl>

	
		<!-- 총구매개수, 구매액 -->
		<dl>
			<dt>
				<span>최종 결제금액</span>
				<span style="text-align: right;">
					<font style="font-weight: bolder; font-size: 20px; color: #8080ff;">
						<span>
							<input type="text" readonly="readonly" style="text-align: right; background-color: #ffffff; border:0" 
								name="totalOrderPriceMain" id="totalOrderPriceMain" value = "<fmt:formatNumber value="${totalPrice}" type="number"/>">&nbsp;원
							<input type="hidden" id="totalPriceDelivery" name="totalPriceDelivery" value="${totalPrice + deliveryFee}">	
						</span>
					</font>
					
					<button type="button" onclick="showOrder('5')" style="margin-left: 15px;"><span class="sr_only">닫기</span>
						<img alt="" src="<%=cp%>/resources/image/orderButton.PNG" height="20px;">
					</button>
				</span>
			</dt>
			<dd class="on" id = "5" style="display: none">
				<div class="cont">
					<table style="width: 1118px; margin: 0px 0px 30px 0px; background-color: #f5f5f5; border-top: 1px solid #cacaca; border-bottom: 1px solid #cacaca;" class="panel_cont">	
						<tr>
							<td style="padding: 20px 40px;">
								<font style="font-weight: bolder; font-size: 20px; color: black;">총 주문 금액</font></td>
							<td style="padding: 20px 40px;" align="right">
								<span>
									<input type="text" readonly="readonly" style="text-align: right; background-color: #f5f5f5; border:0" 
										name="totalOrderPrice" id="totalOrderPrice" value = "<fmt:formatNumber value="${totalPrice}" type="number"/>">&nbsp;원
								</span>
							</td>
						</tr>		
						<c:forEach var="orderListDto" items="${orderList }">
						<tr>
							<td style="padding: 10px 50px;">
								<font style="font-size: 17px; color: gray;">${orderListDto.productName}</font>
							</td>
							<td style="padding: 10px 40px;" align="right">
								<span style="font-size: 17px; color: gray; text-align: right;" >
									${orderListDto.amount }개 &nbsp;&nbsp; <fmt:formatNumber value="${orderListDto.amount * orderListDto.price }" type="number"/>원
								</span>					
							</td>
						</tr>	
						</c:forEach>
						<tr>
							<td style="padding: 10px 50px;">
								<font style="font-size: 17px; color: gray;">포인트 사용</font>
							</td>
							<td style="padding: 10px 40px;" align="right">
								<span style="font-size: 17px; color: gray; text-align: right;" >
									<span><input type="text" readonly="readonly" style="text-align: right; background-color: #f5f5f5; border:0" 
										name="discount" value=0>&nbsp;원</span>
								</span>					
							</td>
						</tr>	
						<tr>
							<td style="padding: 10px 50px;">
								<font style="font-size: 17px; color: gray;">쿠폰 사용</font>
							</td>
							<td style="padding: 10px 40px;" align="right">
								<span style="font-size: 17px; color: gray; text-align: right;" >
									<span><input type="text" readonly="readonly" style="text-align: right; background-color: #f5f5f5; border:0" 
										name="couponDiscount" value=0>&nbsp;원</span>
								</span>					
							</td>
						</tr>	
						<tr>
							<td style="padding: 10px 50px;">
								<font style="font-size: 17px; color: gray;">배송비</font>
							</td>
							<td style="padding: 10px 40px;" align="right">
								<span style="font-size: 17px; color: gray; text-align: right;" >
									<span><input type="text" readonly="readonly" style="text-align: right; background-color: #f5f5f5; border:0" 
										name="deliveryFee" id="deliveryFee" value="${deliveryFee }">&nbsp;원</span>
								</span>					
							</td>
						</tr>		
					</table>
					
					<table style="width: 1118px; margin: 0px 0px 30px 0px; background-color: #f5f5f5; border-top: 1px solid #cacaca; border-bottom: 1px solid #cacaca;" class="panel_cont">
						<tr>
							<td style="padding: 20px 40px;">
								<font style="font-weight: bolder; font-size: 20px; color: black;">적립 예정 포인트</font></td>
							<td style="padding: 20px 40px;" align="right">
								<span><font style="font-weight: bolder; font-size: 20px; color: black;">
									<input type="text" readonly="readonly" style="text-align: right; background-color: #f5f5f5; border:0" 
										name="totalOrderPoint" id="totalOrderPoint" value = "<fmt:formatNumber value="${totalPrice * 0.01}" type="number"/>">&nbsp;P</font>
								<input type="hidden" name="totalPoint" id="totalPoint" value="${totalPrice * 0.01}">
								</span>
							</td>
						</tr>
						<c:forEach var="orderListDto" items="${orderList }">
						<tr>
							<td style="padding: 10px 50px;">
								<font style="font-size: 17px; color: gray;">${orderListDto.productName}</font>
							</td>
							<td style="padding: 10px 40px;" align="right">
								<span style="font-size: 17px; color: gray; text-align: right;" >
									<fmt:formatNumber value="${orderListDto.amount * orderListDto.price * 0.01}" type="number"/>P
								</span>					
							</td>
						</tr>	
						</c:forEach>					
					</table>
				</div>
			</dd>	
		</dl>
	</div>
	<!-- 버튼 -->
	<div class="page_btns">
		<input type="hidden" id="useCouponKey" name="useCouponKey" value="0">
		<button type="button" class="btn_lg_primary" id="orderPayment" onclick="sendOrderList();" >결제하기</button>
	</div>
	
	</form>
	


</div>
	
<!-- // page contents -->



<%@include file="../layout/footer.jsp"  %>
