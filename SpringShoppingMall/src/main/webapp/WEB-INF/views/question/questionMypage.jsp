<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="../layout/top.jsp"%>
<%@include file="../layout/mypage.jsp"%>

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

.post__upload {
	display: -webkit-box;
	display: -moz-flex;
	display: -ms-flexbox;
	display: flex;
	-webkit-box-pack: center;
	-ms-flex-pack: center;
	-moz-justify-content: center;
	justify-content: center;
	-webkit-box-align: center;
	-ms-flex-align: center;
	-moz-align-items: center;
	align-items: center;
	width: 100%;
	padding: 220px 0;
	border: 1px dashed #dbdbdb;
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
	color: #757575;
	font-weight: 700;
	font-size: 15px;
}

.profile-image {
	top: 20px;
	width: 250px;
	height: 250px;
	margin-top: 30px;
	margin-left: auto;
	margin-right: auto;
}

.profile-image img {
	width: 250px;
	height: 250px;
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

/* mypage css */
#filter {
	margin: 15px 0;
	font-weight: bold;
	font-size: 13pt;
	font:#8080ff;
}

#filter>a.on{
	color: #8080ff;
}
.questions-item__link:last-child>.questions-item {
	border-bottom: 1px solid #C6C6C6;
}
</style>
<link rel="stylesheet" type="text/css"
	href="<%=cp%>/resources/css/bucket.css?ver=1">
<script type="text/javascript"
	src="<%=cp%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		var on='${on}';
		
		if(on=='me'||on==""){
			$('#me').addClass('on');
			$('#other').removeClass('on');
		}
		else{
			$('#other').addClass('on');
			$('#me').removeClass('on');
		}

	});
</script>


