<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
%>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/order/order.css" />

<jsp:include page="../header.jsp"/>


	<div class="container">
		
		<h4>주문 메뉴</h4>
		<br><br>
		
		<div class="card-deck mb-5">
		
		  <div class="card">
		    <img src="<%= ctxPath%>/images/cup_size/pint.png" class="card-img-top" alt="...">
		    <div class="card-body">
		      <h5 class="card-title">파인트</h5>
		      <p class="card-text">3가지 맛 (320g)</p>
		      <p class="card-text" style="font-weight: bold; font-size: 15pt;">8,000원</p>
		    </div>
		  </div>
		  
		  <div class="card">
		    <img src="<%= ctxPath%>/images/cup_size/quarter.png" class="card-img-top" alt="...">
		    <div class="card-body">
		      <h5 class="card-title">쿼터</h5>
		      <p class="card-text">4가지 맛 (620g)</p>
		      <p class="card-text" style="font-weight: bold; font-size: 15pt;">10,000원</p>
		    </div>
		  </div>
		  
		  <div class="card">
		    <img src="<%= ctxPath%>/images/cup_size/family.png" class="card-img-top" alt="...">
		    <div class="card-body">
		      <h5 class="card-title">패밀리</h5>
		      <p class="card-text">5가지 맛 (960g)</p>
		      <p class="card-text" style="font-weight: bold; font-size: 15pt;">15,000원</p>
		    </div>
		  </div>
		  
		  <div class="card">
		    <img src="<%= ctxPath%>/images/cup_size/halfgallon.png" class="card-img-top" alt="...">
		    <div class="card-body">
		      <h5 class="card-title">하프갤런</h5>
		      <p class="card-text">6가지 맛 (1200g)</p>
		      <p class="card-text" style="font-weight: bold; font-size: 15pt;">20,000원</p>
		    </div>
		  </div>
	
		</div>
		
	</div>
	
<%-- 개인 브랜치와 연결됐는지 확인하는 주석 --%>

<jsp:include page="../footer.jsp"></jsp:include>
