<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="../layout/top3.jsp"  %>
<%@include file="../layout/mypage.jsp"  %>

<style>
.container2 {
    margin-right: auto;
    margin-left: auto;
    box-sizing: border-box;
    width: 1186px;
    max-width: 100%;
    box-sizing: border-box;
    min-height: 600px;
    padding-top: 60px;
}

.profile-image {
    top: 20px;
    width: 250px;
    height: 250px;
    margin-top:30px;
    margin-left: auto;
    margin-right: auto;
}

.profile-info__name {
    font-size: 30px;
    line-height: 40px;
    margin-left: 10px;
    margin-bottom: 9px;
    word-wrap: break-word;
}

.short-cut__icon {
    position: relative;
    width: 28px;
    margin: 0 auto 8px;
}

.short-cut__item {
	display: inline-block;
	width: 105px;
	text-align: center;
}

</style>

<div class="container2">

<div style="width: 336px; margin-right:50px; display: inline-block; vertical-align: top;">

<div style="display: block; ">
	<div class="profile-image" >
	<img alt="" src="../upload/list/1806576130.jpg" style="border-radius: 100%;">
	</div>
	
	<div style="border-bottom: 1px solid #ebebeb; margin-bottom: 20px; margin-top: 20px;"  ></div>
	
	<div class="profile-info__name"><strong>${userId }</strong></div>
	
	<div style="color: #bdbdbd; font-size: 13px;">
		<a href="/users/1527075/follower" style="display: inline-block; margin-left: 10px; ">팔로워 <!-- -->0</a>&nbsp;&nbsp;&nbsp;
		<a href="/users/1527075/followee" style="display: inline-block;">팔로잉 <!-- -->0</a>
	</div>
	
	<div style="border-bottom: 1px solid #ebebeb; margin-bottom: 20px; margin-top: 20px;"  ></div>
	
	<div style="margin-top:20px;">
		<div class="short-cut__item">
		<a href="#">
		<div class="short-cut__icon">
			<svg width="24" height="24" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet">
			<path fill="currentColor" d="M22.971 7.638c-.548-5.17-7.119-7.135-10.57-2.488a.5.5 0 0 1-.802 0C8.148.503 1.577 2.469 1.029 7.625.642 12.451 3.897 17.183 12 21.436c8.104-4.252 11.36-8.984 10.972-13.798zm.996-.093c.428 5.319-3.137 10.446-11.738 14.899a.5.5 0 0 1-.46 0C3.169 17.99-.395 12.864.034 7.532.656 1.67 7.904-.683 12 4.052 16.096-.683 23.344 1.67 23.967 7.545z">
			</path>
			</svg>
		</div>
		<strong>관심 상품</strong>
		</a>
		</div>
		
		<div class="short-cut__item ">
		<a href="#">
		<div class="short-cut__icon">
			<svg width="24" height="24" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet">
			<path fill="currentColor" d="M22.971 7.638c-.548-5.17-7.119-7.135-10.57-2.488a.5.5 0 0 1-.802 0C8.148.503 1.577 2.469 1.029 7.625.642 12.451 3.897 17.183 12 21.436c8.104-4.252 11.36-8.984 10.972-13.798zm.996-.093c.428 5.319-3.137 10.446-11.738 14.899a.5.5 0 0 1-.46 0C3.169 17.99-.395 12.864.034 7.532.656 1.67 7.904-.683 12 4.052 16.096-.683 23.344 1.67 23.967 7.545z">
			</path>
			</svg>
		</div>
		<strong>관심 코디</strong>
		</a>
		</div>
		
		<div class="short-cut__item">
		<a href="#">
		<div class="short-cut__icon">
			<svg width="24" height="24" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet">
				<path fill="#000" fill-opacity=".74" fill-rule="evenodd" transform="matrix(1 0 0 -1 0 23.033)" d="M12.943 6.342a2 2 0 0 1-1.886 0L3 2.032V20.5a.5.5 0 0 0 .5.5h17a.5.5 0 0 0 .5-.5V2.033l-8.057 4.309zm-.471-.882l8.056-4.31A1 1 0 0 1 22 2.034V20.5a1.5 1.5 0 0 1-1.5 1.5h-17A1.5 1.5 0 0 1 2 20.5V2.033a1 1 0 0 1 1.472-.882l8.056 4.31a1 1 0 0 0 .944 0z">
				</path>
			</svg>
		</div>
		<strong>스크랩북</strong>
		</a>
		</div>
	</div>
	
	
	
</div>

</div>





<div style="width: 750px; display: inline-block; vertical-align: top;">
			<table style="width: 750px;">
				<c:set var="i" value="0" />
				<c:forEach var="dto" items="${lists }">

					<c:if test="${i==0 }">
					
						<tr height="30px"></tr>
						<tr>
						<c:set var="j" value="0" />
					</c:if>



					<td align="center">
					
						<table width="250">
							<tr><td>
								<a href="<%=cp1%>/pr/detail.action?superProduct=''">
								<img style="background-color: #f5f5f5; width: 240px; height: 240px; margin-left : 5px; margin-right: 5px" alt="" src="../upload/list/${dto.originalName}" />
								</a></td>
							</tr>
							<tr><td>
								<a href="${dto.storeUrl }" >
								<p align="left" style="font-size: 11pt; margin-bottom: 10px; margin-left: 3px;">${dto.storeName }</p>
								</a></td>
							</tr>
							<tr height="16px"><td>
								<p align="left" style="font-size: 13pt; margin-bottom: 10px; margin-left: 3px;">${dto.productName }</p></td>
							</tr>
							<tr height="25px"><td>
								<p align="left" style="font-size: 17pt; margin-bottom: 10px; margin-left: 3px; color: black;">${dto.price}원</p></td>
							</tr>
							<tr><td>
								<p align="left" style="margin: 0px 10px 10px 3px; height: 20px">
								<span style="font-size: 14pt;  color: #8080FF" >★</span>
								<span>평점 ${dto.reviewRate}</span>
								<span>&nbsp;&nbsp;&nbsp;리뷰&nbsp;${dto.reviewCount}</span>
								
								<span style="font-size: 14pt;  color: #8080FF; margin-left: 90px;">
									<input type="hidden" id="superProduct" value="${dto.superProduct}" >
									<button class="goodButton" value="${dto.superProduct}"></button>
								</span>
								
								</p></td>
							</tr>
						</table>
						
						
						<c:set var="j" value="${j+1 }" /> 
						<c:set var="i" value="1" />

					</td>

					<c:if test="${j==3 }">
						</tr>
						<c:set var="j" value="0" />
						<c:set var="i" value="0" />
					</c:if>

				</c:forEach>



				<c:if test="${j!=3 }">
					<c:forEach begin="${j }" end="2" step="1">
						<td width="400"></td>
						<c:set var="j" value="${j+1 }" />
					</c:forEach>
					</tr>
				</c:if>
				

				<tr height="100">
					<td align="center" colspan="3">
						<c:if test="${dataCount!=0 }">
							<font style="font-size: 20px">${pageIndexList}</font>
						</c:if> 
						<c:if test="${dataCount==0 }">
							등록된 게시물이 없습니다.
						</c:if>
					</td>
				</tr>
			</table>

<div>



</div>
</div>


</div>


<%@include file="../layout/footer.jsp"  %>