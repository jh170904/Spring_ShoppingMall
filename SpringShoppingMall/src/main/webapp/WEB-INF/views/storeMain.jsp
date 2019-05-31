<%@page import="com.codi.dto.MemberDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="./layout/top.jsp"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">


$(function(){
	
	
	$(".goodButton").click(function(){

		var superProduct = $(this).attr('value');

        var info = '<%=(MemberDTO)session.getAttribute("customInfo")%>';
        
        if(info=="" || info==null){
        	alert("로그인이 필요합니다.");
        	return;
        }
        
        $.ajax({
            async: true,
            type : 'POST',
            data : superProduct,
            url : "../storeGoodOneItem.action",
            dataType : "json",
            contentType: "application/json; charset=UTF-8",
            success : function(data) {
            	if(data.cnt > 0) {
            		$(".goodDiv" + superProduct).html('<img src="../resources/image/heart1.PNG" style="height: 25px;"/> ');
                } else {
            		$(".goodDiv" + superProduct).html('<img src="../resources/image/heart2.PNG" style="height: 25px;"/> ');
                }
                
            },
            error : function(error) {
            	alert("로그인이 필요합니다.");
            }
        });
			
	});
	
});


$(function(){
	
    $(".featured-banner__scroller__item").click(function(){
    	
	   	$(".featured-banner__scroller__item").removeClass("active");			// active 클래스를 삭제.
		$(this).addClass("active");												// 클릭한 클래스에 (active)클래스 삽입.
		var imgSrc = $(this).find("img").attr("src");							// 이미지 src 추출
		var itemText = $(this).find(".featured-banner__scroller__item__text").text(); 
		var splitText = itemText.split(",");
		var subText = $(this).find(".featured-banner__scroller__item__subtext").text();
		
    	$(".featured-content__cover-image").fadeOut(400,'swing',function(){
    		$(".featured-content__cover-image img").attr("src",imgSrc);		// 메인 이미지 반영
    		$(".featured-content__cover-image").fadeIn(800);
    	});
    	
    	$(".featured-content__sub-title").fadeOut(400,'swing',function(){
    		$(".featured-content__sub-title").text(subText);				//서브타이틀 메인 반영
    		$(".featured-content__sub-title").fadeIn(800);
		});
		
    	$(".featured-content__title.0").fadeOut(400,'swing',function(){
			$(".featured-content__title.0").text(splitText[0]);				//타이틀1 메인 반영
			$(".featured-content__title.0").fadeIn(800);
		});
	
    	$(".featured-content__title.1").fadeOut(400,'swing',function(){
			$(".featured-content__title.1").text(splitText[1]);				//타이틀2 메인 반영
			$(".featured-content__title.1").fadeIn(800);
		});

    });
    
});

</script>


<style type="text/css">

.featured-banner {
    position: relative;
    height: 375px;
    overflow: hidden;
}

.featured-content__cover-image>img {
    display: block;
    float:right;
    height: 400px;
    margin-right: 750px;
}

.featured-content__title {
	display: inline;
    font-weight: 900;
    line-height: 1.2;
    font-size: 32px;
	cursor:pointer;
	font-family:"Noto Sans KR", "Apple SD Gothic Neo", "맑은 고딕", "Malgun Gothic", sans-serif;
	font-size:32px;
	font-weight:900;
	height:45px;
	letter-spacing:-0.4px;
	line-height:50px;
	width:306.492px;
	-webkit-box-direction:normal;
	-webkit-font-smoothing:antialiased; 
}
.featured-content__sub-title {
	display: inline;
    margin-top: 15px;
    font-size: 17px;
    line-height: 1;
}

.featured-content__text-wrap{
    margin-left: 400px;
	display: inline;
    position: absolute;
    left: 0px;
    top: 50%;
    -webkit-transform: translateY(-50%);
    transform: translateY(-50%);
    color: #000;	
}

.featured-content__sub-title {
	display: inline-block;
    font-size: 13px;
    margin-top: 8px;
    margin-left: 4px;
}

