<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/order/order_detail.css" />

<jsp:include page="../header.jsp" />

<div class="container contents">

	<div id="imgdiv" class="row">
		<div id="item_img" class="col-xl-5 col-lg-5">
			<img class="img-fluid" id="cupsize" src="<%= ctxPath%>/images/images_younggwan/cupsize.png" alt="Responsive image"/>
		</div>
		<div id="item_detail">
			<div class="p-0  my-auto">
				<div>파인트</div>
				<h6 style="font-weight: bold; font-size: 30pt; text-align: right;">8,000원</h6>
			</div>
			<hr style="border: solid 1px #81BEF7;">
			
			<div class="dropdown-label" style="font-weight: bold; font-size: 15pt;">
			    이글루 할래용
		    </div>
  
		    <select> <!-- 설렉트는 한개만 선택가능 -->
				<option selected>맛을 선택하세요</option>
				<option>바람과 할께 날아가다</option>
				<option>1조 짱</option> <!-- selected 지정하면 디폴트값으로 선택됨 -->
				<option>이지윤 지각쟁이</option>
			</select>
			<select> <!-- 설렉트는 한개만 선택가능 -->
				<option selected>맛을 선택하세요</option>
				<option>초대졸</option>
				<option>대졸</option> <!-- selected 지정하면 디폴트값으로 선택됨 -->
				<option>대학원졸</option>
			</select>
			<select> <!-- 설렉트는 한개만 선택가능 -->
				<option selected>맛을 선택하세요</option>
				<option>초대졸</option>
				<option>대졸</option> <!-- selected 지정하면 디폴트값으로 선택됨 -->
				<option>대학원졸</option>
			</select>
	  
	  		<hr style="border: solid 1px #81BEF7;">
  
  			<div class="row justify-content-around">
				 <div class="p-0 my-auto justify-content-center">
		 			 <h3 style="font-weight: bold;">파인트</h3>
				     <span>맛 이름: 이나래, 양혜정, 박예진, 이지윤, 손영관</span> <%-- ■■■■■ 길어지면 위치 바뀜 ■■■■■--%>
				 </div>
				
				<div class="selectMenucnt justify-content-end col-xl-4 col-lg-4 col-md-2 p-0 my-auto">
	                  <div class="d-inline-block"></div>
	                  <div class="mb-5">
	                     <div>수량</div>
	                     <button type="button" class="btn ml-5">
	                        <i class="fa-solid fa-minus"></i>
	                     </button>
	                     <span>1</span>
	                     <button type="button" class="btn">
	                        <i class="fa-solid fa-plus"></i>
	                     </button>
	                  </div>
	             </div>
				 
            </div>
             
			<hr style="border: solid 1px #81BEF7;">
			
			<div class="row justify-content-between mb-3">
				<div class="col-4 text-left" style="font-weight: bold; font-size: 20pt;">합계</div>
				<div class="col-4"></div>
				<div class="col-4 text-right" style="font-weight: bold; font-size: 20pt;">8,000원</div>
				<br>
			</div>
			
			<div id="button" class="mx-auto">
				<input type="button" class="btn btn-lg mr-5" value="장바구니" onclick="go...()" />
	            <input type="button"  class="btn btn-lg" value="구매하기" onclick="go...()" />
			</div>
		</div>
	</div>
	
	<hr style="border: solid 2px #4198e8;">

	<div id="image">
		<div class="row justify-content-center">
			<div class="col-md-7" style="font-weight: bold;"> <img class="img-fluid" alt="..." src="<%= ctxPath%>/images/images_younggwan/cupsize_detai_pint.png"> </div>
		</div>
	</div>
	<hr style="border: solid 2px #4198e8;">
	<div id="image">
		<div class="row">
			<div class="col-md-3" style="font-weight: bold;">아이스크림 맛별 이미지 넣기</div>
		</div>
	</div>
	
</div>

<jsp:include page="../footer.jsp" />
