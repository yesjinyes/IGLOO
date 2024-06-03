<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<jsp:include page="../header.jsp" />

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/order/cart.css" />
<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/order/cart.js"></script>
<script type="text/javascript">
window.closeModal = function(){
    $('.modal').modal('hide');
    setTimeout(function(){
    	javascript:history.go(0);
    },1000);
};

function changetaste() {
	closeModal();
	location.href="<%= ctxPath%>/member/cart.ice";
}

</script>
<%-- ======================================================================================= --%>
<%-- 컴퓨터 화면 --%>
<div id="ctxPath" style="display:none;"><%= ctxPath%></div>
<div id="cartContainer">
	<%-- 진행 현황 --%>
	<div id="orderProcedure" class="row justify-content-end mt-5">
		<div class="col-md-2 p-0">
			장바구니
		</div>
		<div class="col-md-2 col-lg-2 p-0">
			주문/결제
		</div>
		<div class="col-md-1 p-0">
			완료
		</div>
	</div>   

	<hr style="border: solid 2px #6190BC">
<c:if test="${requestScope.havecart == 'none'}">
	<div class="mx-auto text-center">
		<h3 class="mt-5 font-weight-bolder">장바구니에 담긴 상품이 없습니다.</h3>
		<p>원하는 상품을 장바구니에 담아보세요.</p>
		<button type="button" class="btn btndefault" onclick="javascript:continueShopping('<%= ctxPath%>')">쇼핑 계속하기</button>
		<div class="h-50 p-5 m-3"></div>
	</div>
