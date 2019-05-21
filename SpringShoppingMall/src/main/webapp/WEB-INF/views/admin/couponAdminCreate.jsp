<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="../layout/adminNav.jsp"  %>

<style>
#couponAdmin_form {
	max-width: 700px;
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
	box-sizing: border-box;
	width: 350px;
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
}

.notice {
	margin-top: 10px;
	margin-bottom: 10px;
	margin-left: 10px;
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

.zip_button {
	color : #ffffff;
	font-size: 18px;
	min-width: 160px;
	height: 40px;
	padding: 0 20px;
	font-weight: 500;
	border: 0;
	outline: 0 color:#fff;
	background: #999;
}

.sendButton {
	display : inline-block;
    margin-top: 15px;
    width: 195px;
    height: 40px;
    border: none;
    border-radius: 4px;
    font-size: 18px;
    font-weight: 700;
    text-align: center;
    cursor: pointer;
}
</style>

<script type="text/javascript">

	String.prototype.trim = function() {
		var TRIM_PATTERN = /(^\s*)|(\s*$)/g;
		return this.replace(TRIM_PATTERN, "");
	};
	
	
	function couponSendIt(){
	
		f = document.couponMyForm;
		

		str = f.couponName.value;
		str = str.trim();
		if(!str){
			alert("\쿠폰이름을 입력하세요.");//공백제거후 내용이 없으면
			f.couponName.focus();
			return;
		}
		f.couponName.value = str;
		
		str = f.discount.value;
		str = str.trim();
		if(!str){
			alert("\할인금액을 입력하세요.");//공백제거후 내용이 없으면
			f.discount.focus();
			return;
		}
		f.discount.value = str;
		
		str = f.couponScore.value;
		str = str.trim();
		if(!str){
			alert("\적용되는금액을 입력하세요.");//공백제거후 내용이 없으면
			f.couponScore.focus();
			return;
		}
		f.couponScore.value = str;
		
		str = f.couponGrade.value;
		str = str.trim();
		if(!str){
			alert("\적용되는등급을 입력하세요.");//공백제거후 내용이 없으면
			f.couponGrade.focus();
			return;
		}
		if(str!="SILVER"&&str!="COLD"&&str!="VIP"){
			alert("\올바른등급을 입력하세요.\n[SILVER/COLD/VIP]");//공백제거후 내용이 없으면
			f.couponGrade.focus();
			return;
		}
		f.couponGrade.value = str;
		
		str = f.period.value;
		str = str.trim();
		if(!str){
			alert("\적용되는기간을 입력하세요.");//공백제거후 내용이 없으면
			f.period.focus();
			return;
		}
		f.period.value = str;
		
		
		
		f.action = "<%=cp %>/admin/couponAdminCreated_ok.action";
		f.submit();
		
	}
</script>


<div class="ap_contents mypage" style="position: relative;">
	<div id="couponAdmin_form">
	
	<div class="title">쿠폰 등록</div>
	
		<hr class="div m20"/>
		
		<form name="couponMyForm" action="" method="post">
		<table width="600" align="center">
		
		<tr>
			<td width="100" height="50">쿠폰이름</td>
			<td style="padding-left: 20px;">
				<input type="text" name="couponName" size="30" maxlength="20" placeholder="쿠폰명을 입력해 주세요" 
					class="input_wrap w100p">
			</td>
		</tr>
		
		<tr>
			<td width="100" height="50">할인금액</td>
			<td style="padding-left: 20px;">
				<input type="text" name="discount" size="30" maxlength="20" placeholder="할인금액을 입력해주세요"
					class="input_wrap w100p">
			</td>
		</tr>
		<tr>
			<td height="20" colspan="2" style="padding-left: 120px;">
				<div class="notice">금액은 원을 제외한 숫자만 입력가능합니다.</div>
			</td>
		</tr>
	
		<tr>
			<td width="100" height="50">적용되는 금액</td>
			<td style="padding-left: 20px;">
				<input type="text" name="couponScore" size="30" maxlength="20" placeholder="적용되는 금액을 입력해주세요" 
					class="input_wrap w100p">
			</td>
		</tr>
		<tr>
			<td height="20" colspan="2" style="padding-left: 120px;">
				<div class="notice">금액은 원을 제외한 숫자만 입력가능합니다.</div>
			</td>
		</tr>
		
		<tr>
			<td width="100" height="50">적용되는 등급</td>
			<td style="padding-left: 20px;">
				<input type="text" name="couponGrade" size="30" maxlength="20" placeholder="[SILVER/COLD/VIP]" 
					class="input_wrap w100p">
			</td>
		</tr>
		
		<tr>
			<td width="100" height="50">적용 기간</td>
			<td style="padding-left: 20px;">
				<input type="text" name="period" size="30" maxlength="20" placeholder="적용기간을 입력해주세요" 
					class="input_wrap w100p">
			</td>
		</tr>
		<tr>
			<td height="20" colspan="2" style="padding-left: 120px;">
				<div class="notice">기간은 일을 제외한 숫자만 입력가능합니다.</div>
			</td>
		</tr>
		</table>
		
		<table width="600" align="center" style="margin-top: 20px;">
		<tr align="center">
			<td align="center">
				<button class="btn_blg_primary sendButton" type="button" onclick="couponSendIt();">쿠폰 등록</button>
				<button class="btn_blg_secondary sendButton" type="button" onclick="javascript:location.href='<%=cp %>/admin/couponAdminList.action';">쿠폰 리스트</button>
				<button class="btn_blg_secondary sendButton" type="reset" onclick="document.couponMyForm.productId.focus();">다시입력</button>
			</td>
		</tr>
		
		</table>
		</form>
		
	</div>
	
</div>
<%@include file="../layout/footer.jsp"  %>