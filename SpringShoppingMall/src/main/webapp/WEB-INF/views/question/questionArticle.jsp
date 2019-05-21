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

.updateBtn{
	width: 50px; 
	height:30px; 
	background-color: #8080ff; 
	border:1px solid #8080ff; 
	color: white;
}

#followButton{
	background-color: #8080ff; 
	border:1px solid #8080ff; 
	color: white;
}
</style>
<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/bucket.css?ver=1">
<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/show.css?ver=2">
<script type="text/javascript" src="<%=cp%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	
	function updateData(){
		
		var qNum="${dto.qNum}";
		
		url="<%=cp%>/qna/updated.action";
		url+="?qNum="+qNum;
		location.replace(url);
	}
	
	function deleteData(){
		var qNum="${dto.qNum}";
		
		url="<%=cp%>/qna/deleted.action";
		url+="?qNum="+qNum;

		location.replace(url);
	}
</script>

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
				 
				 var me="${sessionScope.customInfo.userId}";
				 
				 $.each(data, function(index, item){ 
					 
					 var writer=item.userId;
					 
	            	 if(index!=(cCnt-1)){
	            		 html += "<div class='reply_content_wrapper'>"; 
	            		 html += "<div class='pf'>"; 
	            		 html += "<img src='<%=cp%>/upload/profile/" +item.mImage +"' width='30' height='30' style='border-radius: 50px;' >";
	                     html += "<strong style='padding-left:10px;'>"+item.userId+"</strong>&nbsp;</div>";
	                     html += "<pre>"+item.content +"</pre><span class='reply_content_wrapper_date'>("+item.replyDate+")";
	                     
	                     if(writer==me){
	                      html += "<a href='javascript:deleteReplyData("+item.replyNum+");'>&nbsp;삭제&nbsp;</a>";
	                     }
	                     
	                     html+="</span></div>";
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
	             
	             var me="${sessionScope.customInfo.userId}";
	             
	             $.each(data, function(index, item){
	            	 
	            	 var writer=item.userId;
	            	 
	            	 if(index!=(cCnt-1)){
	            		 html += "<div class='reply_content_wrapper'>";
	            		 html += "<div class='pf'>"; 
	            		 html += "<img src='<%=cp%>/upload/profile/" +item.mImage +"' width='30' height='30' style='border-radius: 50px;' >";
	                     html += "<strong style='padding-left:10px;'>"+item.userId+"</strong>&nbsp;</div>";
	                     html += "<pre>"+item.content +"</pre><span class='reply_content_wrapper_date'>("+item.replyDate+")";
	                     if(writer==me){
	                      html += "<a href='javascript:deleteReplyData("+item.replyNum+");'>&nbsp;삭제&nbsp;</a>";
	                     }
	                     
	                     html+="</span></div>";
                     
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
				 
				 var me="${sessionScope.customInfo.userId}";

				 $.each(data, function(index, item){ 
					 
					 var writer=item.userId;

	            	  if(index!=(cCnt-1)){
	            		 html += "<div class='reply_content_wrapper'>";
	            		 html += "<div class='pf'>"; 
	            		 html += "<img src='<%=cp%>/upload/profile/" +item.mImage +"' width='30' height='30' style='border-radius: 50px;' >";
	                     html += "<strong style='padding-left:10px;'>"+item.userId+"</strong>&nbsp;</div>";
	                     html += "<pre>"+item.content +"</pre><span class='reply_content_wrapper_date'>("+item.replyDate+")";
	                     
	                    if(writer==me){
	                     html += "<a href='javascript:deleteReplyData("+item.replyNum+");'>&nbsp;삭제&nbsp;</a>";
	                    }
	                     
	                    html+="</span></div>";
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

<script type="text/javascript">

	$(function() {
		$("#followButton").click(function(){
			
	
	        $.ajax({
	            type : 'POST',
				data:{userid:'${dto.userId}'},
	            url : "<%=cp%>/qna/follow.ajax",
	            dataType : "json",
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
	            success : function(data) {
	                //alert(data.cnt);
	                
	                $("#followButton").html(data.str);
	                
	            },
	            beforeSend:showRequest2,
	            error : function(error) {
	                alert("error : " + error);
	            }
	        });
			
		});
	});
	
	function showRequest2() {
        
		var chk='${sessionScope.customInfo.userId}';
		
		if(chk==""){
			alert("로그인을 해주세요!");
			return false;
		}
		else if(chk=='${dto.userId}'){
			alert("자기 자신은 팔로우할 수 없습니다.")
			return false;
		}
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
					class="question__content__footer__date text-gray"> ${dto.qDate } </time>
				<span class="question__content__footer__views text-gray"> 조회
					<span class="question__content__footer__views__content">${dto.qHitCount }</span>
					<c:if test="${sessionScope.customInfo.userId==dto.userId}">
					<div style="float: right; ">
						<input class="updateBtn"
						type="button" value="수정" onclick="updateData();">
						<input class="updateBtn" type="button" value="삭제" onclick="deleteData();">
					</div>
					</c:if>
				</span> 
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
		
		<div class="question__aside__section" style="width: 100px; text-align: center; margin: 10px auto;">
	    <p>
	      <a class="btn btn-md btn-priority question__aside__section__new-question" 
	      href="<%=cp%>/qna/questionMain.action">게시글 목록</a>
	    </p>
		</div>
		
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
					<div id="followButton"
						class="question__author__follow__button question-follow-btn btn btn-xs
                btn-simple "
						role="button" data-target="4183264"
						data-path="/users/4183264/follow"
						data-cancel-path="/users/4183264/unfollow">
						<c:if test="${cnt==0}">
						<span class="inactive" style="width:100px;" >팔로우</span>
						</c:if>
						<c:if test="${cnt==1}">
						<span class="inactive" style="width:100px;" >팔로우 취소</span>
						</c:if>		
						</div>
							
					</div>
				</div>
			</address>
			<div class="question__aside__section" style="width: 330px;">
			    <h2 class="text-heading-5">궁금한 것을 직접 질문해보세요!</h2>
			    <p>
			      <a class="btn btn-md btn-priority question__aside__section__new-question" 
			      href="<%=cp%>/ques/questionCreated.action">질문하러 가기</a>
			    </p>
			</div>
			</div>
			
		</div>
	</nav>
</article>


</main>

<%@include file="../layout/footer.jsp"%>