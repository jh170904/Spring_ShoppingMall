<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../layout/top.jsp" %>
<%@ include file="../layout/mypage.jsp" %>
<!-- 비밀번호 수정 -->

<script type="text/javascript">

<!-- 개인정보 수정 -->
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

<!-- 이미지 미리보기 -->
<script type="text/javascript">
	function showImg(value) {
		
		if(value.files && value.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#showImage').attr('src',e.target.result);
				$("#changeImage").val($('#attach_file').val());
			}
			reader.readAsDataURL(value.files[0]);
		}
		
	}
	
	function deleteImg() {
		$('#showImage').attr('src','../upload/profile/default.jpg');	
		$("#changeImage").val("default.jpg'");
		$("#attach_file").val("");

	}
</script>

<style>

#member_form {
    max-width: 550px;
    width: 100%;
    margin: 30px auto;
    background-color: #ffffff;
    padding: 40px 50px;
    box-sizing: border-box;
    box-shadow: 0 1px 3px 0 rgba(0,0,0,0.2);
    color: #424242;
}

.sub_title {
    float: left;
    margin-left:-10px;
    width: 100px;
    line-height: 40px;
}

input[type=text] {
    padding: 0 15px;
    border: solid 1px #dcdcdc;
    box-sizing: border-box;
    width: 350px;
    height: 40px;
    line-height: 40px;
}

div {
    display: block;
}

form {
    display: block;
    margin-top: 0em;
}

.field {
    margin-top: 20px;
    overflow: hidden;
    clear: both;
}

.title {
    font-size: 24px;
    font-weight: 700;
    text-align: center;
    margin: auto;
    margin-bottom: 40px;
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

input {
    font-family: inherit;
    font-size: inherit;
    font-weight: inherit;
    *font-size: 100%;
}

.imageDiv {
	text-align: center;
	margin-top: 30px;
}

.image_div_bottom {
	padding-bottom : 20px;
	border-bottom:1px solid #e4e4e4;
}

.attach_form {
	width: 210px;
	height: 40px;
	background-color: #5D5D5D;
	color: #ffffff;
	line-height: 40px;
	font-size: 18px;
	font-weight: 700;
	text-align: center;
	display: inline-block;
	margin: auto;
	cursor: pointer;
	vertical-align: middle;
}

.review_showImg {
	width: 200px;
	height: 200px;
	border-radius : 30%;
	border : 1px solid #000000;
	margin : auto;
	margin-bottom: 20px;
}

.review_img {
	width: 200px;
	height: 200px;
	border-radius : 30%;
}

.review_delete {
	display : none;
	width: 35px;
	height: 35px;
	position: relative;
	top: -35px;
	right: -86px;
}

</style>

<!-- session.sestAttribut() : 회원정보수정msg받아옴 -->
<c:if test="${!empty msg }">
	<script type="text/javascript">
		alert("${msg}");
	</script>
</c:if>


<!-- // page title -->
<div id="member_form">
	<div class="title">회원정보 수정</div>
	<form class="private-info" name="infoUpdateForm" method="post" enctype="multipart/form-data">
	
		<fieldset class="form">
			
			<div class="field image_div_bottom">			
				<div class="review_showImg"><img src="../upload/profile/${dto.mImage }" class="review_img" id="showImage"></div>	
					
				<input type="file" name="imageUpdate" id="attach_file" maxlength="100" class="boxTF" style="display: none;" onchange="showImg(this)">
				<div class="imageDiv">
					<label for="attach_file" class="attach_form">
						<div>프로필변경</div>
					</label>
					<div class="attach_form" onclick="deleteImg();">프로필 삭제</div>
				</div>
			</div>
			
			<div class="field">
				<div class="sub_title">메세지</div>
				<input type="text" id="mMessage" value="${dto.mMessage }" name="mMessage">
			</div>
			
			<legend class="sr_only">비밀번호 입력항목</legend>
			<div class="align_right">
				<span class="notice">필수 입력 항목입니다.</span>
			</div>
			
			<div class="field">
				<div class="sub_title">아이디</div>
				<input type="text" value="${dto.userId}" title="아이디" disabled="" name="userId">
			</div>
			
			<div class="field">
				<div class="sub_title">이름</div>
				<input type="text" value="${dto.userName}" title="이름" disabled="">
			</div>
			
			<div class="field">
				<div class="sub_title">E-mail</div>
				<input type="text" id="email" value="${dto.email }" name="email" title="이메일 주소 입력">
			</div>
			
			<input type="hidden" name="preImage" value="${dto.mImage }">
			<input type="hidden" name="changeImage" id="changeImage" value="">
			<button id="sendButton" onclick="changePrivateInfo()" type="button">수정 완료</button>

		</fieldset>
		
	</form>

</div>

<%@ include file="../layout/footer.jsp"%>