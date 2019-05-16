<%@page import="com.codi.dto.MemberDTO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../layout/commuNav.jsp"  %>
<script type="text/javascript" src="<%=cp%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
  	$(function(){
		listPage(1);//첫 실행시 페이지=1로 실행
	}); 

	function insertComment(){
		var params = "content=" + $("#content").val() + "&iNum=" + ${dto.iNum};
		$.ajax({
			type:"POST",
			url:"<%=cp%>/pr/replyCreated.action",
			dataType : "json",
			data:params,
			contentType:"application/x-www-form-urlencoded; charset=UTF-8", 
			//콜백함수
			success:function(data){
				 var html = "";
				 var cCnt = data.length;
				 $.each(data, function(index, item){ 
					 
	            	  if(index!=(cCnt-1)){
	            		 html += "<div class='reply_content_wrapper'>"; 
	            		 html += "<img src='<%=cp%>/upload/profile/" +item.mImage +"' width='30' height='30' style='border-radius: 50px;' >";
	                     html += "<strong style='padding-left:10px;'>"+item.userId+"</strong>&nbsp;";
	                     html += item.content +"<span class='reply_content_wrapper_date'>("+item.replyDate+")";
	                     html += "<a href='javascript:deleteReplyData("+item.replyNum+");'>&nbsp;삭제&nbsp;</a></span></div>";
	            	  }else if(index==(cCnt-1)){
	            		 html += "<span class='paging'>"+item.pageIndexList+"</span>";
	            		 $(".totalReplyDataCount").val(item.totalReplyDataCount);
	            		 $(".pageNum").val(item.pageNum);
	            	 } 
	             });
	             $("#listData").html(html);
	             $("#listData").show();
	             $("#content").val("");
	             $("#content").focus();
	             
			},
			beforeSend:showRequest,
			error:function(e){
				alert(e.responseText);
			}	
		});
	}
	
	function showRequest(){
		f = document.commentForm;
		str = f.content.value;
		str = str.trim();
		if(str=="" || !str){
			alert("\n 댓글을 입력해주세요.");
			f.content.focus();
			return false;
		}
		return true;
	}
  	
	function listPage(page){
		$.ajax({
			type:'POST',
			url : "<%=cp%>/pr/replyList.action",
			dataType : "json",
			data:{pageNum:page, iNum:'${dto.iNum}'},
			contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
	        success : function(data){
	        	 var html = "";
	             var cCnt = data.length;
	             $.each(data, function(index, item){
	            	 if(index!=(cCnt-1)){
	            		 html += "<div class='reply_content_wrapper'>";
	            		 html += "<img src='<%=cp%>/upload/profile/" +item.mImage +"' width='30' height='30' style='border-radius: 50px;' >";
	                     html += "<strong style='padding-left:10px;'>"+item.userId+"</strong>&nbsp;";
	                     html += item.content +"<span class='reply_content_wrapper_date'>("+item.replyDate+")";
	                     html += "<a href='javascript:deleteReplyData("+item.replyNum+");'>&nbsp;삭제&nbsp;</a></span></div>";
	            	 }else if(index==(cCnt-1)){
	            		 html += "<span class='paging'>"+item.pageIndexList+"</span>";
	            		 $(".totalReplyDataCount").val(item.totalReplyDataCount);
	            		 $(".pageNum").val(item.pageNum);
	            	 }
	             });
	             $("#listData").html(html);
	             $("#listData").show();
	        },
			error:function(e){
				alert(e.responseText);
			}
		});
		
	}
  	
	function deleteReplyData(replyNum){
		//삭제 후 페이지 이동 필요
		var replyPageNum = $(".pageNum").val();
				
		var xhr = $.ajax({
			type:"POST",
			url:"<%=cp%>/pr/replyDeleted.action",
			dataType : "json",
			data: {	
					replyNum:replyNum,
					pageNum:replyPageNum,
					iNum:'${dto.iNum}'
			},
			traditional : true, 
   		    async : false,
			contentType:"application/x-www-form-urlencoded; charset=UTF-8", 
			//콜백함수
			success:function(data){
				 var html = "";
				 var cCnt = data.length;
				 $.each(data, function(index, item){ 
					 
	            	  if(index!=(cCnt-1)){
	            		 html += "<div class='reply_content_wrapper'>";
	            		 html += "<img src='<%=cp%>/upload/profile/" +item.mImage +"' width='30' height='30' style='border-radius: 50px;' >";
	                     html += "<strong style='padding-left:10px;'>"+item.userId+"</strong>&nbsp;";
	                     html += item.content +"<span class='reply_content_wrapper_date'>("+item.replyDate+")";
	                     html += "<a href='javascript:deleteReplyData("+item.replyNum+");'>&nbsp;삭제&nbsp;</a></span></div>";
	            	  }else if(index==(cCnt-1)){
	            		  html += "<span class='paging'>"+item.pageIndexList+"</span>";
	            		 $(".totalReplyDataCount").val(item.totalReplyDataCount);
	            		 $(".pageNum").val(item.pageNum);
	            	 } 
	             });
	             $("#listData").html(html);
	             $("#listData").show();
	             
			},
			beforeSend:function(xhr){
				
				var checkedIdFlag = checkId(replyNum);
				
				if(!checkedIdFlag){
					xhr.abort();
				}
			},
			error:function(e){
				alert(e.responseText);
			}	
		});
	}
	
	function checkId(replyNum){
		
		var flag = false;		

   		$.ajax({
   			type:"POST",
   			url:"<%=cp%>/pr/replyIdCheck.action",
   			dataType : "json",
   			data: {	
   					replyNum:replyNum,
   					iNum:'${dto.iNum}'
   			},	
   			traditional : true, 
   		    async : false,
   			contentType:"application/x-www-form-urlencoded; charset=UTF-8", 
   			success:function(data){
   				
   				if(data){
   					flag = true;
   				}else{
   					alert("\n 작성한 사용자만 댓글을 삭제할 수 있습니다.");
   				}
   			},
   			error:function(e){
   				alert(e.responseText);
   			}	
   		});
   		
   		return flag;
	}
  	

	$(function(){
		
		$(".goodButton").click(function(){
			var iNum = $(this).attr('value');
			alert(iNum);
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
	            		$(".codiHeartCount").html(data.count);
	                } else {
	            		$(".goodDiv" + iNum).html('<img src="../resources/image/heart2.PNG" style="height: 25px;"/> ');
	            		$(".codiHeartCount").html(data.count);
	                }
	            },
	            error : function(error) {
	            	alert("로그인이 필요합니다.");
	            }
	        });
		});
		
		$(".itemGoodButton").click(function(){
			var superProduct = $(this).attr('value');
	        var info = '<%=(MemberDTO)session.getAttribute("customInfo")%>';
	        
	        if(info=="" || info==null){
	        	alert("로그인이 필요합니다.");
	        	return;
	        }
	             
	        $.ajax({
	            async: true,
	            type : 'POST',
	            data : superProduct,
	            url : "../storeGood.action",
	            dataType : "json",
	            contentType: "application/json; charset=UTF-8",
	            success : function(data) {
	            	if(data.cnt > 0) {
	            		$(".itemGoodDiv" + superProduct).html('<img src="../resources/image/heart1.PNG" style="height: 25px;"/> ');
	                } else {
	            		$(".itemGoodDiv" + superProduct).html('<img src="../resources/image/heart2.PNG" style="height: 25px;"/> ');
	                } 
	            },
	            error : function(error) {
	            	alert("로그인이 필요합니다.");
	            }
	        });
		});
		
		
		
		$(".followButton").click(function(){
			var dtoId = $(this).attr('value');
	        
	        $.ajax({
	            async: true,
	            type : 'POST',
	            data : dtoId,
	            url : "../follow.action",
	            dataType : "json",
	            contentType: "application/json; charset=UTF-8",
	            success : function(data) {
	            	$(".followDiv" + dtoId).html(data.str);
	            },
	            error : function(jqXHR, exception) {
	                if (jqXHR.status === 0) {
	                    alert('Not connect.\n Verify Network.');
	                }else if (jqXHR.status == 400) {
	                    alert('Server understood the request, but request content was invalid. [400]');
	                }else if (jqXHR.status == 401) {
	                    alert('Unauthorized access. [401]');
	                }else if (jqXHR.status == 403) {
	                    alert('Forbidden resource can not be accessed. [403]');
	               	}else if (jqXHR.status == 404) {
	                    alert('Requested page not found. [404]');
	                }else if (jqXHR.status == 500) {
	                	alert("로그인이 필요합니다.");
	                }else if (jqXHR.status == 503) {
	                    alert('Service unavailable. [503]');
	                }else if (exception === 'parsererror') {
	                    alert('Requested JSON parse failed. [Failed]');
	                }else if (exception === 'timeout') {
	                    alert('Time out error. [Timeout]');
	                }else if (exception === 'abort') {
	                    alert('Ajax request aborted. [Aborted]');
	                }else {
	                    alert('Uncaught Error.n' + jqXHR.responseText);
	                }

	            }
	        });
				
		});
		
	});
