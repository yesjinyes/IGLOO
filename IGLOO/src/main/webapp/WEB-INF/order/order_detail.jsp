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
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQuery UI CSS 및 JS --%>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/header.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/order/order_detail.css" />

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/order/order_detail.js"></script>

</head>
<body>
	<nav id="nav_top" class="navbar navbar-expand-lg navbar-light fixed-top"><%-- bg-warning --%>
		<a class="navbar-brand" href="#"><i class="fa-solid fa-ice-cream fa-3x"></i></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto"> <!-- .mr-auto 는 css 의  margin-right: auto; 임. 즉, 가로축 미사용 공간 너비의 일부를 바깥 여백에 할당한다는 의미임. -->
		    	<li class="nav-item active">
		        	<a class="nav-link" href="#"><span class="color-first">메뉴</span></a>
		      	</li>
		      	<li class="nav-item active">
		        	<a class="nav-link text-info" href="#"><span class="color-first">주문하기</span></a>
		      	</li>
		      	<li class="nav-item active">
		        	<a class="nav-link" href="#"><span class="color-first">지점 찾기</span></a>
		      	</li>
		      	<li class="nav-item active">
		        	<a class="nav-link" href="#"><span class="color-first">이벤트</span></a>
		      	</li>
		      	<li class="nav-item active">
		        	<a class="nav-link" href="#"><span class="color-first">고객센터</span></a>
		      	</li>
		      	<c:if test="${not empty sessionScope.login_user and sessionScope.login_user.userid != 'admin'}">
			      	<li class="nav-item dropdown">
				        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" data-toggle="dropdown">
				        	회원전용
				        </a>
				        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
				        	<a class="dropdown-item" href="#">Action</a>
				          	<a class="dropdown-item" href="#">Another action</a>
				          	<div class="dropdown-divider"></div>
				          	<a class="dropdown-item" href="#">Something else here</a>
				        </div>
			      	</li>
		      	</c:if>
		      	<c:if test="${not empty sessionScope.login_user and sessionScope.login_user.userid == 'admin'}">
			      	<li class="nav-item dropdown">
			        	<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" data-toggle="dropdown">
			          		관리자전용
			        	</a>
			        	<div class="dropdown-menu" aria-labelledby="navbarDropdown">
			          		<a class="dropdown-item" href="#">Action</a>
			          		<a class="dropdown-item" href="#">Another action</a>
			          		<div class="dropdown-divider"></div>
			          		<a class="dropdown-item" href="#">Something else here</a>
		        		</div>
			      	</li>
		      	</c:if>
		      	<li class="nav-item">
		        	<a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
		      	</li>
		    </ul>
		    
			<form class="form-inline my-2 my-lg-0">
		      	<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
		      	<button class="btn btn-outline-success my-2 my-sm-0 button" type="submit">검색</button>
		    </form>
		    
        	<div class="text-end">
        		<button type="button" class="btn btn-outline-success ml-5 " onclick="javascript:sign('<%= ctxPath%>')" >회원가입</button>
                <button type="button" class="btn btn-outline-success" onclick="javascript:login('<%= ctxPath%>')">로그인</button>
        	</div>
		</div>
	</nav>
<%-- 여기까지 헤더 --%>
<div class="container contents">

	<div id="imgdiv">
		<div id="item_img">
			<img id="shootingstar" src="" />
		</div>
		
		<div id="item_detail">
			<div><span>컵 사이즈 이름</span></div>
			<h6>8,000원</h6>
			
			<hr style="border: solid 2px grey;">
			
			
			
			
			
			
	<div class="dropdown-label">
	    이글루
	    <span style="font-family: Material Icons;">restaurant</span>
    </div>
  <div class="dropdown">
    <button class="dropbtn dropdown-toggle">
      <span class="dropbtn_icon">more_horiz</span>
      <span class="dropbtn_content">Select a menu...</span>
      <span class="dropbtn_click" style="font-family: Material Icons; font-size : 16px; color : #3b3b3b; float:right;"
        onclick="dropdown()">▽</span>
    </button>
    <div class="dropdown-content">
      <div class="fastfood" onclick="showMenu(this.innerText)">Burgerking</div>
      <div class="fastfood" onclick="showMenu(this.innerText)">Mcdonals</div>
      <div class="fastfood" onclick="showMenu(this.innerText)">Lotteria</div>
    </div>
  </div>
  
  
  <div class="dropdown">
    <button class="dropbtn">
      <span class="dropbtn_icon">more_horiz</span>
      <span class="dropbtn_content">Select a menu...</span>
      <span class="dropbtn_click" style="font-family: Material Icons; font-size : 16px; color : #3b3b3b; float:right;"
        onclick="dropdown()">▽</span>
    </button>
    <div class="dropdown-content">
      <div class="fastfood" onclick="showMenu(this.innerText)">Burgerking</div>
      <div class="fastfood" onclick="showMenu(this.innerText)">Mcdonals</div>
      <div class="fastfood" onclick="showMenu(this.innerText)">Lotteria</div>
    </div>
  </div>
  
  
  <div class="dropdown">
    <button class="dropbtn">
      <span class="dropbtn_icon">more_horiz</span>
      <span class="dropbtn_content">Select a menu...</span>
      <span class="dropbtn_click" style="font-family: Material Icons; font-size : 16px; color : #3b3b3b; float:right;"
        onclick="dropdown()">▽</span>
    </button>
    <div class="dropdown-content">
      <div class="fastfood" onclick="showMenu(this.innerText)">Burgerking</div>
      <div class="fastfood" onclick="showMenu(this.innerText)">Mcdonals</div>
      <div class="fastfood" onclick="showMenu(this.innerText)">Lotteria</div>
    </div>
  </div>
  
  
  <hr style="border: solid 2px grey;">
  
  
  
  
  
			
			<h3>컵 사이즈 이름</h3>
			<div> 수량 </div>
			<div><span>- 맛 이름</span></div>

			<hr style="border: solid 2px grey;">
			
			<div id="detail_ingredient">
			
				<div id="sum">
					<span>합계</span><span>원</span>
				</div>
				
				<br>
				
			</div>
				<div id="button" class="mx-auto">
					   <input type="button" class="btn btn-success btn-lg mr-5" value="가입하기" onclick="goRegister()" />
                       <input type="reset"  class="btn btn-danger btn-lg" value="취소하기" onclick="goReset()" />
				</div>
		</div>
	</div>
	
	<hr style="border: solid 2px grey;">

	<div id="Nutrition">
		<div class="row">
			<div class="col-md-3" style="font-weight: bold;">사진</div>
		</div>
	</div>
	<div id="Nutrition">
		<div class="row">
			<div class="col-md-3" style="font-weight: bold;">사진</div>
		</div>
	</div>

</div>
<%-- 여기까지 컨텐츠 --%>

     <div class="row mt-2 mb-4 text-center" id="footer" style="width:90%; margin: 0 auto;">
       <div class="col-md-12">
          <p>
             &copy; Company 2024 &nbsp;&nbsp; 대표전화(전국): 1577-1588
          </p>
          <p>
             쌍용강북교육센터 우수한 형제자매들
          </p>
       </div>
     </div>

</body>
</html>
<%-- 여기까지 푸터 --%>
