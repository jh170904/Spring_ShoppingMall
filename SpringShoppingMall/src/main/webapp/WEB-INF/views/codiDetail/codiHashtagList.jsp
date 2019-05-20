<%@page import="com.codi.dto.MemberDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../layout/commuNav.jsp"  %>

<script type="text/javascript">
	$(function(){
		$(".goodButton").click(function(){
			var iNum = $(this).attr('value');
			
	        var info = '<%=(MemberDTO)session.getAttribute("customInfo")%>';
	        
	        $.ajax({
	            async: true,
	            type : 'POST',
	            data : iNum,
	            url : "../codiGood.action",
	            dataType : "json",
	            contentType: "application/json; charset=UTF-8",
	            success : function(data) {
	            	if(data.temp > 0) {
	            		$(".goodDiv" + iNum).html('<img src="../resources/image/heart1.PNG" style="height: 25px;"/> ');
	            		$("#codiHeartCount").html(data.count);
	                } else {
	            		$(".goodDiv" + iNum).html('<img src="../resources/image/heart2.PNG" style="height: 25px;"/> ');
	            		$("#codiHeartCount").html(data.count);
	                }
	            },
	            error : function(error) {
	            	alert("로그인이 필요합니다.");
	            }
	        });
		});
	});

</script>

<style type="text/css">
#container {
    margin: 0 auto;
    max-width: 1200px;
}
.set_wrapper .set_container {
    padding: 8px;
    overflow: hidden;
}

div#content_menu_container {
    position: relative;
    margin-top: 25px;
}

#container div#content_menu_container div#content_menu div.menu_container div.menu a {
    padding: 5px 10px 20px 10px;
    font-size: 14px;
    text-decoration: none;
}

#container div#content_menu_container div#content_menu {
    border: 1px solid rgba(0,0,0,0.0);
    background: #F6F6F6;
}

.clear_both {
    clear: both;
}

div.menu_container {
    margin: 20px;
}

div#content_menu_container div#content_menu div.menu_container div.selector {
    padding: 2px 15px 1px 5px;
}

div#content_menu_container div#content_menu div.menu_container div.menu {
    float: left;
    padding: 5px 5px;
    position: relative;
    color: #333;
    font-size: 16px;
    text-transform: capitalize;
}

div#content_menu_container div#content_menu div.menu_container div.menu a.tagger {
    border-radius: 2px;
    border-color: rgba(0,0,0,.12);
    color: #333;
}

div#content_menu_container {
    position: relative;
    max-width: 1200px;
}

a.tagger {
    height: 18px;
    border: 1px solid #d4d4d4;
    display: block;
    float: left;
    margin: 5px;
    font-weight: 700;
}

strong {
    color: #333;
    font-weight: 900;
}

.set_container .set .thumb_wrapper {
    text-align: center;
}
.set_container {
    padding: 8px;
    overflow: hidden;
}

div{
	display: block;
}

.set_container .set .codi_list_items_wrapper .codi_item {
    overflow: hidden;
    border-top: 1px solid rgba(0,0,0,.12);
    padding: 5px 8%;
}

.set_container .set .codi_list_items_wrapper .codi_item .codi_item_thumb_wrapper {
    width: 30%;
    height: 65px;
    float: left;
    text-align: left;
}

.set_container .set .codi_list_items_wrapper .codi_item .codi_item_info .codi_item_title {
    padding: 10px;
    text-transform: capitalize;
}

.set_container .set .codi_list_items_wrapper .codi_item .codi_item_info .codi_item_price {
    padding-left: 5px;
    color: #8080ff;
    font-size: 14px;
    float: left;
    font-weight: 600;
}
#container #content_wrapper #content .set_wrapper .set_container .set .info_wrapper {
    padding: 10px 15px 15px 15px;
	height: 8px;
}
.set_container .set .info_wrapper .like_info {
	height: 100%;
    color: #999;
    padding-left: 5px;
    padding-bottom: 5px;
}

.codi_item_thumb_wrapper img{
	width: 50px;
	height: 60px;
}

#content .set_wrapper {
    width: 25%;
    float: left;
    border: #333;
}

.set_container .set {
    background: #fff;
    margin: 20px 5px;
    border: 1px solid rgba(0,0,0,.12);
    
}

.codi_item_more a {
    text-decoration: none;
    color: #999;
    font-weight: 600;

}

.codi_item_more {
	text-align: center;
	padding: 5px;
}

.info_wrapper{
	text-align: right;
	padding: 5px 5px;
	height: 50px;
}

.liked_cnt{
	padding-right: 130px;
}

button {
	width: 40px;
	height: 40px;
}

#content_foot {
    position: absolute;
    width: 1200px;
    bottom: 0px;
    text-align: center;
}

.paging {
    display: inline-block;
    width: 100%;
    height: 30px;
    line-height: 30px;
    vertical-align: top;
    font-size: 18px;
    font-weight: 900;
}

.paging a{
	padding-right:10px;
	padding-left: 10px;
}
.paging font{
	padding-right:10px;
	padding-left: 10px;
}

.set_container .set:hover {
    outline: 2px solid #8080ff;
}

.menu.selector :hover {
    outline: 2px solid #8080ff;
}

#floating_create a {
    position: relative;
    display: block;
    width: 100%;
    height: 100%;
}

