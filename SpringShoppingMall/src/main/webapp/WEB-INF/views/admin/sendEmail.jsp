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
	padding-bottom: 25px;
	margin-bottom: 25px;
	font-size: 24px;
	font-weight: 700;
	border-bottom: 1px solid #dcdcdc;
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


</style>

<script type="text/javascript">
	String.prototype.trim = function() {
		var TRIM_PATTERN = /(^\s*)|(\s*$)/g;
		return this.replace(TRIM_PATTERN, "");
	};
	function sendIt(){
		f = document.myForm;
		
		str = f.subject.value;
		str = str.trim();
		if(!str){
			alert("\n제목을 입력하세요.");
			f.subject.focus();
			return;
		}
		f.subject.value = str;
		
		str = f.content.value;
		str = str.trim();
		if(!str){
			alert("\n내용을 입력하세요.");
			f.content.focus();
			return;
		}
		f.content.value = str;

		f.action = "<%=cp %>/admin/sendEmali_ok.action";
		f.submit();
		
	}
</script>
						
<style>


.fontPStyle{
	border: 1px solid #dcdcdc; 
	padding:10px;
	font-size: 16px; 
	height: 40px;
	vertical-align: middle;
	cursor: pointer;
}

.divStyle {
	display: inline-block;
	margin: 0px 5px;
	vertical-align: middle;
}

.bold {
	font-weight: bold;
}

.underline {
	text-decoration:underline;
}

.italic {
	font-style: italic;
}

.lineThrough {
	text-decoration: line-through;
}

dd {
	width: 20px; 
	height: 20px; 
	display: inline-block; 
}

.content {
	height: 600px; 
	width: 900px;
	padding: 10px; 
	line-height: 30px;
}

</style>

<script type="text/javascript">

 	function fontSize(size) {
		$('#content').css('fontSize',size);
		$('#content').css('lineHeight',size);
		$("input[name=fontsize]").val(size);		
	}
	
	function fontStyle(value) {
		
		if(value=='underline')
			var style='lineThrough';
		else if(value=='lineThrough')
			var style='underline';
		
		if($('#content').hasClass(value)){
			$('#content').removeClass(value);
			$(eval("'#" + value + "'")).css('backgroundColor','#ffffff');
			$(eval("'input[name=\"" + value + "\"]'")).val("");
			
		}else{
			$('#content').addClass(value);
			$(eval("'#" + value + "'")).css('backgroundColor','#d4d4d4');
			$(eval("'input[name=\"" + value + "\"]'")).val(value);
			
			if($('#content').hasClass(style)){
				$('#content').removeClass(style);
				$(eval("'#" + style + "'")).css('backgroundColor','#ffffff');
				$(eval("'input[name=\"" + style + "\"]'")).val("");
			}
		}
		
	}
	
	function openColor() {
		$('#color').css('display','block');
	}
	
	function changeColor(color) {
		$('#content').css('color',color);
		$('#color').css('display','none');
		$('#fontColor').css('color',color);
		$("input[name=color]").val(color);
	}	

</script>

