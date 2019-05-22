<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../layout/top.jsp" %>
<%@ include file="../layout/mypage.jsp" %>

<style>
#review_form {
	max-width: 800px;
	width: 100%;
	margin: 30px auto;
	background-color: #ffffff;
	padding: 40px 50px;
	box-sizing: border-box;
	box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.2);
	color: #424242;
}

.sub_title {
	float: left;
	width: 100px;
	line-height: 40px;
}

input[type=text] {
	padding: 0 15px;
	border: solid 1px #dcdcdc;
	width : 570px;
	box-sizing: border-box;
	height: 40px;
	line-height: 40px;
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
	color : #000000;
	margin-bottom: 25px;
	font-size: 24px;
	font-weight: 700;
	text-align: center;
}

.button {
	margin-top: 25px;
	text-align: center;
}


.notice {
	margin-top: 10px;
	font-size: 12px;
	color: #757575;
}

#sendButton {
	margin-top: 15px;
	width: 50%;
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

.sendButton {
	display : inline-block;
    margin-top: 15px;
    width: 295px;
    height: 40px;
    border: none;
    border-radius: 4px;
    font-size: 18px;
    font-weight: 700;
    text-align: center;
    cursor: pointer;
}

.rate_span {
	display: inline-block;
	margin-right: 10px;	
}

input[type=radio] { 
	border:none;
} 

.rate_text {
	color : #999999;
	margin-top : 30px;
	margin-bottom: 25px;
	font-size: 14px;
	font-weight: 300;
	text-align: center;
}

.rate_text_p {
	margin-top: 20px;
}

.ui_table {
    border-top: 1px solid #333;
    border-bottom: 1px solid #333;
}

.file_table {
	padding-top : 10px;
	padding-bottom : 10px;
	border-bottom: 1px solid #333;
}

.attach_form {
	display : inline-block;
	width: 100px;
	height: 100px;
	background-color: #5D5D5D;
	color: #ffffff;
	text-align: center;
	line-height: 100px;
	font-size: 16px;
	font-weight: 700;
}

.review_showImg {
	width: 100px;
	height: 100px;
	display: inline-block;
	margin-left: 20px;
	position: absolute;
}

.review_img {
	width: 100px;
	height: 100px;
}

.review_delete {
	display : none;
	width: 35px;
	height: 35px;
	position: relative;
	top: -35px;
	right: -86px;
}


.review_div_dl {
	margin-top: 20px;
	padding-bottom: 20px;

}

.review_div_dl_bottom {
	border-bottom:1px solid #e4e4e4;
}

.review_dt_title {
	padding-left : 10px;
    font-weight: 600;
    color: #333;
    font-size: 16px;
    display: inline-block; 
    width: 120px;
}

.agree {
	padding-left : 10px;
	margin-top: 30px;
	color : #888888;
	font-size: 14px;
	line-height: 1.6em;
}

.review_ui {
	list-style: disc;
	list-style-position: inside;
}

.agree_table {
	margin-top: 30px;
}

.agree_title {
	margin-bottom: 1em;
	font-size: 16px;
	font-weight: 600;
	color: #333333;
}

.iagree {
	margin-top: 10px;
}

</style>

<script type="text/javascript">

	function writeReview() {
		
		var f = document.review;
		
		var str = f.rate.value;
		if(!str) {
			alert("평점을 선택해주세요");
			return;
		}
		
		str = f.subject.value;
		if (!str) {
			alert("제목을 입력하세요");
			f.subject.focus();
			return;
		}
		f.subject.value = str;
	
		str = f.content.value;
		if (!str) {
			alert("내용을 입력해주세요");
			f.content.focus();
			return;
		}
		
		if(str.length>1000){
			alert("리뷰는 1000자이상 작성할 수 없습니다.");
			f.content.focus();
			return;
		}
		f.content.value = str;
		
		str = document.getElementById('iagree');
		if(str.src.match('checkmark_no')){
			alert("개인정보 수집 및 이용 동의가 필요합니다.");
			return;
		}
		
		f.action = "<%=cp%>/review/reviewWrited_ok.action";
		f.submit();
	}
	
	function changeHeart(rate) {
		
		for(var changeOn=1;changeOn<=rate;changeOn++){
			
			var imgOn = document.getElementById(eval("'img_" + changeOn + "'"));
			imgOn.src = '../resources/image/heart2.PNG';
	
		}
			
		
		for(var chagneOff=5;chagneOff>rate;chagneOff--){

			var imgOff = document.getElementById(eval("'img_" + chagneOff + "'"));
			imgOff.src = '../resources/image/heart1.PNG';
		}
		
		document.review.rate.value=rate;
	
	}
	
	function iagree(){
		
		var agreeOn = document.getElementById('iagree');

		if(agreeOn.src.match('checkmark_no')){
			agreeOn.src = "../resources/image/checkmark_yes.png";
		}
		else {
			agreeOn.src = "../resources/image/checkmark_no.png";
		}
		
	}
	
</script>

