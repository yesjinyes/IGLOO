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
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/pastReview.css" />


<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/member/editReview.js"></script> <%-- 리뷰 수정 JS --%>




	<div id="content" class="col-9">

	<div id="btnReview">
		<a class="btn menufont_size" href="<%= ctxPath %>/member/ableReview.ice" >작성가능한 리뷰</a>
		<a class="btn menufont_size" href="<%= ctxPath %>/member/pastReview.ice" >작성한 리뷰</a>
	</div>
	
	<hr>
	<br>
	
	<c:if test="${not empty requestScope.pastList}">
		<c:forEach var="preview" items="${requestScope.pastList }">
	
		    <div class="col-md-12">
		      <div class="review">
		        <div class="sumarry">
		          <div class="img-container">
		            <img src="<%= ctxPath%>/images/img_hj/cup_size/pint.png"/>
		          </div>
		          <div class="option-container">
		            <h3>파인트</h3>
		          	
		            <ul>
		              <li>초코나무숲</li>
		              <li>초코나무숲</li>
		              <li>초코나무숲</li>
		            </ul>
		          </div>
		          <button class="toggleBtn" type="button" data-toggle="collapse" data-target="#hiddenContent1" aria-expanded="false" aria-controls="hiddenContent1">▼</button>
		        </div>
		        <div class="content collapse" id="hiddenContent1">
		          <div class="bind">
		          
		          	<%-- 주문매장 이름.  배열로 랜덤돌리기 --%>
		            <h3>매장명</h3>
		            
		            <%-- 수정, 삭제 버튼.  모든 버튼 이벤트 alert말고 컨펌으로 바꾸기 --%>
		            <div class="btns">
		              <a href="javascript:goEditReview('${(sessionScope.loginuser).userid}','<%= ctxPath%>')" id="btnEdit" class="btn btn-outline-secondary" role='button' >수정</a>
		              <button id="btnDel" class="btn btn-outline-secondary">삭제</button>
		            </div>
		          </div>
		          
		          <%-- 첨부된 리뷰사진 --%>
		          <div class="reviewImgs">
					<i class="fa-solid fa-image fa-10x"></i><%-- 리뷰사진 없다면 --%>
					<%-- 리뷰사진 있다면 포문. ${requestScope.첨부사진} --%>
		          </div>
		          
		          <%-- 별점 --%>
		          <div class="star"><%-- ${requestScope.star} --%>☆☆☆☆☆&nbsp;&nbsp; 
		            <span class="date">${requestScope.writedate}</span>
		          </div>
		          
		          <%-- 내용 --%>
		          <div class="text">
		            ${requestScope.reviewcontent}
		          </div>
		        </div>
		      </div>
		  </div>
		  
		</c:forEach>
	</c:if>
	
	
	
	<%-- 작성한 리뷰가 없을경우 --%>
    <c:if test="${empty requestScope.pastList}">
		<div style="text-align: center;" class="mt-5">
			<div id="noreview">리뷰를 작성해주세요!</div>
		</div>
	</c:if>

   
    
  </div>

</div>
</div>
</div>









<jsp:include page="../footer.jsp" />