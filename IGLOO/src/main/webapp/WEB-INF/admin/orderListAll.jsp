<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />

<style type="text/css">
span#ordercode {
	color: #3399ff;
	cursor: pointer;
}

span#ordercode:hover {
	text-decoration: underline;
}

tbody td {
 vertical-align : middle;
}
</style>

<div class="container mt-5 pt-5" style="border: solid 1px red;">

	<div id="top" style="text-align: center;">
		<img style="width: 30%;" src="<%= ctxPath%>/images/img_narae/전체주문내역.png"/>
	</div>

	<div>
	※ 주문자 정보는 주문코드 클릭 시 확인 가능합니다.<br>
	※ 주문상태 변경은 주문상태 클릭 시 변경 가능합니다.
	
	</div>
	
	

	<div id="tableDiv">
		<table class="table table-bordered" style="text-align: center;">
			<thead>
				<tr>
					<th>주문코드</th>
					<th>주문일자</th>
					<th>제품정보</th>
					<th>주문수량</th>
					<th>총 금액</th>
					<th>주문상태</th>
				</tr>
			</thead>
		
			<tbody>
				<c:forEach var="odvo" items="${requestScope.odvoList}">
					<tr>
						<td class="align-middle">
						
						
							<span id="ordercode" data-toggle="modal" data-target="#exampleModal_large">
							  ${odvo.order.ordercode}
							</span>
							
							<!-- Modal -->
							<div class="modal fade" id="exampleModal_large">
							  <div class="modal-dialog modal-lg modal-dialog-scrollable">
							  <!-- .modal-dialog 클래스를 사용하여 <div> 요소에 크기 클래스를 추가합니다. -->
							    <div class="modal-content">

							      <!-- Modal body -->
							      <div class="modal-body mt-5" style="border: solid 1px red;">
									  <img src="<%=ctxPath%>/images/img_narae/주문고객정보조회.png" style="width: 40%;"/>
									  <div style="border: solid 1px blue;"></div>
							        
							        
							      </div>
							      
							      <!-- Modal footer -->
							      <div class="modal-footer">
							        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
							        <button type="button" class="btn btn-primary">Save changes</button>
							      </div>
							    </div>
							  </div>
							</div>
						
						</td>
						<td class="align-middle">${odvo.order.orderdate}</td>
						<td class="align-middle">
							<div>${odvo.product.productname}</div>
							<div>선택옵션</div>
							<c:forEach var="taste" items="${odvo.tastenamelist}">
								<div>${taste.tastename}</div>
							</c:forEach>
						</td>
						<td class="align-middle">${odvo.ordercount}</td>
						<td class="align-middle"><fmt:formatNumber value="${odvo.order.totalprice}" pattern="###,###" />원</td>
						<td class="align-middle">
							<c:choose>
								<c:when test="${odvo.pickupstatus == 1}">주문완료</c:when>
								<c:when test="${odvo.pickupstatus == 2}">준비 중</c:when>
								<c:when test="${odvo.pickupstatus == 3}">픽업대기</c:when>
								<c:otherwise>픽업완료</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

</div>

<jsp:include page="../footer.jsp" />