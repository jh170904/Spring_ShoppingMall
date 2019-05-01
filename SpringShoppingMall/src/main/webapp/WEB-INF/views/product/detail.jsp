<%-- <%@page import="com.member.MemberDTO"%> --%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../layout/storeNav.jsp"  %>

<style>

ul.tabs{
  margin: 0px;
  padding: 0px;
  list-style: none;
}
ul.tabs li{
  display: inline-block;
  cursor: pointer;
}

.tab-content{
  display: none;
  padding: 15px;
}
 
.tab-content.current{
  display: inherit;
}

.selected-options{
	margin: 20px 0; 
	overflow-x: auto;
    box-sizing: border-box;
    padding: 15px;
    position: relative;
    background: #fafafa;
    border-bottom: solid 1px #ededed;
	font-size: 16px;
}

.selected-options>.item>.detail>.amount>input {
    border: none;
    background-color: transparent;
    text-align: center;
    flex-grow: 1;
    width: 0;
}

.icon-pointer-x-dark{
    width: 12px;
    height: 12px;
    background-position: top -39px left -270px;
    
    background-repeat: no-repeat;
    display: inline-block;
    
    position: absolute;
    right: 15px;
    top: 15px;
}

.icon-etc-button-plus{
    width: 13px;
    height: 13px;
	display: inline-block;
}


.icon-etc-button-minus{
    width: 13px;
    height: 13px;
    display: inline-block;
}

p{
    display: block;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
}

.amount{
	display: block;
	padding-top: 20px;
    width: 80px;
    display: flex;
    float:left; 
}

div.amount{
	margin-left:10px;
	margin-right: 380px;
}

.bold{
	font-weight: bold;
	font-size: 17pt;
}

.cover__info__coupon__btn {
    width: 100%;
    height: 40px;
    margin-top : 20px;
    margin-bottom : 20px;
    box-sizing: border-box;
    border: solid 1px #8080ff;
    border-radius: 4px;
    padding: 0;
    font-size: 15px;
    font-weight: bold;
    color: #8080ff;
    background-color: white;
}

.selling-option {
	font:400 13.3333px Arial;
    width: 200px;
    padding-left: 15px;
    padding-right: 15px;
	height: 30px; 
	padding: 2px 2px; 
	border: 1px solid #d9d9d9;
}

tr{
	font-size: 12pt;
}

.cover__info__product__price{
    font-weight: bold;
    background-color: transparent;
    font-size: 32px;
    margin-right: -8px;
}
</style>

<script type="text/javascript" src="<%=cp%>/resources/js/httpRequest.js"></script>
<script type="text/javascript">

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

	function totSet(count){

		var f = document.detailForm;	
		var totalCount = count * ${dto.price};		
		//천단위 콤마 삽입
		var totalCount1 = thousandSeparatorCommas(totalCount);
		document.getElementById("totalPrice").value = totalCount1;

	}

	function addCartItem(){
		f = document.detailForm;
		//장바구니 추가
		str = f.amount.value;
		str = str.trim();
		if(str==0){
			alert("\n 구매할 수량을 선택하세요.");
			f.amount.focus();
			return false;
		}
		f.amount.value = str;
		
		str = f.productSize.value;
		str = str.trim();
		if(str==0){
			alert("\n 상품 사이즈를 선택하세요.");
			f.productSize.focus();
			return false;
		}
		f.productSize.value = str;
		
		str = f.color.value;
		str = str.trim();
		if(str==0){
			alert("\n 상품 색상을 선택하세요.");
			f.color.focus();
			return false;
		}
		f.color.value = str;
		return true;
	}
	
	function addDirectOrder(){
		
		f = document.detailForm;
		
		//수량선택
		str = f.amount.value;
		str = str.trim();
		if(str==0){
			alert("\n 수량을 선택하세요.");
			f.amount.focus();
			return;
		}
		f.amount.value = str;
		
		//사이즈선택
		str = f.productSize.value;
		str = str.trim();
		if(str==""){
			
			if(!str){
				alert("\n 사이즈를 선택하세요.");
				f.productSize.focus();
				return;
			}
			f.productOption.value = str;
		}
		
		//색상선택
		str = f.color.value;
		str = str.trim();
		if(str==""){
			
			if(!str){
				alert("\n 색상을 선택하세요.");
				f.color.focus();
				return;
			}
			f.productOption.value = str;
		}

		f.action = "<%=cp %>/cart/cartAdd_directOrder.do";
		f.submit();
				
	}
	
	$(document).ready(function(){
		   
		  $('ul.tabs li').click(function(){
		    var tab_id = $(this).attr('data-tab');
		 
		    $('ul.tabs li').removeClass('on current');
		    $('.tab-content').removeClass('on current');
		 
		    $(this).addClass('on current');
		    $("#"+tab_id).addClass('on current');
		  })
		 
		})
	
	
	$(function(){
		
		$("#reviewOn").click(function(){
			
			listPage(1);
			
			var superProduct = "<c:out value="${superProduct}" />";
			var order = "<c:out value="${order}" />";
			
			var params = "superProduct=" + superProduct+ "&order=" + order;
			
			$.ajax({
				type:"POST",
				url:"detailReview.action",
				data:params,
				success:function(args){
					$("#tab-2").html(args);			
				},
				error:function(e){
					alert(e.responseText);
				}
				
			});
			
		});
		
	});

	
 	$(function(){
		
		$("#btn_basket").click(function(){
			
			var params = "productName=" + $("#productName").val() 
						+ "&amount=" + $("#amount").val()
						+ "&price=" + $("#price").val()
						+ "&productSize=" + $("#productSize").val()
						+ "&color=" + $("#color").val();
			$.ajax({				
				type:"POST",
				url:"<%=cp%>/cart/cartAdd_ok.action",
				data: params,
				//dataType : "",//반환데이터
				success:function(args){
					//콜백함수
					if(args==true){
						alert("장바구니에 상품이 추가되었습니다.");
					}else{
						alert("장바구니를 이용하시려면, 로그인이 필요합니다.")
					}
				},
				beforeSend:addCartItem,
				error:function(e){
					alert(e.responseText);
				}
				
			});
			
		});

	}); 
	
	function listPage(page,order){
		
		var url = "detailReview.action";
		var superProduct = "<c:out value="${superProduct}" />";
		
		$.post(url,{pageNum:page,superProduct:superProduct,order:order},function(args){
			
			$("#tab-2").html(args);
			
		});
		
		$("#tab-2").show(); //display:block의 역할 - 보여지는거(none의 반대)
		
	}
	
	function changeReviewOption(order){
		
		var url = "detailReview.action";
		var superProduct = "<c:out value="${superProduct}" />";
		
		$.post(url,{superProduct:superProduct,order:order},function(args){
			
			$("#tab-2").html(args);
			
		});
		
		$("#tab-2").show(); //display:block의 역할 - 보여지는거(none의 반대)
		
	}

