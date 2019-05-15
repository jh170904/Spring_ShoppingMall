<%@page import="com.codi.dto.MemberDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%@include file="../layout/commuNav.jsp"%>
<style type="text/css">
.comment_list {
    border-top: 1px solid #000;
}

.comment_wrapper .comment_container .comment_write_wrapper .comment_write textarea {
    font-family: 'Noto Sans Regular','Spoqa Han Sans JP','맑은 고딕',Dotum,'Apple SD Gothic Neo',Sans-serif;
    border: 1px solid #d4d4d4;
   	padding: 5px 10px 0;
    width: 580px;
    height: 100px;
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
    padding-left: 3px;
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
    margin-bottom: 3px;
    border-bottom: 1px dotted gray;
}

.reply_content_wrapper_date {
    float: right;
    vertical-align: bottom;
}
.reply_content_wrapper_date a {
    padding: 1px 6px;
    margin-left: 10px;
    color: #999;
    font-size: 11pt;
    font-weight: 700;
}

.paging b {
    margin: 0 auto;
    padding-left: 5px;
    padding-right: 5px;
    font-size: 16px;
    font-weight: 900;

}

.paging{
	display:table; 
	margin-left:auto; 
	margin-right:auto;

}
pre{
	display: inline-block;
	height: 100%;
}

.pf{
	vertical-align: center;
}

#writeBtn{
	width: 130px;
	height: 100px;
	background-color: #8080ff;
	color: #fff;
	border: 1px solid #8080ff;
}

