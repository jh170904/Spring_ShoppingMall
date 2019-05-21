<%@ page contentType="text/html; charset=UTF-8"%>

<%@include file="../layout/top.jsp"%>

<style>
select {
border: 1px solid #999;
font-family: inherit;
background: url('<%=cp%>/resources/images/question/sort-down.png') no-repeat 95% 50%;
border-radius: 0px;
}
</style>

<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/bucket.css?ver=2">
<script type="text/javascript" src="<%=cp%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

$(function(){
	
	var orderStd='${orderStd}';
	if(orderStd=='hit'){
		$("#selectBox").val("인기순").prop("selected", true);
	}
	else{
		$("#selectBox").val("최신순").prop("selected", true);
	}
	
}); 
</script>


<div class="questions-filter__float sticky-content open"
	data-sticky-enabled="false" style="position: relative;" data-offset="131.979166">
	<div class="questions-filter__content container">
		<div class="questions-filter__filters">
			<div class="filter-select" id="questions-filter-sort"
				data-modal-id="questions-filter-sort-modal">
				<dl class="filter-select__header" role="button">
					<dt class="filter-select__header__name">
						정렬<span class="icon icon-pointer-angle-down-dark-sm"></span>
					</dt>
					<dd class="filter-select__header__value">
						<select id="selectBox" name="selectBox" style="width: 100px;">
							<option onclick="javascript:location.href='${listUrl}?order=qNum desc&orderStd=new&${notyet }';" value="최신순">최신순</option>
							<option onclick="javascript:location.href='${listUrl}?order=qHitCount desc&orderStd=hit&${notyet }';" value="인기순" >인기순</option>
						</select>
					</dd>
					
				</dl>
			</div>
		</div>
		<div class="questions-filter__actions">
			<a class="set-reply btn btn-normal btn-sm"
				href="<%=cp%>/qna/questionMain.action"> 전체 게시글 보기 </a>
			<a class="set-reply btn btn-normal btn-sm"
				href="<%=cp%>/qna/questionMain.action?status=notyet"> 답변을 기다리는 질문 </a> <a
				class="questions-filter__actions__new-question btn btn-priority btn-sm"
				href="<%=cp%>/ques/questionCreated.action">질문하기</a>
		</div>
	</div>
</div>

<section id="questions-list" class="container">
	<c:forEach var="dto" items="${lists}" varStatus="status">
	
	<a class="questions-item__link"
		href="<%=cp%>/qna/questionAticle.action?qNum=${dto.qNum}">
		<article class="questions-item">
			<div class="questions-item__image">
				<div class="image-wrap square">
					<c:if test="${dto.saveFileName!=null }">
					<img
						src="${imagePath}/${dto.saveFileName}">
					</c:if>
				</div>
			</div>
			<h1 class="questions-item__title text-heading-5 bold text-black">${dto.qSubject }</h1>
			<p class="questions-item__content text-caption-1">${dto.qContent }</p>
			
			<footer class="questions-item__footer">
				<span class="questions-item__footer__author"> <span
					class="questions-item__footer__author__image"> 
					<img src="${memberPath }/${dto.mImage }"
						onerror="this.src='https://bucketplace-v2-development.s3.amazonaws.com/uploads/default_images/avatar.png'">
				</span> 
				<span class="questions-item__footer__author__content text-caption-1">${dto.userId }</span>
				</span> <span class="questions-item__footer__meta text-caption-1"> <time
						datetime="${dto.qDate}"
						class="questions-item__footer__date text-gray"> ${dto.qDate } </time>
						<span class="questions-item__footer__comments text-gray">
		                답글
		                <span class="questions-item__footer__comments__content ">
		                 ${dto.replyCount }
		                </span>
		              	</span>
						<span class="questions-item__footer__views text-gray"> 조회 <span
						class="questions-item__footer__views__content">${dto.qHitCount }</span>
				</span>
				</span>
				<ul class="questions-item__footer__tags keyword-list">
				<li class="keyword-item questions-item__footer__tags__tag" role="button">${dto.qHashTag}</li>

				</ul>
				
			</footer>
		</article>
	</a>
	</c:forEach>
</section>

	<div style="text-align: center; margin-top: 25px; margin-bottom: 50px;"">
		<c:if test="${dataCount!=0 }">
			<font style="font-size: 20px">${pageIndexList}</font>
		</c:if>
	</div>


<%@include file="../layout/footer.jsp"%>