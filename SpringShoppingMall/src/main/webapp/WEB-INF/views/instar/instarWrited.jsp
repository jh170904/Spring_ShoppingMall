<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../layout/top.jsp" %>
<%@ include file="../layout/mypage.jsp" %>

<style>

.form_fields {
    max-width: 800px;
    width: 100%;
    margin: 30px auto 140px;
    padding-bottom: 20px;
    background-color: #ffffff;
    color: #424242;
    border-radius: 4px;
    box-sizing: border-box;
    box-shadow: 0 1px 3px 0 rgba(0,0,0,0.2);
    overflow: hidden;
}

#upload_image {
    height: 600px;
    background-color: #dcdcdc;
    position: relative;
}

#showImage{
	width: 800px;
	height: 600px;
}


.description {
    display: block;
    padding: 15px;
    outline: none;
    border: none;
    font-size: 15px;
    color : #8f8f8f;
    line-height: 28px;
}

.instarInput{
	padding: 15px;
    outline: none;
    border: none;
    width: 760px;
}

.ui-floating-menu {
    position: fixed;
    bottom: 0;
    width: 100%;
    height: 70px;
    overflow: hidden;
    z-index: 500;
    background-color: #8080ff;
    box-sizing: border-box;
}

.button {
    margin: 0;
    height: 100%;
    width: 230px;
    background: none;
    border: none;
    border-left: #8080ff;
    float: right;
    line-height: 50px;
    display: block;
    border-radius: 4px;
    font-size: 18px;
    font-weight: 700;
    color: #ffffff;
    cursor: pointer;
    text-align: center;
}

</style>

<script>

	function writeInstar(){
		
		var f = document.instarForm;
		
		str = f.iSubject.value;
		if(!str) {
	        alert("제목을 입력하세요");
	        f.iSubject.focus();
	        return;
	    }
		
		str = f.iContent.value;
		if(!str) {
	        alert("내용을 입력하세요");
	        f.iContent.focus();
	        return;
	    }
		
		str = f.iHashTag.value;
		if(!str) {
	        alert("태그 입력하세요");
	        f.iHashTag.focus();
	        return;
	    }
		
		f.action = "<%=cp%>/myPage/instarWrited_ok.action";
		f.submit();
		
	}
	
</script>

<body>
	<form id="instarForm" method="post" name="instarForm">
		<div class="form_fields">
			<div id="upload_image">
				<img id="showImage" src="${imagePath }/${iImage}">
			</div>
			
			<div class="description">
				<input type="text" name="iSubject" class="instarInput" placeholder="제목을 입력해주세요" style="border-bottom:1px #dcdcdc double">
			</div>
			
			<div class="description">
				<textarea rows="7" cols="85" name="iContent" class="instarInput" placeholder="내용을 입력해주세요" style="border-bottom:1px #dcdcdc double"></textarea>
			</div>
			
			<div class="description">
				<input type="text" name="iHashTag" class="instarInput" placeholder="태그를 입력해주세요(#태그1#태그2)">
			</div>
		</div>
		
		<div class="ui-floating-menu">
			<button class="button" onclick="writeInstar();">작성하기</button>
		</div>
		
		<input type="hidden" name="iNum" value="${iNum }">
	</form>
	
</body>


<%@ include file="../layout/footer.jsp" %>