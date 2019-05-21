<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp1 = request.getContextPath();	
%>

<style>

.myPageCategory{ 
	width : 100%;
	margin-left: auto; 
	margin-right: auto;
	background-color: #eeeeee;
	/* margin-top: 20px; */
}

#myPage_category{ 
	width : 800px;
	height:50px;
	margin-left: auto; 
	margin-right: auto;
	margin-top: 5px;
}

#con_category{ 
	width : 260px;
	height:50px;
	margin-left: auto; 
	margin-right: auto;
	margin-top: 20px;
}

#myPageMenu {
	width: 1200px;
	height:50px;  
	margin-left: auto; 
	margin-right: auto;
	text-align:center;
	vertical-align: middle;

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
	width:130px;
	font-size:16px;
}

.myPageCategory .menuLink:hover { 
	color:#8080ff;
	font-weight: bold; 
	
}

.myPageMenuCategory {
	height:50px;  
	width:1000px;
	margin-left: auto; 
	margin-right: auto;
	text-align:center;
}

.myPageCategory2 ul li {
	list-style:none;
	float:left;
	color:#000000;
	line-height:30px;
	width: 130px;
	vertical-align:middle;
	text-align:center;	
}

.myPageCategory2 .menuLink {
	text-decoration:none;
	display:block; 
	width:100px;
	font-size:16px;

}

.myPageCategory2 .menuLink:hover { 
	color:#8080ff;
	font-weight: bold; 
	
}

</style>

<script>
	$(document).ready( function(){
    	  
    	  var f = location.pathname;
          var url = f.split('/');
          var option = url[2];
          var option2 = url[3];
          var mypage = url[3]; 

          if(option=='codi'){
    		  option = 'myPage';
    	  }
          
    	  var x = document.getElementById(eval("'" + option + "'"));
    	  
    	  var y = document.getElementById(eval("'" + option + "_category'"));
    	  var z = document.getElementById(eval("'" + option2 + "'"));
    	  
    	  x.style.color="#8080ff";
    	  x.style.fontWeight="bold";
    	  
    	  y.style.display="block";
    	  if(mypage=='update.action'){
        	 y.style.display="none";
          }
    	  
    	  z.style.color="#8080ff";
    	  z.style.fontWeight="bold";   
    	  z.style.paddingBottom="10px";
    	  z.style.borderBottom="3px solid #8080ff";
    	  
	 });
	
</script>

<div class="myPageCategory">
	<nav id="myPageMenu" style="border-bottom: 1px solid #ebebeb;" > 
		<ul> 
			<li>
				<a class="menuLink" href="<%=cp1%>/myPage/myPageMain.action" id="myPage">프로필</a>
			</li> 
			<li>
				<a class="menuLink" href="<%=cp1%>/order/myOrderLists.action" id="order">주문/배송조회</a>
			</li> 
			
			<li>
				<a class="menuLink" href="<%=cp1%>/review/reviewList.action" id="review">나의 리뷰</a>
			</li> 
			
			<li>
				<a class="menuLink" href="<%=cp1%>/coupon/myCouponList.action" id="coupon">나의 쿠폰</a>
			</li> 
			
			<li>
				<a class="menuLink" href="<%=cp1%>/dest/destlist.action" id="dest">배송지 관리</a>
			</li>
			
			<li>
				<a class="menuLink" href="<%=cp1%>/con/update.action" id="con">개인정보 수정</a>
			</li> 
			 
		</ul> 
	</nav>
</div>


<div class="myPageCategory2" name="myPageMenuCategory" id="myPage_category" style="display: none;">
	<nav> 
		<ul> 
			<li>
				<a class="menuLink" href="<%=cp1%>/myPage/myPageMain.action" id="myPageMain.action">모두보기</a>
			</li> 
			
			<li>
				<a class="menuLink" href="#" id="">질문과답변</a>
			</li> 
			
			<li>
				<a class="menuLink" href="<%=cp1%>/myPage/myInstarLists.action" id="myInstarLists.action">내코디</a>
			</li> 
						
			<li>
				<a class="menuLink" href="<%=cp1%>/codi/codicreated.action" id="codicreated.action">코디 올리기</a>
			</li> 
			
			<li>
				<a class="menuLink" href="<%=cp1%>/myPage/myStoreHeartLists.action" id="myStoreHeartLists.action">관심상품</a>
			</li>
			
			<li>
				<a class="menuLink" href="<%=cp1%>/myPage/myCodiHeartists.action" id="myCodiHeartists.action">관심코디</a>
			</li> 
			 
		</ul> 
	</nav>
</div>		

<div class="myPageCategory2" name="myPageMenuCategory" id="con_category" style="display: none;">
	<nav> 
		<ul> 
			<li>
				<a class="menuLink" href="<%=cp1%>/con/update_ok.action" id="update_ok.action">회원 정보 수정</a>
			</li> 
			<li>
				<a class="menuLink" href="<%=cp1%>/con/update_ok_pwd.action" id="update_ok_pwd.action">비밀번호 수정</a>
			</li> 			 
		</ul> 
	</nav>
</div>		


<div style="border-bottom: 1px solid #ebebeb;"  ></div>


