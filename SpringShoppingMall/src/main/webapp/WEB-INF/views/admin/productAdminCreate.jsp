<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="../layout/adminNav.jsp"  %>

<style>
#productAdmin_form {
	max-width: 1000px;
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

select {
	padding: 0 15px;
	border: solid 1px #dcdcdc;
	box-sizing: border-box;
	width: 350px;
	height: 40px;
	line-height: 40px;
}

select::-ms-expand {
	margin-right : -15px;
	width: 40px;
	height: 40px;
	
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

.file_table {
	padding-top : 10px;
	padding-bottom : 10px;
	border-bottom: 1px solid #333;
}

.attach_form {
	width: 100px;
	height: 100px;
	background-color: #5D5D5D;
	color: #ffffff;
	text-align: center;
	line-height: 100px;
	font-size: 16px;
	font-weight: 700;
}

input[type=file] {
	padding: 0px;
	border: solid 1px #dcdcdc;
	box-sizing: border-box;
	width: 350px;
	height: 40px;
	line-height: 40px;
	display: inline-block;
}

.review_showImg {
	border: 1px solid #EAEAEA;
	width: 300px;
}

.review_detail {
	border: 1px solid #EAEAEA;
	width: 700px;
}

.review_img {
	width: 300px;
}

.detail_img {
	width: 700px;
}

.deleteButton {
	display: inline-block;
	height: 40px;
	width : 9%;
	background-color: #000000;
	border: none;
	color: #ffffff;
	font-size: 18px;
	font-weight: 500;
	text-align: center;
	cursor: pointer;
	line-height: 40px;
}

</style>

<script type="text/javascript">
	String.prototype.trim = function() {
		var TRIM_PATTERN = /(^\s*)|(\s*$)/g;
		return this.replace(TRIM_PATTERN, "");
	};
	function sendIt(){
		f = document.myForm;
		
		//id
		str = f.productId.value;
		str = str.trim();
		if(!str){
			alert("\n상품id을 입력하세요.");
			f.productId.focus();
			return;
		}
		f.productId.value = str;
		
		//Category
		str = f.productCategory.value;
		str = str.trim();
		if(!str){
			alert("\n상품Category을 입력하세요.");
			f.productCategory.focus();
			return;
		}
		f.productCategory.value = str;
		
		//ProductName
		str = f.productName.value;
		str = str.trim();
		if(!str){
			alert("\n상품명을 입력하세요.");
			f.productName.focus();
			return;
		}
		f.productName.value = str;
		
		//옵션은 Null값일 수 있다.
		
		//color
		str = f.color.value;
		str = str.trim();
		if(!str){
			alert("\n color을 입력하세요.");//공백제거후 내용이 없으면
			f.color.focus();
			return;
		}
		f.color.value = str;
		
		/*size
		str = f.productSize.value;
		str = str.trim();
		if(!str){
			alert("\n size을 입력하세요.");
			f.productSize.focus();
			return;
		}
		f.productSize.value = str;
		*/
		
		//storeName
		str = f.storeName.value;
		str = str.trim();
		if(!str){
			alert("\n storeName을 입력하세요.");
			f.storeName.focus();
			return;
		}
		f.storeName.value = str;
		
		//storeUrl
		str = f.storeUrl.value;
		str = str.trim();
		if(!str){
			alert("\n storeUrl을 입력하세요.");
			f.storeUrl.focus();
			return;
		}
		f.storeUrl.value = str;
		
		//price
		str = f.price.value;
		str = str.trim();
		if(!str){
			alert("\n price을 입력하세요.");
			f.price.focus();
			return;
		}
		f.price.value = str;
		
		if(f.fileCategory.checked==true){
			f.fileCategory.value="list";
		}else if(f.fileCategory.checked==false){
			f.fileCategory.value="";
		}

		f.action = "<%=cp %>/admin/productAdminCreate_ok.action";
		f.submit();
		
	}
</script>

<script>

	function Re_enter(){
		
		$("img").attr('src', '');		
		$("#showImage_div").css('display', 'none');
		$("#detail1_div").css('display', 'none');
		$("#detail2_div").css('display', 'none');
		$("#detail3_div").css('display', 'none');
		
		document.myForm.productId.focus();
		
	}

</script>

<!-- 이미지 미리보기 -->
<script type="text/javascript">
	function showImg(value,img) {
		
		
		if(value.files && value.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$(eval("'#" +img + "'")).attr('src',e.target.result);
				$(eval("'#" +img + "_div'")).css('display', 'block');
			}
			reader.readAsDataURL(value.files[0]);
		}
		
	}
	
	function deleteImg(img) {
		$(eval("'#" +img + "'")).attr('src','');		
		$(eval("'#input_" +img + "'")).val("");
		$(eval("'#" +img + "_div'")).css('display', 'none');

	}