<!-- 이미지 미리보기 -->
<script type="text/javascript">
	function showImg(value) {
		
		if(value.files && value.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#showImage').attr('src',e.target.result);
				$('#review_delete').css("display","inline-block"); 
			}
			reader.readAsDataURL(value.files[0]);
		}
		
	}
	
	function deleteImg() {
		$('#showImage').attr('src','');		
		$("#attach_file").val("");
		$('#review_delete').css("display","none"); 

	}
</script>

<!-- 글자수 체크 -->
<script type="text/javascript">

	$(function() {
	    $('#content').keyup(function (e){
	        var content = $(this).val();
	        $('#counter').html(content.length + ' | 1,000');
	    });
	    $('#content').keyup();
	});

</script>

<form name="review" method="post" enctype="multipart/form-data">

<div class="ap_contents mypage">
	<div id="review_form">
		
		<div class="title">${dto.productName }리뷰 작성</div>
		
		<div class="rate_text">
			<img class="rate_span" src="../resources/image/heart1.PNG" width="55px" onclick="changeHeart('1')" id="img_1">
			<img class="rate_span" src="../resources/image/heart1.PNG" width="55px" onclick="changeHeart('2')" id="img_2">
			<img class="rate_span" src="../resources/image/heart1.PNG" width="55px" onclick="changeHeart('3')" id="img_3">
			<img class="rate_span" src="../resources/image/heart1.PNG" width="55px" onclick="changeHeart('4')" id="img_4">
			<img class="rate_span" src="../resources/image/heart1.PNG" width="55px" onclick="changeHeart('5')" id="img_5">
			<input type="hidden" name="rate" value=""><br/>
			<p class="rate_text_p">상품을 평가해주세요</p>
		</div>

		<div class="ui_table">
			<dl class="review_div_dl review_div_dl_bottom">
				<dt class="review_dt_title">색상</dt>
				<dt style="display: inline-block;">${dto.color }</dt>
			</dl>
			
			<dl class="review_div_dl review_div_dl_bottom">
				<dt class="review_dt_title">상품사이즈</dt>
				<dt style="display: inline-block;">${dto.productSize}</dt>
			</dl>
			
			<dl class="review_div_dl review_div_dl_bottom">
				<dt class="review_dt_title">제목</dt>
				<dt style="display: inline-block;">
					<input type="text" name="subject" maxlength="90" placeholder="최대 30자까지 입력 가능합니다">
				</dt>
			</dl>
			
			<dl class="review_div_dl">
				<dt class="review_dt_title">
					내용<br/>
					<p style="color:#333333; font-size: 13px; margin-top: 10px;" id="counter"></p>
				</dt>
				<dt style="display: inline-block;">
					<textarea rows="20" cols="40" name="content" id="content" maxlength="1000" style="padding: 10px; line-height: 1.5em;"></textarea>
				</dt>
			</dl>
		</div>
		
		<div class="file_table">
			<input type="file" name="reviewUpload" id="attach_file" style="display: none;" onchange="showImg(this)">
			<label for="attach_file">
				<div class="attach_form">사진첨부</div>
			</label>
			<div class="review_showImg"><img class="review_img" id="showImage"></div>
			<div class="review_delete" id="review_delete" onclick="deleteImg();"><img src="../resources/image/review_delete.png"></div>		
		</div>
		
		<div class="agree">
			<ul class="review_ui">
				<li style="margin-bottom: 10px;">
					타인의 글 도용 및 올바르지 않은 리뷰 작성의 경우, 게시판 성격과 관련 없는 게시물은 임의로 삭제될 수 있습니다.<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(동일 내용의 반복 등록, 무의미한 내용 입력, 광고 및 욕설, 비방의 글, 성인글, 출처를 안 밝힌 뉴스기사 등)
				</li>
				<li>
					저작권 등 다른 사람의 권리를 침해하거나 게시판 성격과 관련 없는 게시물은 임의로 삭제될 수 있습니다.<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(반복 등록된 글, 무의미한 내용, 광고 및 욕설, 비방의 글, 성인글 등)
				</li>
			</ul>

			<dl class="agree_table">
				<dt class="agree_title">개인정보 수집 및 이용 동의 (필수)</dt>
				<dd>
					<ul class="review_ui">
						<li>수집 및 이용 목적 : 리뷰의 신뢰성 향상을 위해</li>
						<li>이용·보유 및 이용 기간 : 회원탈퇴시까지</li>
						<li>신청자는 개인정보 수집 및 이용 동의에 거부할 수 있습니다. 다만, 거부할 경우 리뷰 작성이 불가능 합니다.</li>
					</ul>
				</dd>
				<div class="iagree">
					<div style="display: inline-block;" onclick="iagree();">
						<img src="../resources/image/checkmark_no.png" style="width: 15px;" id="iagree">
					</div>
					<p style="display: inline-block;" onclick="iagree();">동의합니다</p>
				</div>
			</dl>

		</div>
		
		<div class="button">	
			<input type="hidden" name="reviewNum" value="${dto.reviewNum }">
			<input type="button" class="btn_blg_secondary" value="취소" onclick="javascript:location.href='<%=cp%>/review/reviewPossibleList.action?pageNum=${pageNum}';">
			<input type="button" class="btn_blg_primary" value="등록" onclick="writeReview()">
		</div>
		
	</div>
	

</div>

</form>


<%@ include file="../layout/footer.jsp" %>