</script>

<style type="text/css">
#container #codi_view_container {
    overflow: auto;
    padding: 0;
    padding-bottom: 30px;
    display: block;
    font-size: 12px;
    font-family: 'Noto Sans Regular','Spoqa Han Sans JP','맑은 고딕',Dotum,'Apple SD Gothic Neo',Sans-serif;
    color: #333;
}
.codi_view_wrapper {
    overflow: auto;
    display: block;
}

#container {
    margin: 0 auto;
    max-width: 1285px;
}
.codi_info_wrapper {
    float: right;
    margin-left: 0;
    box-sizing: border-box;
    padding-right: 17px;
}

.info_wrapper{

    padding: 10px 5px 15px 15px;
	font-size: 16pt;
	font-weight: bold;
	color: #8080ff;
}

.document_info_wrapper {
    float: left;
    position: relative;
    margin-left: 1%;
    margin-bottom: 10px;
    border-radius: 5px;
    width: 32%;
    background: #fff;
    overflow: hidden;
}

.codi_dialog .codi_info_wrapper {
    float: right;
    margin-left: 0;
    box-sizing: border-box;
    padding-right: 17px;
}

.document_dialog .document_content_wrapper {
    float: left;
    position: relative;
    padding: 10px 0;
    width: 66%;
    padding-top: 0;
    background: #fff;
    overflow: hidden;
}
.profile_wrapper {
	text-align: center;
    position: relative;
    margin: 10px 20px 0 20px;
    overflow: hidden;
    font-size: 14pt;
    font-weight: bold;
}

