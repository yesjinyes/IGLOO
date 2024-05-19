<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
		// IGLOO	
%>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/order/order.css" />

<jsp:include page="../header.jsp"/>

<div class="container">
	
	<h4>주문 메뉴</h4>
	<br><br>
	
	<form name="cupsize" action="<%= ctxPath%>/order/order_detail.ice" method="get">
	
	  <div class="card-deck mb-5">
	  
		<div class="card" id="card_pint">
	      <img src="<%= ctxPath%>/images/img_yejin/cup_size/pint.png" class="card-img-top" style="height: 50%;" alt="...">
	      <div class="card-body">
	        <h5 class="card-title">파인트</h5>
	        <p class="card-text">3가지 맛 (320g)</p>
	        <p class="card-text" style="font-weight: bold; font-size: 15pt;">8,000원</p>
	      	<input type="submit" value="주문하기" style="float: right"/>
	      </div>
		</div>
		
		<div class="card" id="card_quarter">
	    <img src="<%= ctxPath%>/images/img_yejin/cup_size/quarter.png" class="card-img-top" style="height: 50%;" alt="...">
	      <div class="card-body">
	        <h5 class="card-title">쿼터</h5>
	        <p class="card-text">4가지 맛 (620g)</p>
	        <p class="card-text" style="font-weight: bold; font-size: 15pt;">10,000원</p>
	        <input type="submit" value="주문하기" style="float: right"/>
	      </div>
	    </div>
	  
	    <div class="card" id="card_family">
	    <img src="<%= ctxPath%>/images/img_yejin/cup_size/family.png" class="card-img-top" style="height: 50%;" alt="...">
	      <div class="card-body">
	        <h5 class="card-title">패밀리</h5>
	        <p class="card-text">5가지 맛 (960g)</p>
	        <p class="card-text" style="font-weight: bold; font-size: 15pt;">15,000원</p>
	        <input type="submit" value="주문하기" style="float: right"/>
	      </div>
	    </div>
	  
	    <div class="card" id="card_halfgallon">
	    <img src="<%= ctxPath%>/images/img_yejin/cup_size/halfgallon.png" class="card-img-top" style="height: 50%;" alt="...">
	      <div class="card-body">
	        <h5 class="card-title">하프갤런</h5>
	        <p class="card-text">6가지 맛 (1200g)</p>
	        <p class="card-text" style="font-weight: bold; font-size: 15pt;">20,000원</p>
	        <input type="submit" value="주문하기" style="float: right"/>
	      </div>
	    </div>
		
	</div>
	  
	<%-- form 으로 내용이 전달되려면 input 태그의 name 이 필요한데... 이걸 어떻게 넘길지.. --%>  
	<input type="hidden" name="productname"/>
	<input type="hidden" name="productdetail"/>
	<input type="hidden" name="price"/>
		
	</form>
	
</div>	
		
		
		
		
		
	<%-- 전에 작성했던 내용 (form 태그로 작성을 안해서 위에 다시 작성) --%>
	<%-- <div class="card-deck mb-5">
	
	  <div class="card" id="card_pint">
	    <img src="<%= ctxPath%>/images/img_yejin/cup_size/pint.png" class="card-img-top" alt="...">
	    <div class="card-body">
	      <h5 class="card-title">파인트</h5>
	      <p class="card-text">3가지 맛 (320g)</p>
	      <p class="card-text" style="font-weight: bold; font-size: 15pt;">8,000원</p>
	      <a href="<%= ctxPath%>/order/order_detail.ice" class="btn btn-info stretched-link">주문하기</a>
	    </div>
	  </div>
	  
	  <div class="card" id="card_quarter">
	    <img src="<%= ctxPath%>/images/img_yejin/cup_size/quarter.png" class="card-img-top" alt="...">
	    <div class="card-body">
	      <h5 class="card-title">쿼터</h5>
	      <p class="card-text">4가지 맛 (620g)</p>
	      <p class="card-text" style="font-weight: bold; font-size: 15pt;">10,000원</p>
	    </div>
	  </div>
	  
	  <div class="card" id="card_family">
	    <img src="<%= ctxPath%>/images/img_yejin/cup_size/family.png" class="card-img-top" alt="...">
	    <div class="card-body">
	      <h5 class="card-title">패밀리</h5>
	      <p class="card-text">5가지 맛 (960g)</p>
	      <p class="card-text" style="font-weight: bold; font-size: 15pt;">15,000원</p>
	    </div>
	  </div>
	  
	  <div class="card" id="card_halfgallon">
	    <img src="<%= ctxPath%>/images/img_yejin/cup_size/halfgallon.png" class="card-img-top" alt="...">
	    <div class="card-body">
	      <h5 class="card-title">하프갤런</h5>
	      <p class="card-text">6가지 맛 (1200g)</p>
	      <p class="card-text" style="font-weight: bold; font-size: 15pt;">20,000원</p>
	    </div>
	  </div>

	</div> --%>
	

<jsp:include page="../footer.jsp"></jsp:include>
