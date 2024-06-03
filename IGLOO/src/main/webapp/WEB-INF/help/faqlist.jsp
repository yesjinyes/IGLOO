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
		
		$("div#faqImgDiv").css("width", "10%");
		
		$("div#faqImgDiv").click(function(e){
		
			$(e.target).css("width", "50%");
			
		});
		
		$("div#togglebtn").click(function(e){
			
			$(e.target).parent().parent().parent().find("#answer").show();
			$(e.target).parent().parent().addClass("toggleq");
			$(e.target).hide();
			$(e.target).parent().find("#hidebtn").show();
			
		});
		
		$("div#hidebtn").click(function(e){
			
			$(e.target).parent().parent().parent().find("#answer").hide();
			// $("div#answer").hide();
			// $("div#question").removeClass("toggleq");
			$(e.target).parent().parent().removeClass("toggleq");
			$(e.target).parent().find("#togglebtn").show();
			$(e.target).hide();
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
				<div id="q_content">
					<div>${faq.q_content}</div>
					<c:if test="${not empty faq.faq_img}"><div id="faqImgDiv" class="toggle" style="text-align: center; margin-top: 3%;"><img id="faqImg" style="width: 50%;" src="<%=ctxPath %>/images/img_narae/faq_img/${faq.faq_img}"/>🔍</div></c:if>
				</div>
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
	
	<div style="text-align: center;" class="mt-5">
		<img style="width: 30%;" src="<%=ctxPath%>/images/img_narae/텅.png"/>
		<div id="nofaq">문의 내역이 존재하지 않습니다.</div>
	</div>
	
	</c:if>
	
	
	
	
	
	
	
	
	
</div>
		

		</div>
	</div>
</div>

<jsp:include page="../footer.jsp" />