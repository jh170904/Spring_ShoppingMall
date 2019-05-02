<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="../layout/top3.jsp"  %>
<%@include file="../layout/mypage.jsp"  %>

<style>
.container2 {
    margin-right: auto;
    margin-left: auto;
    box-sizing: border-box;
    width: 1136px;
    max-width: 100%;
    box-sizing: border-box;
    min-height: 600px;
    padding-top: 50px;
}

.post__title {
    color: #000;
    font-weight: 700;
    position: relative;
    margin-bottom: 20px;
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
    padding: 80px 0;
    border: 1px dashed #dbdbdb;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    color: #757575;
    font-weight: 700;
    font-size: 13px;
}

.profile-image {
    top: 20px;
    width: 250px;
    height: 250px;
    margin: auto;
}

.profile-info__name {
    font-size: 30px;
    line-height: 40px;
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
	width: 90px;
	text-align: center;
}

</style>

<div class="container2">

<div style="width: 336px; display: inline-block; vertical-align: top;">

<div style="display: block; ">
	<div class="profile-image" >
	<img alt="" src="../upload/list/1806576130.jpg" style="border-radius: 100%;">
	</div>
	
	<div class="profile-info__name"><strong>${userId }</strong></div>
	
	<div style="color: #bdbdbd; font-size: 13px;">
		<a href="/users/1527075/follower" style="display: inline-block; ">팔로워 <!-- -->0</a>&nbsp;&nbsp;&nbsp;
		<a href="/users/1527075/followee" style="display: inline-block; ">팔로잉 <!-- -->0</a>
	</div>
	
	<div style="margin-top:20px;">
		<div class="short-cut__item">
		<a href="<%=cp %>/myPage/storeGood.action">
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

<div style="margin-bottom: 60px; position: relative;">
<h5 class="post__title">내코디 <strong>0</strong></h5>
<a href="/projects/write" class="post--projects__upload post__upload">
첫 번째 집들이를 올려보세요
</a>
</div>

<div style="margin-bottom: 60px; position: relative;">
<h5 class="post__title">집들이 <strong>0</strong></h5>
<a href="/projects/write" class="post--projects__upload post__upload">
첫 번째 집들이를 올려보세요
</a>
</div>

<div>



</div>
</div>


</div>


<%@include file="../layout/footer.jsp"  %>