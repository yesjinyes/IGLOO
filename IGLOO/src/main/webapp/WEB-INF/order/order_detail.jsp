<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<jsp:include page="../header.jsp" />

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/order/order_detail.css" />
<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/order/order_detail.js"></script>

<div id="ctxPath" style="display:none;"><%= ctxPath%></div>
<div class="container contents justify-content-arround">

	<form name="orderDetailFrm">
	
		<%-- 상품 구매 상단 정보 띄우기 시작--%>
		<div class="row justify-content-center">
		
			<div id="imgdiv" style="border: solid 0px red;" class="col-md-4">
				<img src="<%= ctxPath%>/images/img_yejin/cup_size/${requestScope.pvo.productimg}" class="img-fluid" style="border: solid 0px blue;" alt="...">
			</div>
			
			<div id="item_detail" style="border: solid 1.5px #81BEF7; padding: 4% 5%; margin-left: 5%;" class="col-md-6">
				
				<div style="font-size: 30pt;">${requestScope.pvo.productname}</div>

				<h6 style="font-size: 27pt; text-align: right;">
					<fmt:formatNumber value="${requestScope.pvo.price}" pattern="###,###" />원
				</h6>
				<input type="hidden" id="productprice" value="${requestScope.pvo.price}"/>
				<hr style="border: solid 1px #81BEF7;"><br>
				
				<%-- 맛 선택 --%>
				<c:forEach begin="1" end="${fn:substring(requestScope.pvo.productdetail, 0, 1)}" varStatus="status">
			 		<p class="status"></p>
			 		<select id="taste${status.index}" name="selectbox" class="selectedtaste" style="padding: 0.5% 0;"> 
						<option value="">맛을 선택하세요</option>
			    		<c:forEach var="tvo" items="${requestScope.tasteList}">	
			             	<option value="${tvo.tasteno}">${tvo.tastename}</option>
				        </c:forEach>
			        </select>
			    </c:forEach>
			    
				<input type="hidden" id="tastecount" value="${fn:substring(requestScope.pvo.productdetail, 0, 1)}"/>

				<br><hr style="border: solid 1px #81BEF7;">
			
				<%-- 선택한 맛, 수량 --%>
				<div id="resultList" style="border: solid 0px black; font-size: 11pt;">
				</div>
			
				<%-- 총합계 금액 --%>
				<div class="row justify-content-center" >
					<div class="col-4 text-left" style="font-weight: bold; font-size: 20pt;">합계</div>
					<div class="col-2"></div>
					<div class="col-6 text-right">
						<span class="productprice" style="font-weight: bold; font-size: 20pt; border: solid 0px red;">0</span>
						<span style="font-weight: bold; font-size: 20pt; border: solid 0px blue;">원</span>
					</div>
					<input type="hidden" name="productprice" value="${requestScope.pvo.price}"/>
					<br>
				</div>
			
				<%-- 장바구니, 구매하기 버튼 --%>
				<div id="button" class="mx-auto" align="center">
					<input type="button" class="btnclick btn-lg mr-5" value="장바구니" onclick="goCart()" />
			        <input type="button"  class="btnclick btn-lg" value="주문하기" onclick="goOrder()" />
				</div>
					
			</div>
		</div>
		
		<%----------------------------------------------------------------------%>
	
		<%-- 하단 사진 --%>
		<br><br><hr style="border: solid 2px #4198e8;"><br><br>
	
		<div id="image">
			<div class="row justify-content-center">
				<div class="col-md-7" style="font-weight: bold;"> 
					<img class="img-fluid" src="<%= ctxPath%>/images/img_yejin/cup_detail/${requestScope.pvo.productimgBelow}">
				</div>
				
				
				<hr style="border: solid 1px #bad9f7; width: 80%; margin: 5% 0;">
				
				<div>
				<p id="menutitle">맛 상세정보</p>
					<c:forEach begin="1" end="28" varStatus="status">
						<img id="order_detail_menuimg" class="img-fluid" src="<%= ctxPath%>/images/img_yejin/order_detail_menuimg/${status.index}.png" /> 			
					</c:forEach>
				</div>
			</div>
		
		</div>
		
	</form>
	 
	<br><br><hr style="border: solid 2px red; width: 70%;">
	
	
</div>


<%-- 넘겨줄 정보(맛번호) --%>
<form name="tasteinfo">
   <input type="text" name="tasteno" value=""/>
   <input type="text" name="pcode" value="${requestScope.pvo.productcodeno}"/>
</form>


<%-- footer 넣어야 함 --%>
<%-- <jsp:include page="../footer.jsp" /> --%>