.featured-banner__item__content-wrap{
    color:#333;
	width: 100%;
	height: 300px;
	margin: 0 0 200px 200px;
	display: inline-block;
	-webkit-transition:width 2s, height 2s, background-color 2s, -webkit-transform 2s;
    transition:width 2s, height 2s, background-color 2s, transform 2s;
}

.featured-banner__scroller__item.active {
    background: #8080ff;
    color: #fff;
}


.featured-banner__scroller__item {
    display: flex;
    height: 76px;
    width: 100%;
    background: #fff;
    border: none;
    padding:0;
}

.featured-banner__scroller__item__text {
	width :100px;
    font-size: 11px;
    padding: 5px 5px;
	align-self: center;
    text-align: left;
    max-height: 74px;
    word-break: break-word;
    overflow: hidden;
}

.featured-banner__scroller__item__image > img {
	display:inline-block;
    margin-left: 10px;
    margin-top:10px;
    margin-bottom: 10px;
    width: 50px;
    height: 50px;
    border-radius: 25px; 
}

.featured-banner__scroller {
    max-width: 170px;
    top: 0;
    background: #fff;
    position: absolute;
    right: 350px;
}

.container {
	margin-right: auto;
	margin-left: auto;
	box-sizing: border-box;
	width: 1136px;
	max-width: 100%;
	box-sizing: border-box;
	min-height: 1px;
	margin-top: 40px;
}
body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, code, form, fieldset, legend, input, textarea, p, blockquote, th, td {
	margin: 0;
	padding: 0;
}

#store-index {
	display: -webkit-box;
	display: -moz-flex;
	display: -ms-flexbox;
	display: flex;
	-ms-flex-flow: column;
	-webkit-box-orient: vertical;
	-webkit-box-direction: normal;
	flex-flow: column;
}
header, footer, main {
	box-sizing: border-box;
	position: relative;
	display: block;
}
main {
	display: -webkit-box;
	display: -webkit-flex;
	display: -moz-flex;
	display: -ms-flexbox;
	display: flex;
	-webkit-box-direction: normal;
	-webkit-box-orient: vertical;
	-webkit-flex-direction: column;
	-moz-flex-direction: column;
	-ms-flex-direction: column;
	flex-direction: column;
	-webkit-box-flex: 1;
	-webkit-flex: 1 0 auto;
	-moz-box-flex: 1;
	-moz-flex: 1 0 auto;
	-ms-flex: 1 0 auto;
	flex: 1 0 auto;
	-ms-flex-negative: 0;
	min-height: 1px;
}

