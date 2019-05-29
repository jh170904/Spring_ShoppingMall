<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>회원가입</title>
<script type="text/javascript" src="<%=cp%>/resources/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/member-join.css?ver=1">
<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/font.css">
<script type="text/javascript">

//아이디의 유효성 검사
var regExp1= /^[A-Za-z0-9+]{4,12}$/;

//아이디 체크여부 확인 (아이디 중복일 경우 = 0 , 중복이 아닐경우 = 1 )
$(function() {
	$("#userId").keyup(function(){
		//userid 를 param.
        var userid =  $("#userId").val();

        $.ajax({
            async: true,
            type : 'POST',
            data : userid,
            url : "idcheck.action",
            dataType : "json",
            contentType: "application/json; charset=UTF-8",
            success : function(data) {
				//입력창이 비었을경우 html 지워줌
            	if(userid==""){
                  	var newDiv=document.getElementById("result");
                  	newDiv.innerHTML="";
                  	idck = 0;
				}
            	else if(!regExp1.test(userid)){
                  	var html="<p class=\"text\" style=\"color:red;\">"
                      	html+="형식에 맞게 아이디를 입력해주세요.</p>"
                      	var newDiv=document.getElementById("result");
                      	newDiv.innerHTML=html;
                    idck = 0;
            	}
				else if(data.cnt > 0) {
                    
                    $("#userId").focus();
                  	
                  	var html="<p class=\"text\" style=\"color:red;\">"
                  	html+="사용할 수 없는 아이디입니다.</p>"
                  	var newDiv=document.getElementById("result");
                  	newDiv.innerHTML=html;
                  	
                    idck = 0;
                
                }else {
                	
                  	var html="<p class=\"text\" style=\"color:blue;\">"
                    html+="사용가능합니다.</p>"
                    var newDiv=document.getElementById("result");
                    newDiv.innerHTML=html;
                    
                    //아이디가 중복하지 않으면  idck = 1 
                    idck = 1;
                }
                
            },
            error : function(error) {
                alert("error : " + error);
            }
        });
		
	});
});

</script>
<script type="text/javascript">
function sendIt(){

	var f= document.myForm;
	
	//아이디의 유효성 검사
	var regExp1= /^[A-Za-z0-9+]{4,12}$/;
	
	//비밀번호의 유효성 검사
	var regExp2= /^[a-zA-Z0-9]{6,16}$/;

	//아이디 검사
	str=f.userId.value;
	str=str.trim();
	if(!str){
		alert("아이디를 입력하세요!");
		f.userId.focus();
		return;
	}
	
	if(!regExp1.test(str)){
		alert("형식에 맞춰 ID를 입력하세요.");
		str="";
		f.userId.focus();
		return;
	}
	
	f.userId.value=str;
	
	//패스워드 검사
	str=f.userPwd.value;
	str=str.trim();
	if(!str){
		alert("패스워드를 입력하세요!");
		f.userPwd.focus();
		return;
	}
	
	if(!regExp2.test(str)){
		alert("형식에 맞춰 PASSWORD를 입력하세요.");
		str="";
		f.userPwd.focus();
		return;
	}
	
	if(str!=f.userPwd1.value){
		alert("비밀번호가 동일하지 않습니다.");
		str="";
		f.userPwd1.focus();
		return;
	}
	
	f.userPwd.value=str;
	
	//이름 검사
	str=f.userName.value;
	str=str.trim();
	if(!str){
		alert("이름을 입력하세요!");
		f.userName.focus();
		return;
	}
	f.userName.value=str;
	
	if((f.email1.value == "")||(f.email2.value == "")) {
		alert("이메일을 입력하세요!!");
		f.email1.focus();
		return;
	}
	
    //if(confirm("회원가입을 하시겠습니까?")){
    //}
    
    if(idck==0){
	    alert('아이디 중복체크를 해주세요');
	    return;
	}else{
		alert("회원가입을 축하합니다");
	}
	
	f.action="signup_ok.action";
	f.submit();

	}

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
</head>
<body>
	<div class="ap_wrapper">

		<div id="ap_container" class="ap_container">
			<div class="page_title_area">
				<h1>내일의 코디북 통합 회원가입</h1>
			</div>

			<div class="ap_contents member_join">
				<h2 class="h_title d1">환영합니다.</h2>
				<p class="text">간단한 회원가입으로 포인트를 확인하세요.</p>
				<form class="validate" name="myForm" id="frm">
					<fieldset class="form">
						<legend class="sr_only">회원가입 정보입력</legend>

						<div class="input_group">
							<div id="divInputId" class="input_wrap">
								<input type="text" title="아이디 입력" id="userId" name="userId"
									value="" placeholder="아이디(4-12자 영문, 숫자)">
							</div>
						</div>
						
						<div class="input_group" style="margin-top: 5px;">
							<div id="result" class="input_wrap w30p">
							</div>
						</div>
						<div class="input_wrap">
							<input type="password" title="비밀번호 입력" id="userPwd"
								name="userPwd" placeholder="비밀번호(6-16자 영문, 숫자)"
								pass-word="pass-word">
						</div>
						<div class="input_wrap">
							<input type="password" title="비밀번호 확인 입력" placeholder="비밀번호 확인"
								id="userPwdEcChk" name="userPwd1">
						</div>

						<div class="input_wrap">
							<input type="text" placeholder="이름(실명으로 입력해주세요)" title="이름 입력"
								id="custNm" name="userName"
								user-name="user-name" />
						</div>

						<div class="input_group">
							<div class="input_wrap w30p no-check">
								<input type="tel" pattern="[0-9]*" placeholder="이메일"
									title="이메일 입력" name="email1" 
									maxlength="11" />
							</div>
							<span class="gap" style="width: 20px; line-height: 40px;">&nbsp;@&nbsp;</span>

							<div class="input_wrap w30p no-check">
								<input type="tel" pattern="[0-9]*" placeholder="" title="이메일 입력"
									name="email2" 
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
							<a href="javascript:sendIt();" id="send" class="btn_lg_primary">
								<i class="ico_check_w"></i><span>가입완료</span>
							</a>
						</div>
					</fieldset>
				</form>
			</div>

		</div>
	</div>

</body>
</html>

























