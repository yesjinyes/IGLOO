<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 형변환 해줄때  --%>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<%-- 폰트어썸 --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-Avb2QiuDEEvB4bZJYdft2mNjVShBftLdPG8FJ0V7irTLQ8Uo0qcPxh4Plq7G5tGm0rU+1SPhVotteLpBERwTkw==" crossorigin="anonymous" referrerpolicy="no-referrer" />



<jsp:include page="../sidebar.jsp" /> 

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/pastReview.css" />


<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/member/editReview.js"></script> <%-- 리뷰 수정 JS --%>




	<div id="content" class="col-9">

	<div id="btnReview">
		<a class="btn menufont_size" href="<%= ctxPath %>/member/ableReview.ice" >작성가능한 리뷰</a>
		<a class="btn menufont_size" href="<%= ctxPath %>/member/pastReview.ice" >작성한 리뷰</a>
	</div>
	
	<hr>
	<br>
	
    <div class="col-md-12">
      <div class="review">
        <div class="sumarry">
          <div class="img-container">
            <img src="<%= ctxPath%>/images/img_hj/cup_size/pint.png"/>
          </div>
          <div class="option-container">
            <h3>파인트</h3>
          	
            <ul>
              <li>초코나무숲</li>
              <li>초코나무숲</li>
              <li>초코나무숲</li>
            </ul>
          </div>
          <button class="toggleBtn" type="button" data-toggle="collapse" data-target="#hiddenContent1" aria-expanded="false" aria-controls="hiddenContent1">▼</button>
        </div>
        <div class="content collapse" id="hiddenContent1">
          <div class="bind">
            <h3>이글루 홍대점</h3>
            <div class="btns">
              <a href="javascript:goEditReview('${(sessionScope.loginuser).userid}','<%= ctxPath%>')" id="btnEdit" class="btn btn-outline-secondary" role='button' >수정</a>
              <button id="btnDel" class="btn btn-outline-secondary">삭제</button>
            </div>
          </div>
          <div class="reviewImgs">
			<i class="fa-solid fa-image fa-10x"></i><%-- 리뷰사진 없을때 --%>
          </div>
          <div class="star">☆☆☆☆☆&nbsp;&nbsp;
            <span class="date">2024.05.14</span>
          </div>
          <div class="text">
            맛도리
          </div>
        </div>
      </div>
  </div>


    <div class="col-md-12">
      <div class="review">
        <div class="sumarry">
          <div class="img-container">
            <img src="<%= ctxPath%>/images/img_hj/cup_size/halfgallon.png"/>
          </div>
          <div class="option-container">
            <h3>하프갤런</h3>
            <ul>
              <li>블루베리</li>
              <li>블루베리</li>
              <li>블루베리</li>
              <li>블루베리</li>
              <li>블루베리</li>
              <li>블루베리</li>
            </ul>
          </div>
          <button class="toggleBtn" type="button" data-toggle="collapse" data-target="#hiddenContent2" aria-expanded="false" aria-controls="hiddenContent2">▼</button>
        </div>
        <div class="content collapse" id="hiddenContent2">
          <div class="bind">
            <h3>이글루 부평점</h3>
            <div class="btns"> 
              <a href="javascript:goEditReview('${(sessionScope.loginuser).userid}','<%= ctxPath%>')" id="btnEdit" class="btn btn-outline-secondary" role='button' >수정</a>
              <button id="btnDel" class="btn btn-outline-secondary">삭제</button>
            </div>
          </div>
          <div class="reviewImgs">
            <i class="fa-solid fa-image fa-10x"></i><i class="fa-solid fa-image fa-10x"></i><%-- 리뷰사진 없을때 --%>
          </div>
          <div class="star">☆☆☆☆☆&nbsp;&nbsp;
            <span class="date">2024.05.10</span>
          </div>
          <div class="text">
            아이스크림이 착하고 사장님이 맛있어요
          </div>
        </div>
      </div>
    </div>
    <div class="more col-md-12 ">
    	 <span id="end" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: red;"></span> 
         <button type="button" class="btn btn-outline-secondary" id="btnMoreReview" value="">더보기</button>
         <span id="totalReview"></span>   
         <span id="countReview">0</span>
    </div>
  </div>

</div>
</div>
</div>









<jsp:include page="../footer.jsp" />