</c:if>
<c:if test="${requestScope.havecart != 'none'}">
	<div class="totalSelect custom-control form-check mb-5">
		<input class="form-check-input" type="checkbox" value="" id="Allchecked">
	  	<label class="form-check-label ml-5" for="Allchecked">
	    	전체 선택
	  	</label>
		<label class="ml-5 my-auto">
			총 금액 : 
			<span class="cartTotalprice" style="font-weight:bold;">${requestScope.totalprice}</span>
			원
		</label>
	</div>
	
	<div id="cartview" class="col">
		<div id="choiceTotalMenu" class="custom-control custom-checkbox">
			<c:forEach var="cartList" items="${requestScope.cartList}" varStatus="cartStatus">
				<%-- 하나의 선택 메뉴 --%>
				<div class="choiceMenu">
					<%-- 하나의 선택 버튼 --%>
					<input id="${cartList.cartno}" name="choicemenu" class="custom-control-input test" type="checkbox" value="" />
					<div class="choiceOneMenu row custom-control-label">
						<%-- 선택한 메뉴 이미지 --%>
						<div class="menuclick col-xl-2 col-lg-2 col-md-2">
							<img class="img-fluid mt-5" src="<%= ctxPath%>/images/img_hj/cup_size/${cartList.product.productimg}" alt="Responsive image">
						</div>
		
						<%-- 선택한 제품과 맛 --%>
						<div class="menuclick SelectTotalMenu col-xl-3 col-lg-3 col-md-3 ">
							<%-- 선택한 제품 삭제 --%>
							<div class="row justify-content-end">
								<div class="col-2 mt-2">
									<div class="productname " style="display:none;">${cartList.product.productname}</div>
									<button class="delete btn pl-0 mr-5">
										<i class="fa-solid fa-xmark"></i>
									</button>
								</div>
							</div>
							<%-- 선택한 제품 품목 --%>
							<label class="text-center mx-auto mt-3">${cartList.product.productname}</label>
							<div class="card p-0 mb-3">
			         			<div class="card-body p-1">
			         			<c:forEach var="totaltastelist" items="${requestScope.totaltastelist}" varStatus="tasteStatus">
			         				<c:if test="${cartStatus.index == tasteStatus.index}">
										${totaltastelist}
									</c:if>
			           			</c:forEach>
			         			</div>
			       			</div>
		       			</div>
		       			
		       			<%-- 제품 선택한 맛 나열 --%>
		       			<div class="choiceAlltaste my-auto col-xl-3 col-lg-3 col-md-3 ">
		       				<ul class="list-group list-group-flush">
		       					<c:forEach var="tastenamelist" items="${cartList.tastenamelist}" varStatus="status">
			           				<li class="list-group-item">${tastenamelist.tastename}</li>
			           			</c:forEach>
							</ul>
							<div class="row justify-content-center">
								<div id="selectno" style="display:none;">${cartList.fk_selectno}</div>
								<button type="button" class="updatetaste btn btn-sm btn-outline-info col-10" data-toggle="modal" data-target="#updatetaste" data-dismiss="modal">수정</button>
							</div>
						</div>
						
						<%-- 수량 --%>
						<div class="selectMenucnt justify-content-center col-xl-2 col-lg-2 col-md-2 p-0">
							<div class="d-inline-block"></div>
							<div class="mb-5">
								<div id="divcartno" name="divcartno" style="display:none;">${cartList.cartno}</div>
								<span class="Productprice" style="display:none;">${cartList.product.price}</span>
								<div style="font-weight:bold; font-size:18pt;">수량</div>
								<button type="button" class="btn btnminus">
									<i class="fa-solid fa-minus"></i>
								</button>
								<span class="productCnt" style="font-weight:bold;">${cartList.count}</span>
								<button type="button" class="btn btnplus">
									<i class="fa-solid fa-plus"></i>
								</button>
							</div>
						</div>
						
						<%-- 금액 --%>
						<div class="selectOneprice my-auto justify-content-center text-center col-xl-2 col-lg-2 col-md-2 p-0">
							<div>
								<%-- 수량 * 제품가격 --%>
								<span class="choiceproductprice">${cartList.product.price * cartList.count}</span>
							</div>
						</div>
					</div>
				</div>
				<%-- 구분선 --%>
				<hr style="border: solid 1px black">
			</c:forEach>
			<%-- 선택메뉴 끝 --%>
		</div>
	</div>	<%-- 장바구니 내부 종료 --%>
	
	<%-- 주문금액 --%>
	<div id="orderPrice" class="mt-5 mb-5">
		<div class="row justify-content-end">
			<div class="col-4 col-sm-4 col-md-3 col-lg-2 text-right my-auto" style="font-weight: bold;">주문금액</div>
			<div class="col-4 col-sm-4 col-md-4 text-success my-auto" style="font-weight: bold;">
				<span id="totalPriceinfo" class="totalPrice" style="font-weight: bold;">0</span>
				원
			</div>
			<div class="mb-5"></div>
			<button type="button" class="btn btn-sm col-5 col-sm-4" onclick="javascript:continueOrder()">
			<span class="choiceCnt" style="font-weight: bold;">0</span>
			건 주문하기</button>
			<div class="col-1"></div>
		</div>
	</div>
	
	<%-- 하단 바 고정 --%>
	<nav class="footbar row justify-content-end navbar navbar-expand-sm bg-dark text-white navbar-dark fixed-bottom mx-3">
	  	<p class="my-auto col-md-2" style="font-weight:bold;">
	  		총&nbsp;
	  		<span style="font-weight: bold;" class="choiceCnt">0</span>
	  		<span style="font-weight:bold;">건</span>
	  		&nbsp;주문금액
	  	</p>
	  	&nbsp;&nbsp;
	    <p class="my-auto p-0 col-md-3" style="font-weight:bold;">
	    	<span class="navtotalPrice" style="font-weight:bold;">0</span>
			원
	    </p>
		<button onclick="javascript:continueOrder()" type="button" style="font-weight: bold; font-size:15pt;" class="orderbtn btn btn-sm btn-secondary ml-3 col-5 col-md-3 col-lg-3 col-xl-3">주문하기</button>
	</nav>
</c:if>
</div>
<%-- ======================================================================================= --%>

<%-- 넘겨줄 정보(ajax) --%>
<form name="sendinfo" style="display:none;">
	<input type="text" name="cartno" value=""/>
	<input type="text" name="prevCount" value=""/>
	<input type="text" name="count" value=""/>
</form>

<%-- 넘겨줄 정보(주문결제) --%>
<form name="orderinfo" style="display:none;">
	<input type="text" name="str_cartno" value=""/>
	<input type="text" name="str_selectno" value=""/>
	<input type="text" name="totalprice" value=""/>
</form>

<%-- ****** 맛 수정 Modal 시작 ****** --%>
  <div class="modal fade" id="updatetaste" data-backdrop="static">
   <div class="modal-dialog">
   		<div class="modal-content">
	        <%-- Modal body --%>
	        <div class="modal-body">
	          	<div id="updatetaste_frame">
					<iframe id="iframe_updatetaste" style="border: solid 1px black; width: 100%; height: 400px;">  
		            </iframe>
	          	</div>
	        </div>
    	</div>
  	</div>
</div>
<%-- ****** 맛 수정 Modal 끝 ****** --%>
<jsp:include page="../footer.jsp" />

