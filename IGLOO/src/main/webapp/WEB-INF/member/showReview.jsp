<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 형변환 해줄때  --%>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>


<jsp:include page="../header.jsp" />


<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/showReview.css" />




<div id="container">

	<div class="review">
		
		<div class="sumarry">
			<div class="img">
				제품 이미지
			</div>
			<div class="option">
				<h2>파인트</h2>
				<ul><%-- foreach --%>
					<li>초코나무숲</li>
					<li>초코나무숲</li>
					<li>초코나무숲</li>
				</ul>
			</div>
			<button class="btn" type="button" data-toggle="collapse" data-target="#hiddenContent" aria-expanded="false" aria-controls="hiddenContent">▼</button>
		</div>
		
		
		<div class="content collapse" id="hiddenContent">
			<div class="storeName">이글루 홍대점
				<span class="editBtn">
					<button>수정</button>
					<button>삭제</button>
				</span>
			</div>
			<%-- <c:if test="사진 있다면, 없다면"></c:if> --%>
			<div class="star">☆☆☆☆☆&nbsp;&nbsp;
				<span class="date">2024.05.14</span>
			</div>
			<div class="text">
			
				맛도리
			
			</div>
		</div>
	</div>
	
	<br><br><br><br><br>
	


	
	<div class="review">
		<div class="sumarry">
			<div class="img">
			
			</div>
			<div class="option">
			
			</div>
		</div>
		
		<div id="detail">
			<div class="storeName">이글루 부평점
				<button>수정</button>
				<button>삭제</button>
			</div>
			<%-- <c:if test="사진 있다면, 없다면"></c:if> --%>
			<div class="star">☆☆☆☆☆&nbsp;&nbsp;
				<span class="date">2024.05.10</span>
			</div>
			<div class="text">
			
				아이스크림이 착하고 사장님이 맛있어요
			
			</div>
		</div>
	</div>
	
	
	
</div>













<jsp:include page="../footer.jsp" />