</script>


<div class="ap_contents mypage" style="position: relative;">
	<div id="productAdmin_form">
	
	<div class="title">상품 등록</div>

		<form name="myForm" method="post" enctype="multipart/form-data">
		<table  width="900" align="center">
		
		<tr>
			<td width="150" height="50">상품id</td>
			<td style="padding-left: 20px;">
				<input type="text" name="productId" size="30" maxlength="20" placeholder="상품ID를 입력해 주세요" 
					class="input_wrap w100p">
			</td>
		</tr>

		<tr>
			<td width="150" height="50">상위상품id (superProduct)</td>
			<td style="padding-left: 20px;">
				<input type="text" name="superProduct" size="30" maxlength="20" placeholder="상위상품ID를 입력해 주세요" 
					class="input_wrap w100p">
			</td>
		</tr>
		
		<tr>
			<td width="150" height="50">상품카테고리</td>
			<td style="padding-left: 20px;">
				<select name="productCategory" class="input_wrap w100p">
	  				<option value="">카테고리 선택</option>
	  				<c:forTokens var='item' items="OUTER,TOP,BOTTOM,DRESS,SHOES,BAG,ACC" delims="," >
						<option value="${item}" >${item}</option>
					</c:forTokens>
				</select>
			</td>
		</tr>
		
		<tr>
			<td width="150" height="50">상품명</td>
			<td style="padding-left: 20px;">
				<input type="text" name="productName" size="30" maxlength="100" placeholder="상품명 입력해 주세요" 
					class="input_wrap w100p">
			</td>
		</tr>
		
		<tr>
			<td width="150" height="50">상품사이즈</td>
			<td style="padding-left: 20px;">
			<input type="text" name="productSize" size="30" maxlength="100" placeholder="상품사이즈를 입력해 주세요" 
					class="input_wrap w100p">
			</td>
		</tr>
		
		<tr>
			<td width="150" height="50">색상</td>
			<td style="padding-left: 20px;">
				<select name="color" class="input_wrap w100p">
					<option value="">색상 선택</option>
					<c:forTokens var='item' items="핑크,레드,오렌지,보라,블랙,그레이,브라운,그린,블루,옐로우,베이지,화이트,실버" delims="," >
					<option value="${item}">${item}</option>
					</c:forTokens>
				</select>
			</td>
		</tr>
		
		<tr>
			<td width="150" height="50">판매처</td>
			<td style="padding-left: 20px;">
				<input type="text" name="storeName" size="30" maxlength="100" placeholder="판매처를 입력해 주세요" 
					class="input_wrap w100p">
			</td>
		</tr>
		
		<tr>
			<td width="150" height="50">판매처Url</td>
			<td style="padding-left: 20px;">
			<input type="text" name="storeUrl" size="30" maxlength="100" placeholder="판매처url을 입력해 주세요" 
					class="input_wrap w100p">
			</td>
		</tr>
		
		<tr>
			<td width="150" height="50">판매상태</td>
			<td style="padding-left: 20px;">
				<select name="state" class="input_wrap w100p">
					<option value="">판매상태 선택</option>
					<c:forTokens var='item' items="판매중,일시품절,판매중지" delims="," >
					<option value="${item}">${item}</option>
					</c:forTokens>
				</select>
			</td>
		</tr>
		
		<tr>
			<td width="150" height="50">상품가격</td>
			<td style="padding-left: 20px;">
				<input type="text" name="price" size="30" maxlength="100" placeholder="상품가격을 입력해 주세요" 
					class="input_wrap w100p">
			</td>
		</tr>
		
		<tr>
			<td height="10" colspan="2" style="padding-left: 170px;">
				<div class="notice">금액은 원을 제외한 숫자만 입력가능합니다.</div>
			</td>
		</tr>
		
		<tr><td colspan="2" height="1" bgcolor="#dbdbdb" align="center"></td></tr>
		<tr>
			<td width="150" height="50">리스트사진</td>
			<td style="padding-left: 20px;">
				<input type="file" name="productListImage" id="input_showImage" onchange="showImg(this,'showImage')" class="input_wrap w90p attach_file">		
				<button class="deleteButton" type="button" onclick="deleteImg('showImage');">삭제</button>
			</td>
		</tr>
		<tr>
			<td height="10" colspan="2" style="padding-left: 170px;">
				<div class="review_showImg" style="display: none;" id="showImage_div"><img class="review_img" id="showImage"></div>	
			</td>
		</tr>
		<tr>
			<td height="10" colspan="2" style="padding-left: 170px;">
				<div style="margin: 10px 0px; font-size: 15px;">메인 이미지&nbsp;&nbsp;<input type="checkbox" name="fileCategory" value="" checked="checked"/></div>
			</td>
		</tr>
		
		<tr><td colspan="2" height="1" bgcolor="#dbdbdb" align="center"></td></tr>
		<tr>
			<td width="150" height="50">상세사진1</td>
			<td style="padding-left: 20px;">
				<input type="file" name="productDetailImage1" id="input_detail1" onchange="showImg(this,'detail1')" class="input_wrap w90p detailImg">		
				<button class="deleteButton" type="button" onclick="deleteImg('detail1');">삭제</button>
			</td>
		</tr>
		<tr>
			<td width="150" height="50">상세사진2</td>
			<td style="padding-left: 20px;">
				<input type="file" name="productDetailImage2" id="input_detail2" onchange="showImg(this,'detail2')" class="input_wrap w90p detailImg">		
				<button class="deleteButton" type="button" onclick="deleteImg('detail2');">삭제</button>
			</td>
		</tr>
		<tr>
			<td width="150" height="50">상세사진3</td>
			<td style="padding-left: 20px;">
				<input type="file" name="productDetailImage3" id="input_detail3" onchange="showImg(this,'detail3')" class="input_wrap w90p detailImg">	
				<button class="deleteButton" type="button" onclick="deleteImg('detail3');">삭제</button>	
			</td>
		</tr>
		
		<tr>
			<td height="10" colspan="2" style="padding-left: 170px;">
				<div class="review_detail" style="display: none;" id="detail1_div"><img class="detail_img" id="detail1"></div>	
			</td>
		</tr>
		<tr>
			<td height="10" colspan="2" style="padding-left: 170px;">
				<div class="review_detail" style="display: none;" id="detail2_div"><img class="detail_img" id="detail2"></div>	
			</td>
		</tr>		
		<tr>
			<td height="10" colspan="2" style="padding-left: 170px;">
				<div class="review_detail" style="display: none;" id="detail3_div"><img class="detail_img" id="detail3"></div>	
			</td>
		</tr>
		</table>
		
		<table width="900" align="center" style="margin-top: 20px;">
		<tr align="center">
			<td  align="center">
				<button class="btn_blg_primary sendButton" type="button" onclick="sendIt();">상품등록</button>
				<button class="btn_blg_secondary sendButton" type="button" onclick="javascript:location.href='<%=cp %>/admin/productAdminList.action';">제품리스트</button>
				<button class="btn_blg_secondary sendButton" type="reset" onclick="Re_enter();">다시입력</button>
				
			</td>
		</tr>
		</table>
		</form>
	</div>
</div>

<%@include file="../layout/footer.jsp"  %>
