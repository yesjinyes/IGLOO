<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/order/payment.css" />

<jsp:include page="../header.jsp" />

<div class="container contents">
	
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


	<img src="<%= ctxPath%>/images/igloo_logo.png" style="width:130px;"/>
	<span style="margin-bottom: 1%; font-size: 25pt; font-weight: bold;">결제창</span>
	<div style="border: solid 5px black; background-color: #ccf2ff;  border-radius: 10px;" id="imgdiv">
		<div id="item_detail">
			<div style="margin-bottom: 1%; font-size: 13pt; font-weight: bold;">가게주소</div>
			<div style="background-color: white; border: solid 0px gray; border-radius: 10px; display: flex; align-items: center;" >
				<div style="margin: 2%;">
					<div style="font-size: 11pt; font-weight: bold; color: gray; margin-top: 1%;">서울특별시 마포구 월드컵북로 21 풍성빌딩 2층 GCLASS 25명의 사람들 안녕하세요 두줄로 만들어보려고 이렇게 늘려보느라 아무말이나 적는중</div>
				</div>
			</div>
			<hr style="border: solid 1px #81BEF7;">
			
			<div style="margin-bottom: 1%; font-size: 13pt; font-weight: bold;">내 연락처</div>
			<div style="background-color: white; border-radius: 10px; display: flex; align-items: center;" >
				<div style="margin: 2%;">
					<div style="font-size: 11pt; font-weight: bold; color: gray; margin-top: 1%;">010-1234-1234</div>
				</div>
			</div>
			<hr style="border: solid 1px #81BEF7;">
			
			<div style="margin-bottom: 1%; font-size: 13pt; font-weight: bold;">가게 사장님께</div>
			<div style="background-color: white; border-radius: 10px; display: flex; align-items: center;" >
				<div style="margin: 2%;">
					<div style="font-size: 11pt; font-weight: bold; color: gray; margin-top: 1%;">제가 먹어본 아이스크림중에는 이글루가 최고에요! 집 앞 3분거리에 베스킨라빈스 있는데 이제 거기로 가는 대신 이글루 옵니다. 오늘도 갈게요. 곧 뵈어요.</div>
				</div>
			</div>
			<hr style="border: solid 1px #81BEF7;">
			
			<div style="margin-bottom: 1%; font-size: 13pt; font-weight: bold;">결제 방법</div>
			<div style="background-color: white; border-radius: 10px; display: flex; align-items: center;" >
				<div style="margin: 2%;">
					<!-- <input id="male" type="radio" name="gender" checked/> --> <!-- checked 지정하면 디폴트값으로 선택됨. 복수개 지정가능 -->
					<input id="realmoney" type="radio" name="paymentmethod" />
					<label style="font-size: 11pt; font-weight: bold; color: gray; margin-top: 1%;" for="realmoney">만나서 결제</label>
					<br>
					<input id="mobilemoney" type="radio" name="paymentmethod" /> <!-- 같은 name 을 지정한 라벨들끼리는 그 중 하나만 선택할 수 있다. -->
					<label style="font-size: 11pt; font-weight: bold; color: gray; margin-top: 1%;" for="mobilemoney">모바일 결제</label>
				</div>
			</div>
			
			<hr style="border: solid 1px #81BEF7;">
			
			<div style="margin-bottom: 0%; font-size: 13pt; font-weight: bold;">결제 금액</div>
			<div style="background-color: white; border-radius: 10px;" >
				<div style="margin: 5% 5%;">
					<div class="row justify-content-between mb-3">
						<div class="col-4 text-left" style="font-weight: bold; font-size: 20pt;">합계</div>
						<div class="col-4"></div>
						<div class="col-4 text-right" style="font-weight: bold; font-size: 20pt;">8,000원</div>
						<br>
					</div>
					
					<hr style="border: solid 1px gainsboro;">

					<div class="row justify-content-between mb-3">
						<div class="col-4 text-left" style=" font-size: 10pt;">주문상품</div>
						<div class="col-4"></div>
						<div class="col-4 text-right" style="font-size: 10pt;">파인트</div>
						<br>
					</div>
				</div>	
			</div>
			<div id="button" class="mx-auto">
				<input type="button" class="btn btn-lg mr-5" value="취소하기" onclick="go...()" />
	            <input type="button"  class="btn btn-lg" value="구매하기" onclick="go...()" />
			</div>
		</div>
	</div>
	

	
</div>

<jsp:include page="../footer.jsp" />
