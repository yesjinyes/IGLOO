<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 형변환 해줄때  --%>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<%-- 폰트어썸 --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-Avb2QiuDEEvB4bZJYdft2mNjVShBftLdPG8FJ0V7irTLQ8Uo0qcPxh4Plq7G5tGm0rU+1SPhVotteLpBERwTkw==" crossorigin="anonymous" referrerpolicy="no-referrer" />



<jsp:include page="../sidebar.jsp" /> 

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/ableReview.css" />

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/member/ableReview.js"></script> <%-- 리뷰 수정 JS --%>



<div id="content" class="col-9">

	<div id="btnReview">
		<a class="btn menufont_size" href="<%= ctxPath %>/member/ableReview.ice" >작성가능한 리뷰</a>
		<a class="btn menufont_size" href="<%= ctxPath %>/member/pastReview.ice" >작성한 리뷰</a>
	</div>
	
	<hr>
	<br>
	
	
	<c:if test="${not empty requestScope.odvoList}">
		<c:forEach var="odvo" items="${requestScope.odvoList }">
		    <div class="col-md-12">
		      <div class="review">
		        
		        
		        <%-- 해당 날짜 주문시간과 주문코드 --%>
				<div class="dateorderlist my-3 ml-4">
					<div>${odvo.order.orderdate}</div>
					
					<br>
					
					<%-- 주문한 지점 이름 --%>
					<h3>홍대부평점</h3>
				</div>
				
				
				<%-- 선택한 메뉴 이미지 --%>
				<div class="img-container">
					<img class="img-fluid mt-5" src="<%= ctxPath%>/images/img_hj/cup_size/${odvo.product.productimg}" alt="Responsive image">
				</div>
				
		          
		          <div class="option-container">
			        <%-- 선택한 제품 품목 --%>
					<h3>${odvo.product.productname}</h3>
		          	<ul class="list-group list-group-flush">
		            	<c:forEach var="taste" items="${odvo.tastenamelist}" varStatus="jjinStatus">
		  							<li class="list-group-item">${taste.tastename}</li>
	  					</c:forEach>
		            </ul>
		          </div>
		          
		          <div class="btnwrite" style="margin-top:30px ; text-align: right;">
		          	<a href="javascript:goWriteReview('${(sessionScope.loginuser).userid}','<%= ctxPath%>')" id="btnWrite" class="btn btn-outline-secondary" role='button' >작성하기</a>
		          </div>
		        
		      </div>
		  </div>
		</c:forEach>
    </c:if>
    
    

    <c:if test="${empty requestScope.odvoList}">
		<div style="text-align: center;" class="mt-5">
			<div id="noreview">작성가능한 리뷰가 존재하지 않습니다.</div>
		</div>
	</c:if>

    
    
</div>


		</div>
	</div>
</div>







<jsp:include page="../footer.jsp" />