<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<jsp:include page="../header.jsp" />

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/main/storeSearchMap.css" />
<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/main/storeSearchMap.js"></script>

<div id="storeSearch">
	<nav id="searchList" class="navbar navbar-expand-sm justify-content-center">
		<ul class="navbar-nav">
			<li class="nav-item">
		    	<a class="nav-link" href="<%= ctxPath%>/store/searchList.ice">리스트로 검색</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="<%= ctxPath%>/store/searchMap.ice">지도로 검색</a>
		    </li>
		</ul>
	</nav>
</div>

<br>
<%-- 검색창 --%>
<div class="input_text">
	<label class="my-auto">
		<input class="my-sm-0" type="text" name="store_search" id="store_search" size="50" placeholder='지점명 또는 주소를 입력하세요' required="required">
	</label>
	<button id="btnSearch" class="btn my-sm-0" type="submit">
		<img src="<%= ctxPath%>/images/img_hj/search.png" class="img-fluid" alt="Responsive image">
	</button>
</div>

<%-- 구분선 --%>
<br><br>
<hr>
<%-- 지점 표시 --%>
<div id="ctxPath" style="display:none;"><%= ctxPath%></div>
<div id="searchDIV"></div>
<div id="nostoresearch" class="mx-auto text-center">
	<h3 class="mt-5 font-weight-bolder">지점명 또는 주소를 검색해주세요.</h3>
	<div class="h-50 p-5 m-3"></div>
</div>

<%-- Header 마무리에 따라 div 추가 닫기 --%>
<jsp:include page="../footer.jsp" />