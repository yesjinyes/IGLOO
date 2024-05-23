<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
    String productimg = request.getParameter("productimg");
    String productname = request.getParameter("productname");
    String productprice = request.getParameter("productprice");
    
    System.out.println("productimg : "+ productimg);
    System.out.println("productname : "+ productname);
    System.out.println("productprice : "+ productprice);
%>

<jsp:include page="../header.jsp" />

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/order/order_detail.css" />

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/order/order_detail.js"></script>

<div class="container contents">
  
  <form name="orderDetailFrm">
  	<c:forEach var="detailList" items="${requestScope.detailList}" varStatus="status">
		
		<%-- 상품 정보(이미지, 상품명, 가격) --%>
		<div id="item_detail">
			<img src="<%= ctxPath%>/images/img_yejin/cup_size/${detailList.productimg}" class="card-img-top" style="width: 300px; height: 350px;" alt="사진경로잘못됨">
			<div class="p-0  my-auto">
				<div style="font-size: 30pt;"><%= productname%></div>
				<h6 style="font-size: 27pt; text-align: right;">${detailList.price}</h6>
			</div>
			
			<hr style="border: solid 1px #81BEF7;">
	  
			<div class="dropdown-label" style="font-weight: bold; font-size: 15pt;">
			    이글루 할래용
		    </div>
		 </div>
		 
  </c:forEach>    
	    <hr style="border: solid 1px #81BEF7;">
		
		<%-- 맛 선택 --%>
		<c:forEach var="tasteList" items="${requestScope.tasteList}" begin="0" end="2" varStatus="status">
	 		<%-- <p class="status">index값${status.index}</p> --%>
	 		<select id="taste" name="selectbox" class="infoData" > <!-- onchange="selectTaste(this)" -->
				<option value="">맛을 선택하세요</option>
	    		<c:forEach var="tvo" items="${requestScope.tasteList}">	
	             	<option value="${tvo.tasteno}">${tvo.tastename}</option>
		        </c:forEach> 
	        </select>
	    </c:forEach>
	     
		<hr style="border: solid 1px #81BEF7;">
		
		<%-- 선택한 맛, 수량 --%>
		<div style="border: solid 1px orange; display: flex;">
			<div class="row justify-content-around" style="border: solid 1px blue; width: 60%;">
				<div id="selecttasteList">
			    	<p id="tasteresult"></p>
			        <input type="hidden" name="selecttasteList"/>
				</div>
			</div>
		
			 <%-- 수량 +, - 버튼 --%>
			 <div class="num" style="border: solid 1px red; text-align: center; width: 20%;" >
			 	<span style="text-align: center;">수량</span><br>
			 	<span class="count">
			 		<a href="#" class="minus" style="font-size: 30pt; margin-right: 10pt;">-</a>
			 		<span id="result" style="font-size: 20pt;">1</span>
			 		<a href="#" class="plus" style="font-size: 20pt; margin-left: 10pt;">+</a>
			 	</span>
			 </div>
		</div>
    
                        
	<hr style="border: solid 1px #81BEF7;">
			
	<%-- 총 합계 금액 --%>
	<div class="row justify-content-between mb-3">
		<div class="col-4 text-left" style="font-weight: bold; font-size: 20pt;">합계</div>
		<div class="col-4"></div>
		<div class="col-4 text-right productprice" style="font-weight: bold; font-size: 20pt;">${requestScope.detailList.productprice}</div>
		<br>
	</div>

	<div id="button" class="mx-auto">
		<input type="button" class="btn btn-lg mr-5" value="장바구니" onclick="goCart('<%=ctxPath%>')" />
        <input type="button"  class="btn btn-lg" value="구매하기" onclick="goOrder('<%=ctxPath%>')" />
	</div>

	<%----------------------------------------------------------------------%>
	
	<%-- 하단 사진 --%>
	<hr style="border: solid 2px #4198e8;">

	<div id="image">
	  <c:forEach var="detailList" items="${requestScope.detailList}">
		<div class="row justify-content-center">
			<div class="col-md-7" style="font-weight: bold;"> 
				<img class="img-fluid" src="<%= ctxPath%>/images/img_yejin/cup_detail/${detailList.productimgBelow}">
			</div>
		</div>
	  </c:forEach>
	</div>
	
	<hr style="border: solid 2px #4198e8;">
	<div id="image">
		<div class="row">
			<div class="col-md-3" style="font-weight: bold;">아이스크림 맛별 이미지 넣기</div>
		</div>
	</div>
	
  </form>
</div>

<jsp:include page="../footer.jsp" />