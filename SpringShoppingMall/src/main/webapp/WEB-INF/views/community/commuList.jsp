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


		var superProduct = $(this).attr('value');


        var info = '<%=(MemberDTO)session.getAttribute("customInfo")%>';
        
        if(info=="" || info==null){
        	alert("ㅅㅂ로그인이 필요합니다.");
           	alert(id);
        	return;
        }
        
        
        
        $.ajax({
            async: true,
            type : 'POST',
            data : superProduct,
            url : "../good.action",
            dataType : "json",
            contentType: "application/json; charset=UTF-8",
            success : function(data) {
            	if(data.cnt > 0) {
            		$(".goodDiv" + superProduct).html('♡');
                } else {
            		$(".goodDiv" + superProduct).html('♥');
                }
                
            },
            error : function(error) {
            	alert("로그인이 필요합니다.");
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
		<img style="border:1px solid #F6F6F6; width: 36px; height: 36px; border-radius: 18px; display: inline-block;" src="../upload/instar/${dto.iImage }"/>
	</a>
	<p style="margin-left:10px; margin-bottom:5px; display: inline-block; vertical-align:bottom;">
		<a href="#">
			<strong>${dto.userId }</strong>
		</a>
		
		<strong>&nbsp;・&nbsp;</strong>
		<button style="color: #C98AFF; padding: 0; font-weight: 700; padding-bottom: 4px;" type="button">팔로우</button>
		
		<a href="/users/820291"><br>
			<small>honeyflamingo.kr</small>
		</a>
	</p>
	
	<a href="<%=cp%>/pr/instarView.action?iNum=${dto.iNum}">
		<img style="border:1px solid #F6F6F6; width: 266px; height: 266px; border-radius: 18px; margin-top:10px; display: inline-block;" src="../upload/instar/${dto.iImage }"/>
	</a>
	
	<div style="display: flex;">
		<button class="goodButton" value="${dto.iNum}">
		<img src="../resources/image/heart.PNG" style="background-position: width: 30px; height: 30px;"/>
		1
		</button>
		<button class="card__action__btn" type="button">
		<img src="../resources/image/scrap.PNG" style="background-position: width: 30px; height: 30px;"/>
		2
		</button>
		<button class="card__action__btn" type="button">
		<img src="../resources/image/reply.PNG" style="background-position: width: 30px; height: 30px;"/>
		3
		</button>
	</div>
	
	<div class="text_overflow">
	${dto.iContent}
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


<%@include file="../layout/footer.jsp"  %>