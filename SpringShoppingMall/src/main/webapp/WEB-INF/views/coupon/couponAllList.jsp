<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="../layout/storeNav.jsp"  %>

<script type="text/javascript">
	function sendButton(){
		var f = document.buttonForm;

		f.userId.value
		f.couponKey.value
		f.userGrade.value
		f.couponGrade.value
		
		if(f.userGrade.value!=f.couponGrade.value){
			alert("발급받을 수 없는 등급입니다.");
			return;
		}
		
		
		f.action = "<%=cp %>/coupon/";
		f.submit();
	}
</script>

<div id="ap_container" class="ap_container">

	<!-- 제목 -->
	<div class="page_title_area">
		<div class="page_title">
			<h2 class="h_title page">쿠폰/혜택</h2>
			<p class="text font_lg"></p>
		</div>
	</div>


	<!-- 내용 -->
	<div class="ap_contents">
	
		<div class="ui_tab">
			<div class="tab_menu equally">
				<ul>
					<li class="on"><a href="#">등급별 고객 혜택 쿠폰</a></li>
					<li><a href="<%=cp %>/coupon/couponMyList.action" style="border-bottom: 1px solid #8080FF">나만의 혜택</a></li>
				</ul>
			</div>
		</div>
		

		<div class="tab-cont" >

			<h3 class="coupon-section__title">등급별 고객 혜택 쿠폰</h3>
			<div align="center">
			<ul class="coupon-section_list clear">
			
			
				<c:forEach var="dto" items="${lists }">
			
				<li class="coupon-section_list__item" style="width: 550px;">
					<div class="coupon-section-coupon clear">
						<div class="coupon-section-coupon__desc-area">
							<span class="coupon-section-coupon__flag">온라인 전용</span>
							
							<div class="coupon-section-coupon__unit-block">
								<span class="coupon-section-coupon__unit coupon-section-coupon__unit--v2 coupon-section-coupon__unit--point"  style="font-size: 30pt; color: #8080FF;">${dto.discount }</span>
								<span class="coupon-section-coupon__unit coupon-section-coupon__unit--v3"  style="font-size: 30pt; color: #8080FF;">원 할인 </span>
							</div>
							
							<div class="coupon-section-coupon__guide-block" style="width: 180px;" >
								<span class="coupon-section-coupon__guide" style="font-size: 11pt;">[${dto.couponGrade }] ${dto.couponScore }원 이상 구매시 ${dto.discount }원 할인쿠폰</span> 
								<span class="coupon-section-coupon__subtext" style="font-size: 11pt;">${dto.couponScore }원 이상 구매 시</span>
							</div>
							
						</div>
						<div class="coupon-section-coupon__btn-area">
							<form action="<%=cp %>/coupon/couponIssue_ok.action" class="coupon-section-coupon__btn-area" method="post">
								<input type="hidden" name="couponKey" value="${dto.couponKey }"/>
								<input type="hidden" name="couponGrade" value="${dto.couponGrade }"/>
								<input type="submit" value="" style="width: 90px; height: 220px; border: none; background-color: rgba( 255, 255, 255, 0 );"></input>
							</form>
						</div>
					</div>
				</li>
				
				</c:forEach>
				
			</ul>
			</div>

			<!-- 유의사항 -->
			<dl class="coupon-section-dot-list">
				<dt class="coupon-section-dot-list__title">유의사항</dt>
				<dd class="coupon-section-dot-list__item">해당 쿠폰은 온라인몰 전용쿠폰입니다.</dd>
				<dd class="coupon-section-dot-list__item">로그인 후 쿠폰 다운로드 및 사용 가능합니다.</dd>
				<dd class="coupon-section-dot-list__item">쿠폰 유효기간은 마이페이지 쿠폰함에서 확인해 주세요.</dd>
				<dd class="coupon-section-dot-list__item">쿠폰은 타 프로모션 및 쿠폰과 중복사용이 불가합니다.(1주문당 1쿠폰 사용 가능)</dd>
				<dd class="coupon-section-dot-list__item">각 쿠폰별로 1회만 다운로드 가능합니다.</dd>
				<dd class="coupon-section-dot-list__item">다운로드 쿠폰은 당사 사정에 따라 사전 고지 없이 변경/종료 될 수 있습니다.</dd>
				<dd class="coupon-section-dot-list__item">부정한 방법으로 쿠폰을 사용 및 취득한 경우, 해당 주문 건은 사전 고지 없이 취소됩니다.</dd>
			</dl>
			
			
		</div>
	</div>
</div>


<%@include file="../layout/footer.jsp"  %>