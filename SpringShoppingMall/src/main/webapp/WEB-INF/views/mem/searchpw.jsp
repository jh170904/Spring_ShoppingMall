<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp=request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비밀번호 찾기</title>
<script type="text/javascript" src="<%=cp%>/resources/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/member-join.css">
<script type="text/javascript">

	function sendIt(){
		
		var f= document.myForm;
	
	  	f.action="searchpw_ok.action";
		f.submit();
	}
	
	//이메일 naver.com,daum.com 등 선택 
	function emailCheck() {
		
		var f = document.myForm;
		var clength = f.emailSel.options.length;
		var cvalue = f.emailSel.selectedIndex;
	
		f.email2.value = "";
	
		if (cvalue == (clength - 1)) {
			f.email2.readOnly = false;
		} else {
			f.email2.value = f.emailSel.options[cvalue].value;
			f.email2.readOnly = true;
		}
	
	}
</script>
<script type="text/javascript">
	var pwdck = 0;
	var f = document.myForm;
	
	$(function() {
	    
	    $("#findPwd").click(function() {

	        var obj = new Object(); 
	        obj.userId = $("#userId").val();
	        obj.userName = $("#userName").val();
	        obj.email = $("#email1").val()+"@"+$("#email2").val();
	         
	        var json_data = JSON.stringify(obj); // form의 값을 넣은 오브젝트를 JSON형식으로 변환
	        
	        $.ajax({
	            type : 'POST',
	            data : json_data,
	            url : "pwdAjax.action",
	            dataType : "json",
	            contentType: "application/json; charset=UTF-8",
	            success : function(data) {
	            	
	            	if(data.cnt==''||data.cnt==null) {
	                    alert("회원정보가 조회되지 않습니다.");
						$("#userName").focus();
	                    	                
	                } else {
	                    //alert("회원정보 조회 성공");

	                    //아이디가 중복하지 않으면  idck = 1 
	                    pwdck = 1;

	            	  	sendIt();
	                }     
	            },
	            beforeSend:showRequest,
	            error : function(error) {
	                alert("error : " + error);
	            }
	        });
	        
	    });
	});

	function showRequest() {
		
		var userId=$.trim($("#userId").val());
		var userName=$.trim($("#userName").val());
		var email1=$.trim($("#email1").val());
		var email2=$.trim($("#email2").val());
		
        if(userId==""){
        	alert("아이디를 입력해주세요.");
        	$("#userId").focus();
        	return false;//이거 안쓰면 success부분의 alert창이 뜸
        }
		
        if(userName==""){
        	alert("이름을 입력해주세요.");
        	$("#userName").focus();
        	return false;//이거 안쓰면 success부분의 alert창이 뜸
        }
        
        if(email1==""||email2==""){
        	alert("이메일을 입력해주세요.");
        	$("#email1").focus();
        	return false;
        }
        
		
	}
</script>
</head>
<body>
	<div class="ap_wrapper">

		<div id="ap_container" class="ap_container">
			<div class="page_title_area">
				<h1>나만의 코디북 통합 비밀번호 찾기</h1>
			</div>

			<div class="ap_contents find_id_pwd">
				<h2 class="h_title d1">비밀번호 찾기</h2>
				<p class="text">본인 인증으로 비밀번호를 찾으실 수 있습니다.</p>
				<form class="validate" name="myForm">
					<fieldset class="form">
						<legend class="sr_only">본인인증 정보입력</legend>
					
						<div class="input_wrap">
							<input type="text" title="아이디 입력" name="userId" id="userId"
								placeholder="아이디" required="required">
						</div>

						<div class="input_wrap">
							<input type="text" title="이름 입력" name="userName" id="userName"
								placeholder="이름(실명으로 입력해주세요)" required="required">
						</div>

						<div class="input_group">
							<div class="input_wrap w30p no-check">
								<input type="tel" pattern="[0-9]*" placeholder="이메일"
									title="이메일 입력" name="email1" id="email1"
									maxlength="11" />
							</div>
							<span class="gap" style="width: 20px; line-height: 40px;">&nbsp;@&nbsp;</span>

							<div class="input_wrap w30p no-check">
								<input type="tel" pattern="[0-9]*" placeholder="" title="이메일 입력"
									name="email2"  id="email2"
									maxlength="11" />
							</div>
							<span class="gap"></span>
							<div class="select_wrap">
								<select title="선택" id="emailSel" name="emailSel" onchange="emailCheck();">
									<option value="">&nbsp;선택</option>
									<option value="naver.com">&nbsp;naver.com</option>
									<option value="daum.net">&nbsp;daum.net</option>
									<option value="nate.com">&nbsp;nate.com</option>
									<option value="">&nbsp;직접 입력</option>
								</select>
							</div>
						</div>

						<div class="form_btns">
								<button type="button" id="findPwd" class="btn_lg_primary">비밀번호 찾기</button>
						</div>

					</fieldset>
				</form>
			</div>

		</div>
	</div>
</body>
</html>









