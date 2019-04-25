<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="../layout/storeNav.jsp"  %>

<div id="ap_container" class="ap_container">

	<div class="page_title_area">
		<div class="page_title" style="border-top-color: black;">
			<h2 class="h_title page">카테고리</h2>
			<p class="text font_lg"></p>
		</div>
	</div>
	
	
	<div class="ap_contents prd_list">
		<div class="prd_category" style="height: 1px; padding:0px; border-top: none; border-bottom-color: #888;">
		</div>
		
		
		<div class="item_list column2">
			<div class="panel notice etu_find_store_none no_result"
				style="display: none;">
				<i class="ico"></i>
				<p class="text font_lg">
					<span class="tit_1">상품이 존재하지 않습니다.</span>
				</p>
			</div>
			
			<div class="pagination"></div>
			
			<table style="width: 1200">
				<c:set var="i" value="0" />
				<c:forEach var="dto" items="${lists }">

					<c:if test="${i==0 }">
					
						<tr height="30px"></tr>
						<tr>
						<c:set var="j" value="0" />
					</c:if>



					<td align="center">
					
						<table width="400">
							<tr>
								<img style="background-color: #f5f5f5; width: 268px; height: 268px; margin-left : 10px; margin-right: 10px" alt="" src="./upload/list/${dto.originalName}" } />
							</tr>
							<tr>
								<a href="${dto.storeUrl }" >
								<p align="left" style="font-size: 11pt; margin-bottom: 10px; margin-left: 62px;">${dto.storeName }</p>
								</a>
							</tr>
							<tr height="16px">
								<p align="left" style="font-size: 13pt; margin-bottom: 10px; margin-left: 62px;">${dto.productName }</p>
							</tr>
							<tr height="25px">
								<p align="left" style="font-size: 17pt; margin-bottom: 10px; margin-left: 62px; color: black;">${dto.price}원</p>
							</tr>
							<tr>
								<p align="left" style="margin: 0px 0px 10px 62px;">
								<span style="font-size: 11pt;  color: #8080FF" >★</span>
								<span>평점 3.4</span>
								<span>&nbsp;&nbsp;&nbsp;리뷰 10개</span>
								<span style="font-size: 15pt;  color: #8080FF; margin-left: 120px;">♡</span>
								</p>
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
		</div>
	</div>


</div>


<%@include file="../layout/footer.jsp"  %>