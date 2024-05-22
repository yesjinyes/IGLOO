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

function goBack(url) {
	url = '<%=ctxPath%>'+url;
	location.href = url;
}

</script>

<head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
</head>

<jsp:include page="../header.jsp" />

<style type="text/css">

div#customerDetail {
background-color: #e6f3ff;
border-radius: 20px;
padding: 3%;
}

span.span {
display: inline-block;
background-color: white;
border-radius: 10px;
width: 10%;
font-weight: bold;
height: 30px;
text-align: center;
line-height: 200%;
margin-right: 1%;
}

div#customerDetail > div {
margin-bottom: 1%;
}

span#q_title {
display: inline-block;
background-color: white;
width: 85%;
height: 30px;
border-radius: 10px;
position: relative;
top: -2px;
padding-left: 1%;
line-height: 180%;
}

span#q_content {
display: inline-block;
background-color: white;
width: 85%;
height: 100px;
border-radius: 10px;
padding: 1%;
overflow: auto;
}

span#q_content_title {
position: relative;
top: -77px;
}

div#customerDetail > div > span:nth-child(2) {
padding-left: 1%;
}

div#AnswerWrap {
background-color: #e9edf1;
border-radius: 20px;
padding: 3%;
}

span#a_content {
display: inline-block;
background-color: white;
width: 85%;
height: 150px;
border-radius: 10px;
padding: 1%;
overflow: auto;
position: relative;
top: 15px;
}

span#a_content_title {
position: relative;
top: -113px;
}
</style>

<div class="container" style="margin-top: 5%;">

	<div class="mt-5 p-5" id="customerQ">
		<div style="text-align: center;"><img style="width: 30%;" src="<%= ctxPath%>/images/img_narae/1대1문의내용.png"/></div>
		<div id="customerDetail">
			
			<div><span class="span">고객 ID</span><span id="userid">${requestScope.fvo.fk_userid }</span></div>
			<div><span class="span">고객명</span><span id="name">${requestScope.fvo.mvo.name }</span></div>
			<div><span class="span">등록날짜</span><span id="q_writeday">${requestScope.fvo.q_writeday }</span></div>
			<div><span class="span">카테고리</span><span id="category"><c:choose><c:when test="${requestScope.fvo.fk_categoryno == 1}">제품문의</c:when>
																 <c:when test="${requestScope.fvo.fk_categoryno == 2}">픽업문의</c:when>
																 <c:when test="${requestScope.fvo.fk_categoryno == 1}">지점문의</c:when>
																 <c:when test="${requestScope.fvo.fk_categoryno == 1}">결제문의</c:when>
																 <c:otherwise>기타문의</c:otherwise></c:choose></span></div>
			<div><span class="span">제목</span><span id="q_title">${requestScope.fvo.q_title }</span></div>
			<div><span class="span" id="q_content_title">내용</span><span id="q_content">${requestScope.fvo.q_content }</span></div>
		</div>
	
	</div>
	<c:if test="${requestScope.fvo.answerstatus == 0}">
	<div style="color: #99ceff; font-size: 10pt; font-weight: bold; text-align: center;">============================== 답변 작성 ==============================</div>
		<div class="mb-5 p-5" id="adminA">
		<div id="AnswerWrap">
			<div class="mb-3" style="width: 93%; margin-left: 3%; font-size: 10pt; font-weight: bold;">작성자: 관리자(admin)</div>
			<div class="mb-3" id="answerInput" style="text-align: center;">
				<form name="answer"><textarea name="answerText" rows="10" cols="120"></textarea><input type="hidden" name="q_no" value="${requestScope.fvo.q_no }" /></form>
			</div>
			<div id="buttons" style="text-align: right;"><span class="btn btn-primary mr-3" id="submit">등록</span><span class="btn btn-light mr-5" id="reset">취소</span></div>
		</div>
		</div>
	</c:if>

	<c:if test="${requestScope.fvo.answerstatus == 1}">
		<div style="color: #99ceff; font-size: 10pt; font-weight: bold; text-align: center;">============================== 답변 내용 ==============================</div>
		<div class="p-5" id="adminA_already">
		<div id="AnswerWrap">
		<div class="mb-3" style="width: 93%; margin-left: 3%; font-size: 10pt; font-weight: bold;">작성자: 관리자(admin)</div>
		<div><span class="span">등록날짜</span><span id="writeday">${requestScope.fvo.a_writeday }</span></div>
		<div><span class="span" id="a_content_title">내용</span><span id="a_content">${requestScope.fvo.a_content }</span></div>
		</div>
		</div>
	</c:if>

<div style="text-align: center;"><span class="btn btn-info mb-5" onclick="goBack('${requestScope.goBackURL}')">목록 보기</span></div>

</div>


<jsp:include page="../footer.jsp" />