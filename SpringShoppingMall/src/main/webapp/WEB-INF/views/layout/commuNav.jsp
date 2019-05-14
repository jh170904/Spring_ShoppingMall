<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp4 = request.getContextPath();
%>
<%@include file="./top2.jsp"  %>
		
		<table style="width: 1200px; margin-left: auto; margin-right: auto; ">
			<tr>
				<td>
				<div class="gnb_area" style="border: none;">
					<ul class="gnb">
						<li><a style="color: #8080FF;" href="<%=cp4 %>/pr/commuMain.action">커뮤니티</a></li>
						<li><a href="<%=cp4 %>/pr/storeMain.action">스토어</a></li>
					</ul>
				</div>
				</td>
			</tr>
			<tr>
			<td>
				<div class="gnb_area">
					<ul class="gnb" >
						<li><a href="#">커뮤니티홈</a></li>
						<li><a href="<%=cp4 %>/pr/commuList.action">코디</a></li>
						<li><a href="<%=cp4 %>/pr/codiHashTagList.action">테마</a></li>
						<li><a href="<%=cp%>/qna/questionMain.action">질문과 답변</a></li>
					</ul>
				</div>
				</td>
			</tr>
		</table>



		
		
		</div>
