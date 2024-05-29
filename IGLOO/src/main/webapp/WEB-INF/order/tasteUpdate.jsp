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

<%-- font 감자꽃 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">

<%-- 직접 만든 CSS --%>
<style>
*{
	font-family: "Gamja Flower", sans-serif;
}
</style>

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/order/tasteUpdate.js" ></script> 
<script type="text/javascript">

window.onload = function(){
	   
   $("button#btnSubmit").click(function(){

       const iframe_updatetaste = document.getElementById("iframe_updatetaste");     
       
       const iframe_window = iframe_updatetaste.contentWindow;                  
       
       iframe_window.func_form_reset_empty();

   })  // end of $("button#btnSubmit").click(function(){})-------------
   
   $("button#btnCancel").click(function(){

       const iframe_updatetaste = document.getElementById("iframe_updatetaste");     
       
       const iframe_window = iframe_updatetaste.contentWindow;                  
       
       iframe_window.func_form_reset_empty();

   })  // end of $("button#btnCancel").click(function(){})-------------
   
}	// end of window.onload = function()-------
</script>
<div id="ctxPath" style="display:none;"><%= ctxPath%></div>
<form name="tasteUpdateFrm">
	<div class="m-3 text-center" style="border:solid 1px black;">
	<img src="<%= ctxPath%>/images/igloo_logo.png" style="width:150px;" class="my-1"/>
	<c:forEach var="selecttvo" items="${requestScope.selectTasteList}" varStatus="status">	
		<div class="my-2">
		<span>선택한 맛${status.count} : </span>
		<select name="selectbox" class="selectedtaste" style="padding: 0.5% 0;">
	   		<option value="${selecttvo.tasteno}">${selecttvo.tastename}</option>
	   		<c:forEach var="tvo" items="${requestScope.tasteList}">	
	        	<c:if test="${selecttvo.tastename != tvo.tastename}">
	        		<option value="${tvo.tasteno}">${tvo.tastename}</option>
	        	</c:if>
	        </c:forEach>
	   		</select>
	   		</div>
	   	</c:forEach>
	   	<button type="button" class="btn btnupdate btn-outline-info mb-3">수정</button>
	   	<button type="button" class="btn btn-outline-info mb-3" id="btnCancel" onclick="window.parent.changetaste()">취소</button>
	   	</div>
	   	<input id="updateTasteno" name="updateTasteno" style="display:none;"/>
	   	<input name="selectno" value="${requestScope.selectno}" style="display:none;"/>
</form>