<div class="container2">
	<div style="width: 336px; margin-right: 50px; display: inline-block; vertical-align: top;">
		<div style="display: block;">
			<div class="profile-image">
				<img alt="" src="${memberPath }/${loginUserInfo.mImage }"
					style="border-radius: 100%;">
			</div>

			<div
				style="border-bottom: 1px solid #ebebeb; margin-bottom: 20px; margin-top: 20px;"></div>

			<div class="profile-info__name">
				<strong>${dto.userId }</strong>
			</div>


			<div style="color: #bdbdbd; font-size: 13px;">
				<a href="<%=cp%>/myPage/follower.action"
					style="display: inline-block; margin-left: 10px;">팔로워
					${follower }</a>&nbsp;&nbsp;&nbsp; <a
					href="<%=cp%>/myPage/following.action"
					style="display: inline-block;">팔로잉 ${following }</a>
			</div>

			<div
				style="border-bottom: 1px solid #ebebeb; margin-bottom: 20px; margin-top: 20px;"></div>

			<div style="margin-top: 20px;">
				<div class="short-cut__item">
					<a href="<%=cp%>/myPage/myStoreHeartLists.action">
						<div class="short-cut__icon">
							<svg width="24" height="24" viewBox="0 0 24 24"
								preserveAspectRatio="xMidYMid meet">
			<path fill="currentColor"
									d="M22.971 7.638c-.548-5.17-7.119-7.135-10.57-2.488a.5.5 0 0 1-.802 0C8.148.503 1.577 2.469 1.029 7.625.642 12.451 3.897 17.183 12 21.436c8.104-4.252 11.36-8.984 10.972-13.798zm.996-.093c.428 5.319-3.137 10.446-11.738 14.899a.5.5 0 0 1-.46 0C3.169 17.99-.395 12.864.034 7.532.656 1.67 7.904-.683 12 4.052 16.096-.683 23.344 1.67 23.967 7.545z">
			</path>
			</svg>
						</div> <strong>관심 상품</strong>
					</a>
				</div>

				<div class="short-cut__item ">
					<a href="<%=cp%>/myPage/myCodiHeartists.action">
						<div class="short-cut__icon">
							<svg width="24" height="24" viewBox="0 0 24 24"
								preserveAspectRatio="xMidYMid meet">
			<path fill="currentColor"
									d="M22.971 7.638c-.548-5.17-7.119-7.135-10.57-2.488a.5.5 0 0 1-.802 0C8.148.503 1.577 2.469 1.029 7.625.642 12.451 3.897 17.183 12 21.436c8.104-4.252 11.36-8.984 10.972-13.798zm.996-.093c.428 5.319-3.137 10.446-11.738 14.899a.5.5 0 0 1-.46 0C3.169 17.99-.395 12.864.034 7.532.656 1.67 7.904-.683 12 4.052 16.096-.683 23.344 1.67 23.967 7.545z">
			</path>
			</svg>
						</div> <strong>관심 코디</strong>
					</a>
				</div>

				<div class="short-cut__item">
					<a href="<%=cp%>/myPage/myInstarLists.action">
						<div class="short-cut__icon">
							<svg width="24" height="24" viewBox="0 0 24 24"
								preserveAspectRatio="xMidYMid meet">
				<path fill="#000" fill-opacity=".74" fill-rule="evenodd"
									transform="matrix(1 0 0 -1 0 23.033)"
									d="M12.943 6.342a2 2 0 0 1-1.886 0L3 2.032V20.5a.5.5 0 0 0 .5.5h17a.5.5 0 0 0 .5-.5V2.033l-8.057 4.309zm-.471-.882l8.056-4.31A1 1 0 0 1 22 2.034V20.5a1.5 1.5 0 0 1-1.5 1.5h-17A1.5 1.5 0 0 1 2 20.5V2.033a1 1 0 0 1 1.472-.882l8.056 4.31a1 1 0 0 0 .944 0z">
				</path>
			</svg>
						</div> <strong>내코디</strong>
					</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 게시판 리스트 부분 -->
	<div style="width: 750px; display: inline-block; vertical-align: top;">
		<div id="filter">
			<a href="<%=cp%>/myPage/questionMypage.action?on=me" style="margin-right: 5px;" class="on" id="me">내가 한 질문</a>
			<a href="<%=cp%>/myPage/questionMypage.action?status=reply&on=other" id="other">내가 한 답변</a>
		</div>
		<c:forEach var="dto" items="${lists}" varStatus="status">

			<a class="questions-item__link"
				href="<%=cp%>/qna/questionAticle.action?qNum=${dto.qNum}">

				<article class="questions-item">
					<div class="questions-item__image">
						<div class="image-wrap square">
							<c:if test="${dto.saveFileName!=null }">
								<img src="${imagePath}/${dto.saveFileName}">
							</c:if>
						</div>
					</div>
					<h1 class="questions-item__title text-heading-5 bold text-black">${dto.qSubject }</h1>
					<p class="questions-item__content text-caption-1">${dto.qContent }</p>

					<footer class="questions-item__footer">
						<span class="questions-item__footer__author"> <span
							class="questions-item__footer__author__image"> <img
								src="${memberPath }/${dto.mImage }"
								onerror="this.src='https://bucketplace-v2-development.s3.amazonaws.com/uploads/default_images/avatar.png'">
						</span> <span
							class="questions-item__footer__author__content text-caption-1">${dto.userId }</span>
						</span> <span class="questions-item__footer__meta text-caption-1">
							<time datetime="${dto.qDate}"
								class="questions-item__footer__date text-gray">
								${dto.qDate } </time> <span
							class="questions-item__footer__comments text-gray"> 답글 <span
								class="questions-item__footer__comments__content ">
									${dto.replyCount } </span>
						</span> <span class="questions-item__footer__views text-gray"> 조회
								<span class="questions-item__footer__views__content">${dto.qHitCount }</span>
						</span>
						</span>
						<ul class="questions-item__footer__tags keyword-list">
							<li class="keyword-item questions-item__footer__tags__tag"
								role="button">${dto.qHashTag}</li>

						</ul>

					</footer>
				</article>
			</a>
		</c:forEach>
		<div
			style="text-align: center; margin-top: 25px; margin-bottom: 50px;"">
			<c:if test="${dataCount!=0 }">
				<font style="font-size: 20px">${pageIndexList}</font>
			</c:if>
		</div>
	</div>

</div>


<%@include file="../layout/footer.jsp"%>