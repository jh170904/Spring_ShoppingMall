<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../layout/top.jsp" %>

<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>

<style>

.inLine_review { 
	display: inline;
}

.review_on {
	background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;
}
	
</style>

<script>
	function showReview(review) {

		var content = document.getElementById(review);

		if(content.style.display == "none"){
			content.style.display = "block";
		}else{
			content.style.display = "none";
		}
	}
</script>

<div class="page_title_area">

	<div class="page_title">
		<h2 class="h_title page">나의 리뷰</h2>
		<p class="text font_lg"></p>
	</div>
</div>

<div class="ap_contents mypage coupon">

	<!-- tab menu wrap -->
	<div class="ui_tab">
		<!-- tab menu -->
		<div class="tab_menu equally">
			<ul>
				<li class="on"><a href="review/reviewList.action?order=recent">작성한 리뷰 <b id="availCnt">${dataCount_yes }</b>개</a></li>
				<li><a href="review/reviewPossibleList.action">작성 가능한 리뷰 <b id="expCnt">${dataCount_no }</b>개</a></li>
			</ul>
		</div>
		
		<br/>
		
		<div style="margin-left: 12px;">
			<dl>
				<dd class="inLine_review"><button onclick="javascript:location.href='review/reviewList.action?order=recent';" style="<c:if test='${order eq "recent"}'>background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;</c:if>" class="btn_sm_bordered_review">최신순</button></dd>
				<dd class="inLine_review"><button onclick="javascript:location.href='review/reviewList.action?order=worst';" style="<c:if test='${order eq "worst"}'>background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;</c:if>" class="btn_sm_bordered_review">낮은 평점순</button></dd>
				<dd class="inLine_review"><button onclick="javascript:location.href='review/reviewList.action?order=best';" style="<c:if test='${order eq "best"}'>background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;</c:if>" class="btn_sm_bordered_review">높은 평점순</button></dd>
			</dl>			
		</div>

		<!-- tab content -->
		<div class="tab_cont">
			<div class="panel benefit_panel_list">
				<table class="ui_table_striped data_table thead_colored align_center @table-striped-apply" id="shpiTable">

					<colgroup>
						<col width="10%">
						<col width="20%">
						<col width="40%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
					</colgroup>

					<thread>
					<tr>
						<th scope="col" bgcolor="#F2F2F2">등록일</th>
						<th scope="col" bgcolor="#F2F2F2">상품</th>
						<th scope="col" bgcolor="#F2F2F2">제목</th>
						<th scope="col" bgcolor="#F2F2F2">평점</th>
						<th scope="col" bgcolor="#F2F2F2">보기</th>
						<th scope="col" bgcolor="#F2F2F2">삭제</th>
					</tr>
					</thread>

					<tbody id="paging">
						<c:forEach var="dto" items="${lists }">
							<tr>
								<td class="check_wrap check_only" style="vertical-align: top;">${dto.reviewDate_view }</td>
								<td style="vertical-align: top;"><a href="pr/detail.action?superProduct=${dto.superProduct}">${dto.productName }</a></td>
								<td align="left" style="vertical-align: top;">${dto.subject }
									<p id="${dto.reviewDate }" style="display: none; font-size: 11px;" ><br/>
									<c:if test="${dto.originalName ne null }">
										<img alt="" src="../upload/review/${dto.originalName }" height="100px;"><br/>
									</c:if>
									${dto.content }</p>
								</td>
								<td style="vertical-align: top;">
									<c:forEach var="i" begin="1" end="${dto.rate }" step="1">
										<img alt="" src="<%=cp%>/resources/image/heart_on.png" height="13px;">
									</c:forEach>
									
									<c:forEach var="j" begin="${dto.rate+1 }" end="5" step="1">
										<img alt="" src="<%=cp%>/resources/image/heart_off.png" height="13px;">
									</c:forEach>
								</td>
								<td style="vertical-align: top;">
									<button onclick="showReview('${dto.reviewDate }')" class="btn_sm_bordered">리뷰보기</button>
								</td>
								<td style="vertical-align: top;">
									<button onclick="javascript:location.href='review/reviewDeleted.action?productId=${dto.productId }&reviewDate=${dto.reviewDate }&originalName=${dto.originalName }';" class="btn_sm_bordered">삭제하기</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<div align="center">
				<c:if test="${dataCount!=0 }">
					<font style="font-size: 20px">${pageIndexList}</font>
				</c:if> 
				<c:if test="${dataCount==0 }">
					작성한 리뷰가 없습니다.
				</c:if>
			</div>
		</div>

	</div>
</div>

<%@ include file="../layout/footer.jsp" %>