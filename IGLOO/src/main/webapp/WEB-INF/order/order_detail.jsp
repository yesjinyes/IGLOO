<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
    String productimg = request.getParameter("productimg");
    String productname = request.getParameter("productname");
    String productprice = request.getParameter("productprice");
%>

<jsp:include page="../header.jsp" />

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/order/order_detail.css" />

<script type="text/javascript">
	$(document).ready(function() {
		const value = $('select.select-box').val();
		
		console.log("value 확인 => ", value);
		
		
		
	});// end of $(document).ready(function() {})
</script>



<div class="container contents">

  <form name="orderDetailFrm">

	<div id="imgdiv" class="row">
	  
		<div id="item_img" class="col-xl-5 col-lg-5">
			<img id="cupsize" src="<%= ctxPath%>/images/images_younggwan/cupsize.png" style="width: 300px; height: 350px; border: solid 1px red;" alt="Responsive image"/>
		</div>
		
		<div id="item_detail">
			<div class="p-0  my-auto">
				<div style="font-size: 30pt;"><%= productname%></div>
				<h6 style="font-size: 27pt; text-align: right;"><%= productprice%>원</h6>
			</div>
			<hr style="border: solid 1px #81BEF7;">
	  
			<div class="dropdown-label" style="font-weight: bold; font-size: 15pt;">
			    이글루 할래용
		    </div>
      
  			<select name="taste1" class="infoData select-box">
              <option value="">맛을 선택하세요</option>
              <c:forEach var="tvo" items="${requestScope.tasteList}">
                <option value="${tvo.tasteno}">${tvo.tastename}</option>
              </c:forEach> 
            </select>
  
			<select name="taste2" class="infoData select-box">
              <option value="">맛을 선택하세요</option>
              <c:forEach var="tvo" items="${requestScope.tasteList}">
                <option value="${tvo.tasteno}">${tvo.tastename}</option>
              </c:forEach> 
            </select>
            
			<select name="taste3" class="infoData select-box">
              <option value="">맛을 선택하세요</option>
              <c:forEach var="tvo" items="${requestScope.tasteList}">
                <option value="${tvo.tasteno}">${tvo.tastename}</option>
              </c:forEach> 
            </select>
	  
	  		<hr style="border: solid 1px #81BEF7;">
  
  			<div class="row justify-content-around">
				 <div class="p-0 my-auto justify-content-center">
		 			 <h4 style="font-weight: bold;" ><%= productname%></h4>
				     <span>=== 선택한 맛이 나오는 자리 ===</span> <%-- ■■■■■ 길어지면 위치 바뀜 ■■■■■--%>
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
				<div class="col-4 text-right" style="font-weight: bold; font-size: 20pt;"><%= productprice%>원</div>
				<br>
			</div>
			
			<div id="button" class="mx-auto">
				<input type="button" class="btn btn-lg mr-5" value="장바구니" onclick="go...()" />
	            <input type="button"  class="btn btn-lg" value="구매하기" onclick="go...()" />
			</div>
		</div>
	 
	</div>
	
	<%----------------------------------------------------------------------%>
	
	<hr style="border: solid 2px #4198e8;">

	<div id="image">
	  <c:forEach var="imgDetailList" items="${requestScope.imgDetailList}">
		<div class="row justify-content-center">
			<div class="col-md-7" style="font-weight: bold;"> <img class="img-fluid" alt="..." src="<%= ctxPath%>/images/img_yejin/cup_detail/${imgDetailList.productimgBelow}"> </div>
		</div>
	  </c:forEach>
	</div>
	<hr style="border: solid 2px #4198e8;">
	<div id="image">
		<div class="row">
			<div class="col-md-3" style="font-weight: bold;">아이스크림 맛별 이미지 넣기</div>
		</div>
	</div>
	
  </form>
</div>

<jsp:include page="../footer.jsp" />
