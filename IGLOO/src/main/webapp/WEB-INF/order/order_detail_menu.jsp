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
    	<div id="header">
	      <h2 class="page-header__title">Ice Cream</h2>
	      <h10>한 입에 물면 달콤하게 사르르 녹는 아이스크림.<br>
			   당신이 어떤 기분이든 이글루를 만난 당신의 기분은 아마 달콤해졌을 거예요.</h10>
       </div>
    
    <div class="align">
	   <form name="align_frm" >
	      <span style="font-size: 12pt; font-weight: bold;">메뉴 정렬&nbsp;-&nbsp;</span>
	      <select name="menuAlign">
	         <option value="name">가나다순</option>
	         <option value="order">인기순</option>      
	      </select>
	    </form>
  	</div>
  	
 		 
     <div class="row" id="displayAlign" style="text-align: left;"></div> <%-- 행개수는 따로 설정하지 않고 3줄 기본으로 함. --%>

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
