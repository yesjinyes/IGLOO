<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 형변환 해줄때  --%>
    
   
<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>    
      
      

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

<%-- jQuery UI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>
    
  
<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/editReview.css" />    
    
    
    
    
    
<div class="container">

     <h2>리뷰 수정</h2>
     <hr>
	 <br><br>
	 
     <p>리뷰사진, 별점, 리뷰내용만 수정</p> 
     
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
        </div>
        <div class="content" >
          <div class="bind">
            <h3>이글루 ...점</h3>
          </div>
          <div class="reviewImgs">
			<i class="fa-solid fa-image fa-10x"></i><%-- 리뷰사진 없을때 --%>
          </div>
          <div class="star">☆☆☆☆☆&nbsp;&nbsp;
            <span class="date">2024.05.14</span>
          </div>
          <div class="form-floating">
			  <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 100px">맛도리</textarea>
			  <label for="floatingTextarea2"></label>
		  </div>
        </div>
        <div id="btnSubmit">
      		<input type="button" class="btn btn-success" value="수정하기" onclick="goEdit()" />
      	</div>
      </div>
   </div>