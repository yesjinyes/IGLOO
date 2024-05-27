<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />

<style type="text/css">

div.contentWrap {
	margin: 3%;
}

div.searchTitle {
	font-size: 15pt;
	font-weight: bold;
}

div.searchTitle > span {
	font-size: 12pt;
	font-weight: normal;
	color: #4d4d4d;
}

span#n {
	color: blue;
}

div.resultDiv {
	background-color: #ccf2ff;
	border-radius: 20px;
	padding: 2%;
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

<div class="container" style="margin-top: 7%;">
	<img style="width: 30%; margin-left: 37%;" src="<%=ctxPath%>/images/igloo_logo.png"/>
	<div id="topDiv" style="margin: 3%; font-size: 20pt; font-style: italic; font-weight: bold; color: #6c8da3; ">
	"${requestScope.search}"에 대한 검색 결과&nbsp;<span id="hideSpan" style="text-decoration: underline;">더보기</span>
	</div>

	<div style="padding: 3%;">
		<c:if test="${requestScope.tagName == 'taste'}">
			<div id="tasteWrap" class="contentWrap">
			<div class="searchTitle" style="color: #FD8A69;">&lt;메뉴&gt; <span class="searchResultCnt">검색 결과 <span id="n">${requestScope.totalSearchCount}</span>건</span></div>
			
				<div class="resultDiv">
					<c:forEach var="tasteList" items="${requestScope.tasteList}" varStatus="status">
							<div class="tasteInfo" style="display: flex; background-color: #f5faff; border-radius: 10px;">
								<div style="width: 10%;"><img style="width: 100%; cursor: pointer;" onclick="goTasteDetail(${tasteList.tasteno})" src="<%=ctxPath%>/images/img_narae/icecream_image/${tasteList.tasteimg}"/></div>
								<div style="padding-top: 2%;">
									<div style="padding-bottom: 1%; color: #009dff; text-decoration: underline; cursor: pointer;" onclick="goTasteDetail(${tasteList.tasteno})">${tasteList.tastename}</div>
									<div style="font-size: 10pt;">${tasteList.tasteexplain}</div>
								</div>
							</div>
							<hr style="border-width: thin;">
					</c:forEach>
				</div>
		</div>
		</c:if>
		
		<c:if test="${requestScope.tagName == 'product'}">
			<div id="cupWrap" class="contentWrap">
		
			<div class="searchTitle" style="color: #FFCD4A;">&lt;제품&gt; <span class="searchResultCnt">검색 결과 <span id="n">${requestScope.totalSearchCount}</span>건</span></div>
				<div class="resultDiv">
					<c:forEach var="productList" items="${requestScope.productList}" varStatus="status">
							<div class="productInfo" style="display: flex; background-color: #f5faff; border-radius: 10px;">
								<div style="width: 5%; margin: 1% 2%;"><img style="width: 100%;" onclick="goProductDetail('${productList.productcodeno}')" src="<%=ctxPath%>/images/img_narae/cup_size/${productList.productimg}"/></div>
								<div style="padding: 2% 0%;">
									<div style="padding-bottom: 1%; color: #009dff; text-decoration: underline; cursor: pointer;" onclick="goProductDetail('${productList.productcodeno}')">${productList.productname}</div>
									<div style="font-size: 10pt;">${productList.productdetail}</div>
								</div>
							</div>
							<hr style="border-width: thin;">
					</c:forEach>
				</div>
		</div>
		</c:if>
	
		<c:if test="${requestScope.tagName == 'faqlist'}">
			<div id="faqWrap" class="contentWrap">
			<div class="searchTitle" style="color: #AFD485;">&lt;고객센터&gt; <span class="searchResultCnt">검색 결과 <span id="n">${requestScope.totalSearchCount}</span>건</span></div>
				<div class="resultDiv">
					<c:forEach var="faqList" items="${requestScope.faqList}" varStatus="status">
							<div class="faqInfo" style="display: flex; background-color: #f5faff; border-radius: 10px;">
								<div style="width: 8%; margin: 1% 2%;">
									<c:choose>
									<c:when test="${faqList.f_category == '기타'}"><img onclick="goFaqDetail('${faqList.f_category}')" style="width: 100%; cursor: pointer;" src="<%=ctxPath%>/images/img_narae/기타문의.png"/></c:when>
									<c:when test="${faqList.f_category == '제품'}"><img onclick="goFaqDetail('${faqList.f_category}')" style="width: 100%; cursor: pointer;" src="<%=ctxPath%>/images/img_narae/제품문의.png"/></c:when>
									<c:when test="${faqList.f_category == '회원'}"><img onclick="goFaqDetail('${faqList.f_category}')" style="width: 100%; cursor: pointer;" src="<%=ctxPath%>/images/img_narae/회원문의.png"/></c:when>
									<c:otherwise><img style="width: 100%;" src="<%=ctxPath%>/images/img_narae/포인트문의.png"/></c:otherwise>
									</c:choose>
								</div>
								<div style="padding: 2%;">
									<div style="padding-bottom: 1%; color: #009dff; text-decoration: underline; cursor: pointer;" onclick="goFaqDetail('${faqList.f_category}')">${faqList.f_title}</div>
									<div style="font-size: 10pt;">${fn:substring(faqList.f_content, 0, 50)}...</div>
								</div>
							</div>
							<hr style="border-width: thin;">
					</c:forEach>
				</div>
		</div>
		</c:if>
	</div>
	
    <div id="pageBar" style="display: flex;"> 
	    <nav style="margin: auto;">
	    	<ul class="pagination">${requestScope.pageBar}</ul>
	    </nav>
    </div>

</div>


<jsp:include page="../footer.jsp" />