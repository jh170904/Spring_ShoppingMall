<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../layout/adminNav.jsp"  %>


<script>
	function showReview(review) {

		var content = document.getElementById(review);
		if(content.style.display == "none"){
			content.style.display = "block";
		}else{
			content.style.display = "none";
		}
		
		var contentReport = document.getElementById(review + "_report");
		if(contentReport.style.display == "none"){
			contentReport.style.display = "block";
		}else{
			contentReport.style.display = "none";
		}
	}
</script>

<div class="ap_contents product detail">

	<div style="width:1200px;margin:30px auto;text-align:center;">
		<div style="width: 1100px; height:100px; text-align:center; line-height:50px; font-size: 30px; color:#000000; border: none">
			신고리뷰관리
		</div>
		
		<div style="width: 1200px; margin-top: 50px;">
			<table class="ui_table_striped data_table thead_colored align_center @table-striped-apply" >
			
				<colgroup>
					<col width="10%">
					<col width="10%">
					<col width="28%">
					<col width="22%">
					<col width="20%">
					<col width="10%">
				</colgroup>
				
				<thread>
				<tr>
					<th scope="col" bgcolor="#F2F2F2">리뷰번호</th>
					<th scope="col" bgcolor="#F2F2F2">작성자</th>
					<th scope="col" bgcolor="#F2F2F2">리뷰내용</th>
					<th scope="col" bgcolor="#F2F2F2">신고내용</th>
					<th scope="col" bgcolor="#F2F2F2">리뷰&신고 보기</th>
					<th scope="col" bgcolor="#F2F2F2">리뷰삭제</th>
				</tr>
				</thread>
				
				<tbody id="paging">
					<c:forEach var="reportCount" items="${reviewNumAndCount }">
						<tr align="center">
							<td width="100" height="30" style="vertical-align: top;">${reportCount.reviewNum }</td>
							<td style="vertical-align: top;">${reportCount.userId }</td>
							<td style="vertical-align: top; text-align: left;">
								<p style="font-size: 15px; color: #000000;">${reportCount.subject }</p>
								<p id="${reportCount.reviewNum }" style="display: none; font-size: 13px; color: #000000;"><br/>
									${reportCount.content }
								</p>
							</td>
							<td width="100" height="30" style="vertical-align: top;">
								<p style="font-size: 15px; color: #000000;">${reportCount.reportCount } 회</p>
								<p id="${reportCount.reviewNum }_report" style="display: none; text-align:left; font-size: 13px; color: #000000;"><br/>
									<c:forEach var="dto" items="${adminReportReview }">
									<c:if test="${reportCount.reviewNum eq dto.reviewNum }">
										${dto.reoprtContent } (신고자 : ${dto.reportedUserId } )<br/>	
									</c:if>
									</c:forEach>
								</p>
							</td>	
							<td style="vertical-align: top;">
								<button onclick="showReview('${reportCount.reviewNum }')" class="btn_sm_bordered">리뷰보기</button>
							</td>					
							<td style="vertical-align: top;">
								<a href="<%=cp%>/admin/reviewAdminDelete.action?reviewNum=${reportCount.reviewNum }&pageNum=${pageNum }" class="btn_sm_bordered" style="color: #ffffff; background-color: #000000">리뷰삭제</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div style="font-size:12pt; clear:both;	height:32px;line-height:32px;margin-top:5px;text-align:center;">
				<p>
					<c:if test="${dataCount!=0 }">
						<font style="font-size: 20px">${pageIndexList}</font>
					</c:if>
					<c:if test="${dataCount==0 }">
						신고된 내역이 없습니다.
					</c:if>
				</p>
			</div>

		</div>
	</div>

</div>
	
<%@include file="../layout/footer.jsp"  %>