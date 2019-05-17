<%@page import="com.codi.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<style>

.inLine_review { 
	display: inline;
}

.user_id {
	display: block;
	margin: 10px 0 5px; 
	color: #333;
	font-size: 16px;
}

.flag {
	display: inline-block;
    width: 71px;
    height: 21px;
    margin: 10px 2px 0 0;
    font-size: 12px;
    font-weight: 300;
    text-align: center;
    color: #fff;
    line-height: 21px;
    background: #9adada;
    vertical-align: middle;
}

.title {
	display: inline-block;
    font-size: 17px;
    color: #333;
    margin: 10px 2px 0 0;
    height: 21px;
    line-height: 21px;
    vertical-align: middle;
    font-weight: 300;
}

.text {
	line-height: 1.5em;
    word-break: keep-all;
    font-size: 14px;
}

</style>

<script type="text/javascript">

</script>


<c:if test="${dataCount_yes==0 }">
	<div class="prd_detail_wrap">
		<div class="contenteditor-root">작성된 리뷰가 없습니다.</div>
	</div>
</c:if>

<c:if test="${dataCount_yes!=0 }">
	<div class="prd_detail_wrap">
		<div class="contenteditor-root">
			<div>
				<table class="review_summary" style="margin-bottom: 50px;">
					<tr>
						<td style="width: 400px; text-align: center;">전체상품평<br />
							<span class="ui_rating"> 
								<c:forEach var="i" begin="1" end="${avgReviewRate }" step="1">
									<img alt="" src="<%=cp%>/resources/image/heart_on.png" height="25px;">
								</c:forEach> 
								<c:forEach var="j" begin="${avgReviewRate+1 }" end="5" step="1">
									<img alt="" src="<%=cp%>/resources/image/heart_off.png" height="25px;">
								</c:forEach>
							</span><br/><small>(${avgReviewRate })</small>
						</td>
						<td>
							<ul class="rating_list">
								<c:forEach var="heart" begin="1" end="5" step="1"> 
									<li>
										<span> 
											<c:forEach var="on" begin="${heart}" end="5" step="1">
												<img alt="" src="<%=cp%>/resources/image/heart_on.png" height="25px;">
											</c:forEach> 
											<c:forEach var="on" begin="1" end="${heart-1}" step="1">
												<img alt="" src="<%=cp%>/resources/image/heart_off.png" height="25px;">
											</c:forEach> 
											<small>&nbsp;&nbsp;&nbsp;&nbsp;(${rate[heart-1] })</small>
										</span> 
										<span class="graph" style="margin-left: 20px;"> 
											<span style="width: ${rate[heart-1]/dataCount_yes * 100}%"></span>
										</span> 
										<span class="num">
											<small>&nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatNumber value="${(rate[heart-1])/(dataCount_yes) }" type="percent" /></small>
										</span>
									</li>
								</c:forEach>
							</ul>
						</td>
					</tr>

				</table>
				
				<div style="margin-bottom: 15px; float: left;">
					<dl>
						<dd class="inLine_review"><a onclick="changeReviewOption('recent');" style="<c:if test='${order eq "recent"}'>background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;</c:if>" class="btn_sm_bordered_review">최신순</a></dd>
						<dd class="inLine_review"><a onclick="changeReviewOption('worst');" style="<c:if test='${order eq "worst"}'>background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;</c:if>" class="btn_sm_bordered_review">낮은 평점순</a></dd>
						<dd class="inLine_review"><a onclick="changeReviewOption('best');" style="<c:if test='${order eq "best"}'>background:#8080ff; border:1px solid #8080ff; color:#ffffff; font-weight: bold;</c:if>" class="btn_sm_bordered_review">높은 평점순</a></dd>
					</dl>			
				</div>

				<table class="ui_table_striped data_table thead_colored align_center @table-striped-apply" id="shpiTable">

					<colgroup>
						<col>
						<col>
					</colgroup>
						<tbody id="paging">
						<c:forEach var="dto" items="${lists }">
							<tr>
								<td style="text-align: left; width: 150px; vertical-align: top; padding-left: 50px;">
									<span class="ui_rating"> 
										<c:forEach var="i" begin="1" end="${dto.rate }" step="1">
											<img alt="" src="<%=cp%>/resources/image/heart_on.png" height="15px;">
										</c:forEach> 
										<c:forEach var="j" begin="${dto.rate+1 }" end="5" step="1">
											<img alt="" src="<%=cp%>/resources/image/heart_off.png" height="15px;">
										</c:forEach>
									</span> 
									<span class="user_id">${dto.userId }</span> <small>${dto.reviewDate }</small>
								</td>

								<td style="text-align: left; width: 600px;">
									<small class="opt">사이즈: #${dto.productSize }<br/>컬러: #${dto.color }</small><br/>
									<span class="flag">구매자 후기</span> 
									<span class="title">${dto.subject }</span><br/><br/>
									<c:if test="${!empty dto.savefileName }">
										<a href="${imagePath_review }/${dto.savefileName}"> 
											<img alt="" src="${imagePath_review }/${dto.savefileName}" width="70" height="70">
										</a><br/>
									</c:if>
									
									<span class="text reduce">${dto.content }</span><br/><br/>
									 
									
									<span style="font-size: 10pt;">
										<input type="hidden" id="reviewNum" value="${dto.reviewNum}" >
										<a class="reviewGood" value="${dto.reviewNum}" onclick="clickReviewGood('${order}','${pageNum}','${dto.reviewNum}')">
											<div class="goodDiv${dto.reviewNum}">
												<c:set var="k" value="0" />
												<c:forEach var="good" items="${good }">
													<c:if test="${dto.reviewNum eq good}">
														<span style="border: 1px solid #8080ff; color: #ffffff; background-color:#8080ff ; padding: 5px 10px;">도움이 돼요</span>&nbsp;&nbsp;${dto.goodCount}명에게 도움이 되었습니다.
														<c:set var="k" value="1" />
													</c:if>
												</c:forEach>
												<c:if test="${k==0 }">
													<span style="border: 1px solid #8080ff; color: #8080ff; padding: 5px 10px;">도움이 돼요</span>&nbsp;&nbsp;${dto.goodCount}명에게 도움이 되었습니다.
												</c:if>
											</div>
										</a>
									</span>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div align="center">
		<font style="font-size: 17px">${pageIndexList}</font>
	</div>
</c:if>