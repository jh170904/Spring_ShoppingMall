<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../layout/top.jsp"%>

<%
	request.setCharacterEncoding("UTF-8");

	//아이디 저장(쿠키)
	Cookie[] cookies = request.getCookies();
	String id = "";

	if (cookies != null) {
		for (Cookie c : cookies) {

			if (c.getName().indexOf("userId") != -1) {
				//out.print("cookie name : " + c.getName() + "<br>");
				id = URLDecoder.decode(c.getValue(), "UTF-8");
				//System.out.println(c.getValue());
			}
		}
	}
%>


<script type="text/javascript">
function sendIt(){
	
	var f= document.myForm;

  	f.action="login_ok.action";
	f.submit();

	}

	//비밀번호 input창에서 엔터눌렀을 경우 로그인 버튼 눌리게
	function enterkey() {
		if (window.event.keyCode == 13) {
			$("#login").click();
		}
	}	
</script>

<script type="text/javascript">
	var idck = 0;
	var f = document.myForm;
	
	$(function() {
		
	    $("#login").click(function() {

	        var obj = new Object(); 
	        obj.userId = $("#userId").val();
	        obj.userPwd = $("#userPwd").val();

	        var json_data = JSON.stringify(obj); // form의 값을 넣은 오브젝트를 JSON형식으로 변환
	        
	        $.ajax({
	            type : 'POST',
	            data : json_data,
	            url : "loginAjax.action",
	            contentType : "application/json; charset=UTF-8",
	            success : function(data) {
	            	
	            	if(data.cnt==0) {
	                    alert("아이디 또는 비밀번호가 틀립니다.");
						$("#userId").focus();
	                    	                
	                } else {
	                    alert("로그인 성공");
	                    //아이디가 중복하지 않으면  idck = 1 
	                    idck = 1;
						sendIt();
	                }     
	            },
	            beforeSend:showRequest,
	            error:function(request,status,error){
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	             }

	        });
	        
	    });
	});

	function showRequest() {
        
		var userId=$.trim($("#userId").val());
		var userPwd=$.trim($("#userPwd").val());
		
        if(userId==""){
        	alert("아이디을 입력해주세요.");
        	$("#userId").focus();
        	return false;//이거 안쓰면 success부분의 alert창이 뜸
        }
        
        if(userPwd==""){
        	alert("비밀번호를 입력해주세요.");
        	$("#userPwd").focus();
        	return false;
        }
		
	}
</script>


<div class="page_title_area">

	<!-- // breadcrumb 미노출 페이지는 감춤 -->
	<div class="page_title">


		<h2 class="h_title page">로그인</h2>

		<p class="text font_lg"></p>
	</div>
</div>

<!-- page contents -->
<form method="GET" id="sub" action="/main"></form>
<div class="ap_contents login">
	<div class="panel">
		<div class="panel_cont">
			<fieldset class="form">
				<legend class="sr_only">로그인 정보 입력</legend>
				<div class="join_info"></div>

				<div class="login_tab_contents">
					<!-- // 일반로그인 -->
					<div class="login_area">
						<form id="main" name="myForm">
							<div class="input_wrap">
								<input type="text" title="아이디 입력" id="userId" name="userId" value="<%=id%>"
									placeholder="아이디" required="required" >
							</div>
							<div class="input_wrap">
								<input type="password" title="비밀번호 입력" id="userPwd" name="userPwd"
									placeholder="비밀번호" required="required" onkeyup="enterkey();">
							</div>
							<div class="clear">
								<div class="check_wrap">
									<input type="checkbox" id="save_id" name="id_ck"
										checked="checked"><label for="save_id">아이디 저장</label>
									<%-- <% if(id.length()>1)out.println("checked"); %> --%>

								</div>
								<div>
									<a href="searchid.action">아이디 찾기</a> │ 
									<a href="searchpw.action">비밀번호 찾기</a>
								</div>
							</div>
							<button type="button" id="login" class="btn_primary_login">로그인</button>
						</form>

					</div>


				</div>
			</fieldset>

			<hr class="div m20">
			<dl class="dl_cont">
				<dt class="h_title cont">아직도 회원이 아니세요?</dt>
				<dd>
					<p class="text">
						나만의 코디북에서 모든 쇼핑몰을 하나의 아이디로 편리하게, <br>통합멤버십(포인트)적립 및 다양한 서비스와
						혜택을 누리세요.
					</p>
					<a href="signup.action" class="btn_md_bordered vertical">회원가입 </a>
				</dd>
			</dl>
		</div>
	</div>

</div>

<%@ include file="../layout/footer.jsp"%>































