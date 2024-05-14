<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/sidebar.css" />


<div id="container" class="mx-auto">
	<div class="row">
		<div id="sidebar" class="col-3 mt-5" style="border:solid 1px blue; text-align:center;">
			<div id="sidebar" style="border:solid 3px #81BEF7; border-radius: 10px 10px; width:45%; margin-left:30%;">
				<div style="font-weight: bold; margin-top:5%;">마이페이지</div>
				<hr style="width: 80%;">
				<div style="font-weight: bold;">주문관리</div>
				<a style="color:black; text-decoration: none;" href="<%= ctxPath %>.up"><div>-주문조회</div></a>
				<br>
				<div style="font-weight: bold;">게시물 관리</div>
				<a style="color:black; text-decoration: none;" href="<%= ctxPath %>.up"><div>-내가 쓴 리뷰</div></a>
				<a style="color:black; text-decoration: none;" href="<%= ctxPath %>.up"><div>-1:1 문의 내역</div></a>
				<br>
				<div style="font-weight: bold;">정보관리</div>
				<a style="color:black; text-decoration: none;" href="<%= ctxPath %>.up"><div>-회원정보 변경</div></a>
				<a style="color:black; text-decoration: none;" href="<%= ctxPath %>.up"><div style="margin-bottom:5%;">-비밀번호 변경</div></a>
			</div>
		</div>
		
		<div id=”content” class="col-9" style="border:solid 1px red;">
<%-- 	
	본 내용에 이거 넣고 마무리하기	
			</div>
		</div>
	</div>
--%>