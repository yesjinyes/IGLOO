<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<jsp:include page="../header.jsp" />

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/order/order_detail.css" />
<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/order/order_detail.js"></script>


<div class="container contents d-flex justify-content-center row">

	<form name="orderDetailFrm">
  		
  		<%-- 상품 구매정보 --%>
		<div id="imgdiv" style="width: 300px; height: 350px;">
			<img src="<%= ctxPath%>/images/img_yejin/cup_size/${requestScope.productimg}" style="width: 350px; height: 400px;]" alt="...">
		</div>
		
		<div id="item_detail" style="border: solid 1px green; display: inline-block;">
			
			<div style="font-size: 30pt;">${requestScope.productname}</div>
			<h6 style="font-size: 27pt; text-align: right;">
				<fmt:formatNumber value="${requestScope.productprice}" pattern="###,###" />원
			</h6>
		
			<hr style="border: solid 1px #81BEF7;">

			<%-- 맛 선택 --%>
			<c:forEach begin="1" end="${requestScope.tastecount}" varStatus="status">
		 		<p class="status"></p>
		 		<select id="taste${status.index}" name="selectbox" class="selectedtaste"> 
					<option value="">맛을 선택하세요</option>
		    		<c:forEach var="tvo" items="${requestScope.tasteList}">	
		             	<option value="${tvo.tasteno}">${tvo.tastename}</option>
			        </c:forEach> 
		        </select>
		    </c:forEach>
		    
			<input type="hidden" id="tastecount" value="${requestScope.tastecount}"/>
			<hr style="border: solid 1px #81BEF7;">

			<%-- 선택한 맛, 수량 --%>
			<div style="border: solid 1px orange; display: flex;">
				<div class="row justify-content-around" style="border: solid 1px blue; width: 70%; margin-right: 10%;">
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
				<div class="col-4 text-right productprice" style="font-weight: bold; font-size: 20pt;"></div>
				<br>
			</div>
		
			<div id="button" class="mx-auto">
				<input type="button" class="btn btn-lg mr-5" value="장바구니" onclick="goCart('<%=ctxPath%>')" />
		        <input type="button"  class="btn btn-lg" value="구매하기" onclick="goOrder()" />
			</div>
			
		</div>
	
		<%----------------------------------------------------------------------%>
	
		<%-- 하단 사진 --%>
		<hr style="border: solid 2px #4198e8;">
	
		<div id="image">
			<div class="row justify-content-center">
				<div class="col-md-7" style="font-weight: bold;"> 
					<img class="img-fluid" src="<%= ctxPath%>/images/img_yejin/cup_detail/${requestScope.productimgBelow}">
				</div>
			</div>
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

