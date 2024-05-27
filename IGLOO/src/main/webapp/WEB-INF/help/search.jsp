<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="../header.jsp" />

<script type="text/javascript">

function goTasteDetail(tasteno){
	location.href = "<%=ctxPath%>/product/menuDetail.ice?tasteno="+tasteno;
}

function goProductDetail(productno){
	location.href = "<%=ctxPath%>/order/order_detail.ice?pcode="+productno;
}

function goFaqDetail(f_category){
	location.href = "<%=ctxPath%>/help/help.ice?category="+f_category;
}

function searchMore(tag){
	
	// console.log(tag.id);
	const tagName = tag.id;
	const frm = document.hiddenFrm;
	frm.tagName.value = tagName;
	frm.action="searchMore.ice";
	frm.method="get";
	frm.submit();

	
	
}

</script>


<style type="text/css">

div.noResultDiv {
	background-color: #ccf2ff;
	height: 100px;
	border-radius: 20px;
	text-align: center;
	padding-top: 1.2%;
}

div.resultDiv {
	background-color: #ccf2ff;
	border-radius: 20px;
	padding: 2%;
}

div.noResultDiv > span {
	position: relative;
	top: 7px;
}

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

div.more {
	color: #919191;
}

div.more:hover {
	text-decoration: underline;
	cursor: pointer;
}

</style>

<form name="hiddenFrm">
	<input type="hidden" name="searchWord" value="${requestScope.search}" />
	<input type="hidden" name="tagName" value="" />

</form>

<div class="container" style="margin-top: 7%;">
	<img style="width: 30%; margin-left: 37%;" src="<%=ctxPath%>/images/igloo_logo.png"/>
	<div id="topDiv" style="margin: 3%; font-size: 20pt; font-style: italic; font-weight: bold; color: #6c8da3; ">
	"${requestScope.search}"에 대한 검색 결과
	</div>

	<div id="allWrap">
		
		<div id="tasteWrap" class="contentWrap">
			<div class="searchTitle" style="color: #FD8A69;">&lt;메뉴&gt; <span class="searchResultCnt">검색 결과 <span id="n">${requestScope.tasteList_size}</span>건</span></div>
			
			<c:if test="${empty requestScope.tasteList}">
				<div class="noResultDiv">
					<span style="font-size: 30pt;">😢</span> 검색 결과가 없습니다.
				</div>
			</c:if>
			<c:if test="${not empty requestScope.tasteList}">
				<div class="resultDiv">
					<c:forEach var="tasteList" items="${requestScope.tasteList}" varStatus="status">
						<c:if test="${status.count <= 3}">
							<div class="tasteInfo" style="display: flex; background-color: #f5faff; border-radius: 10px;">
								<div style="width: 10%;"><img style="width: 100%; cursor: pointer;" onclick="goTasteDetail(${tasteList.tasteno})" src="<%=ctxPath%>/images/img_narae/icecream_image/${tasteList.tasteimg}"/></div>
								<div style="padding-top: 2%;">
									<div style="padding-bottom: 1%; color: #009dff; text-decoration: underline; cursor: pointer;" onclick="goTasteDetail(${tasteList.tasteno})">${tasteList.tastename}</div>
									<div style="font-size: 10pt;">${tasteList.tasteexplain}</div>
								</div>
							</div>
							<hr style="border-width: thin;">
						</c:if>
					</c:forEach>
					<c:if test="${requestScope.tasteList_size > 3}">
						<div align="right" class="more" id="taste" onclick="searchMore(this)">검색 결과 더보기</div>
					</c:if>
				</div>
			</c:if>
		
		
		</div>
		
		<div id="cupWrap" class="contentWrap">
		
			<div class="searchTitle" style="color: #FFCD4A;">&lt;제품&gt; <span class="searchResultCnt">검색 결과 <span id="n">${requestScope.productList_size}</span>건</span></div>
			<c:if test="${empty requestScope.productList}">
				<div class="noResultDiv">
				<span style="font-size: 30pt;">😢</span> 검색 결과가 없습니다.
				</div>
			</c:if>
			<c:if test="${not empty requestScope.productList}">
				<div class="resultDiv">
					<c:forEach var="productList" items="${requestScope.productList}" varStatus="status">
						<c:if test="${status.count <= 3}">
							<div class="productInfo" style="display: flex; background-color: #f5faff; border-radius: 10px;">
								<div style="width: 5%; margin: 1% 2%;"><img style="width: 100%;" onclick="goProductDetail('${productList.productcodeno}')" src="<%=ctxPath%>/images/img_narae/cup_size/${productList.productimg}"/></div>
								<div style="padding: 2% 0%;">
									<div style="padding-bottom: 1%; color: #009dff; text-decoration: underline; cursor: pointer;" onclick="goProductDetail('${productList.productcodeno}')">${productList.productname}</div>
									<div style="font-size: 10pt;">${productList.productdetail}</div>
								</div>
							</div>
							<hr style="border-width: thin;">
						</c:if>
					</c:forEach>
					<c:if test="${requestScope.productList_size > 3}">
						<div align="right" class="more" id="product" onclick="searchMore(this)">검색 결과 더보기</div>
					</c:if>
				</div>
			</c:if>
		</div>
		
		<div id="faqWrap" class="contentWrap">
			
			<div class="searchTitle" style="color: #AFD485;">&lt;고객센터&gt; <span class="searchResultCnt">검색 결과 <span id="n">${requestScope.faqList_size}</span>건</span></div>
			
			<c:if test="${empty requestScope.faqList}">
				<div class="noResultDiv">
				<span style="font-size: 30pt;">😢</span> 검색 결과가 없습니다.
				</div>
			</c:if>
			<c:if test="${not empty requestScope.faqList}">
				<div class="resultDiv">
					<c:forEach var="faqList" items="${requestScope.faqList}" varStatus="status">
						<c:if test="${status.count <= 3}">
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
						</c:if>
					</c:forEach>
					<c:if test="${requestScope.faqList_size > 3}">
						<div align="right" class="more" id="faqlist" onclick="searchMore(this)">검색 결과 더보기</div>
					</c:if>
				</div>
			</c:if>
		</div>
		
	</div>

<%-- 검색결과 더보기 클릭 시 

	<div class="contentWrap" id="hideDiv">
	
		<div id="tasteMoreDiv">
		
			<div class="searchTitle" style="color: #FD8A69;">&lt;메뉴&gt; <span class="searchResultCnt">검색 결과 <span id="n">${requestScope.tasteList_size}</span>건</span></div>
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
		
		<div id="cupMoreDiv">
		
			<div class="searchTitle" style="color: #FFCD4A;">&lt;제품&gt; <span class="searchResultCnt">검색 결과 <span id="n">${requestScope.productList_size}</span>건</span></div>
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
		
		<div id="faqMoreDiv">
		
			<div class="searchTitle" style="color: #AFD485;">&lt;고객센터&gt; <span class="searchResultCnt">검색 결과 <span id="n">${requestScope.faqList_size}</span>건</span></div>
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
	
	</div>
	
	--%>

</div>




<jsp:include page="../footer.jsp" />