.profile_codi_title {
    font-size: 16px;
    font-family: 'Noto Sans Regular','Spoqa Han Sans JP','맑은 고딕',Dotum,'Apple SD Gothic Neo',Sans-serif;
    color: #555;
    font-weight: 900;
    padding: 15px 5px 10px 15px;
}

.profile_codi .codi_wrapper {
    float: left;
    position: relative;
    margin: 0 2% 2%;
    outline: 1px solid rgba(0,0,0,.12);
    width: 46%;
    height: 160px;
    text-align: center;
}
.profile_codi .codi_wrapper img{
    height: 160px;
}

.codi_wrapper{
    height: 160px;
}

.profile_wrapper .profile_image img {

    width: 80px;
    height: 80px;
    border-radius: 50%;
}
.profile_wrapper .nick_name {
	text-align: center;
    color: #8080ff;
    text-decoration: none;
    text-align: center;
    font-weight:bold;
    font-family: 'Noto Sans Regular','Spoqa Han Sans JP','맑은 고딕',Dotum,'Apple SD Gothic Neo',Sans-serif;
    font-size: 16px;
}
.profile_wrapper .follow_wrapper {
    text-transform: capitalize;
    font-size: 12px;
    margin: 0;
    font-family: 'Noto Sans Regular','Spoqa Han Sans JP','맑은 고딕',Dotum,'Apple SD Gothic Neo',Sans-serif;
    cursor: pointer;
    outline: 0;
    line-height: 30px;
    color: #8080ff;
    background: #fff;
    border: 1px solid #8080ff;
    border-radius: 5px;
    text-align: center;
    width: 100px;
    height: 30px;
    font-size: 14px;
    font-weight: 700;
    margin: 15px auto 0;
}

