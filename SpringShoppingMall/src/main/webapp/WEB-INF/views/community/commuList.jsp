<%@page import="com.codi.dto.MemberDTO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="../layout/commuNav.jsp"  %>

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
    text-align: center;
}

.card__action__btn, .card__action__link {
    -webkit-box-flex: 1;
    -moz-flex: 1;
    -ms-flex: 1;
    flex: 1;
    border: none;
    height: 56px;
    font-size: 12px;
    padding: 0;
    background: transparent;
    color: #424242;
    position: relative;
}

.icon--common-action {
    background-image: url(/resources/image/1410959343.PNG);
    background-size: 400px auto;
}


.text_overflow {
  overflow: hidden; 
  text-overflow: ellipsis;
  height: 45px;
}


</style>

<script type="text/javascript">


$(function(){
	
	
	$(".goodButton").click(function(){


		var iNum = $(this).attr('value');
        
        $.ajax({
            async: true,
            type : 'POST',
            data : iNum,
            url : "../codiGood.action",
            dataType : "json",
            contentType: "application/json; charset=UTF-8",
            success : function(data) {
            	if(data.temp > 0) {
            		$(".goodDiv" + iNum).html('<img src="../resources/image/heart1.PNG" style="height: 25px;"/> ' + data.count);
                } else {
            		$(".goodDiv" + iNum).html('<img src="../resources/image/heart2.PNG" style="height: 25px;"/> ' + data.count);
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

<div class="container2">

<c:set var="i" value="0" />

<c:forEach var="dto" items="${lists }">

<c:if test="${i==0 }">
	<div style="display: block;" >
	<c:set var="j" value="0" />
</c:if>

<div style="width: 280px; height: 450px; display: inline-block;">
<div style="position: relative;  text-align: left;">
	<a href="/users/2324110">
		<img style="border:1px solid #F6F6F6; width: 36px; height: 36px; border-radius: 18px; display: inline-block;" src="../upload/profile/${dto.mImage }"/>
	</a>
	<p style="margin-left:10px; margin-bottom:5px; display: inline-block; vertical-align:bottom;">
		<a href="#">
			<strong>${dto.userId }</strong>
		</a>
		
		<strong>&nbsp;・&nbsp;</strong>
		<button class="followButton" value="${dto.userId}"style="color: #C98AFF; padding: 0; font-weight: 700; padding-bottom: 4px;" type="button">
			<div class="followDiv${dto.userId}">
				<c:set var="k" value="0" />
				<c:forEach var="follow" items="${follow }">
					<c:if test="${dto.userId eq follow}">
						팔로우 취소
						<c:set var="k" value="1" />
					</c:if>
				</c:forEach>
				<c:if test="${k==0 }">
					팔로우
				</c:if>
			</div>
		</button>
		
		<a href="/users/820291"><br>
			<small>${dto.mMessage }</small>
		</a>
	</p>
	
	<div style="width: 260px;" >
	<a href="<%=cp%>/pr/codiDetailList.action?iNum=${dto.iNum}">
		<img style="border:1px solid #C2C2C2; border-radius:15px; width: 256px; height: 236px; margin-left:2px; margin-top:5px; margin-bottom:5px; display: inline-block;" src="../upload/makecodi/${dto.iImage }.png"/>
	</a>
	</div>

	
	<div style="display: flex; border:1px solid #C2C2C2; width: 260px; border-bottom: none; border-top-left-radius: 15px; border-top-right-radius: 15px;">
		<button class="goodButton" value="${dto.iNum}" style="margin-left: 5px; height: 40px;">
			<div class="goodDiv${dto.iNum}">
				<c:set var="k" value="0" />
				<c:forEach var="good" items="${good }">
					<c:if test="${dto.iNum eq good}">
						<img src="../resources/image/heart2.PNG" style="height: 25px;"/>
						<c:set var="k" value="1" />
					</c:if>
				</c:forEach>
				<c:if test="${k==0 }">
					<img src="../resources/image/heart1.PNG" style="height: 25px;"/>
				</c:if>
				${dto.heartCount }
			</div>
		</button>
		
		<button class="card__action__btn" type="button" style="text-align: left; margin-left: 10px; height: 40px;">
		<img src="../resources/image/reply.PNG" style="width: 30px;"/>
		3
		</button>
	</div>
	
	<div class="text_overflow" style="border:1px solid #C2C2C2;  width: 260px; border-top:none; border-bottom-right-radius: 15px; border-bottom-left-radius: 15px; " >
		<span style="margin: 5px;">
		${dto.iContent}
		</span>
	</div>
</div>
</div>
<!-- end 하나 이미지 -->

<c:set var="j" value="${j+1 }" /> 
<c:set var="i" value="1" />

<c:if test="${j==4 }">
	</div>
	<c:set var="j" value="0" />
	<c:set var="i" value="0" />
</c:if>

</c:forEach>

<c:if test="${j!=4 and j!=0}">
	<c:forEach begin="${j }" end="3" step="1">
		<div style="width: 280px; display: inline-block; "></div>
		<c:set var="j" value="${j+1 }" />
	</c:forEach>
	</div>
</c:if>

<div style="height:100px;">
	<c:if test="${dataCount!=0 }">
		<font style="font-size: 20px">${pageIndexList}</font>
	</c:if> 
	<c:if test="${dataCount==0 }">
		등록된 게시물이 없습니다.
	</c:if>
</div>

<%@include file="../layout/footer.jsp"  %>