<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="./top2.jsp"  %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp2 = request.getContextPath();
%>
		
		<table style="width: 1200px; margin-left: auto; margin-right: auto; ">
			<tr>
				<td>
				<div class="gnb_area" style="border: none;">
					<ul class="gnb">
						<li><a href="<%=cp2 %>/commuMain.action">커뮤니티</a></li>
						<li><a style="color: #8080FF;" href="<%=cp2 %>/storeMain.action">스토어</a></li>
					</ul>
				</div>
				</td>
			</tr>
			<tr>
			<td>
				<div class="gnb_area">
					<ul class="gnb" >
						<li><a href="#">스토어홈</a></li>
						<li><a href="<%=cp2 %>/listNew.action">카테고리</a></li>
						<li><a href="#">랭킹</a></li>
						<li><a href="#">코디속BEST</a></li>
					</ul>
				</div>
				</td>
			</tr>
		</table>



		
		
		</div>