.container > h1 {
	color: #000;
	font-weight: 700;
	font-size: 20px;
	margin-bottom: 14px;
	position: relative;
}
.category-list-wrap {
	overflow: hidden;
	position: relative;
}
.category-list {
	display: -webkit-box;
	display: -moz-flex;
	display: -ms-flexbox;
	display: flex;
	position: relative;
}
/* @media all and (min-width:1024px) */
.category-list {
	-ms-flex-flow: nowrap;
	flex-flow: nowrap;
	-webkit-transition-property: -webkit-transform;
	transition-property: -webkit-transform;
	transition-property: transform;
	transition-property: transform, -webkit-transform;
	-webkit-transition-timing-function: ease;
	transition-timing-function: ease;
}
.category-list__next, .category-list__prev {
	position: absolute;
	height: 100%;
	width: 64px;
	top: 0px;
}
.category-list__next {
	right: 0px;
	background-image: -webkit-gradient(linear,left top,right top,from(hsla(0,0%,100%,.01)),to(#fff));
	background-image: linear-gradient(90deg,hsla(0,0%,100%,.01),#fff);
}
input[type='number'], input[type='text'], input[type='password'], input[type='file'], select, option, textarea, input[type='submit'], button {
	-webkit-appearance: none;
	-moz-appearance: textfield;
}
a {
	color: inherit;
	text-decoration: none;
}
a, button, [role=button], input[type=button], input[type=submit], input[type=reset] {
	cursor: pointer;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
}
input, textarea, select, button {
	font-size: inherit;
}
.category-list__next > button, .category-list__prev > button {
	position: absolute;
	top: 50%;
	-webkit-transform: translateY(-50%);
	transform: translateY(-50%);
	cursor: pointer;
	border: none;
	padding: 0;
	background: transparent;
}
.category-list__next > button {
	right: 0px;
}
/* @media all and (min-width:1024px) */
.category-item-wrap {
	-webkit-box-flex: 1;
	-moz-flex: 1;
	-ms-flex: 1;
	flex: 1;
	min-width: 10%;
}
.category-item-wrap > button {
	border: none;
	padding: 0;
	background: transparent;
	width: 100%;
	height: 100%;
}
fieldset, img {
	border: 0;
}
a * {
	border: none;
}
.category-item {
	text-align: center;
	font-weight: 700;
}
.category-item__image {
	position: relative;
	display: inline-block;
}
/* @media all and (min-width:1024px) */
.category-item__image {
	width: 80px;
	height: 80px;
}
/* @media all and (min-width:1024px) */
.category-item__title {
	margin-top: 20px;
	color: #333;
}
.category-item__image > svg {
	position: absolute;
	left: 50%;
	top: 50%;
	-webkit-transform: translate(-50%, -50%);
	transform: translate(-50%, -50%);
}
.product-item {
    margin-bottom: 20px;
    display: inline;
}
.product-item__image{
	display: inline-block;
}
.product-item__info__price {
    font-size: 17px;
    line-height: 17px;
    font-weight: 700;
    margin-right: 6px;
}

.product-item__info__price>.discount-rate {
    margin-right: 4px;
    font-weight:bold;
    color: #8080ff;
}

.product-item__info__price>strong {
    margin-right: 4px;
    color: #000;
}

.product-item__info__title>p {
    max-height: 32px;
}

p {
    display: block;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    margin-top: 5px;
    margin-bottom: 5px;
}

.product-item__info__title>p {
    max-height: 32px;
}

.featured-banner__scroller__item__subtext{
	display:none;
}

</style>
<div class="featured-banner">
<a href="<%=cp %>/pr/storeMain.action" >
	<div class="featured-banner__item" style="background: rgb(242, 242, 244);">
		<div class="featured-banner__item__content-wrap">
			<div class="featured-content__cover-image">
				<img src="<%=cp %>/resources/image/mainImage/830822023.jpg" width="600" height="300">
				<div style="background: linear-gradient(to right, rgb(242, 242, 244) 10px, rgba(242, 242, 244, 0));"></div>
			</div>
			<div class="featured-content__text-wrap" >
				<div class="featured-content__title 0" style="display:block;">DAILY TIP</div>
				<div class="featured-content__title 1" style="display:block;">단조로움을 거부한다</div>
				<div class="featured-content__sub-title" style="display:block;">봄,여름 상의 스타일링</div>
			</div>
		</div>
	</div>
</a>
<div class="featured-banner__scroller" style="color: #333;">
	<button class="featured-banner__scroller__item active" type="button">
		<div class="featured-banner__scroller__item__image">
		<img src="<%=cp %>/resources/image/mainImage/830822023.jpg" >
		</div>
		<div class="featured-banner__scroller__item__text">DAILY TIP, 단조로움을 거부한다</div>
		<div class="featured-banner__scroller__item__subtext">봄,여름 상의 스타일링</div>
	</button>
	<button class="featured-banner__scroller__item" type="button">
		<div class="featured-banner__scroller__item__image">
		<img src="<%=cp %>/resources/image/mainImage/1923042963.jpg" ></div>
		<div class="featured-banner__scroller__item__text">얼굴이 소멸되는 마법, '퍼프 소매'</div>
		<div class="featured-banner__scroller__item__subtext" >여리여리 해보이는 마법이 필요하다면</div>
	</button>
	<button class="featured-banner__scroller__item" type="button">
		<div class="featured-banner__scroller__item__image">
		<img src="<%=cp %>/resources/image/mainImage/691198742.jpg"></div>
		<div class="featured-banner__scroller__item__text">린넨의 계절, 여름</div>
		<div class="featured-banner__scroller__item__subtext">시원하고 스타일리쉬하게</div>
	</button>
	<button class="featured-banner__scroller__item" type="button">
		<div class="featured-banner__scroller__item__image">
		<img src="<%=cp %>/resources/image/mainImage/833582952.jpg"></div>
		<div class="featured-banner__scroller__item__text">같은 옷, 다른 코디</div>
		<div class="featured-banner__scroller__item__subtext">믹스매치를 통한 스타일링</div>
	</button>
	<button class="featured-banner__scroller__item" type="button">
		<div class="featured-banner__scroller__item__image">
		<img src="<%=cp %>/resources/image/mainImage/90390629.jpg" ></div>
		<div class="featured-banner__scroller__item__text">편안한 롱스커트, 데일리룩</div>
		<div class="featured-banner__scroller__item__subtext">꾸민듯 안꾸민듯 스타일링</div>
	</button>
	</div>
</div>
</section>

<section class="container">
<h1>카테고리</h1>
<div class="category-list-wrap">
<div class="category-list fold">
<div class="category-item-wrap">
	<a href="<%=cp %>/pr/listCategory.action?productCategory=OUTER">
		<div class="category-item">
			<img class="category-item__image" src="<%=cp %>/resources/image/categoryImage/outer.png">
			<div class="category-item__title">OUTER</div>
		</div>
	</a>
</div>
<div class="category-item-wrap">
	<a href="<%=cp %>/pr/listCategory.action?productCategory=TOP">
	<div class="category-item">
		<img class="category-item__image" src="<%=cp %>/resources/image/categoryImage/top.jpg" >
		<div class="category-item__title">TOP</div>
	</div>
	</a>	
</div>
<div class="category-item-wrap">
	<a href="<%=cp %>/pr/listCategory.action?productCategory=BOTTOM">
	<div class="category-item">
		<img class="category-item__image" src="<%=cp %>/resources/image/categoryImage/bottom.jpg" >
		<div class="category-item__title">BOTTOM</div>
	</div>
	</a>	
</div>
<div class="category-item-wrap">
	<a href="<%=cp %>/pr/listCategory.action?productCategory=DRESS">
	<div class="category-item">
		<img class="category-item__image" src="<%=cp %>/resources/image/categoryImage/dress.png" >
		<div class="category-item__title">DRESS</div>
	</div>
	</a>	
</div>
<div class="category-item-wrap">
	<a href="<%=cp %>/pr/listCategory.action?productCategory=SHOES">
	<div class="category-item">
		<img class="category-item__image" src="<%=cp %>/resources/image/categoryImage/shoes.png" >
		<div class="category-item__title">SHOES</div>
	</div>
	</a>	
</div>
<div class="category-item-wrap">
	<a href="<%=cp %>/pr/listCategory.action?productCategory=BAG">
	<div class="category-item">
		<img class="category-item__image" src="<%=cp %>/resources/image/categoryImage/bag.jpg">
		<div class="category-item__title">BAG</div>
	</div>
	</a>	
</div>
<div class="category-item-wrap">
	<a href="<%=cp %>/pr/listCategory.action?productCategory=ACC">
	<div class="category-item">
		<img class="category-item__image" src="<%=cp %>/resources/image/categoryImage/acc.png">
		<div class="category-item__title">ACC</div>
	</div>
	</a>	
</div>
</section>

<section class="container">
<h1>인기상품</h1>
<table>
	<tr>
	<c:forEach var="dto" items="${lists }">
		<td width="275" style="padding: 10px;">
			<div class="product-item">
				<div class="product-item__image">
				<a href="<%=cp%>/pr/detail.action?superProduct=${dto.superProduct}">
					<img src="../upload/list/${dto.originalName}" style="width: 280px; height: 280px; border-radius: 15px;" >
				</a>
				</div>
					<div class="product-item__info">
						<div class="product-item__info__title">
						<p class="product-item__info__title__brand" style="font-weight: bold; color: #8080ff; font-size: 12pt;"><a href="${dto.storeUrl }" >${dto.storeName}</a></p>
						<p>${dto.productName}</p>
						</div>
						
						<div class="product-item__info__price" style="float: left;">
						<strong><fmt:formatNumber value="${dto.price}" groupingUsed="true" />원</strong>
						</div>

						<div class="product-item__info__col">
							<span style="font-size: 11pt;  color: #8080FF" >★</span>
							<span>평점 <fmt:formatNumber value="${dto.reviewRate}" pattern="0.0"/></span>
							<span>&nbsp;&nbsp;&nbsp;리뷰&nbsp;<fmt:formatNumber value="${dto.reviewCount}" pattern="0.0"/></span>
							<span style="font-size: 14pt;  color: #8080FF; float: right; padding-right: 20px;" >
								<input type="hidden" id="superProduct" value="${dto.superProduct}" >
								<button class="goodButton" value="${dto.superProduct}">
								<div class="goodDiv${dto.superProduct}" >
									<c:set var="k" value="0" />
									<c:forEach var="good" items="${good }">
									<c:if test="${dto.superProduct eq good}">
										<img src="../resources/image/heart2.PNG" style="height: 25px;"/> 
										<c:set var="k" value="1" />
									</c:if>
									</c:forEach>
									<c:if test="${k==0 }">
										<img src="../resources/image/heart1.PNG" style="height: 25px;"/> 
									</c:if>
								</div>
								</button>
							</span>
						</div>
					</div>
			</div>
		</td>
		</c:forEach>
	</tr>
</table>
</section>

<section class="container" style="padding-bottom: 30px;">
<h1>코디속 BEST</h1>
<table>
	<tr>
	<c:forEach var="dto" items="${codiBestlists }">
		<td width="275" style="padding: 10px;">
			<div class="product-item">
				<div class="product-item__image">
				<a href="<%=cp%>/pr/detail.action?superProduct=${dto.superProduct}">
					<img src="../upload/list/${dto.originalName}" style="width: 280px; height: 280px; border-radius: 15px;" >
				</a>
				</div>
					<div class="product-item__info">
						<div class="product-item__info__title">
						<p class="product-item__info__title__brand" style="font-weight: bold; color: #8080ff; font-size: 12pt;"><a href="${dto.storeUrl }" >${dto.storeName}</a></p>
						<p>${dto.productName}</p>
						</div>
						
						<div class="product-item__info__price" style="float: left;">
						<strong><fmt:formatNumber value="${dto.price}" groupingUsed="true" />원</strong>
						</div>

						<div class="product-item__info__col">
							<span style="font-size: 11pt;  color: #8080FF" >★</span>
							<span>평점 <fmt:formatNumber value="${dto.reviewRate}" pattern="0.0"/></span>
							<span>&nbsp;&nbsp;&nbsp;리뷰&nbsp;<fmt:formatNumber value="${dto.reviewCount}" pattern="0.0"/></span>
							<span style="font-size: 14pt;  color: #8080FF; float: right; padding-right: 20px;" >
								<input type="hidden" id="superProduct" value="${dto.superProduct}" >
								<button class="goodButton" value="${dto.superProduct}">
								<div class="goodDiv${dto.superProduct}" >
									<c:set var="k" value="0" />
									<c:forEach var="good" items="${good }">
									<c:if test="${dto.superProduct eq good}">
										<img src="../resources/image/heart2.PNG" style="height: 25px;"/> 
										<c:set var="k" value="1" />
									</c:if>
									</c:forEach>
									<c:if test="${k==0 }">
										<img src="../resources/image/heart1.PNG" style="height: 25px;"/> 
									</c:if>
								</div>
								</button>
							</span>
						</div>
					</div>
			</div>
		</td>
		</c:forEach>
	</tr>
</table>
</section>

<%@include file="./layout/footer.jsp"  %>