.codi_dialog .codi_info_wrapper {
    float: right;
    margin-left: 0;
    box-sizing: border-box;
    padding-right: 17px;
}

.codi_dialog .codi_info_wrapper {
    float: right;
    margin-left: 0;
    box-sizing: border-box;
    padding-right: 17px;
}

.liked_wrapper .total_liked {
	margin-top: 20px;
    border-top: 1px solid #8080ff;
    width: 100%;
    margin: 5px 0;
    font-size: 14px;
    padding: 9px 0 9px 45px;
}
.codi_dialog .detail_title {
    margin: 25px 0 12px 3px;
}

.title {
    margin: 25px 0 12px 3px;
    padding-left: 20px;
}
body {
    background: #fff;
    font-size: 12px;
    font-family: 'Noto Sans Regular','Spoqa Han Sans JP','맑은 고딕',Dotum,'Apple SD Gothic Neo',Sans-serif;
    color: #333;
    margin: 0;
}
.set_container {
	width: 300px;
    padding: 8px;
    overflow: hidden;
    display: inline-block;
    vertical-align: top;
}
.thumb_wrapper {
    text-align: center;
    width: 100%;
}
.set_container .set .profile_wrapper {
    overflow: hidden;
    padding: 15px 15px 10px 15px;
    padding-top: 10px;
    margin: 0;
}
.title_wrapper {
    color: #555;
    text-decoration: none;
    text-transform: capitalize;
    padding: 5px 5px 5px 5px;
    line-height: 18px;
    font-size: 14px;
    text-align: center;
    width: 280px;
}

.set_wrapper .set_container .set {
    background: #fff;
    margin: 0;
    border: 1px solid rgba(0,0,0,.12);
}
.set .thumb_wrapper img.item.thumb {
    margin-top: 15px;
    max-width: 200px;
    max-height: 300px;
}

.set.item{
	border: 1px solid rgba(0,0,0,.12);
}

.price{
	 font-size: 18px;
	 padding-left:140px;
}

.line {
    border-top: 1px solid #d4d4d4;
    width: 100%;
    margin: 5px 0;
    padding: 5px 5px 5px 5px;
}

.comment_wrapper .comment_container .comment_write_wrapper .comment_write input[type=text] {
    font-family: 'Noto Sans Regular','Spoqa Han Sans JP','맑은 고딕',Dotum,'Apple SD Gothic Neo',Sans-serif;
    border: 1px solid #d4d4d4;
    padding: 6px 0;
    width: 700px;
    height: 30px;
    text-indent: 1em;
    font-size: 14px;
    margin: 5px 5px 5px 5px;
}

form {
    display: block;
    margin-top: 0em;
}

table {
    border-collapse: separate;
    border-spacing: 2px;
}

.total_liked {
    padding-right: 56px;
    padding-top: 8px;
    padding-bottom: 12px;
    font-size: 16px;
    text-align: right;
}

.description a{
    font-size: 16px;
    padding-bottom: 15px;
    color: #00b7ff;
    text-decoration:none;
}
.description {
    font-size: 16px;
    padding-bottom: 15px;
}