</style>
<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/bucket.css?ver=1">
<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/show.css">
<script type="text/javascript" src="<%=cp%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
  	$(function(){
		listPage(1);//첫 실행시 페이지=1로 실행
	}); 

	function insertComment(){
		var params = "content=" + $("#content").val() + "&qNum=" + ${dto.qNum};
		$.ajax({
			type:"POST",
			url:"<%=cp%>/qna/replyCreated.action",
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
	            		 html += "<div class='pf'>"; 
	            		 html += "<img src='<%=cp%>/upload/profile/" +item.mImage +"' width='30' height='30' style='border-radius: 50px;' >";
	                     html += "<strong style='padding-left:10px;'>"+item.userId+"</strong>&nbsp;</div>";
	                     html += "<pre>"+item.content +"</pre><span class='reply_content_wrapper_date'>("+item.replyDate+")";
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
			url : "<%=cp%>/qna/replyList.action",
			dataType : "json",
			data:{pageNum:page, qNum:'${dto.qNum}'},
			contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
	        success : function(data){
	        	 var html = "";
	             var cCnt = data.length;
	             $.each(data, function(index, item){
	            	 if(index!=(cCnt-1)){
	            		 html += "<div class='reply_content_wrapper'>";
	            		 html += "<div class='pf'>"; 
	            		 html += "<img src='<%=cp%>/upload/profile/" +item.mImage +"' width='30' height='30' style='border-radius: 50px;' >";
	                     html += "<strong style='padding-left:10px;'>"+item.userId+"</strong>&nbsp;</div>";
	                     html += "<pre>"+item.content +"</pre><span class='reply_content_wrapper_date'>("+item.replyDate+")";
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
				
		$.ajax({
			type:"POST",
			url:"<%=cp%>/qna/replyDeleted.action",
			dataType : "json",
			data: {	
					replyNum:replyNum,
					pageNum:replyPageNum,
					qNum:'${dto.qNum}'
			},				
			contentType:"application/x-www-form-urlencoded; charset=UTF-8", 
			//콜백함수
			success:function(data){
				 var html = "";
				 var cCnt = data.length;
				 $.each(data, function(index, item){ 
					 
	            	  if(index!=(cCnt-1)){
	            		 html += "<div class='reply_content_wrapper'>";
	            		 html += "<div class='pf'>"; 
	            		 html += "<img src='<%=cp%>/upload/profile/" +item.mImage +"' width='30' height='30' style='border-radius: 50px;' >";
	                     html += "<strong style='padding-left:10px;'>"+item.userId+"</strong>&nbsp;</div>";
	                     html += "<pre>"+item.content +"</pre><span class='reply_content_wrapper_date'>("+item.replyDate+")";
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
	
</script>
<main role="main" id="root">
<article id="page" class="page-2col container" data-question-id="10126">
	<section id="question__content" class="page-2col__content">
		<header class="question__content__header page-2col__content__header">
			<div class="question__content__header__top text-body-1">
				<a class="question__content__header__top__board" href="<%=cp%>/qna/questionMain.action">질문과 답변</a>
			</div>
			<h1 id="question-name"
				class="question__content__header__name text-heading-3 text-black bold">${dto.qSubject }</h1>
		</header>
		
		<section class="question__content__body">
			<p>${dto.qContent }</p>
			<c:if test="${dto.saveFileName!=null }">
			<img src="${imagePath}/${dto.saveFileName}" alt="None"> 
			</c:if>
		</section>
		<footer class="question__content__footer">
			<ul class="question__content__footer__tags keyword-list">
				<c:if test="${hashArray!=null }">
				<c:forEach var="hash" items="${hashArray}">
				<li><a class="keyword-item"
					href="/questions?query=%EA%B2%AC%EC%A0%81">${hash}</a></li>
				</c:forEach>
				</c:if>
			</ul>
			

			<div class="question__content__footer__meta text-caption-1">
				<time datetime="2019-05-14T09:30:14+09:00"
					class="question__content__footer__date text-gray"> 2019년 05월
					14일 09:30 </time>
				<span class="question__content__footer__views text-gray"> 조회
					<span class="question__content__footer__views__content">19</span>
				</span> <span class="question__content__footer__bookmarks text-gray">
					스크랩 <span class="question__content__footer__bookmarks__content">
						0 </span>
				</span> <a class="question__content__footer__report text-gray-light"
					data-remote="true" href="/questions/10126/report">신고</a>
			</div>
		</footer>

		<!-- 코멘트와 구분 -->
		<!-- 댓글 -->
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
										<textarea rows="20" id="content" name="content" ></textarea>
										<input type="button" id="writeBtn" onclick="insertComment();" value="작성"></button>
										</form>
									<% }else{ %>
										<img alt="" src="<%=cp %>/upload/profile/default.jpg" width="30" height="30" style="border-radius: 50px;">
									</td>
									<td class="comment_write">
										<textarea rows="20" id="content" name="content" readonly="readonly" placeholder="로그인 하시면 댓글 작성이 가능합니다." ></textarea>
										<input type="button" id="writeBtn" value="작성"></button>
									<% } %>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				</div> 
	
		<!-- 댓글여기까지 -->
		
	</section>
	
	<nav id="question__sidebar" class="page-2col__sidebar sticky-top"
		style="min-height: 522.76px;">
		<div class="page-2col__sidebar__content sticky-content open"
			data-sticky-enabled="false" data-offset="131.979166"
			style="position: relative;">
			<address class="question__sidebar__author question__author">
				<a class="question__author__link" href="/users/4183264">
					<div class="question__author__image">
						<img
							src="${memberPath}/${dto.mImage}"
							onerror="this.src='https://bucketplace-v2-development.s3.amazonaws.com/uploads/default_images/avatar.png'">
					</div>
					<div class="question__author__content">
						<div class="question__author__content__name text-body-1">
							<span class="question__author__content__name__name">${dto.userId }</span>
						</div>
						<div class="question__author__content__body text-caption-4"></div>
					</div>
				</a>
				<div class="question__author__follow">
					<div
						class="question__author__follow__button question-follow-btn btn btn-xs
                btn-simple"
						role="button" data-target="4183264"
						data-path="/users/4183264/follow"
						data-cancel-path="/users/4183264/unfollow">
						<span class="active"><span
							class="icon icon-etc-check-white-sm"></span>팔로잉</span><span
							class="inactive">팔로우</span>
					</div>
				</div>
			</address>
			<div class="question__sidebar__actions question__actions">   
				<div class="question__actions__action__wrap">
					<div class="question__actions__action question-share-btn"
						role="button" data-target="10126"
						data-path="/questions/10126/increase_share">
						<span class="icon icon-action-share-alt-gray-sm inactive"></span>
						<span class="icon icon-action-share-alt-white-sm active"></span> <span
							class="question__actions__action__caption">공유</span> <span
							class="question__actions__action__count">0</span>
					</div>
					<div id="" class="tooltip-share-sns hidden" style="right:">
						<!--data-title="" data-username=""-->
						<a class="btn-share-sns facebook"
							href="https://www.facebook.com/sharer.php?u=https://ohou.se/questions/10126?affect_id=0&amp;affect_type=QuestionIndex&amp;query="
							target="_blank"><span class="icon icon-sns-square-facebook"></span></a>
						<div class="btn-share-sns kakaostory" href="#" target="_blank">
							<span class="icon icon-sns-square-kakao-story"></span><a
								href="https://story.kakao.com/s/share?url=https%3A%2F%2Fohou.se%2Fquestions%2F10126%3Faffect_id%3D0%26affect_type%3DQuestionIndex%26query%3D&amp;text=%EC%A3%BC%EB%B0%A9%EA%B3%BC%20%EB%B6%99%EC%96%B4%EC%9E%88%EB%8A%94%20%EB%B2%BD%20%ED%97%88%EB%AC%BC%EA%B8%B0.%0A%0A%EC%98%A4%EB%8A%98%EC%9D%98%EC%A7%91%EC%97%90%EC%84%9C%20%EC%9D%B8%ED%85%8C%EB%A6%AC%EC%96%B4%20%EA%B3%A0%EC%88%98%EB%93%A4%EA%B3%BC%20%EC%A0%84%EB%AC%B8%EA%B0%80%EB%93%A4%EC%97%90%EA%B2%8C%20%EC%A1%B0%EC%96%B8%EC%9D%84%20%EB%B0%9B%EC%95%84%EB%B3%B4%EC%84%B8%EC%9A%94!&amp;kakao_agent=sdk%2F1.29.1%20os%2Fjavascript%20lang%2Fko-KR%20device%2FWin32%20origin%2Fhttps%253A%252F%252Fohou.se&amp;app_key=3019c756ec77dd7e0a24e56d9d784f77"
								target="_blank"><img
								src="//dev.kakao.com/sdk/js/resources/story/icon_small.png"
								width="24" height="24"></a>
						</div>

						<a class="btn-share-sns naver"
							href="http://share.naver.com/web/shareView.nhn?url=https://ohou.se/questions/10126?affect_id=0&amp;affect_type=QuestionIndex&amp;query=&amp;title=오늘의집에서 보기"
							target="_blank"><span class="icon icon-sns-square-naver"></span></a>
					</div>
				</div>
			</div>
			
		</div>
	</nav>
</article>

<section id="question__floating" class="floating-bar sticky-bottom"
	style="height: auto;">
	<div class="floating-bar__content sticky-content question__floating"
		data-sticky-enabled="false" style="position: relative; bottom: 0px;">
		<div class="question__floating__actions question__actions">
			<div class="question__actions__action__wrap">
				<div class="question__actions__action question-share-btn"
					role="button" data-target="10126"
					data-path="/questions/10126/increase_share">
					<span class="icon-common-action__j-8" aria-hidden="true"></span> <span
						class="question__actions__action__caption">공유</span> <span
						class="question__actions__action__count">0</span>
				</div>
				<div id="" class="tooltip-share-sns hidden" style="right:">
					<!--data-title="" data-username=""-->
					<a class="btn-share-sns facebook"
						href="https://www.facebook.com/sharer.php?u=https://ohou.se/questions/10126?affect_id=0&amp;affect_type=QuestionIndex&amp;query="
						target="_blank"><span class="icon icon-sns-square-facebook"></span></a>
					<div class="btn-share-sns kakaostory" href="#" target="_blank">
						<span class="icon icon-sns-square-kakao-story"></span><a
							href="https://story.kakao.com/s/share?url=https%3A%2F%2Fohou.se%2Fquestions%2F10126%3Faffect_id%3D0%26affect_type%3DQuestionIndex%26query%3D&amp;text=%EC%A3%BC%EB%B0%A9%EA%B3%BC%20%EB%B6%99%EC%96%B4%EC%9E%88%EB%8A%94%20%EB%B2%BD%20%ED%97%88%EB%AC%BC%EA%B8%B0.%0A%0A%EC%98%A4%EB%8A%98%EC%9D%98%EC%A7%91%EC%97%90%EC%84%9C%20%EC%9D%B8%ED%85%8C%EB%A6%AC%EC%96%B4%20%EA%B3%A0%EC%88%98%EB%93%A4%EA%B3%BC%20%EC%A0%84%EB%AC%B8%EA%B0%80%EB%93%A4%EC%97%90%EA%B2%8C%20%EC%A1%B0%EC%96%B8%EC%9D%84%20%EB%B0%9B%EC%95%84%EB%B3%B4%EC%84%B8%EC%9A%94!&amp;kakao_agent=sdk%2F1.29.1%20os%2Fjavascript%20lang%2Fko-KR%20device%2FWin32%20origin%2Fhttps%253A%252F%252Fohou.se&amp;app_key=3019c756ec77dd7e0a24e56d9d784f77"
							target="_blank"><img
							src="//dev.kakao.com/sdk/js/resources/story/icon_small.png"
							width="24" height="24"></a>
					</div>

					<a class="btn-share-sns naver"
						href="http://share.naver.com/web/shareView.nhn?url=https://ohou.se/questions/10126?affect_id=0&amp;affect_type=QuestionIndex&amp;query=&amp;title=오늘의집에서 보기"
						target="_blank"><span class="icon icon-sns-square-naver"></span></a>
				</div>
			</div>
		</div>

	</div>
</section>

</main>

<%@include file="../layout/footer.jsp"%>