</script>
<div class="ap_contents product detail" >
	<form method="post" name="detailForm">
		<!-- product 정보 -->
		<div class="prd_detail_default">	
			<div class="prd_detail_info">
				<div class="prd_detail_default">
				
					<div class="prd_img_wrap">
						<div class="slide goods_slide ix-slide-max-apply">
							<img style="width: 500px; height: 500px;" alt="${dto.originalName}" src="../upload/list/${dto.saveFileName }">
						</div>
					</div>
				
					<div class="prd_info_wrap">
						<table>
						<tr>
							<td><input type="hidden" id="productId" name="productId" value=""></td>
						</tr>
						<tr>
							<td><a href="${dto.storeUrl }" style="font-weight: bold; color:#8080ff; font-size: 16pt;">${dto.storeName }</a><br>
							카테고리 ${dto.productCategory }</td>
						</tr>
						<tr>
							<td style="margin-top: 10px; height: 70px;">
							<input type="hidden" value="${dto.productName}" name="productName" id="productName"> 
							<h3 style="font-size: 34px; color:#333; font-weight: 300; word-break: keep-all; ">${dto.productName} </h3>
							</td>
						</tr>
						<tr>
							<td style="font-size: 26px; height: 80px;">
							<span class="cover__info__product__price">
							<input type="hidden" value="${dto.price}" name="price" id="price">
								<b><fmt:formatNumber value="${dto.price}" groupingUsed="true"/>원</b>
							</span>
							
							<div class="cover__info__coupon">
					            <button class="cover__info__coupon__btn">
					              <span class="icon-common-etc__m-10" style="vertical-align: middle;"></span>
					              ????원 할인쿠폰
					            </button>
					          </div>
							</td>
						</tr>
										
						<!-- 수량선택 -->
						<tr height="40">
							<td style="padding: 2px 0px 0px 0px">
							수량
							<span style="float: right;">
							<select name="amount" class="selling-option" id="amount">
								<option value="0">수량선택</option>
								<c:forEach var="cnt"  begin="1" end="9" step="1">
									<option onclick="totSet(${cnt});"value="${cnt}">${cnt}</option>
								</c:forEach>
							</select>
							</span>
							</td>
						</tr>
						
						<!-- 사이즈선택 -->
						<c:if test="${!empty dto.productSize}">
						<tr height="40">
							<td style="padding: 2px 0px 0px 0px">
							사이즈
							<span style="float: right;">
							<select name="productSize" class="selling-option" id="productSize">
								<option value="0">사이즈 선택</option>
								<c:forEach var="option" items="${sizeList }">
									<option value="${option }">${option }</option>
								</c:forEach>
							</select>
							</span>
							</td>
						</tr>
						</c:if>
						
						<!-- 색상선택 -->
						<c:if test="${!empty dto.color }">
						<tr height="40">
							<td style="padding: 2px 0px 0px 0px">
							색상
							<span style="float: right;">
							<select name="color" class="selling-option" id="color">
								<option value="0">색상 선택</option>
								<c:forEach var="option" items="${colorList }">
									<option value="${option }">${option }</option>
								</c:forEach>
							</select>
							</span>
							</td>
						</tr>
						</c:if>
						
						<!-- 합계금액 -->
						<tr height="50">
							<td style="padding: 5px 10px;border: 1px solid #d9d9d9; margin-top: 10px;">
							<span style="float: left; padding: 5px 0;">총 합계금액</span>
							<div style="position:relative; padding-left:200px; float: right; padding: 5px 0;">
								<input type="text" readonly="readonly" id="totalPrice" size="10" value="" style="border: 0;">
							</div>
								
							</td>
						</tr>
						<tr>
							<td>
							<div class="prd_etc_info">
								<div class="prd_etc_info_left">
									<dl>
										<dt>상태</dt>
										<dd>${dto.state}</dd>
									</dl>
									<dl>
										<dt>배송비</dt>
										<dd>최종 결제금액 50,000원 이상 주문시 무료배송</dd>
									</dl>
								</div>
								<div class="prd_etc_info_right"> 
									<dl> 
										<dt>포인트</dt>
										<dd>1% 적립</dd>
									</dl>
								</div>
							</div>
							</td>
						</tr>
						<tr>
							<td>
							<!-- 구매버튼,장바구니버튼 -->
							<div class="purchase_button_set">
								<span><button id="btn_buy_now" class="btn_lg_bordered emp btn_buy_now" type="button" onclick="addDirectOrder();">바로구매</button></span>
								<span><button id="btn_basket" class="btn_lg_primary btn_basket" type="button">장바구니 담기</button></span>
							</div>
							</td>
						</tr>						
						</table>
							<!-- 옵션선택 ajax 수정예정.... --> 							
							 <section class="selected-options text-caption-1" >
						      <div class="item hide">
						        <p class="name">${dto.productName} - ${dto.color} - ${dto.productSize} </p>
						        <div class="detail" style="width: 550px; display: flex;"> 
						          <div class="amount">
						            <span class="icon icon-etc-button-minus" role="button">
						            	<img src="<%=cp%>/resources/image/minus_icon.png" onclick="">
						            </span>
						            <input style="height: 13px;" type="number" value="1">
						            <span class="icon icon-etc-button-plus" role="button">
						            	<img src="<%=cp%>/resources/image/plus_icon.png" onclick="">
						            </span>
						          </div>
						          <p class="price bold" style="float: right;">
						          	<span class="amount">${dto.price}</span>
						          </p>
						        </div>
						        <span class="icon icon-pointer-x-dark btn-remove" role="button" aria-hidden="false">
						        	<img src="<%=cp%>/resources/image/x_icon.png" onclick="removeItem();" >
						        </span>
						      </div>
						    </section>
						</div> 
				</div>
			</div>
		</div>

	<hr class="div m30">
	
	<!-- product 상세정보 -->

	<div class="prd_detail_bottom">
		<!-- tab menu wrap -->
		<div class="ui_tab prd_detail_tap">
			<!-- tab menu -->
			<div class="tab_menu">
				<ul class="tabs">
					<li class="on current" data-tab="tab-1"><button type="button">상세정보</button></li>
					<li class="" data-tab="tab-2" id="reviewOn">
						<button type="button">리뷰/후기 (${dataCount_yes })</button>
					</li>
					<li class="" data-tab="tab-3"><button type="button">배송/교환/반품</button></li>
				</ul>

			</div>
		</div>

		<br /> <br /> <br />
		<div id="tab-1" class="tab-content current">
			<div class="prd_detail_wrap">
				<div class="contenteditor-root">
					<!-- 상세이미지 출력 -->
					<c:forEach var="detailDTO" items="${detailImagelists}">
						<div class="contenteditor-image">
							<a href="${detailImagePath }/${detailDTO.saveFileName}"><img src="${detailImagePath }/${detailDTO.saveFileName}" /></a>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>

		<div id="tab-2" class="tab-content">
			
		</div>
		
		<br /> <br /> <br />
		<div id="tab-3" class="tab-content">
			<div class="prd_detail_wrap">
				<div class="contenteditor-root">
					<div class="contenteditor-image">
						<img src="<%=cp%>/project/image/deliveryImage1.PNG" /><br>
						<img src="<%=cp%>/project/image/deliveryImage2.PNG" />
					</div>
				</div>
			</div>
		</div>
		
	</div>
</form>
</div>


<!-- ap_contents product detail -->
<%@include file="../layout/footer.jsp"%>