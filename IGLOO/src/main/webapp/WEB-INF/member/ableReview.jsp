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
<script type="text/javascript" src="<%= ctxPath%>/js/member/editReview.js"></script> <%-- 리뷰 수정 JS --%>




<div id="content" class="col-9">

	<div id="btnReview">
		<a class="menufont_size" href="<%= ctxPath %>/member/ableReview.ice">작성가능한 리뷰</a>
		<a class="menufont_size" href="<%= ctxPath %>/member/pastReview.ice">적성한 리뷰</a>
	</div>
	
	<hr>
	<br>
	
    <div class="col-md-12">
    
    
    </div>
     
</div>










<jsp:include page="../footer.jsp" />