<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />


<div class="container mt-5 pt-5" style="border: solid 1px red;">

	<div id="top" style="text-align: center;">
		<img style="width: 30%;" src="<%= ctxPath%>/images/img_narae/전체주문내역.png"/>
	</div>

	<div id="tableDiv">
		<table class="table table-bordered">
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
			
			
			
			</tbody>
		
		</table>
	</div>








</div>




<jsp:include page="../footer.jsp" />