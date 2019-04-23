<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp_ct = request.getContextPath();
%>
<%@page import="java.net.URLEncoder"%>
	<script type="text/javascript">

		$(document).ready(function() {
			$('.btn_close').click(function(){
				$("#bottom_menu").slideUp();
			})
		});

	</script>

<div id="bottom_menu" style="display: none;">
	<div class="category_wrap open" style="display: block;">
		<div class="inner_wrap">
			<h2 class="sr_only">전체메뉴</h2>
			<dl class="focus_target" tabindex="0">
				<dt class="on">
					<button type="button">유형별</button>
				</dt>
				<dd>
					<ul class="sub">
		
			   <% 
                  String arrCategory[] = {"아이","립","페이스","네일","스킨케어","팩/마스크","클렌징","바디/헤어","향수","화장소품"};
               
                  for(String s:arrCategory ){
                     
                     String category = URLEncoder.encode(s, "UTF-8");
                     out.println("<li><a href="+cp_ct+"/product/listCategory.do?productCategory="+category+">");
                     out.println(s+"</a></li>");
                  }
               %>
						</li>
						
						
					</ul>

					<div class="banner M02_prod_types_p_1" style="display: none;">

					</div>

					<div class="banner corner_slide M02_prod_types_p_2"
						style="width: 425px; display: block;">
						<div class="slide"
							data-ix-options="view-length:1; auto-play:true; delay:3000;">
							<div class="ix-list-viewport">
								<ul class="ix-list-items">
									<li class="ix-list-item"><a
										href="#none">
										<img alt="배너 내용"
										src="https://images-kr.etudehouse.com/fileupload/display/EH01/prod_types/ko/2019/02/28/배너카데고리-롤링배너_425_390_1551339488081.jpg"></a></li>
								</ul>
							</div>
							<div class="ix-controller">
								<ul class="ix-thumbs">
									<li class="ix-thumb"><button type="button" class="ix-btn">
											<!--ix-index-->
											번째 배너
										</button></li>
								</ul>
							</div>
						</div>
					</div>	
				</dd>
			</dl>
			<button type="button" class="btn_close">
			닫기</button>
		</div>
	</div>