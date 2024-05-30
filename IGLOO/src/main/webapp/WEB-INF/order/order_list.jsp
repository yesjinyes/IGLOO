<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>
<%-- 관리자 탭 메뉴 내리기 --%>
<head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
</head>

<jsp:include page="../header.jsp" />
<jsp:include page="../sidebar.jsp" />

<%-- font 쥬아 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/order/order_list.css" />
<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/order/order_list.js"></script>

<%-- 주문내역 --%>
<div id="orderlistContents" class="mt-5">
	<span id="input_searchlist">주문내역 검색</span>
	
	<%-- 검색창 --%>
	<div class="input_text row justify-content-center mt-3">
		<label class="my-auto col-6 p-0">
			<input class="my-sm-0" type="text" name="orderlist_search" id="orderlist_search" required="required">
		</label>
		<button id="btnorderlistSearch" class="btn my-sm-0 px-0 pt-0 col-1" type="button">
			<img src="<%= ctxPath%>/images/img_hj/search.png" class="img-fluid" alt="Responsive image">
		</button>
	</div>	
	
	<hr>
		
	<%-- 기간 설정 --%>
	<div class="mb-5">
		<div id="setDuration" class="ml-4 my-3">기간 설정</div>	
		<div id="Periodgroup" class="mx-auto text-center">
			<div class="btn-group" role="group" class="mx-auto">
				<button type="button" class="btn btn-light">전체</button>
			  	<button type="button" class="btn btn-light">1개월</button>
			  	<button type="button" class="btn btn-light">3개월</button>
			  	<button type="button" class="btn btn-light">6개월</button>
			  	<button type="button" class="btn btn-light">1년</button>
			</div>
		</div>
	</div>
		
	<%-- 기간 표시 --%>
	<div class="ml-4 my-3">
		기간 : 
		<span id="selectdate"></span> ~ 
		<span id="nowdate">2024.05.13</span>
	</div>
	
	<hr style="border: solid 2px #6190BC">
	<div id="orderlist"></div>
	
	<c:if test="${requestScope.haveorderlist == 'none'}">
		<div id="noorderlist" class="mx-auto text-center">
			<h3 class="mt-5 font-weight-bolder">주문내역에 담긴 상품이 없습니다.</h3>
			<div class="h-50 p-5 m-3"></div>
		</div>
	</c:if>
	
	<c:if test="${requestScope.haveorderlist != 'none'}">
	<%-- 주문내역 결과창 --%>
	<div id="SearchorderlistContents">
		<div class="orderdate ml-4"></div>
		
		<div class="Oneorderdate">
			<c:forEach var="orderdetailList" items="${requestScope.orderdetailList}" varStatus="orderdetailStatus">
				<%-- 해당 날짜 주문시간과 주문코드 --%>
				<div class="dateorderlist my-3 ml-4">
					<div>${orderdetailList.order.orderdate}</div>
					<div>주문코드 : ${orderdetailList.fk_ordercode}</div>
				</div>
					
				<%-- 해당 날짜 주문내역 --%>
				<div id="orderlist" class="row justify-content-center mb-3">
					<%-- 선택한 메뉴 이미지 --%>
					<div class="col-xl-2 col-lg-2 ">
						<img class="img-fluid mt-5" src="<%= ctxPath%>/images/img_hj/cup_size/${orderdetailList.product.productimg}" alt="Responsive image">
					</div>
				
					<%-- 선택한 제품과 맛 --%>
					<div class="orderMenu col-xl-3 col-lg-3 ">
							
						<%-- 선택한 제품 품목 --%>
						<label class="text-center mx-auto mt-3">${orderdetailList.product.productname}</label>
							
		       			<%-- 제품 선택한 맛 나열 --%>
		       			<div class="choiceAlltaste my-auto">
		       				<ul class="list-group list-group-flush">
		       					<c:forEach var="jjintotaltastelist" items="${requestScope.jjintotaltastelist}" varStatus="jjinStatus">
				  					<c:forEach var="totaltastelist" items="${jjintotaltastelist}">
				  						<c:if test="${jjinStatus.index == orderdetailStatus.index}">
				  							<li class="list-group-item">${totaltastelist}</li>
				  						</c:if>
				  					</c:forEach>
				  				</c:forEach>
							</ul>
						</div>
					</div>
					
					<%-- 수량 --%>
					<div class="selectMenucnt justify-content-center text-center col-xl-2 col-lg-2 p-0">
						<div class="mt-5">
							<div class="d-inline-block"></div>
							<div>수량</div>
							<span>${orderdetailList.ordercount}</span>
						</div>
					</div>
					
					<%-- 금액 --%>
					<div class="selectOrderprice justify-content-center text-center col-xl-2 col-lg-2 p-0">
						<div class="mt-5 mb-5">
							<div class="d-inline-block"></div>
							<div>
								<fmt:formatNumber value="${orderdetailList.orderprice}" pattern="###,###" />
								원
							</div>
						</div>
					</div>
						
					<%-- 주문상태 --%>
					<div class="Ordersituation justify-content-center text-center col-xl-2 col-lg-2 p-0">
						<div class="mt-5 mb-5">
							<div class="d-inline-block"></div>
							<div>
								<c:if test="${orderdetailList.pickupstatus == 1}">
									주문완료
								</c:if>
								<c:if test="${orderdetailList.pickupstatus == 2}">
									준비중
									<br>
									<span style="font-size:10pt;">예상 준비시간
										<br>
										${orderdetailList.pickuptime}
									</span>
								</c:if>
								<c:if test="${orderdetailList.pickupstatus == 3}">
									픽업대기
								</c:if>
								<c:if test="${orderdetailList.pickupstatus == 4}">
									픽업완료
								</c:if>
							</div>
						</div>
					</div>
				</div>
				
				<%-- 다른 주문목록 구분선 --%>
				<hr>
			</c:forEach>	
		<%-- 마무리 구분선 --%>
		<hr style="border: solid 2px #6190BC">
		</div>	
	</div>
	</c:if>
	<%-- 더보기 방식으로 페이징 처리 --%>
	<%--
	<div>
		<p class="text-center">
			<span id="end" style="display:block; margin:20px; font-size:14pt; font-weight:bold; color:red;"></span>
			<button type="button" class="btn btn-secondary btn-lg" id="btnMoreOrderlist" value="">더보기...</button>
			<span id="totalOrderlistCnt">${requestScope.totalOrderlistCnt}</span>
			<span id="countOrderlist">0</span>
		</p>
	</div>
	--%>
</div>

<%-- sidebar 닫기 --%>
		</div>
	</div>
</div>

<%-- 넘겨줄 정보 --%>
<form name="sendinfo" style="display:none;">
	<input type="text" name="searchorderList" value=""/>
	<input type="text" name="orderListPeriod" value=""/>
</form>

<div id="ctxPath" style="display:none;"><%= ctxPath%></div>

<jsp:include page="../footer.jsp" />