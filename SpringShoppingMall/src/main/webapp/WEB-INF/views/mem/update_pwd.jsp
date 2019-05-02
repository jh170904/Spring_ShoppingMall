<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../layout/top3.jsp" %>
<%@ include file="../layout/mypage.jsp" %>
<!-- 비밀번호 수정 -->

<script type="text/javascript">
function changePassword(){
	
	//아이디,비밀번호의 유효성검사
	
	var f= document.pwdUpdateForm;

	str=f.oriPassword.value;
	str=str.trim();
	if(!str){
		alert("기존 비밀번호를 입력하세요!");
		f.oriPassword.focus();
		return;
	}
	f.oriPassword.value=str; 
	
	str=f.pass1.value;
	str=str.trim();
	if(!str){
		alert("신규 비밀번호를 입력하세요!");
		f.pass1.focus();
		return;
	}
	f.pass1.value=str; 
	
	str=f.pass2.value;
	str=str.trim();
	if(!str){
		alert("신규 비밀번호확인을 입력하세요!");
		f.pass2.focus();
		return;
	}
	f.pass2.value=str; 
	
	str=f.pass1.value;
	str2=f.pass2.value;
	if(str!=str2){
		alert("신규 비밀번호와 확인이 같지 않습니다!");
		f.pass1.focus();
		return;
	}
	
	str=f.oriPassword.value;
	str=str.trim();
	f.oriPassword.value=str; 

	var pw='${sessionScope.customInfo.userPwd}';
	if(str!=pw){
		alert("기존 비밀번호가 틀렸습니다.");
		f.oriPassword.focus();
		return;
	}
	
	alert("비밀번호가 수정되었습니다.");

  	f.action="update_pwd.action"; 
	f.submit();  
}
</script>
<style>

#password_form {
    margin: 50px auto;
    padding: 30px;
    max-width: 400px;
    width: 100%;
    border-radius: 4px;
    box-sizing: border-box;
    background-color: #ffffff;
    box-shadow: 0 1px 3px 0 rgba(0,0,0,0.2);
}

#password_form>.title {
    margin-bottom: 25px;
    font-size: 24px;
    font-weight: 700;
}

.notice {
    margin-top: 10px;
    font-size: 12px;
    color: #757575;
}

label {
    color: #424242;
    display: block;
    font-size: 14px;
    font-weight: bold;
}

#password_form>form>input[type=text], #password_form>form input[type=password] {
    margin: 10px 0 15px;
    width: 100%;
    padding: 0 20px;
    box-sizing: border-box;
    font-size: 16px;
    line-height: 40px;
    border: 1px solid #dcdcdc;
    height: 40px;
}

#sendButton {
    margin-top: 15px;
    width: 100%;
    height: 40px;
    background-color: #8080ff;
    border: none;
    border-radius: 4px;
    color: #ffffff;
    font-size: 18px;
    font-weight: 700;
    text-align: center;
    cursor: pointer;
}

</style>

<!-- session.sestAttribut() : 회원정보수정msg받아옴 -->
<c:if test="${!empty msg }">

	<script type="text/javascript">
			alert("${msg}");
	</script>
</c:if>

<!-- // page title -->
<div id="password_form">
	<div class="title">비밀번호 수정</div>
	<form class="pass-check" name="pwdUpdateForm">
	
		<fieldset class="form">
		
			<legend class="sr_only">비밀번호 입력항목</legend>
			
				<label for="prev_pw">비밀번호 수정</label>
				<input type="password" maxlength="16" id="ori-pass" name="oriPassword" placeholder="기존 비밀번호">

				<label for="new_pw">새 비밀번호</label>
				<div class="notice">영문 대소문자 또는 숫자로 구성된 6-16자로 입력해주세요.</div>
				<input type="password" maxlength="16" id="pass1" name="pass1" required="required" placeholder="새 비밀번호 입력" title="새 비밀번호 입력">
				<div class="rating_box">
					<span class="rating"></span>
				</div>

				<label for="new_pw2">새 비밀번호 확인</label>
				<!-- 공통 : error 일 때 class="error" 추가 -->
				<input type="password" maxlength="16" id="pass2" name="pass2" placeholder="비밀번호 확인">
				<div class="help">
					<span class="completion"><span class="sr_only">완료</span></span>
				</div>

			<button id="sendButton" type="button" onclick="changePassword();">수정완료</button>
			
		</fieldset>
		
	</form>

</div>

<%@ include file="../layout/footer.jsp"%>