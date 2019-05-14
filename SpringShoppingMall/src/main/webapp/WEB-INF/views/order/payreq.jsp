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
function _pay(_frm) {
	
	_frm.sndReply.value = getLocalUrl("orderComplete.action?orderNum=${orderNum}&discount=${discount}&destZip=${destZip}&destAddr1=${destAddr1}&destAddr2=${destAddr2}&destAddrKey=${destAddrKey}&userEmail=${userEmail}&userName=${userName}&totalOrderPrice=${totalOrderPrice}&mode=card&totalPoint=${totalPoint}") ;

	_frm.action ='https://kspay.ksnet.to/store/KSPayFlashV1.3/KSPayPWeb.jsp?sndCharSet=utf-8';
	//_frm.action ='http://210.181.28.116/store/KSPayFlashV1.3/KSPayPWeb.jsp?sndCharSet=utf-8';
	_frm.submit();

}

function getLocalUrl(mypage) 
{ 
	var myloc = location.href; 
	return myloc.substring(0, myloc.lastIndexOf('/')) + '/' + mypage;
} 

</script>

</head>
<body onload="_pay(document.LGD_PAYINFO)">
<form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="<%=cp%>/order/orderComplete.action">

<input type="hidden" name="sndReply" value="file:///C:/Users/itwill/Downloads/%ED%86%B5%ED%95%A9%EB%AA%A8%EB%93%88(PC)/Web/jsp_utf8/kspay_wh_rcv.jsp">
<input type="hidden" name='sndStoreid' value='2999199999' size='15' maxlength='10'>
<input type='hidden' name='sndOrdername' value='${userName}' size='30'>
<input type='hidden' name='sndOrdernumber' value='${orderNum}' size='30'>
<input type='hidden' name='sndGoodname' value='${orderProdudct}' size='30'>
<input type='hidden' name='sndAmount' value='${totalOrderPrice}' size='15' maxlength='9'>
<input type='hidden' name='sndEmail' value='${userEmail}' size='30'>
<input type='hidden' name='sndMobile' value='${destPhone }' size='12' maxlength='12'>
<input type="hidden" name="sndPayMethod" value="1000000000">
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