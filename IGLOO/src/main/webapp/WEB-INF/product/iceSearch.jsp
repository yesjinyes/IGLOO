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
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/iceSearch.css" />

<%-- 직접 만든 JS --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>



    <div class="container mx-auto my-5 pt-5" >
      <h2 class="page-header__title">Search</h2>
      <h2 id="search_result" > <%-- ${requestScope.검색어}  --%> "__"검색결과 총 <%-- ${requestScope.검색결과개수} --%> __건</h2>
      
      
      <span style="font-size: 12pt; font-weight: bold;">페이지당 아이스크림수&nbsp;-&nbsp;</span>
      <select name="sizePerPage">
         <option value="10">12개</option>
         <option value="5">8개</option>
         <option value="3">4개</option>      
      </select>
   
      
      <div class="row pt-5">
        <div class="col-md-3">
        	<div class="ice">
	           <a href="#">
	             <img src="<%= ctxPath %>/images/img_jy/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
	           </a>
            </div>
            <div class="text-center pt-2">슈팅톡톡</div>
        </div>
        
        <div class="col-md-3">
        	<div class="ice">
	           <a href="#">
	             <img src="<%= ctxPath %>/images/img_jy/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
	           </a>
            </div>
            <div class="text-center pt-2">슈팅톡톡</div>
        </div>
        
        <div class="col-md-3">
        	<div class="ice">
	           <a href="#">
	             <img src="<%= ctxPath %>/images/img_jy/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
	           </a>
            </div>
            <div class="text-center pt-2">슈팅톡톡</div>
        </div>
        
        <div class="col-md-3">
        	<div class="ice">
	           <a href="#">
	             <img src="<%= ctxPath %>/images/img_jy/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
	           </a>
            </div>
            <div class="text-center pt-2">슈팅톡톡</div>
        </div>
      </div>
      
      
      <div class="row pt-5">
        <div class="col-md-3">
        	<div class="ice">
	           <a href="#">
	             <img src="<%= ctxPath %>/images/img_jy/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
	           </a>
            </div>
            <div class="text-center pt-2">슈팅톡톡</div>
        </div>
        
        <div class="col-md-3">
        	<div class="ice">
	           <a href="#">
	             <img src="<%= ctxPath %>/images/img_jy/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
	           </a>
            </div>
            <div class="text-center pt-2">슈팅톡톡</div>
        </div>
        
        <div class="col-md-3">
        	<div class="ice">
	           <a href="#">
	             <img src="<%= ctxPath %>/images/img_jy/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
	           </a>
            </div>
            <div class="text-center pt-2">슈팅톡톡</div>
        </div>
        
        <div class="col-md-3">
        	<div class="ice">
	           <a href="#">
	             <img src="<%= ctxPath %>/images/img_jy/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
	           </a>
            </div>
            <div class="text-center pt-2">슈팅톡톡</div>
        </div>
      </div>
      
      
      
      <%-- 페이징 처리
      
            <c:if test="${!empty requestScope.아이스크림총개수}">
             <c:forEach var="membervo" items="${requestScope.아이스크림총개수}" varStatus="status"> fvarStatus="status"  인덱스 
                   <tr>
                      
                      <fmt:parseNumber var="currentShowPageNo" value="${requestScope.currentShowPageNo}" />
                      <fmt:parseNumber var="sizePerPage" value="${requestScope.sizePerPage}" />
                       fmt:parseNumber 은 문자열을 숫자형식으로 형변환 시키는 것이다. 
                      
                      <td>${(requestScope.아이스크림총개수) - ( currentShowPageNo - 1 ) * sizePerPage - (status.index)}</td> status.index"  인덱스 가져오깅    currentShowPageNo는 컨트롤러에서 string으로 했기때문에 빼기하려면 타입바꿔줘야함  
                           페이징 처리시 보여주는 순번 공식 
                           데이터개수 - (페이지번호 - 1) * 1페이지당보여줄개수 - 인덱스번호 => 순번 
                       
                       
                      <td>${membervo.샤베트}</td>
                      <td>${membervo.심플}</td>
                      <td>${membervo. ...}</td>
                      
                   </tr>
             </c:forEach>
          </c:if>
          
          <c:if test="${empty requestScope.아이스크림리스트}">
                <td colspan="5">데이터가 존재하지 않습니다</td>
          </c:if>
      
    --%>
      
      <%-- 페이지 바 --%>
      <div aria-label="Page navigation" class="pn">
	   <div class="pagination" >
		  <a href="#">&laquo;</a>
		  <a href="#">1</a>
		  <a class="active" href="#">2</a>
		  <a href="#">3</a>
		  <a href="#">4</a>
		  <a href="#">5</a>
		  <a href="#">6</a>
		  <a href="#">&raquo;</a>
		</div>
      </div>
      
      
    </div>
  
<%-- Header 마무리에 따라 div 추가 닫기 --%>
<jsp:include page="../footer.jsp" />