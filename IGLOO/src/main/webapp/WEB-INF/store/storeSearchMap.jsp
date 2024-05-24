<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/main/storeSearchMap.css" />

<jsp:include page="../header.jsp" />

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
<div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
	<div class="card-body">
    	<div class="card-columns m-5 row">
			<div class="card text-white col-lg-5 p-0">
				<div class="card-body text-center ">
					<img src="<%= ctxPath%>/images/img_hj/map.png" class="img-fluid" alt="Responsive image" >
				</div>
			</div>
			<div class="ml-5 pt-5 col-lg-3 col-md-4">
				<h1 class="card-text">지점1</h1>
				<p class="card-text storeinfoDetails">주소</p>
				<p class="card-text storeinfoDetails">영업시간</p>
				<p class="card-text storeinfoDetails">전화번호</p>
			</div>
      	</div>
    </div>
</div>
    	

<%-- Header 마무리에 따라 div 추가 닫기 --%>
<jsp:include page="../footer.jsp" />