.reply_content_wrapper {
	text-align: left;
    padding: 6px;
    padding-right: 20px;
    position: relative;
	font-size: 14px;
    font-family: 'Noto Sans Regular','Spoqa Han Sans JP','맑은 고딕',Dotum,'Apple SD Gothic Neo',Sans-serif;
    color: #333;
}
.reply_content_wrapper_date{
	float: right;
}

.reply_content_wrapper_date a{
    padding: 1px 6px;
    margin-left: 10px;
    color: #999;
    font-size: 11pt;
    font-weight: 700;
}

.paging a {
	padding-left: 5px;
	padding-right: 5px;
	font-size: 14px;
	font-weight: 700;
}

.paging b {
	margin :0;
	padding-left: 5px;
	padding-right: 5px;
	font-size: 16px;
	font-weight: 900;
}
</style>



<div class="codi_view" id="container">
	<div class="title" style="margin-left: 40px;"><span style="font-size: 18pt; font-weight: 800; color: #8080ff;">${dto.iSubject}</span></div>	
	<table>
		<tr>
			<td width="800px" align="center" style="padding-left: 50px;">
			
				<!-- 코디 이미지 -->
				<img src="<%=cp %>/upload/makecodi/${dto.iImage}.png" >
				
				<!-- 좋아요 -->
				<div class="total_liked">
					<span class="codiHeartCount">${codiHeartCount }</span>명이 좋아합니다 
					<div style="display: inline;">
						<button class="goodButton" value="${dto.iNum}" style="margin-left: 5px; height: 40px;">
							<div class="goodDiv${dto.iNum}">
								<c:if test="${dto.heartCount==0}">
									<img src="../resources/image/heart1.PNG" style="height: 25px;"/>
								</c:if>
								<c:if test="${dto.heartCount!=0 }">
									<img src="../resources/image/heart2.PNG" style="height: 25px;"/>
								</c:if>
							</div>
						</button>
					</div>
				</div>
			
				<!-- 해쉬태그 -->
				<div class="description">				
					<c:forTokens var="item" items="${dto.iHashTag }" delims="#" >
						<c:url value="codiHashTagList.action" var="toURL">
				        	<c:param name="iHashtag" value="${item}"/>
						</c:url>
						<a href="${toURL}">#${item}</a> 
					</c:forTokens>
				</div>
				
				<!-- 게시글 내용 -->
				<div class="description">${dto.iContent}</div>
				
				<!-- 댓글 -->
				<div class="comment_wrapper">
				<div class="comment_container">
				<div class="comment_list">
					<span id="listData" style="display: none;">
					<input type="hidden" value="" id="pageNum" name="pageNum" >
					<input type="hidden" value="" id="totalReplyDataCount" name="totalReplyDataCount" >
					</span>
				</div>
					<div class="comment_write_wrapper">
						<table>
							<tbody>
								<tr>
									<td class="profile_image">
									<% if((MemberDTO)session.getAttribute("customInfo")!=null){ %>
										<img alt="" src="<%=cp %>/upload/profile/${loginUserInfo.mImage}" width="30" height="30" style="border-radius: 50px;">
									</td>
									<td class="comment_write">
										<form class="comment" name="commentForm"  onsubmit="return false">
										<input class="comment_content" type="text" id="content" name="content" placeholder="이 코디에 대한 댓글을 달아보세요"
										 autocomplete="off" onkeypress="if( event.keyCode==13 ){insertComment();}" >
										</form>
									<% }else{ %>
										<img alt="" src="<%=cp %>/upload/profile/default.jpg" width="30" height="30" style="border-radius: 50px;">
									</td>
									<td class="comment_write">
										<input class="comment_content" type="text" id="content" name="content" readonly="readonly" placeholder="로그인 하시면 댓글 작성이 가능합니다." >
									<% } %>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				</div> 
			</td>
			
	
			<td width="400px" valign="top">		
					<!-- 작성자 프로필 -->
					<div class="profile_wrapper">
						<div class="profile_image">
						<img alt="profile image" width="90" height="90"	src="<%=cp %>/upload/profile/${userInfo.mImage}">
						</div>
						<div class="nick_name">${dto.userId }</div>	
						<div class="btn follow_wrapper requireLogin">
							<button class="followButton" value="${dto.userId}" class="btn follow_wrapper requireLogin">
							<div class="followDiv${dto.userId}">
								<c:if test="${follow eq 1}">
									팔로우 취소
								</c:if>
								<c:if test="${follow eq 0 }">
									+팔로우
								</c:if>
							</div>
						</button>
						</div>
										
						
					</div>
					
					<!-- 동일아이디 등록코디 -->
					<div class="profile_codi">
						<div class="profile_codi_title">${dto.userId }<span>님의 다른코디</span>
						</div>
						<c:forEach var="codiDTO" items="${codiLists }" >
						<div class="codi_wrapper">
							<a class="codi_link"  href="<%=cp %>/pr/codiDetailList.action?iNum=${codiDTO.iNum}">
							<img src="<%=cp %>/upload/makecodi/${codiDTO.iImage}.png">
							</a>
						</div>
						</c:forEach>
						<c:if test="${codiListsDataCount < 6}">
							<c:if test="${codiListsDataCount== 0}">
							<div class="codi_wrapper" style="height:600px; width:100%; outline:white; text-align: center; font-size: 15px;">등록된 게시물이 없습니다</div>
							</c:if>
							<c:if test="${codiListsDataCount!= 0}">
							<c:forEach step="1" begin="1" end="${6-codiListsDataCount}">
								<div class="codi_wrapper" style="outline:white;"></div>
							</c:forEach>
							</c:if>
						</c:if>
						
					</div>
			</td>
		</tr>
	</table>
	
	
	<div class="line"></div>
	<div class="detail_title" style="margin-left: 40px;"><span style="font-size: 16pt; font-weight: 800;">코디에 사용된 상품</span></div>
	<!-- 코디구성상품 -->
	<c:forEach var="vo" items="${usedProductLists}">
		<div class="set_container" style="margin-left: 10px;">
		
			<div class="set item" >
				<a href="<%=cp%>/pr/detail.action?superProduct=${vo.superProduct}">
				<div class="thumb_wrapper">
				<img class="thumb item" alt="" src="<%=cp %>/upload/codi/${vo.saveFileName}" width="" >
				</div>
				<div class="profile_wrapper">
					<div class="profile_info">
						<div class="nickname"><span>${vo.storeName }</span></div>
					</div>
				</div>
				<div class="title_wrapper" style="top: 0px;">
				<img alt="new" src="https://s1.codibook.net/images/common/new.png?20160509" align="middle" height="13">
				${vo.productName }
				</div>
				</a>
				<div class="info_wrapper">
					<div class="price">
					<fmt:formatNumber value="${vo.price}" groupingUsed="true"/>원
					</div>
				</div>
				
				
				<span style="font-size: 14pt;  color: #8080FF; padding: 10px 10px 10px 10px;  ">
						<input type="hidden" id="superProduct" value="${vo.superProduct}" >
						<button class="itemGoodButton" value="${vo.superProduct}">
							<div class="itemGoodDiv${vo.superProduct}">
								<c:set var="k" value="0" />
								<c:forEach var="good" items="${good }">
									<c:if test="${vo.superProduct eq good}">
										<img src="../resources/image/heart2.PNG" style="height: 25px;"/>
										<c:set var="k" value="1" />
									</c:if>
								</c:forEach>
								<c:if test="${k==0 }">
									<img src="../resources/image/heart1.PNG" style="height: 25px;"/>
								</c:if>
							</div>
						</button>
				</span>
			</div>
			
		</div>
	</c:forEach>

</div>



<%@ include file="../layout/footer.jsp" %>