#floating_create a img {
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    margin: auto;
}

#floating_create {
    border-radius: 50%;
    border: none;
    bottom: 24px;
    box-shadow: 0 2px 10px rgba(0,0,0,.3), 0 0 1px rgba(0,0,0,.1), inset 0 1px 0 rgba(255,255,255,.25), inset 0 -1px 0 rgba(0,0,0,.15);
    cursor: pointer;
    height: 60px;
    position: relativeS;
    transition-duration: .25s;
    transition-property: background-color,box-shadow;
    background: #8080ff;
	right:0;
	float: right;
    width: 60px;
}

</style>


<div class="codi_view" id="container">
<div id="content_menu_container">
	<div id="content_menu">
		<div class="menu_container">
			<div class="menu"><strong>인기 스타일</strong> &nbsp;› &nbsp;</div>
			<div class="menu selector">
			<c:forEach var="item" items="${hashTagLists}" varStatus="status">
 				<c:url value="codiHashTagList.action" var="toURL">
		        	<c:param name="iHashtag" value="${item}"/>
				</c:url>
				<a class="tagger" href="${toURL}">#${item }</a>
 			</c:forEach>
			</div>
				
	<div id="floating_create">
		<a href="<%=cp %>/codi/codicreated.action" data-hasqtip="0" title="로그인하시면 코디 만들기가 가능해요" aria-describedby="qtip-0">
		<img src="https://s1.codibook.net/images/header/btn_editor.png" alt="코디 만들기">
		</a>
	</div>
			<div class="clear_both"></div>
		</div>
	</div>
</div>

<div class="set_container">
<div id="content" style="position: relative; float: left;
	<c:choose>
		<c:when test="${totalCodiHashTagDataCount < 5}">height: 600px;</c:when>
		<c:when test="${totalCodiHashTagDataCount > 5}">height: 1160px;</c:when>
	</c:choose> 
">
	
<c:forEach var="dto" items="${codiHashTagLists}" varStatus="status">
	<!-- 해시태그 코디 하나 -->
	<div class="grid set_wrapper codi" style="position: absolute; top: 0px;
	<c:choose>
		<c:when test="${status.index%4 eq 1}">left:300px;</c:when>
		<c:when test="${status.index%4 eq 2}">left:600px;</c:when>
		<c:when test="${status.index%4 eq 3}">left:900px;</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${status.index < 4}">top: 0px;</c:when>
		<c:when test="${status.index >= 4}">top: 560px</c:when>
	</c:choose>
	">
	
	<div class="set codi" style="width: 280px">
		<div class="thumb_wrapper">
			<a class="codi_link" href="<%=cp %>/pr/codiDetailList.action?iNum=${dto.iNum}">
			<img class="thumb" alt="style" 
				src="<%=cp %>/upload/makecodi/${dto.iImage}.png">
			</a>
		</div>
		
		<div class="codi_list_items_wrapper">
			<!-- 구성상품 -->
			<c:forEach var="itemVO" items="${dto.itemLists}">
			<div class="codi_item" onclick="location.href='<%=cp %>/pr/detail.action?superProduct=${itemVO.superProduct}'">
				<div class="codi_item_thumb_wrapper">
					<span class="helper"></span>
					<img alt="${itemVO.productName}" src="<%=cp %>/upload/codi/${itemVO.saveFileName}">
				</div>
				<div class="codi_item_info">
					<div class="codi_item_title">${itemVO.productName}</div>
					<div class="codi_item_price"><span><fmt:formatNumber value="${itemVO.price}" groupingUsed="true"/>원</span></div>
				</div>
			</div>
			</c:forEach>
			
			<!-- 더보기 링크 -->
			<div class="codi_item_more">
				<a href="<%=cp %>/pr/codiDetailList.action?iNum=${dto.iNum}">더보기</a>
			</div>
		</div>
		
		<!-- 좋아요 --> 
		<div class="info_wrapper">
			<div class="like_info">받은 좋아요 <span class="liked_cnt" id="codiHeartCount">${dto.heartCount}</span>
			

				<button id="goodButton" class="goodButton" value="${dto.iNum}" >
				<div id="goodDiv${dto.iNum}" class="goodDiv${dto.iNum}">
				<c:set var="k" value="0" />
					<!-- 좋아요한 리스트에 있을 경우 하트 출력 -->
					<c:forEach var="good" items="${good }">
						<c:if test="${dto.iNum eq good}">
							<img src="../resources/image/heart2.PNG" style="height: 25px;"/>
							<c:set var="k" value="1" />
						</c:if>
					</c:forEach>
					<!-- 좋아요한 리스트에 없을 경우 빈하트 출력 -->
					<c:if test="${k == 0}">
						<img src="../resources/image/heart1.PNG" style="height: 25px; padding-right: 10px;"/>
					</c:if>	
				</div>
				</button>
	
			</div>
			
		</div>
	</div>
	
	</div>
	<!-- 해시태그 코디 end -->
</c:forEach>

	<!-- 페이징 -->
	<div id="content_foot">
		<div class="paging" >
			${pageIndexList}
		</div>
	</div>

</div>

</div><!-- set_container end -->
</div>
<%@ include file="../layout/footer.jsp" %>