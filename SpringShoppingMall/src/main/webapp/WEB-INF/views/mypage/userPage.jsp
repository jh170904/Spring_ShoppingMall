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

.instarDiv {
	position: absolute; 
	width: 170px; 
	height: 146px; 
	top: 34px; 
	left: 531px; 
	border-radius: 7px; 
	background-color: rgba( 0, 0, 0, 0.3 );
}

.heartDiv {
	position: absolute; 
	width: 170px; 
	height: 146px; 
	top: 35px; 
	left: 531px; 
	border-radius: 7px; 
	background-color: rgba( 0, 0, 0, 0.3 );
}

.instarDivP {
	font-size: 40px; 
	color: #ffffff; 
	height: 148px; 
	text-shadow: 2px 2px 6px #000000; 
	text-align: center; 
	line-height:148px; 
	font-weight: bold; 
}

</style>

<div class="container2">

<div style="width: 336px; margin-right:50px; display: inline-block; vertical-align: top;">

<div style="display: block; ">
	<div class="profile-image" >
	<img alt="" src="${memberPath }/${memberInfo.mImage }" style="border-radius: 100%;">
	</div>
	
	
	<div style="border-bottom: 1px solid #ebebeb; margin-bottom: 20px; margin-top: 20px;"  ></div>
	
	<div class="profile-info__name"><strong>${userId }</strong></div>
	
	<div style="color: #bdbdbd; font-size: 13px;">
		<a href="<%=cp %>/pr/userFollower.action?userId=${userId }" style="display: inline-block; margin-left: 10px; ">팔로워 ${follower}</a>&nbsp;&nbsp;&nbsp;
		<a href="<%=cp %>/pr/userFollowing.action?userId=${userId }" style="display: inline-block; ">팔로잉 ${following}</a>
	</div>
	
	<div style="border-bottom: 1px solid #ebebeb; margin-bottom: 20px; margin-top: 20px;"  ></div>
	
</div>

</div>




<div style="width: 750px; display: inline-block; vertical-align: top;">

	<div align="center" style="font-size: 30px; color:black; margin: 20px; padding-bottom: 20px; border-bottom: 1px solid black; "><h2>${userId }의 코디</h2></div>

	<c:if test="${empty instarList }">
		<div  class="post__upload">
			아직 포스팅이 없습니다.
		</div>
	</c:if>
	
	<c:if test="${!empty instarList }">
	<%int cnt = 0;%>
	<c:forEach var="dto" items="${instarList }">

	<%
		if (cnt == 0) {
			out.print("<dl>");
		}
	%>
	<dd style="display: inline-block; margin-right: 5px; margin-bottom: 30px;">
	<a href="<%=cp%>/pr/codiDetailList.action?iNum=${dto.iNum}">
		<img alt="" src="${imagePath }/${dto.iImage}.png" width="240" height="220" style="border:1px solid #d4d4d4; border-radius: 7px;"><br/>
		<p align="left" style="display:inline-block; font-size: 15px; width: 210px; margin-top: 8px; height:23px; overflow: hidden; ">${dto.iSubject }</p>
	</a>
	</dd>


	<%cnt++;%>
	
	<%
		if (cnt == 3) {
			out.print("</dl>");
			cnt = 0;
		}
	%>
	</c:forEach>
	</c:if>
	
	<div style="text-align: center; margin-top: 25px; margin-bottom: 50px;">
		<c:if test="${dataCount!=0 }">
			<font style="font-size: 20px">${pageIndexList}</font>
		</c:if>
	</div>	
</div>


</div>


<%@include file="../layout/footer.jsp"  %>