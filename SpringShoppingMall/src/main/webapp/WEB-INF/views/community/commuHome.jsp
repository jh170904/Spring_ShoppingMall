<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="../layout/top.jsp"  %>

<style>

.home-header {
    padding: 30px 0 0;
}

.btn_commu_main {
	font-size: 19px;
	min-width: 140px;
	height: 50px;
	font-weight: bold;
	border: 1px solid #000000;
	color: #000000;
}

.today_codi {
	font-size: 20px;
	color: #000000;
	font-weight: bold;
	margin-bottom: 20px;

}

.myFollowNews {
	border: 1px dotted #5d5d5d; 
	border-radius : 10px;
	padding: 100px; 
	text-align: center; 
	font-size: 20px;
	font-weight: bold;
}

.scale {
  width : 100%;
  height : 656px;
  overflow: hidden;
  display: inline-block;
  position: relative;
}


.scale img {
	width : 100%;
 	height : 100%;
 	transform: scale(1);
    -webkit-transform: scale(1);
    -moz-transform: scale(1);
    -ms-transform: scale(1);
    -o-transform: scale(1);
    transition: all 0.3s ease-in-out;   /* 부드러운 모션을 위해 추가*/
 	
}

.scale img:hover {
	transform: scale(1.1);
	-webkit-transform: scale(1.1);
	-moz-transform: scale(1.1);
	-ms-transform: scale(1.1);
	-o-transform: scale(1.1);
}

.todayScale{
	width : 280px;
	height : 255px;
	overflow: hidden;
}

.todayScale img{
	width: 280px;
	height: 255px;
	transform: scale(1);
    -webkit-transform: scale(1);
    -moz-transform: scale(1);
    -ms-transform: scale(1);
    -o-transform: scale(1);
    transition: all 0.3s ease-in-out;   /* 부드러운 모션을 위해 추가*/
}

.todayScale img:hover {
	transform: scale(1.1);
	-webkit-transform: scale(1.1);
	-moz-transform: scale(1.1);
	-ms-transform: scale(1.1);
	-o-transform: scale(1.1);
}

.eventScale {
	width: 380px;
	height: 238px;
	overflow: hidden;
}

.eventImg {
	width: 380px;
	height: 238px;
	transform: scale(1);
    -webkit-transform: scale(1);
    -moz-transform: scale(1);
    -ms-transform: scale(1);
    -o-transform: scale(1);
    transition: all 0.3s ease-in-out;   /* 부드러운 모션을 위해 추가*/
}

.eventImg:hover {
	transform: scale(1.1);
	-webkit-transform: scale(1.1);
	-moz-transform: scale(1.1);
	-ms-transform: scale(1.1);
	-o-transform: scale(1.1);
}

.event{
	font-size: 16px;
	color: #000000;
	margin-top: 10px;
}

</style>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script>

	$(document).ready(function() {
		$('.commu_main_slider').bxSlider({
			auto : true,
			speed : 500,
			pause : 4000,
			mode : 'fade',
			autoControls : true,
			pager : true,
			controls : false,
		});
	});

</script>

