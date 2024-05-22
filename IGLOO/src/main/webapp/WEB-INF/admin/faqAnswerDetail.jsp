<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<% String ctxPath = request.getContextPath(); %>

<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script>

<%-- J Query UI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<jsp:include page="../header.jsp" />

<div class="container" style="border: solid 1px red; margin-top: 5%;">

	<div class="my-5" id="customerQ" style="border: solid 1px green;">
		<h2>1:1 문의 답변</h2>
		<div id="customerDetail">
			
			<div><span>고객 ID</span><span id="userid"></span></div>
			<div><span>고객명</span><span id="name"></span></div>
			<div><span>등록날짜</span><span id="writeday"></span></div>
			<div><span>카테고리</span><span id="category"></span></div>
			<div><span>제목</span><span id="q_title"></span></div>
			<div><span>내용</span><span id="q_content"></span></div>
			
		</div>
	
	</div>
	
	
	<div class="mb-5" id="adminA" style="border: solid 1px blue;">
	
	
	</div>




</div>


<jsp:include page="../footer.jsp" />