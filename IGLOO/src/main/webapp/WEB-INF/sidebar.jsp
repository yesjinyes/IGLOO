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
		<div id="sidebar" class="col-3 mt-5" style="border:solid 0px blue; text-align:center;">
		
			<div id="sidebar" style="border-radius: 10px 10px; width:55%; margin-left:30%;">
				<div style="background-color:#81BEF7; border: solid 2px #063460;">
					<div style="background-color:#81BEF7; vertical-align:center; font-weight:bold; margin: 10% auto;">마이페이지</div>
				</div>
				<div style="border: solid 2px #063460; border-top: solid 0px blue;">
					<br>
					<div style="background-color:#81BEF7; border-radius: 10px 10px; font-weight: bold; width:80%; margin: 0 auto;">주문관리</div>
					<a style="color:black; text-decoration: none;" href="<%= ctxPath %>.up"><div>주문조회</div></a>
					<br>
					<div style="background-color:#81BEF7; border-radius: 10px 10px; font-weight: bold; width:80%; margin: 0 auto;">게시물 관리</div>
					<a style="color:black; text-decoration: none;" href="<%= ctxPath %>.up"><div>내가 쓴 리뷰</div></a>
					<a style="color:black; text-decoration: none;" href="<%= ctxPath %>.up"><div>1:1 문의 내역</div></a>
					<br>
					<div style="background-color:#81BEF7; border-radius: 10px 10px; font-weight: bold; width:80%; margin: 0 auto;">정보관리</div>
					<a style="color:black; text-decoration: none;" href="<%= ctxPath %>.up"><div>회원정보 변경</div></a>
					<a style="color:black; text-decoration: none;" href="<%= ctxPath %>.up"><div style="margin-bottom:5%;">비밀번호 변경</div></a>
					<br>
				</div>
			</div>
		
		</div>
		
		<div id=”content” class="col-9" style="border:solid 1px red;">
<%-- 	
	본 내용에 이거 넣고 마무리하기	
			</div>
		</div>
	</div>
--%>