<div class="ap_container home-header" style="width: 1250px; margin: auto; margin-bottom: 50px;">
	<div>
		<dl>
			<dt style="width: 60%; height:656px; display: inline-block; position: relative;">
				<div class="scale effect" style="border-radius:10px;">
					<img src="${imagePath }/${commuMain.iImage}.png">
				</div>
				<img src="../upload/profile/${commuMain.mImage }" width="40px"; height="40px;" style="border-radius:50px; position: absolute; top: 520px; left: 50px;">
				<p style="position: absolute; top: 460px; left: 55px; font-size: 40px; color: #000000;">${commuMain.iSubject }</p>
				<p style="position: absolute; top: 532px; left: 97px; color: #000000;">${commuMain.userId }</p>
				<button class="btn_commu_main" style="position: absolute; top: 530px; left: 550px;" onclick="location.href='<%=cp%>/pr/codiDetailList.action?iNum=${commuMain.iNum}';">보러가기</button>
			</dt>
		
			<dt style="width:37%; height:656px; display: inline-block; vertical-align: top;">
				<div>
					<ul class="commu_main_slider">
						<li>
							<a href="#"><img src="../resources/image/commuImage/none1.jpg" style="height: 320px; width:460px; border-radius: 10px;"></a><br/>
							<a href="#"><img src="../resources/image/commuImage/none2.jpg" style="height: 320px; width:460px; border-radius: 10px;"></a>
						</li>
						<li>
							<a href="#"><img src="../resources/image/commuImage/none3.jpg" style="height: 320px; width:460px; border-radius: 10px;"></a><br/>
							<a href="#"><img src="../resources/image/commuImage/none4.jpg" style="height: 320px; width:460px; border-radius: 10px;"></a>
						</li>		
					</ul>
				</div>
			</dt>
		</dl>
	</div>
	
	<div>

	
	</div>
	
	<div style="margin-top: 50px;">
		
		<div class="today_codi">오늘의 코디</div>
		
		<div>
			<%int cnt = 0; int flag = 1;%>
			<c:forEach var="dto" items="${todayCodi }">
		
			<%
				if (cnt == 0) {
					out.print("<dl>");
				}
			%>
			<div style="display: inline-block; margin-right: 25px; margin-bottom: 30px;  position: relative;">
			<a href="<%=cp%>/pr/codiDetailList.action?iNum=${dto.iNum}">
				<div class="todayScale" style="border:1px solid #d4d4d4;">
					<img alt="" src="${imagePath }/${dto.iImage}.png"><br/>
				</div>
				<%
					if(flag<4){
				%>
				<div style="position: absolute; top: 0px;">
					<img src="../resources/image/commuImage/gold-medal.png" width="50px" height="55px">
				</div>
				<div style="position: absolute; left: 21px; top: 25px; font-size: 17px; font-weight: bolder; color: #000000">
					<%=flag %>
				</div>
				<% }%>
				
				<div style="margin-bottom: 5px; background:none; position: absolute; top:215px; left: 10px;">
					<img style="border:1px solid #F6F6F6; width: 24px; height: 24px; border-radius: 18px; display: inline-block;" src="../upload/profile/${dto.mImage }"/>
					<p style="margin-left:7px; margin-bottom:5px; display: inline-block; vertical-align:middle;">
						<strong>${dto.userId }</strong>
					</p>
				</div>
			</a>
			</div>
		
		
			<%cnt++; flag++;%>
			
			<%
				if (cnt == 4) {
					out.print("</dl>");
					cnt = 0;
				}
			%>
			</c:forEach>

		</div>
	</div>
	
	<div style="margin-top: 50px;">
		
		<div class="today_codi">오늘의 코디기획전</div>
		
		<div>
		
			<div style="display: inline-block; margin-right: 25px; margin-bottom: 30px;  position: relative;">
				<div class="eventScale" >
					<img class="eventImg" src="../resources/image/commuImage/event1.jpg">
				</div>
				<p class="event">#업타운홀릭 #심플베이직 #데일리 #20대 #30대</p>
			</div>
			
			<div style="display: inline-block; margin-right: 25px; margin-bottom: 30px;  position: relative;">
				<div class="eventScale" >
					<img class="eventImg" src="../resources/image/commuImage/event2.jpg">
				</div>
				<p class="event">#투데이미 #심플베이직 #로맨틱 #10대 #20대</p>
			</div>
			
			<div style="display: inline-block; margin-right: 25px; margin-bottom: 30px;  position: relative;">
				<div class="eventScale" >
					<img class="eventImg" src="../resources/image/commuImage/event3.jpg">
				</div>
				<p class="event">#여름 #summer #데일리 #20대 #30대</p>
			</div>

		</div>
		
	</div>
	
	<div style="margin-top: 50px;">
		
		<div class="today_codi">팔로우 이웃의 소식</div>
		
		<div>
			<c:if test="${!empty followNews}">
				<%cnt = 0;%>
				<c:forEach var="dto" items="${followNews }">
			
				<%
					if (cnt == 0) {
						out.print("<dl>");
					}
				%>
				<div style="display: inline-block; margin-right: 25px; margin-bottom: 30px;">
				<a href="<%=cp%>/pr/codiDetailList.action?iNum=${dto.iNum}">
				
					<div style="margin-bottom: 5px;">
						<img style="border:1px solid #F6F6F6; width: 36px; height: 36px; border-radius: 18px; display: inline-block;" src="../upload/profile/${dto.mImage }"/>
						<p style="margin-left:10px; margin-bottom:5px; display: inline-block; vertical-align:top;">
							<strong>${dto.myFriendId }</strong><br/>
							<small>${dto.mMessage }</small>
						</p>
					</div>
					<img alt="" src="${imagePath }/${dto.iImage}.png" width="280" height="255" style="border:1px solid #d4d4d4; border-radius: 15px;"><br/>
					<p align="left" style="font-size: 15px; margin-top: 5px;">${dto.iSubject }</p>
				</a>
				</div>
			
			
				<%cnt++;%>
				
				<%
					if (cnt == 4) {
						out.print("</dl>");
						cnt = 0;
					}
				%>
				</c:forEach>
			</c:if>
				
			<c:if test="${empty followNews}">
				<c:if test="${myId ne '' }">
					<div class="myFollowNews">팔로우 한 유저의 최근 소식이 없습니다.</div>
				</c:if>
				
				<c:if test="${myId eq '' }">
					<a href="<%=cp%>/mem/login.action">
						<div class="myFollowNews">로그인시 사용 가능합니다.</div>
					</a>					
				</c:if>
			</c:if>
			

		</div>
	</div>
	
</div>


<%@include file="../layout/footer.jsp"  %>