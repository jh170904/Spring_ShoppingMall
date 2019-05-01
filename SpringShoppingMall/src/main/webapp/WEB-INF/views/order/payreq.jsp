<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<title>LG 유플러스 eCredit서비스 결제테스트</title>
<script language="javascript" src="http://xpay.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<script language="javascript" src="https://xpay.lgdacom.net:7443/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<script type="text/javascript">
/*
* iframe으로 결제창을 호출하시기를 원하시면 iframe으로 설정 (변수명 수정 불가)
*/
	var LGD_window_type = "iframe"; 

/*
* 수정 불가
*/
function launchCrossPlatform(){
		lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), 'test', LGD_window_type, null, "", "");
}


$(document).ready(function(){
	setTimeout('close()', 3000);
	
});

function closed() {
	window.open('about:blank','_self').self.close();
}

/*
 * FORM 명만  수정 가능
 */
function getFormObject() {
	return document.getElementById("LGD_PAYINFO");
}
/*
 * 일반용 수정가능(함수명은 수정 불가)
 */
function complete() {
	var f = document.getElementById("LGD_PAYINFO");
	f.action = "orderComplete.action";
	f.submit();
}

</script>

</head>
<body onload="complete();">
<form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="orderComplete.action">
<table>
    
    <tr>
        <td colspan="2">* 결제과 완료되었습니다. 결제완료를 눌러주세요.</td>
    </tr>
    <tr>
        <td colspan="2"></td>
    </tr>    
    <tr>
        <td colspan="2">
		<input type="button" value="결제완료" onclick="complete();"/>         
        </td>
    </tr>    
</table>

<input type='hidden' name='CST_PLATFORM' id='CST_PLATFORM' value='test'>
<input type='hidden' name='LGD_WINDOW_TYPE' id='LGD_WINDOW_TYPE' value='iframe'>
<input type='hidden' name='CST_MID' id='CST_MID' value='dacomst7'>
<input type='hidden' name='LGD_MID' id='LGD_MID' value= '${storeID}'>	<!-- 필수 : 상점ID -->
<input type='hidden' name='LGD_OID' id='LGD_OID' value='${orderNum}'>	<!-- 필수 : 주문번호 -->
<input type='hidden' name='LGD_BUYER' id='LGD_BUYER' value='${userName}'>	<!-- 필수 : 구매자명 -->
<input type='hidden' name='LGD_PRODUCTINFO' id='LGD_PRODUCTINFO' value='${orderProdudct}'>	<!-- 필수 : 구매내역 -->
<input type='hidden' name='LGD_AMOUNT' id='LGD_AMOUNT' value='${totalOrderPrice}'>	<!-- 필수 : 결제금액 -->
<input type='hidden' name='LGD_BUYEREMAIL' id='LGD_BUYEREMAIL' value='${userEmail}'>	<!-- 구매자 이메일 : 결제 성공시 해당 이메일로 결제내역 전송 -->
<input type='hidden' name='LGD_CUSTOM_SKIN' id='LGD_CUSTOM_SKIN' value='red'>	<!-- 사용자 정의 스킨 : red,purple,yellow -->
<input type='hidden' name='LGD_CUSTOM_PROCESSTYPE' id='LGD_CUSTOM_PROCESSTYPE' value='TWOTR'>
<input type='hidden' name='LGD_TIMESTAMP' id='LGD_TIMESTAMP' value='${currentTime}'>	<!-- 필수 : 현재시각 -->
<input type='hidden' name='LGD_HASHDATA' id='LGD_HASHDATA' value='${hashData}'>		<!-- 필수 : 해쉬데이탸ㅏ -->
<input type='hidden' name='LGD_RETURNURL' id='LGD_RETURNURL' value='http://15447772.co.kr/khk/db/xpayCross/returnurl.php'>
<input type='hidden' name='LGD_VERSION' id='LGD_VERSION' value='JSP_XPay_lite_1.0"'>
<input type='hidden' name='LGD_CUSTOM_USABLEPAY' id='LGD_CUSTOM_USABLEPAY' value='SC0010'>
<input type='hidden' name='LGD_CUSTOM_SWITCHINGTYPE' id='LGD_CUSTOM_SWITCHINGTYPE' value='IFRAME'>
<input type='hidden' name='LGD_WINDOW_VER' id='LGD_WINDOW_VER' value='2.5'>
<input type='hidden' name='LGD_ENCODING' id='LGD_ENCODING' value='UTF-8'>
<input type='hidden' name='LGD_ENCODING_NOTEURL' id='LGD_ENCODING_NOTEURL' value='UTF-8'>
<input type='hidden' name='LGD_ENCODING_RETURNURL' id='LGD_ENCODING_RETURNURL' value='UTF-8'>
<input type='hidden' name='LGD_ESCROW_USEYN' id='LGD_ESCROW_USEYN' value='N'>
<input type='hidden' name='LGD_CUSTOM_ROLLBACK' id='LGD_CUSTOM_ROLLBACK' value=''>
<input type='hidden' name='LGD_CASNOTEURL' id='LGD_CASNOTEURL' value='http://15447772.co.kr/khk/db/xpayCross/cas_noteurl.php'>
<input type='hidden' name='LGD_RESPCODE' id='LGD_RESPCODE' value=''>
<input type='hidden' name='LGD_RESPMSG' id='LGD_RESPMSG' value=''>
<input type='hidden' name='LGD_PAYKEY' id='LGD_PAYKEY' value=''>
<input type='hidden' name='destAddr' id='destAddr' value='${destAddr }'>
<input type='hidden' name='destZip' id='destZip' value='${destZip }'>
<input type='hidden' name='destAddr1' id='destAddr1' value='${destAddr1 }'>
<input type='hidden' name='destAddr2' id='destAddr2' value='${destAddr2 }'>
<input type='hidden' name='destAddrKey' id='destAddrKey' value='${destAddrKey }'>
<input type='hidden' name='totalPoint' id='totalPoint' value='${totalPoint }'>
<input type='hidden' name='mode' id='mode' value='card'>
<input type='hidden' name='discount' id='discount' value='${discount }'>

</form>
</body>
</html>