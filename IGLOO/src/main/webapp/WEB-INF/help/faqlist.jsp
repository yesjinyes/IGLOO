<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/help/faqlist.css" />

<jsp:include page="../sidebar.jsp" />

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("div#answer").hide();
		$("div#hidebtn").hide();
		
		$("div#togglebtn").click(function(){
			$("div#answer").show();
			$("div#question").addClass("toggleq");
			$("div#togglebtn").hide();
			$("div#hidebtn").show();
			
		});
		
		$("div#hidebtn").click(function(){
			$("div#answer").hide();
			$("div#question").removeClass("toggleq");
			$("div#togglebtn").show();
			$("div#hidebtn").hide();
		});
		
		$("button#faqbtn").click(function(){
			location.href="<%=ctxPath%>/help/inquiry.ice";
		});
	});
	
</script>

<div id="content" class="mb-5">
	<c:if test="${not empty requestScope.faqlist}">
	<div>
		<div class="mx-3 p-3 mt-4" style="display: flex; justify-content: space-between;">
			<h2 style="font-weight: bold;">1:1 문의 내역</h2>
			<button id="faqbtn" type="button">1:1 문의하기</button>
		</div>
		
		<c:forEach var="faq" items="${requestScope.faqlist }">
		
		<div class="mb-5">
			<div id="question" class="mx-3 p-3">
				<div> 
					<span><span style="font-size: 15pt;">${fn:substring(faq.q_writeday, 0, 10)}</span>&nbsp;&nbsp; ${fn:substring(faq.q_writeday, 11, 19)}</span>
					<span>｜ <c:choose>
								<c:when test="${faq.fk_categoryno == 1 }">제품문의</c:when>
								<c:when test="${faq.fk_categoryno == 2 }">픽업문의</c:when>
								<c:when test="${faq.fk_categoryno == 3 }">지점문의</c:when>
								<c:when test="${faq.fk_categoryno == 4 }">결제문의</c:when>
								<c:when test="${faq.fk_categoryno == 5 }">기타문의</c:when>
							</c:choose> </span>
				</div>
				
				<div id="q_title" class="my-3" style="display: flex; justify-content: space-between;">
					<div>${faq.q_title}</div><div id="togglebtn" class="mx-3">▼</div><div id="hidebtn" class="mx-3">▲</div>
				</div>
				<div id="q_content">${faq.q_content }</div>
			</div>
			
			<c:if test="${faq.a_content != null}">
			
			<div id="answer" class="mx-3 p-3">
				<div id="a_title" class="my-3" style="text-align: center; font-size: 9pt; color: gray;">―――――――――――――――――― :::  1:1 문의 답변  ::: ――――――――――――――――――</div>
				<div>답변 작성 일자: ${fn:substring(faq.a_writeday, 0, 10)}&nbsp;&nbsp; ${fn:substring(faq.a_writeday, 11, 19)}</div>
				<div id="a_content">
					${faq.a_content}
				</div>
			</div>
			
			</c:if>
			
			<c:if test="${faq.a_content == null}">
			
			<div id="answer" class="mx-3 p-3">
				<div id="a_title" class="my-3" style="text-align: center; font-size: 9pt; color: gray;">―――――――――――――――――― :::  1:1 문의 답변  ::: ――――――――――――――――――</div>
				<div id="a_content">
					답변 대기 중입니다. 
				</div>
			</div>
			
			</c:if>
			
			
		</div>
		
		</c:forEach>
		
		
		
	</div>
	
	</c:if>
	
	
	<c:if test="${empty requestScope.faqlist}">
	
	1:1 문의내역이 존재하지 않습니다.
	
	</c:if>
	
	
	
	
	
	
	
	
	
</div>
		

		</div>
	</div>
</div>

<jsp:include page="../footer.jsp" />