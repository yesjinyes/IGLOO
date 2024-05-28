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
<script type="text/javascript" src="<%= ctxPath%>/js/order/order_detail_menu.js"></script>   


<div class="container pt-5" >
   	 
     <div class="row" id="displayAlign" style="text-align: left; margin-top: -15%;"></div>
  
      <%-- 더보기 버튼 --%>
      <div>
         <p class="text-center">
              <span id="end" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: red;"></span> 
			  <button type="button"  class="btn btn-outline-info btn-lg" id="btnMore" value="">더보기...</button>
			  <span id="totalCount">${requestScope.totalCount}</span>	
			  <span id="count">0</span>
         </p>
      </div>
    
</div>
  
