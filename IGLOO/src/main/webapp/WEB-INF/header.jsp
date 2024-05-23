<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IGLOO</title>

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

<%-- jQuery UI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/header.css" />
<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/main/header.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	const navbar = document.querySelector("#nav_top"); //from HTML
	const navbarHeight = navbar.getBoundingClientRect().height;

	document.addEventListener("scroll", () => {
	  const scrollY = window.scrollY;

	  //navbar의 높이가 현재까지 스크롤 된 Y값보다 작다면 navbar에 fixed라는 클래스를 넣어라.
	  //1) 삼항연산자 사용
	  navbarHeight < scrollY ? navbar.classList.add("fixed") : navbar.classList.remove("fixed");
	  

	});
	
});

</script>

</head>
<body>
<%-- === 로그인 전 === --%>
<c:if test="${sessionScope.loginuser == null}">
	<nav id="nav_top" class="navbar navbar-expand-lg navbar-light fixed-top">
		<a class="navbar-brand" href="<%= ctxPath%>/"><img src="<%= ctxPath%>/images/igloo_logo.png" style="width:130px;"/></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto"> <!-- .mr-auto 는 css 의  margin-right: auto; 임. 즉, 가로축 미사용 공간 너비의 일부를 바깥 여백에 할당한다는 의미임. -->
		    	<li class="nav-item active">
		        	<a class="nav-link" href="<%= ctxPath%>/product/iceMenu.ice">
		        		<span class="color-first">메뉴</span>
		        	</a>
		      	</li>
		      	<li class="nav-item active">
		        	<a class="nav-link text-info" href="<%= ctxPath%>/order/order.ice">
						<span class="color-first">주문하기</span>
					</a>
		      	</li>
		      	<li class="nav-item active">
		        	<a class="nav-link" href="<%= ctxPath%>/store/searchList.ice">
						<span class="color-first">지점 찾기</span>
					</a>
		      	</li>
		      	<li class="nav-item active">
		        	<a class="nav-link" href="#">
						<span class="color-first">이벤트</span>
					</a>
		      	</li>
		      	<li class="nav-item active">
		        	<a class="nav-link" href="<%= ctxPath%>/help/help.ice">
						<span class="color-first">고객센터</span>
					</a>
		      	</li>
		    </ul>
		    
			<form style="margin-right:8.1%;" name="searchFrm" action="#" method="get" class="form-inline my-2 my-lg-0" >
		      	<input id="search" class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
		      	<button id="btnSearch" class="btn btn-outline-success my-2 my-sm-0" type="button">검색</button>
		    </form>
		    
        	<div class="text-end">
        		<button type="button" class="btn btn-outline-success ml-5 " onclick="javascript:register('<%= ctxPath%>')" >회원가입</button>
          		<button type="button" class="btn btn-outline-success" onclick="javascript:login('<%= ctxPath%>')">로그인</button>
        	</div>
		</div>
	</nav>
</c:if>
<%-- === 로그인 후 === --%>
<c:if test="${not empty sessionScope.loginuser}">
	<nav id="nav_top" class="navbar navbar-expand-lg navbar-light fixed-top ">
		<a class="navbar-brand" href="<%= ctxPath%>/">
			<img src="<%= ctxPath%>/images/igloo_logo.png" style="width:130px;"/>
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto"> <!-- .mr-auto 는 css 의  margin-right: auto; 임. 즉, 가로축 미사용 공간 너비의 일부를 바깥 여백에 할당한다는 의미임. -->
		    	<li class="nav-item active">
		        	<a class="nav-link" href="<%= ctxPath%>/product/iceMenu.ice">
		        		<span class="color-first">메뉴</span>
		        	</a>
		      	</li>
		      	<li class="nav-item active">
		        	<a class="nav-link text-info" href="<%= ctxPath%>/order/order.ice">
						<span class="color-first">주문하기</span>
					</a>
		      	</li>
		      	<li class="nav-item active">
		        	<a class="nav-link" href="<%= ctxPath%>/store/searchList.ice">
						<span class="color-first">지점 찾기</span>
					</a>
		      	</li>
		      	<li class="nav-item active">
		        	<a class="nav-link" href="#">
						<span class="color-first">이벤트</span>
					</a>
		      	</li>
		      	<li class="nav-item active">
		        	<a class="nav-link" href="<%= ctxPath%>/help/help.ice">
						<span class="color-first">고객센터</span>
					</a>
		      	</li>
		      	<c:if test="${not empty sessionScope.loginuser and sessionScope.loginuser.userid == 'admin'}">
			      	<li class="nav-item dropdown">
			        	<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" data-toggle="dropdown">
			          		관리
			        	</a>
			        	<div class="dropdown-menu" aria-labelledby="navbarDropdown">
			          		<a class="dropdown-item" href="<%= ctxPath%>/admin/memberList.ice">회원 목록</a>
			          		<a class="dropdown-item" href="<%= ctxPath%>/admin/orderListAll.ice">전체 주문 내역</a>
			          		<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="#">제품 등록</a>
			          		<a class="dropdown-item" href="<%= ctxPath%>/admin/faqAnswer.ice">문의 답변 등록</a>
		        		</div>
			      	</li>
		      	</c:if>
		    </ul>
		    
			<form name="searchFrm" action="#" method="get" class="form-inline my-2 my-lg-0" >
		      	<input id="search" class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
		      	<button id="btnSearch" class="btn btn-outline-success my-2 my-sm-0" type="button">검색</button>
		    </form>
		   
	       <div class="text-end" style="margin-left: 2%;">
           		<a href="<%= ctxPath %>/member/mypage.ice">
	              	<i class="fa-solid fa-user fa-xl"></i>
	              	&nbsp;&nbsp;
	              	<span>
	              		${sessionScope.loginuser.name}님 로그인 중
	              	</span>
              	</a>&nbsp;&nbsp;&nbsp;&nbsp;
              	<a href="<%= ctxPath %>/member/cart.ice">
              		<i class="fa-solid fa-cart-arrow-down fa-xl"></i>
              		&nbsp;&nbsp;
              		<span>
              			장바구니
              		</span>
              	</a>&nbsp;&nbsp;&nbsp;&nbsp;
              	<a href="<%= ctxPath %>/login/logout.ice">
              		<i class="fa-solid fa-right-from-bracket fa-xl"></i>
              		&nbsp;&nbsp;
              		<span>
              			로그아웃
              		</span>
              	</a> 
          </div>
		</div>
	</nav>
</c:if>