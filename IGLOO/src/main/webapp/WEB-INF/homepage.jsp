<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/main/homepage.css" />

<jsp:include page="header.jsp" />

<div id="main_logo">
	<img id="logo_img" src="<%= ctxPath%>/images/igloo_logo.png"/>
</div>
<div class="container mt-3">
	<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
		<ol class="carousel-indicators">
		<%-- 테이블 넣은 이후
			<c:if test="${not empty requestScope.imgList}">
				<c:forEach items="${requestScope.imgList}" varStatus="status">
			  		<c:if test="${status.index == 0}">
			  			<li data-target="#carouselExampleIndicators" data-slide-to="${status.index}" class="active"></li>
			  		</c:if>
			  		<c:if test="${status.index > 0}">
			  			<li data-target="#carouselExampleIndicators" data-slide-to="${status.index}" ></li>
			  		</c:if>
			  	</c:forEach>
			</c:if>
		--%> 
			<%-- 테이블 넣기 이전 시작 --%>
			<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li> 
			<%-- 테이블 넣기 이전 끝 --%>
		</ol>
		<div class="carousel-inner">
			<%-- 테이블 넣은 이후
			<c:if test="${not empty requestScope.imgList}">
				<c:forEach var="imgvo" items="${requestScope.imgList}" varStatus="status">
			  		<c:if test="${status.index == 0}">
			  			<div class="carousel-item active">
							<img src="<%= ctxPath %>/images/${imgvo.imgfilename}" class="d-block w-100" alt="..."> 
						</div>
			  		</c:if>
			  		<c:if test="${status.index > 0}">
			  			<div class="carousel-item">
						    <img src="<%= ctxPath %>/images/${imgvo.imgfilename}" class="d-block w-100" alt="...">	      
						</div>
			  		</c:if>
			  	</c:forEach>
			</c:if>
			--%>
			<%-- 테이블 넣기 이전 시작 --%>
			<div class="carousel-item active">
                <img src="<%= ctxPath%>/images/igloo_photo.png" class="d-block w-100 main_img" alt="..."> <!-- d-block 은 display: block; 이고  w-100 은 width 의 크기는 <div class="carousel-item active">의 width 100% 로 잡으라는 것이다. -->
                <div class="carousel-caption d-none d-md-block"> <!-- d-none 은 display : none; 이므로 화면에 보이지 않다가, d-md-block 이므로 d-md-block 은 width 가 768px이상인 것에서만 display: block; 으로 보여라는 말이다.  --> 
                </div>
            </div>
            <div class="carousel-item">
                <img src="<%= ctxPath%>/images/main_photo1.png" class="d-block w-100 main_img " alt="...">
                <div class="carousel-caption d-none d-md-block">
                </div>		      
            </div>
            <div class="carousel-item">
                <img src="<%= ctxPath%>/images/main_photo2.png" class="d-block w-100 main_img " alt="...">
                <div class="carousel-caption d-none d-md-block">
                </div>		      
            </div>
			<%-- 테이블 넣기 이전 끝 --%>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
        	<span class="carousel-control-prev-icon" aria-hidden="true"></span>
	    	<span class="sr-only">Previous</span>
	    </a>
	    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
	        <span class="carousel-control-next-icon" aria-hidden="true"></span>
	        <span class="sr-only">Next</span>
	    </a>
	</div>
	<%--
		이미지 변경 상 아이스크림스푼 위치 변동 이미지
	--%>
</div>
<div class="card-columns">
	<div class="card bg-primary text-white">
		<div class="card-body text-center">
			<p class="card-text">Some text inside the first card</p>
		</div>
	</div>
	<div class="card bg-warning text-white">
		<div class="card-body text-center">
			<p class="card-text">Some text inside the second card</p>
		</div>
	</div>
	<div class="card bg-success text-white">
		<div class="card-body text-center">
		    <p class="card-text">Some text inside the third card</p>
		</div>
	</div>
	<div class="card bg-danger text-white">
		<div class="card-body text-center">
		    <p class="card-text">Some text inside the fourth card</p>
		</div>
	</div>
</div>

<%-- Header 마무리에 따라 div 추가 닫기 --%>
<jsp:include page="footer.jsp" />
