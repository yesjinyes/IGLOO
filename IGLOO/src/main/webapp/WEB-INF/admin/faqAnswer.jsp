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
		
		$("select[name='sizePerPage']").val("${requestScope.sizePerPage}");
		
		$("select[name='sizePerPage']").bind('change', function(){
			const frm = document.member_search_frm;
			frm.submit();
		});
		
		$("tbody > tr.faqInfo").click(function(e){ // 선택자는 tr이지만 클릭한 것은 td이다. 그러므로 e.target은 td태그를 가리킨다.
			// alert($(e.target).parent().text()," 클릭");
			const userid = $(e.target).parent().find(".userid").text();
			// 또는 const userid = $(e.target).parent().children(".userid").text();
			
			const frm = document.memberOneDetail_frm;
			frm.userid.value = userid;
			frm.action = "${pageContext.request.contextPath}/admin/memberOneDetail.ice";
			// 만약 상단에서 .getContextPath를 하지 않았다면 따로 쓸 필요 없이 위와 같이 해주어도 동일하다.
			frm.method = "post";
			frm.submit();
		});		
		
		// ★★★★★★★★★★★★★★★★★★★★★ 문의 상세 정보 보여줘야 함!!!
		
		
	});
	
	function goSearch() {
		
		const frm = document.member_search_frm;
		frm.submit();
		
	}
</script>

<jsp:include page="../header.jsp" />

<style type="text/css">

   table#faqQ tr.faqInfo:hover {
      background-color: #e6ffe6;
      cursor: pointer;
   }

</style>

<div class="container mt-5 pt-5" style="border: solid 1px red;">

	<div style="text-align: center; font-weight: bold;">1:1 문의 내역</div>
	<form name="member_search_frm">
		<span style="font-size: 12pt; font-weight: bold; margin-left: 80%;">페이지당 게시글수&nbsp;</span>
		<select name="sizePerPage">
			<option value="10">10개</option>
			<option value="5">5개</option>
			<option value="3">3개</option>      
		</select>
	</form>

	<table class="table table-bordered" id="faqQ">
	
		<thead>
			<tr style="background-color: #ccf3ff; text-align: center;">
				<th style="width: 5%;">번호</th>
				<th style="width: 10%;">아이디</th>
				<th style="width: 10%;">회원명</th>
				<th style="width: 50%;">제목</th>
				<th style="width: 15%;">답변여부</th>
			</tr>
		</thead>
		
		<tbody>
			<c:if test="${not empty requestScope.faqList}">
			<c:forEach var="faq" items="${requestScope.faqList}" varStatus="status">
				<tr class="faqInfo">
					<fmt:parseNumber var="currentShowPageNo" value="${requestScope.currentShowPageNo}" />
          			<fmt:parseNumber var="sizePerPage" value="${requestScope.sizePerPage}" />
					<td style="text-align: center;">${requestScope.totalFaqCount - (currentShowPageNo-1)*sizePerPage - status.index}</td>
					<td style="text-align: center;">${faq.fk_userid}</td>
					<td style="text-align: center;">${faq.mvo.name}</td>
					<td>${faq.q_title}</td>
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

	<div id="pageBar" style="margin-left: 40%;">
       <nav>
          <ul class="pagination">${requestScope.pageBar}</ul>
       </nav>
    </div>
</div>

<form name="faqOneDetail_frm">
	<input type="hidden" name="goBackURL" value="${requestScope.currentURL}"/>
</form>

<jsp:include page="../footer.jsp" />