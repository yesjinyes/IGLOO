<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<% String ctxPath = request.getContextPath(); %>

<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script>

<%-- J Query UI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	$("span#submit").click(function(){
		// alert("제출");
		const frm = document.answer;
		frm.action = "${pageContext.request.contextPath}/admin/faqAnswerRegister.ice";
		frm.method = "post";
		frm.submit();
	});
	
	$("span#reset").click(function(){
		const url = "<%=ctxPath%>${requestScope.goBackURL}";
		location.href = url;
	});
		
});

</script>

<jsp:include page="../header.jsp" />

<style type="text/css">
span.button {
display: inline-block;
width: 10%;
text-align: center;
border: solid 1px green;
cursor: pointer;

}
</style>

<div class="container" style="border: solid 1px red; margin-top: 5%;">

	<div class="my-5 p-5" id="customerQ" style="border: solid 1px green;">
		<h2>1:1 문의 답변</h2>
		<div id="customerDetail">
			
			<div><span>고객 ID</span><span id="userid">${requestScope.fvo.fk_userid }</span></div>
			<div><span>고객명</span><span id="name">${requestScope.fvo.mvo.name }</span></div>
			<div><span>등록날짜</span><span id="q_writeday">${requestScope.fvo.q_writeday }</span></div>
			<div><span>카테고리</span><span id="category"><c:choose><c:when test="${requestScope.fvo.fk_categoryno == 1}">제품문의</c:when>
																 <c:when test="${requestScope.fvo.fk_categoryno == 2}">픽업문의</c:when>
																 <c:when test="${requestScope.fvo.fk_categoryno == 1}">지점문의</c:when>
																 <c:when test="${requestScope.fvo.fk_categoryno == 1}">결제문의</c:when>
																 <c:otherwise>기타문의</c:otherwise></c:choose></span></div>
			<div><span>제목</span><span id="q_title">${requestScope.fvo.q_title }</span></div>
			<div><span>내용</span><span id="q_content">${requestScope.fvo.q_content }</span></div>
		</div>
	
	</div>
	
	<c:if test="${requestScope.fvo.answerstatus == 0}">
		<div class="mb-5 p-5" id="adminA" style="border: solid 1px blue;">
			<div class="mb-3" style="border: solid 1px red;">작성자: 관리자(admin)</div>
			<div class="mb-3" id="answerInput" style="text-align: center;">
				<form name="answer"><textarea name="answerText" rows="10" cols="120"></textarea><input type="hidden" name="q_no" value="${requestScope.fvo.q_no }" /></form>
			</div>
			<div id="buttons" style="text-align: right;"><span class="button mr-3" id="submit">등록</span><span class="button mr-5" id="reset">취소</span></div>
		</div>
	</c:if>

	<c:if test="${requestScope.fvo.answerstatus == 1}">
		<div class="mb-5 p-5" id="adminA_already" style="border: solid 1px blue;">
		<div class="mb-3" style="border: solid 1px red;">작성자: 관리자(admin)</div>
		<div><span>등록날짜</span><span id="writeday">${requestScope.fvo.a_writeday }</span></div>
		<div><span>내용</span><span id="a_content">${requestScope.fvo.a_content }</span></div>
		</div>
	</c:if>


</div>


<jsp:include page="../footer.jsp" />