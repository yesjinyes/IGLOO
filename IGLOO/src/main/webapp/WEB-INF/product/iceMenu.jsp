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
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/iceMenu.css" />
<script type="text/javascript" src="<%= ctxPath%>/js/myshop/mallHomeMore.js"></script>   









<div class="container pt-5" >
    	<div id="header">
	      <h2 class="page-header__title">Ice Cream</h2>
	      <h10>한 입에 물면 달콤하게 사르르 녹는 아이스크림.<br>
			   당신이 어떤 기분이든 이글루를 만난 당신의 기분은 아마 달콤해졌을 거예요.</h10>
       </div>
    
    <div class="align">
	   <form name="align_frm" >
	      <span style="font-size: 12pt; font-weight: bold;">메뉴 정렬&nbsp;-&nbsp;</span>
	      <select name="menuAlign">
	         <option value="name">가나다순</option>
	         <option value="order">주문많은수</option>
	         <option value="review">리뷰수</option>      
	      </select>
	    </form>
  	</div>
  	
 		 
    <div class="iceTbl row pt-5"> <%-- 행개수는 따로 설정하지 않고 3줄 기본으로 함. --%>
      
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
      
    
      <%-- 더보기 버튼 --%>
      <div>
         <p class="text-center">
              <span id="end" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: red;"></span> 
			  <button type="button" class="btn btn-secondary btn-lg" id="btnMore" value="">더보기...</button>
			  <span id="totalCount">${requestScope.totalCount}</span>	
			  <span id="count">0</span>
         </p>
      </div>
      
       <%-- 맨위로가기 
      <div style="display: flex;">
         <div style="margin: 20px 0 20px auto;">
            <button class="btn btn-info" onclick="goTop()">맨위로가기(scrollTop 1로 설정함)</button>
         </div>
      </div>
	--%>
      
</div>
  
<%-- Header 마무리에 따라 div 추가 닫기 --%>
<jsp:include page="../footer.jsp" />