<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../layout/top.jsp"%>
<%@ include file="../layout/mypage.jsp"%>
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

<!-- 개인정보 수정 -->
<script type="text/javascript">
function changePrivateInfo(){
	
	//email 정규식
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

	var f= document.infoUpdateForm;
	
	str=f.email.value;
	str=str.trim();
	if(!regExp.test(str)){
		alert("형식에 맞춰 이메일을 입력하세요.");
		str="";
		f.email.focus();
		return;
	}
	f.email.value=str;

	alert("회원정보가 수정되었습니다.");
  	f.action="update_data.action"; 
	f.submit();  
}
</script>

<!-- session.sestAttribut() : 회원정보수정msg받아옴 -->
<c:if test="${!empty msg }">

	<script type="text/javascript">
				alert("${msg}");
							</script>
</c:if>

	<div class="page_title_area">
		<!-- breadcrumb 미노출 페이지는 감춤 -->

		<!-- // breadcrumb 미노출 페이지는 감춤 -->
		<div class="page_title">
			<h2 class="h_title page">개인정보 수정</h2>
			<p class="text font_lg"></p>
		</div>
	</div>

	<!-- // page title -->
	<div class="modify_wrap modify_my_info">
		<dl>
			<dd class="modify_cont">
				<h3 class="h_title sub mgt20">비밀번호 수정</h3>
				<form class="pass-check" name="pwdUpdateForm">
					<fieldset class="form">
						<legend class="sr_only">비밀번호 입력항목</legend>
						<div class="ui_table pw_check">
							<dl>
								<dt>
									<label for="prev_pw">비밀번호 수정</label>
								</dt>
								<dd>
									<div class="input_wrap w100p">
										<input type="password" maxlength="16" id="ori-pass"
											name="oriPassword" placeholder="기존 비밀번호">
									</div>
								</dd>
							</dl>
							<dl>
								<dt>
									<label for="new_pw">신규 비밀번호</label>
								</dt>
								<dd>
									<div class="input_wrap w100p">
										<input type="password" maxlength="16" id="pass1"
											name="pass1" required="required"
											placeholder="새 비밀번호 입력" title="새 비밀번호 입력">
										<div class="rating_box">
											<span class="rating"></span>
										</div>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>
									<label for="new_pw2">신규 비밀번호 확인</label>
								</dt>
								<dd>
									<div class="input_wrap w100p">
										<!-- 공통 : error 일 때 class="error" 추가 -->
										<input type="password" maxlength="16" id="pass2" name="pass2"
											placeholder="비밀번호 확인">
										<div class="help">
											<span class="completion"><span class="sr_only">완료</span></span>
										</div>
									</div>

								</dd>
							</dl>
							<p class="text_notice">
							비밀번호는 영문 대소문자 또는 숫자로 구성된 6-16자로 입력해주세요.
							</p>
						</div>
						<div class="form_btns">
							<button class="btn_md_primary" type="button" onclick="changePassword();">
							수정 완료</button>
								
						</div>
					</fieldset>
				</form>

				<hr class="div m60">

				<h3 class="h_title sub" id="private-title">개인정보 수정</h3>
				<form class="private-info" name="infoUpdateForm">
					<fieldset class="form">
						<legend class="sr_only">비밀번호 입력항목</legend>
						<div class="align_right">
							<span class="required">필수 입력 항목입니다.</span>
						</div>
						<div class="ui_table">
							<dl>
								<dt>
									<label for="user_id">아이디</label>
								</dt>
								<dd>
									<div class="input_wrap w100p">
										<input type="text" value="${dto.userId}" title="아이디" disabled="" name="userId">
									</div>
								</dd>
							</dl>
							
							<dl>
								<dt>
									<label for="user_name">이름</label>
								</dt>
								<dd>
									<div class="input_wrap w100p">
										<input type="text" value="${dto.userName}" title="이름" disabled="">
									</div>
								</dd>
							</dl>
							
							<dl>
								<dt><label for="user_email">E-mail</label></dt>
								<dd>
									<div class="input_wrap w100p">
										<input type="text" id="email" value="${dto.email }" name="email" title="이메일 주소 입력">
									</div>
								</dd>
							</dl>
						</div>
						<div class="form_btns">
							<button class="btn_md_primary" onclick="changePrivateInfo()"
								type="button">수정 완료</button>
						</div>
					</fieldset>
				</form>
				
				</dd>
				</dl>
				</div>
			

				<%@ include file="../layout/footer.jsp"%>