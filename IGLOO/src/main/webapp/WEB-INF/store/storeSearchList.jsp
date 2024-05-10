<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>
<%-- 테스트 --%>
<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/main/storeSearchList.css" />

<jsp:include page="../header.jsp" />

<div id="storeSearch">
	<nav id="searchList" class="navbar navbar-expand-sm justify-content-center">
		<ul class="navbar-nav">
			<li class="nav-item">
		    	<a class="nav-link" href="#">리스트로 검색</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="#">지도로 검색</a>
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
		<img src="<%= ctxPath%>/images/search.png" class="img-fluid" alt="Responsive image">
	</button>
</div>

<%-- 구분선 --%>
<br><br>
<hr>
<br>

<%-- 아코디언 --%>
<div id="accordion_container">
	<div class="accordion" id="accordionExample">
  		<div class="card">
    		<div class="card-header" id="headingOne">
      			<h2 class="mb-0">
        			<button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
          				<h3>지점1</h3>
          				<p>주소</p>
        			</button>
      			</h2>
    		</div>
			<%-- 아코디언 내부 --%>
    		<div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
      			<div class="card-body">
        			<div class="card-columns m-5">
						<div class="card bg-primary text-white ">
						    <div class="card-body text-center">
						      	<img src="<%= ctxPath%>/images/map.png" class="img-fluid" alt="Responsive image" >
						    </div>
						</div>
						<div class="ml-5 pt-5">
						    <h1 class="card-text">지점1</h1>
						    <p class="card-text storeinfoDetails">주소</p>
						    <p class="card-text storeinfoDetails">영업시간</p>
						    <p class="card-text storeinfoDetails">전화번호</p>
						</div>
        			</div>
      			</div>
    		</div>
  		</div>
  		<div class="card">
    		<div class="card-header" id="headingTwo">
      			<h2 class="mb-0">
        			<button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
          				<h3>지점2</h3>
          				<p>주소</p>
        			</button>
      			</h2>
    		</div>
    		<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
      			<div class="card-body">
        			<div class="card-columns m-5">
						<div class="card bg-primary text-white ">
						    <div class="card-body text-center">
						      	<img src="<%= ctxPath%>/images/map.png" class="img-fluid" alt="Responsive image" >
						    </div>
						</div>
						<div class="ml-5 pt-5">
						    <h1 class="card-text">지점1</h1>
						    <p class="card-text storeinfoDetails">주소</p>
						    <p class="card-text storeinfoDetails">영업시간</p>
						    <p class="card-text storeinfoDetails">전화번호</p>
						</div>
        			</div>
      			</div>
    		</div>
  		</div>
  		<div class="card">
    		<div class="card-header" id="headingThree">
      			<h2 class="mb-0">
        			<button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
          				<h3>지점3</h3>
          				<p>주소</p>
        			</button>
      			</h2>
    		</div>
   			<div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionExample">
      			<div class="card-body">
        			<div class="card-columns m-5">
						<div class="card bg-primary text-white ">
						    <div class="card-body text-center">
						      	<img src="<%= ctxPath%>/images/map.png" class="img-fluid" alt="Responsive image" >
						    </div>
						</div>
						<div class="ml-5 pt-5">
						    <h1 class="card-text">지점1</h1>
						    <p class="card-text storeinfoDetails">주소</p>
						    <p class="card-text storeinfoDetails">영업시간</p>
						    <p class="card-text storeinfoDetails">전화번호</p>
						</div>
        			</div>
      			</div>
    		</div>
  		</div>
	</div>
</div>

<%-- Header 마무리에 따라 div 추가 닫기 --%>
<jsp:include page="../footer.jsp" />