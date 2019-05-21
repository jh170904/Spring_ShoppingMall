<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../layout/top.jsp" %>
<%@ include file="../layout/mypage.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp3=request.getContextPath();
%>

<script type="text/javascript">
function sendUpdate(){
	
	//아이디,비밀번호의 유효성검사
	
	var f= document.updateForm;

	str=f.userPwd.value;
	str=str.trim();
	if(!str){
		alert("패스워드를 입력하세요!");
		f.userPwd.focus();
		return;
	}
	f.userPwd.value=str;

	var pw='${sessionScope.customInfo.userPwd}';
	
	if(str!=pw){
		alert("패스워드가 틀렸습니다.");
		return;
	}

  	f.action="update_ok.action"; 
	f.submit();  
}
</script>



<div class="page_title_area">
	<!-- breadcrumb 미노출 페이지는 감춤 -->

	<!-- // breadcrumb 미노출 페이지는 감춤 -->
	<div class="page_title">


		<h2 class="h_title page">개인정보 수정</h2>

		<p class="text font_lg"></p>
	</div>
</div>

<!-- // page title -->

<!-- page contents -->
<div class="ap_contents member_info">
	<ul class="list_bullet_dot">
		<li>나만의 코디북은 회원님의 개인정보를 신중히 취급하며, 회원님의 동의 없이는 기재하신 회원정보가 공개되지
			않습니다.</li>
		<li>보다 다양한 서비스를 받으시려면 정확한 정보를 항상 유지해 주셔야 합니다.</li>
	</ul>
	<br>
	<div class="panel gray bdr_top">
		<div class="panel_cont">
			<form name="updateForm">
				<fieldset class="form password_comfirm">
					<legend class="sr_only">비밀번호 입력</legend>
					<div class="ui_table type2">
						<dl>
							<dt>아이디</dt>
							<dd>
								<p class="text">${sessionScope.customInfo.userId }</p>
							</dd>
						</dl>
						<dl>
							<dt>
								<label for="user_pwd">비밀번호</label>
							</dt>
							<dd>
								<div class="input_btn_wrap w100p">
									<span class="input_wrap">
										<input name="userPwd" id="userPwd" type="password" /></span>
										<button class="btn_md_neutral" type="button"
										onclick="sendUpdate();">확인</button>
								</div>
							</dd>
						</dl>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
</div>

<%@ include file="../layout/footer.jsp"%>