<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 형변환 해줄때  --%>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/iceMenu.css" />



<jsp:include page="../header.jsp" />






<body>

    <div class="container pt-5" >
      <h2 class="page-header__title">Ice Cream</h2>
      
    
    <div class="align">
      <span style="font-size: 12pt; font-weight: bold;">메뉴 정렬&nbsp;-&nbsp;</span>
      <select name="menuAlign">
         <option value="name">가나다순</option>
         <option value="name">주문많은수</option>
         <option value="name">리뷰수?</option>      
         <option value="name">...</option>      
      </select>
  	</div>
     
      <div class="row pt-5"> <%-- 행개수는 따로 설정하지 않고 3줄 기본으로 함. c:foreach --%>
        <div class="col-md-3">
           <a href="#">
             <img src="<%= ctxPath %>/images/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
           </a>
             <div class="text-center pt-2">슈팅톡톡</div>
        </div>
        
        <div class="col-md-3">
           <a href="#">
             <img src="<%= ctxPath %>/images/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
           </a>
             <div class="text-center pt-2">슈팅톡톡</div>
        </div>
        
        <div class="col-md-3">
           <a href="#">
             <img src="<%= ctxPath %>/images/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
           </a>
             <div class="text-center pt-2">슈팅톡톡</div>
        </div>
        
        <div class="col-md-3">
           <a href="#">
             <img src="<%= ctxPath %>/images/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
           </a>
             <div class="text-center pt-2">슈팅톡톡</div>
        </div>
      </div>
      
      
      
      <div class="row pt-5">
        <div class="col-md-3">
           <a href="#">
             <img src="<%= ctxPath %>/images/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
           </a>
             <div class="text-center pt-2">슈팅톡톡</div>
        </div>
        
        <div class="col-md-3">
           <a href="#">
             <img src="<%= ctxPath %>/images/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
           </a>
             <div class="text-center pt-2">슈팅톡톡</div>
        </div>
        
        <div class="col-md-3">
           <a href="#">
             <img src="<%= ctxPath %>/images/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
           </a>
             <div class="text-center pt-2">슈팅톡톡</div>
        </div>
        
        <div class="col-md-3">
           <a href="#">
             <img src="<%= ctxPath %>/images/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
           </a>
             <div class="text-center pt-2">슈팅톡톡</div>
        </div>
      </div>
      
      
      
      <div class="row pt-5">
        <div class="col-md-3">
           <a href="#">
             <img src="<%= ctxPath %>/images/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
           </a>
             <div class="text-center pt-2">슈팅톡톡</div>
        </div>
        
        <div class="col-md-3">
           <a href="#">
             <img src="<%= ctxPath %>/images/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
           </a>
             <div class="text-center pt-2">슈팅톡톡</div>
        </div>
        
        <div class="col-md-3">
           <a href="#">
             <img src="<%= ctxPath %>/images/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
           </a>
             <div class="text-center pt-2">슈팅톡톡</div>
        </div>
        
        <div class="col-md-3">
           <a href="#">
             <img src="<%= ctxPath %>/images/icecream image/15 슈팅톡톡 .png" class="img-fluid mx-auto d-block" alt="슈팅톡톡">
           </a>
             <div class="text-center pt-2">슈팅톡톡</div>
        </div>
      </div>
     
      
      <%-- 페이징처리
      
            <c:if test="${!empty requestScope.아이스크림총개수}">
             <c:forEach var="membervo" items="${requestScope.아이스크림총개수}" varStatus="status"> fvarStatus="status"  인덱스 
                   <tr>
                      
                      <fmt:parseNumber var="currentShowPageNo" value="${requestScope.currentShowPageNo}" />
                      <fmt:parseNumber var="sizePerPage" value="${requestScope.sizePerPage}" />
                       fmt:parseNumber 은 문자열을 숫자형식으로 형변환 시키는 것이다. 
                      
                      <td>${(requestScope.아이스크림총개수) - ( currentShowPageNo - 1 ) * sizePerPage - (status.index)}</td> status.index"  인덱스 가져오깅    currentShowPageNo는 컨트롤러에서 string으로 했기때문에 빼기하려면 타입바꿔줘야함  
                           페이징 처리시 보여주는 순번 공식 
                           데이터개수 - (페이지번호 - 1) * 1페이지당보여줄개수 - 인덱스번호 => 순번 
                       
                       
                      <td>${membervo.이름}</td>
                      <td>${membervo.아이디}</td>
                      <td>${membervo. ...}</td>
                      
                   </tr>
             </c:forEach>
          </c:if>
          
          <c:if test="${empty requestScope.아이스크림리스트}">
                <td colspan="5">데이터가 존재하지 않습니다</td>
          </c:if>
      
    
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
  
</body>
<%-- Header 마무리에 따라 div 추가 닫기 --%>
<jsp:include page="../footer.jsp" />