<div class="ap_contents mypage">
	<div id="productAdmin_form">
	
	<div class="title">메일 작성</div>

		<form name="myForm" method="post" enctype="multipart/form-data">
		<table  width="900" align="center">
		
		<tr>
			<td width="150" height="50">받는사람</td>
			<td style="padding-left: 20px;">
				<input type="text" name="email" size="30" maxlength="20" readonly="readonly" value="${dto.email}" 
					class="input_wrap w100p" style="background-color: #F5F5F5">
			</td>
		</tr>

		<tr>
			<td width="150" height="50">제목</td>
			<td style="padding-left: 20px;">
				<input type="text" name="subject" size="30" maxlength="20" 
					class="input_wrap w100p">
			</td>
		</tr>
		
		<tr><td colspan="2" height="30" align="center"></td></tr>
		<tr><td colspan="2" height="1" bgcolor="#dbdbdb" align="center"></td></tr>
		<tr><td colspan="2" height="30"  align="center"></td></tr>
		
		<tr>
			<td colspan="2">
				<div class="divStyle" style="width: 25%;">
					<div style="display: inline-block; width: 45%; vertical-align: middle;">
						<select name="font-size" style="width: 100%">
			  				<option value="">크기</option>
			  				<c:forTokens var='item' items="8pt,9pt,10pt,11pt,12pt,13pt,14pt,18pt,24pt,36pt" delims="," >
								<option value="${item}" onclick="fontSize('${item}')">${item}</option>
							</c:forTokens>
						</select>
					</div>
					
					<div style="display: inline-block; width: 50%; vertical-align: middle;">
						<table>
							<tr>
								<td><p class="fontPStyle" id="bold" style="font-weight: bold;" onclick="fontStyle('bold')">가</p></td>
								<td><p class="fontPStyle" id="underline" style="text-decoration: underline;" onclick="fontStyle('underline')">가</p></td>
								<td><p class="fontPStyle" id="italic" style="font-style: italic;" onclick="fontStyle('italic')">가</p></td>
								<td><p class="fontPStyle" id="linethrough" style="text-decoration: line-through;" onclick="fontStyle('lineThrough')">가</p></td>
								<td><p id="fontColor" class="fontPStyle" style="color: #000000;" onclick="openColor()">가</p></td>
							</tr>
						</table>
					</div>
				</div>

				<div class="divStyle" style="width:15%; margin: 0px 0px 0px 20px; position: realtive; top: 475px; left: 660px; z-index: 1">
					<div id="color" style="display: none; border: 1px solid #5D5D5D; width: 225px; height: 100%;">
						<dl>
							<dd style="background-color: #FF0000;" onclick="changeColor('#FF0000')"></dd>
							<dd style="background-color: #FF5E00;" onclick="changeColor('#FF5E00')"></dd>
							<dd style="background-color: #FFBB00;" onclick="changeColor('#FFBB00')"></dd>
							<dd style="background-color: #FFE400;" onclick="changeColor('#FFE400')"></dd>
							<dd style="background-color: #ABF200;" onclick="changeColor('#ABF200')"></dd>
							<dd style="background-color: #1DDB16;" onclick="changeColor('#1DDB16')"></dd>
							<dd style="background-color: #00D8FF;" onclick="changeColor('#00D8FF')"></dd>
							<dd style="background-color: #0054FF;" onclick="changeColor('#0054FF')"></dd>
							<dd style="background-color: #5F00FF;" onclick="changeColor('#5F00FF')"></dd>
							<dd style="background-color: #FF007F;" onclick="changeColor('#FF007F')"></dd>
						</dl>
						<dl>
							<dd style="background-color: #F15F5F;" onclick="changeColor('#F15F5F')"></dd>
							<dd style="background-color: #F29661;" onclick="changeColor('#F29661')"></dd>
							<dd style="background-color: #F2CB61;" onclick="changeColor('#F2CB61')"></dd>
							<dd style="background-color: #F2CB61;" onclick="changeColor('#F2CB61')"></dd>
							<dd style="background-color: #BCE55C;" onclick="changeColor('#BCE55C')"></dd>
							<dd style="background-color: #86E57F;" onclick="changeColor('#86E57F')"></dd>
							<dd style="background-color: #5CD1E5;" onclick="changeColor('#5CD1E5')"></dd>
							<dd style="background-color: #6799FF;" onclick="changeColor('#6799FF')"></dd>
							<dd style="background-color: #6B66FF;" onclick="changeColor('#6B66FF')"></dd>
							<dd style="background-color: #F361DC;" onclick="changeColor('#F361DC')"></dd>
						</dl>
						<dl>
							<dd style="background-color: #670000;" onclick="changeColor('#670000')"></dd>
							<dd style="background-color: #662500;" onclick="changeColor('#662500')"></dd>
							<dd style="background-color: #665C00;" onclick="changeColor('#665C00')"></dd>
							<dd style="background-color: #476600;" onclick="changeColor('#476600')"></dd>
							<dd style="background-color: #002266;" onclick="changeColor('#002266')"></dd>
							<dd style="background-color: #002266;" onclick="changeColor('#002266')"></dd>
							<dd style="background-color: #BDBDBD;" onclick="changeColor('#BDBDBD')"></dd>
							<dd style="background-color: #BDBDBD;" onclick="changeColor('#BDBDBD')"></dd>
							<dd style="background-color: #5D5D5D;" onclick="changeColor('#5D5D5D')"></dd>
							<dd style="background-color: #000000;" onclick="changeColor('#000000')"></dd>
						</dl>					
					</div>
				</div>
				
		
			</td>
		</tr>

		<tr><td colspan="2" height="20"  align="center"></td></tr>
		
		<tr>
			<td colspan="2">
				<textarea id="content" name="content" class="content"></textarea>
			</td>
		</tr>
		
		</table>
		
		<table width="900" align="center" style="margin-top: 20px;">
		<tr align="center">
			<td  align="center">
				<input type="hidden" name="userName" value="${dto.userName }">
				<input type="hidden" name="bold" value=""><input type="hidden" name="italic" value=""><input type="hidden" name="fontsize" value="10pt">
				<input type="hidden" name="underline" value=""><input type="hidden" name="lineThrough" value=""><input type="hidden" name="color" value="#000000">
				<button class="btn_blg_primary sendButton" type="button" onclick="sendIt();">보내기</button>
				<button class="btn_blg_secondary sendButton" type="reset" onclick="document.myForm.subject.focus();">다시입력</button>
			</td>
		</tr>
		</table>
		</form>
	</div>
</div>

<%@include file="../layout/footer.jsp"  %>
