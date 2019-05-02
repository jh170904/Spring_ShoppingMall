<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp1 = request.getContextPath();	
%>

<style>

.myPageCategory{
	width: 1200px; 
	margin-left: auto; 
	margin-right: auto;
	margin-top: 20px;
}

#myPageMenu {
	height:60px;  
	margin-left: auto; 
	margin-right: auto;
}

.myPageCategory ul li {
	list-style:none;
	float:left;
	color:#000000;
	line-height:30px;
	vertical-align:middle;
	text-align:center;
	
}

.myPageCategory .menuLink {
	text-decoration:none;
	display:block; 
	width:120px;
	font-size:16px;
}

.myPageCategory .menuLink:hover { 
	color:#8080ff;
	font-weight: bold; 
	
}

.myPageMenuCategory{
	height:60px;  
	margin-left: auto; 
	margin-right: auto;
}
</style>

<script>
	$(document).ready( function(){
    	  
    	  var f = location.pathname;
          var url = f.split('/');
          var option = url[2];          

    	  var x = document.getElementById(eval("'" + option + "'"));
    	  var y = document.getElementById(eval("'" + option + "_category'"));
    	  
    	  x.style.color="#8080ff";
    	  x.style.fontWeight="bold";
    	  
    	  y.style.display="block"
    	      	  
	 });
	
</script>

<div class="myPageCategory">
	<nav id="myPageMenu" > 
		<ul> 
			<li>
				<a class="menuLink" href="<%=cp1%>/myPage/myPageMain.action" id="myPage">프로필</a>
			</li> 
			<li>
				<a class="menuLink" href="<%=cp1%>/order/myOrderLists.action" id="order">나의쇼핑</a>
			</li> 
			
			<li>
				<a class="menuLink" href="<%=cp1%>/review/reviewList.action" id="review">나의 리뷰</a>
			</li> 
			
			<li>
				<a class="menuLink" href="<%=cp1%>/dest/destlist.action" id="dest">배송지 관리</a>
			</li>
			
			<li>
				<a class="menuLink" href="#">설정</a>
			</li> 
			 
		</ul> 
	</nav>
	
	<nav name="myPageMenuCategory" id="myPage_category" style="display: none;"> 
		<ul> 
			<li>
				<a class="menuLink" href="#">모두보기</a>
			</li> 
			<li>
				<a class="menuLink" href="#">사진</a>
			</li> 
			
			<li>
				<a class="menuLink" href="#">질문과답변</a>
			</li> 
			
			<li>
				<a class="menuLink" href="#">스크랩북</a>
			</li>
			
			<li>
				<a class="menuLink" href="#">좋아요</a>
			</li> 
			
			<li>
				<a class="menuLink" href="#">나의활동</a>
			</li> 
			 
		</ul> 
	</nav>
	
	<nav name="myPageMenuCategory" id="order_category" style="display: none;"> 
		<ul> 
			<li>
				<a class="menuLink" href="#">주문배송내역 조회</a>
			</li> 
			<li>
				<a class="menuLink" href="#">제품 스크랩북</a>
			</li> 
			
			<li>
				<a class="menuLink" href="#">삼품문의내역</a>
			</li> 
			
			<li>
				<a class="menuLink" href="#">포인트</a>
			</li>
			
			<li>
				<a class="menuLink" href="#">고객센터</a>
			</li> 
		</ul> 
	</nav>
	
	<nav name="myPageMenuCategory" id="review_category" style="display: none;"> 
		<ul> 
			<li>
				<a class="menuLink" href="#">내가 작성한 리뷰</a>
			</li> 
			<li>
				<a class="menuLink" href="#">리뷰쓰기</a>
			</li> 			 
		</ul> 
	</nav>
	
	<nav name="myPageMenuCategory" id="dest_category" style="display: none;"> 
		<ul> 
			<li>
				<a class="menuLink" href="#">배송지 관리</a>
			</li> 		 
		</ul> 
	</nav>
		
</div>
