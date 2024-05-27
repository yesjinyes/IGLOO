<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 형변환 해줄때  --%>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/iceMenu.css" />
<script type="text/javascript" src="<%= ctxPath%>/js/menu/iceMenuMore.js"></script>   


<div class="container" style="margin-top: 1%;">
     <div class="row" sty id="displayAlign" style="text-align: left;"></div> <%-- 행개수는 따로 설정하지 않고 3줄 기본으로 함. --%>
</div>
