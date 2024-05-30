<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<jsp:include page="../header.jsp" />

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/main/storeSearchMap.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/main/storeLocation.css" />

<%-- map --%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=16695e6ff612a1dbaa353fda89e2424d"></script>

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/main/storeSearchMap.js"></script>

<div id="storeSearch" style="text-align:center;">
	<nav id="searchList" class="navbar navbar-expand-sm justify-content-center">
		<ul class="navbar-nav">
			<li class="nav-item">
		    	<a class="nav-link" href="<%= ctxPath%>/store/searchList.ice">리스트로 검색 │</a>
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
	 <span id="btnSearch" onclick="goSearch()" style="cursor: pointer;">
		<img src="<%= ctxPath%>/images/img_hj/search.png" class="img-fluid" alt="Responsive image">
	 </span>
</div>

<%-- 구분선 --%>
<br><br>
<hr>
<%-- 지점 표시 --%>
<div id="ctxPath" style="display:none;"><%= ctxPath%></div>
<div id="searchDIV"></div>
<div id="map" class="mx-auto text-center mb-5" style="width:70%; height:300px;"></div>

<%-- Header 마무리에 따라 div 추가 닫기 --%>
<jsp:include page="../footer.jsp" />