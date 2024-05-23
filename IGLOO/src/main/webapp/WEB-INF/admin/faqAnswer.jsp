<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<% String ctxPath = request.getContextPath(); %>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("select[name='sizePerPage']").val("${requestScope.sizePerPage}");
		
		$("select[name='sizePerPage']").bind('change', function(){
			const frm = document.member_search_frm;
			frm.submit();
		});
		
		$("tbody > tr.faqInfo").click(function(e){ // 선택자는 tr이지만 클릭한 것은 td이다. 그러므로 e.target은 td태그를 가리킨다.
			
			const q_no = $(this).children("#q_no").text();
			
			const frm = document.faqOneDetail_frm;
			frm.fk_q_no.value = q_no;
			frm.action = "${pageContext.request.contextPath}/admin/faqAnswerDetail.ice";
			frm.method = "post";
			frm.submit();
		});		
		
		// ★★★★★★★★★★★★★★★★★★★★★ 문의 상세 정보 보여줘야 함!!!
		
		
	});
	
</script>

<jsp:include page="../header.jsp" />

<style type="text/css">

   table#faqQ tr.faqInfo:hover {
      background-color: #e6ffe6;
      cursor: pointer;
   }
   
   div#tableDiv {
   	  border: solid 1px #cce6ff;
   	  border-radius: 12px;
      overflow: hidden;
   	  
   }
   
   table#faqQ {
   margin: 0%;
   border-style: hidden;
   }

	.page-link {
	  color: #000; 
	  background-color: #fff;
	  border: 1px solid #cce6ff; 
	  font-weight: normal;
	}
	
	.page-item.active .page-link {
	 z-index: 1;
	 color: #555;
	 font-weight:bold;
	 background-color: #cce6ff;
	 border-color: #cce6ff;
	 	  font-weight: normal;
	}
	
	.page-link:focus, .page-link:hover {
	  color: #000;
	  background-color: #fafafa; 
	  border-color: #cce6ff;
		  font-weight: normal;
	}

</style>

<div class="container mt-5 pt-5">

	<div style="text-align: center; font-weight: bold;"><img style="width: 30%;" src="<%=ctxPath %>/images/img_narae/1대1문의목록.png"/></div>
	<form name="member_search_frm" class="mt-5">
		<span style="font-size: 12pt; font-weight: bold; margin-left: 80%;">페이지당 게시글수&nbsp;</span>
		<select name="sizePerPage">
			<option value="10">10개</option>
			<option value="5">5개</option>
			<option value="3">3개</option>      
		</select>
	</form>


	<div class="mb-5" id="tableDiv">
	<table class="table table-bordered" id="faqQ">
	
		<thead>
			<tr style="background-color: #ccf3ff; text-align: center;">
				<th style="width: 7%;">번호</th>
				<th style="display: none;">문의테이블 번호</th>
				<th style="width: 10%;">아이디</th>
				<th style="width: 8%;">회원명</th>
				<th style="width: 40%;">제목</th>
				<th style="width: 25%;">작성일자</th>
				<th style="width: 10%;">답변여부</th>
			</tr>
		</thead>
		
		<tbody>
			<c:if test="${not empty requestScope.faqList}">
			<c:forEach var="faq" items="${requestScope.faqList}" varStatus="status">
				<tr class="faqInfo">
					<fmt:parseNumber var="currentShowPageNo" value="${requestScope.currentShowPageNo}" />
          			<fmt:parseNumber var="sizePerPage" value="${requestScope.sizePerPage}" />
					<td style="text-align: center;">${requestScope.totalFaqCount - (currentShowPageNo-1)*sizePerPage - status.index}</td>
					<td id="q_no" style="text-align: center; display: none;">${faq.q_no }</td>
					<td style="text-align: center;">${faq.fk_userid}</td>
					<td style="text-align: center;">${faq.mvo.name}</td>
					<td>${faq.q_title}</td>
					<td style="text-align: center;">${faq.q_writeday }</td>
					<td style="text-align: center;">
						<c:if test="${faq.answerstatus == 0}"><span style="color: red; font-weight: bold;">미답변</span></c:if>
						<c:if test="${faq.answerstatus == 1}"><span style="color: blue;">답변완료</span></c:if>
					</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${empty requestScope.faqList}">
				<td colspan="5">데이터가 존재하지 않습니다.</td>
			</c:if>
		</tbody>
	</table>
	</div>

	<div id="pageBar" style="margin-left: 42%;">
       <nav>
          <ul class="pagination">${requestScope.pageBar}</ul>
       </nav>
    </div>
</div>

<form name="faqOneDetail_frm">
	<input type="hidden" name="fk_q_no" />
	<input type="hidden" name="goBackURL" value="${requestScope.currentURL}"/>
</form>

<jsp:include page="../footer.jsp" />