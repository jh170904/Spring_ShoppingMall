<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../layout/top3.jsp" %>
<%@ include file="../layout/mypage.jsp" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        document.getElementById('layer').style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                    	addr += ' (' + extraAddr + ')';
                    }
                
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zip').value = data.zonecode;
                document.getElementById("addr1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addr2").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                document.getElementById('layer').style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(document.getElementById('layer'));

        // iframe을 넣은 element를 보이게 한다.
        document.getElementById('layer').style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 document.getElementById('layer')의 top,left값을 수정해 주시면 됩니다.
	function initLayerPosition(){
        var width = 500; //우편번호서비스가 들어갈 element의 width
        var height = 700; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 3; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        document.getElementById('layer').style.width = width + 'px';
        document.getElementById('layer').style.height = height + 'px';
        document.getElementById('layer').style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        document.getElementById('layer').style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        document.getElementById('layer').style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px'; 
    }
</script>

<script type="text/javascript">
	function writeDest() {
		
		var f = document.dest;
	    
	    str = f.destNickname.value;
	    str = str.trim();
	    if(!str) {
	        alert("배송지명을 입력하세요");
	        f.destNickname.focus();
	        return;
	    }
	    
	    <c:forEach items="${destNicknameList}" var="dest">
	    	if(str=="${dest}"){
		        alert("같은 배송지명이 존재합니다.");
		        f.destNickname.focus();
		        f.destNickname.value="";
		        return;
		    }
	    </c:forEach>
	    
	    str = f.destName.value;
	    str = str.trim();
	    if(!str) {
	        alert("받는사람을 입력하세요");
	        f.destName.focus();
	        return;
	    }
	    
	    str = f.destPhone.value;
	    str = str.trim();
	    if(!str) {
	        alert("휴대폰 번호를 입력하세요");
	        f.destPhone.focus();
	        return;
	    }
	    
	    str = f.destTel.value;
	    str = str.trim();
	    if(!str) {
	        alert("일반 전화번호를 입력하세요");
	        f.destTel.focus();
	        return;
	    }
	    
	    str = f.zip.value;
	    str = str.trim();
	    if(!str) {
	        alert("우편번호를 입력하세요");
	        f.zip.focus();
	        return;
	    }
	    
	    str = f.addr1.value;
	    str = str.trim();
	    if(!str) {
	        alert("기본주소를 입력하세요");
	        f.addr1.focus();
	        return;
	    }
	    
	    str = f.addr2.value;
	    str = str.trim();
	    if(!str) {
	        alert("상세주소를 입력하세요");
	        f.addr2.focus();
	        return;
	    }
	    
	    f.action = "<%=cp%>/dest/destwrited_ok.action";
	    f.submit();
		
	}

</script>

<form name="dest" method="post">

<div id="layer" style="display:none;position:fixed; overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<table class="page_title_area" style="margin-top: 80px; margin-bottom: 50px;">
<tr class="page_title">
	<td colspan="2" align="center">
		<h2 class="h_title page">배송지 추가</h2>
		<p class="text font_lg"></p>
	</td>
</tr>
</table>

<div class="ap_contents mypage" style="position: relative;">
<div class="address_list">

<hr class="div m20"/>
<table class="clear" style="width: 600px;" align="center">

<tr style="width: 700px;">
	<td colspan="2">
		<p class="text bullet_dot">자주 사용하시는 배송지를 등록 및 관리하실 수 있습니다./</p>
	</td>
</tr>

<tr>
	<td colspan="2" style="color: #6E6E6E;" width="500px;">
		<p class="text bullet_dot">배송지는 최대 5개까지 추가하실 수 있습니다.</p>
	</td>
</tr>

</table>
<hr class="div m20"/>


<table width="600" align="center">

<tr>
	<td width="100" height="50">배송지명</td>
	<td style="padding-left: 20px;">
		<input type="text" name="destNickname" maxlength="50" placeholder="배송지명을 입력해 주세요" 
			class="input_wrap w100p" style="padding: 10px 0px;">
	</td>
</tr>

<tr>
	<td width="100" height="50">받는사람</td>
	<td style="padding-left: 20px;">
		<input type="text" name="destName" maxlength="50" placeholder="받는 분 성함을 입력해 주세요" 
			class="input_wrap w100p" style="padding: 10px 0px;">
	</td>
</tr>

<tr>
	<td width="100" height="50">휴대전화</td>
	<td style="padding-left: 20px;">
		<input type="text" name="destPhone" maxlength="50" placeholder="010-1234-5678" 
			class="input_wrap w100p" style="padding: 10px 0px;">
	</td>
</tr>

<tr>
	<td width="100" height="50">일반 전화번호</td>
	<td style="padding-left: 20px;">
		<input type="text" name="destTel" maxlength="50" placeholder="02-123-4567" 
			class="input_wrap w100p" style="padding: 10px 0px;">
	</td>
</tr>

<tr>
	<td width="100" rowspan="3" height="50">주소</td>
	<td style="padding-left: 20px;">
	<input type="text" name="zip" id="zip" readonly="readonly" placeholder="우편번호" class="input_wrap w65p" style="padding: 10px 0px;">
		<input type="button" size="20" class="btn_md_form btn_address_fins" onclick="sample2_execDaumPostcode()" value="찾기">
	</td>
</tr>

<tr>
	<td style="padding-left: 20px;" height="50">
		<input type="text" name="addr1" id="addr1" readonly="readonly" placeholder="기본주소" class="input_wrap w100p" style="padding: 10px 0px;">
	</td>
</tr>
<tr>
	<td style="padding-left: 20px;" height="50">
		<input type="text" name="addr2" id="addr2" placeholder="상세주소" class="input_wrap w100p" style="padding: 10px 0px;">
	</td>
</tr>

<tr align="center">
	<td colspan="2">
		<input type="button" class="btn_blg_secondary" value="취소" onclick="javascript:location.href='<%=cp%>/dest/destlist.action';">
		<input type="button" class="btn_blg_primary" value="등록" onclick="writeDest();">
	</td>
</tr>

</table>

</div>
</div>

</form>

<%@ include file="../layout/footer.jsp" %>
