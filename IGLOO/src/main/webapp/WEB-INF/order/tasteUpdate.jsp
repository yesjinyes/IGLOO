<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<%	
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

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

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/order/tasteUpdate.js" ></script> 

<div id="ctxPath"><%= ctxPath%></div>
<form name="tasteUpdateFrm">
	<%-- <c:forEach begin="1" end="${requestScope.tasteselectcnt}" varStatus="status"> --%>
	   	<c:forEach var="selecttvo" items="${requestScope.selectTasteList}" varStatus="status">	
	   		<select name="selectbox" class="selectedtaste" style="padding: 0.5% 0;">
	   		<option value="${selecttvo.tasteno}">${selecttvo.tastename}</option>
	   		<c:forEach var="tvo" items="${requestScope.tasteList}">	
	        	<c:if test="${selecttvo.tastename != tvo.tastename}">
	        		<option value="${tvo.tasteno}">${tvo.tastename}</option>
	        	</c:if>
	        </c:forEach>
	   		</select>
	   	</c:forEach>
	   	<button type="button" class="btn btnupdate">수정</button>
	   	<input id="updateTasteno" name="updateTasteno" />
	   	<input name="selectno" value="${requestScope.selectno}"/>
</form>
