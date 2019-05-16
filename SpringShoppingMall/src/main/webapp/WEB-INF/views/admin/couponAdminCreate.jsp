<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="../layout/adminNav.jsp"  %>

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


	<div class="ap_contents product detail" style="padding-left: 150px;">
	
		<table width="600" border="1" bordercolor="#eeeeee" align="center" >
		
		<tr height="40">
			<td style="padding-left: 20px;">
			<b>쿠폰등록(ADMIN)</b>
			</td>
		</tr>
		</table>
		
		
		<br/><br/>
		
		<form name="couponMyForm" action="" method="post">
		<table border="0" align="center">
		
		<tr>
			<td colspan="2" height="1" bgcolor="#dbdbdb" align="center"></td>
		</tr>
		
		<tr>
			<td width="140" height="30" style="padding-left: 20px;">
			쿠폰이름
			</td>
			<td width="460" style="padding-left: 10px;">
			<input type="text" name="couponName" size="30" maxlength="20" class="boxTF">
			</td>
		</tr>
		
		<tr>
			<td width="140" height="30" style="padding-left: 20px;">
			할인금액
			</td>
			<td width="460" style="padding-left: 10px;">
			<input type="text" name="discount" size="30" maxlength="20" class="boxTF">&nbsp;&nbsp;원
			</td>
		</tr>
		
	
		<tr>
			<td width="140" height="60" style="padding-left: 20px;">
			적용되는 금액
			</td>
			<td width="460" style="padding-left: 10px;">
			<input type="text" name="couponScore" size="30" maxlength="20" class="boxTF">&nbsp;&nbsp;원
			</td>
		</tr>
		
		<tr>
			<td width="140" height="30" style="padding-left: 20px;">
			적용되는 등급
			</td>
			<td width="460" style="padding-left: 10px;">
			<input type="text" name="couponGrade" size="30" maxlength="20" class="boxTF">&nbsp;&nbsp;[SILVER/COLD/VIP]
			</td>
		</tr>
		
		<tr>
			<td width="140" height="30" style="padding-left: 20px;">
			적용 기간
			</td>
			<td width="460" style="padding-left: 10px;">
			<input type="text" name="period" size="30" maxlength="20" class="boxTF">&nbsp;&nbsp;일
			</td>
		</tr>
		
		
		<tr><td colspan="2" height="1" bgcolor="#dbdbdb" align="center"></td></tr>
		<tr>
			<td colspan="2" align="center">
				<div class="purchase_button_set" style="padding-left: 200px;">
					<span><button class="btn_lg_bordered emp btn_buy_now" type="button" onclick="couponSendIt();">쿠폰 등록</button></span>
					<span><button class="btn_lg_bordered emp btn_buy_now" type="button" onclick="javascript:location.href='<%=cp %>/admin/adminList.action';">쿠폰 리스트</button></span>
					<span><button class="btn_lg_primary btn_basket" type="reset" onclick="document.couponMyForm.productId.focus();">다시입력</button></span>
				</div>
			</td>
		</tr>
		
		</table>
		</form>
		
	</div>
	
<%@include file="../layout/footer.jsp"  %>