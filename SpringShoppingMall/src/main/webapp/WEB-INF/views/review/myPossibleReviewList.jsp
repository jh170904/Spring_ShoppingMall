<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../layout/top3.jsp" %>
<%@ include file="../layout/mypage.jsp" %>

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
				<li><a href="<%=cp%>/review/reviewList.action?order=recent">작성한 리뷰 <b id="availCnt">${dataCount_yes }</b>개</a></li>
				<li class="on"><a href="<%=cp%>/review/reviewPossibleList.action">작성 가능한 리뷰 <b id="expCnt">${dataCount_no }</b>개</a></li>
			</ul>
		</div>

		<!-- tab content -->
		<div class="tab_cont">
			<div class="panel benefit_panel_list">
				<table class="ui_table_striped data_table thead_colored align_center @table-striped-apply" id="shpiTable">

					<colgroup>
						<col>
						<col>
						<col>
					</colgroup>

					<thread>
					<tr>
						<th scope="col" bgcolor="#F2F2F2">상품번호</th>
						<th scope="col" bgcolor="#F2F2F2">상품</th>
						<th scope="col" bgcolor="#F2F2F2">작성</th>
					</tr>
					</thread>

					<tbody id="paging">
						<c:forEach var="dto" items="${lists }">
							<tr>
								<td class="check_wrap check_only">${dto.productId }</td>
								<td><a href="<%=cp%>/pr/detail.action?superProduct=${dto.superProduct}">${dto.productName }</a></td>
								<td>
									<button onclick="javascript:location.href='<%=cp%>/review/reviewWrited.action?reviewNum=${dto.reviewNum }'" class="btn_sm_bordered">작성하기</button>
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
					작성 가능한 리뷰가 없습니다.
				</c:if>
			</div>
		</div>

	</div>
</div>

<%@ include file="../layout/footer.jsp" %>