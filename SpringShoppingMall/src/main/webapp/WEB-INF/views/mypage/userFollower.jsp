<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="../layout/top.jsp"  %>
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

.page-navigation__item{
    display: block;
    padding: 0 10px;
    font-weight: bold;
    height: 60px;
    line-height: 60px;
    transition: color .15s ease;
    font-size: 13px;
    display: inline-block; 
    position: relative;
}

#empty_message {
    margin: 30px 0 50px;
    font-size: 14px;
    color: #757575;
    text-align: center;
}

#content3 {
    max-width: 1030px;
    width: 100%;
    min-height: 170px;
    margin: 30px auto;
    background-color: #ffffff;
    box-sizing: border-box;
    box-shadow: 0 1px 3px 0 rgba(0,0,0,0.2);
    overflow: hidden;
    padding: 40px 50px 50px;
    color: #424242;
}

#content3>.title {
    font-size: 24px;
    font-weight: 700;
    padding: 0 0 20px;
}

.user {
    overflow: hidden;
    padding: 30px 0;
    border-top: solid 1px #dcdcdc;
}

.name {
    font-size: 15px;
    font-weight: 700;
    line-height: 30px;
    display: inline-block;
}

</style>

<div class="container2">

<div style="width: 336px; margin-right:50px; display: inline-block; vertical-align: top;">

<div style="display: block; ">
	<div class="profile-image" >
	<img alt="" src="../upload/profile/${userInfo.mImage }" style="border-radius: 100%;">
	</div>
	
	<div style="border-bottom: 1px solid #ebebeb; margin-bottom: 20px; margin-top: 20px;"  ></div>
	
	<div class="profile-info__name"><strong>${userInfo.userId }</strong></div>
	
	<div style="color: #bdbdbd; font-size: 13px;">
		<a href="<%=cp %>/myPage/follower.action" style="display: inline-block; margin-left: 10px; ">팔로워 ${follower}</a>&nbsp;&nbsp;&nbsp;
		<a href="<%=cp %>/myPage/following.action" style="display: inline-block;">팔로잉 ${following}</a>
	</div>
	
	<div style="border-bottom: 1px solid #ebebeb; margin-bottom: 20px; margin-top: 20px;"  ></div>
	
</div>

</div>





<div style="width: 750px; display: inline-block; vertical-align: top;">

<div style="width: 100%; overflow: visible; border-bottom: solid 1px #dbdbdb; text-align: center;">
	<ul>
		<li class="page-navigation__item" style=" color: #8080FF"><a href="<%=cp %>/pr/userFollower.action?userId=${userId }">팔로워<div style="height: 4px; background-color: #8080FF"/></div></a></li>
		<li class="page-navigation__item"><a href="<%=cp %>/pr/userFollowing.action?userId=${userId }">팔로잉</a></li>
	</ul>
</div>

<div id="content3">
	<div class="title">팔로워</div>
	<div>
	
		<c:if test="${empty lists}">
			<div id="empty_message">팔로워한 사용자가 없습니다.</div>
		</c:if>
		
		<c:forEach var="dto" items="${lists }">
		<div class="user">
			<a href="<%=cp %>/pr/userPage.action?userId=${dto.userId}">
				<img style="border:1px solid #F6F6F6; width: 36px; height: 36px; border-radius: 18px; display: inline-block;" src="../upload/profile/${dto.mImage}"/>
				<span class="name">${dto.userId}</span>
			</a>
		</div>
		</c:forEach>

	</div>
</div>

<div style="height:100px; text-align: center;">
	<c:if test="${dataCount!=0 }">
		<font style="font-size: 20px">${pageIndexList}</font>
	</c:if> 
	<c:if test="${dataCount==0 }">
		등록된 게시물이 없습니다.
	</c:if>
</div>

</div>


<%@include file="../layout/footer.jsp"  %>