<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
    
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp"/> 

<%-- 직접 만든 CSS --%>

<script type="text/javascript">

</script>

 
div class="container contents">

  <form name="orderDetailFrm">

	<div id="imgdiv" class="row">
	  
		<%-- <div id="item_img" class="col-xl-5 col-lg-5">
			<img id="cupsize" src="<%= ctxPath%>/images/images_younggwan/cupsize.png" style="width: 300px; height: 350px; border: solid 1px red;" alt="Responsive image"/>
		</div> --%>
		<<%-- c:forEach var="imgList" items="${requestScope.imgList}">
			<img src="<%= ctxPath%>/images/img_yejin/cup_size/${imgList.productimg}" class="card-img-top" style="height: 50%;" alt="사진경로잘못됨">
		</c:forEach> --%>
		<div id="item_detail">
			<div class="p-0  my-auto">
				<div style="font-size: 30pt;"><%= productname%></div>
				<h6 style="font-size: 27pt; text-align: right;"><%= productprice%></h6>
			</div>
			<hr style="border: solid 1px #81BEF7;">
	  
			<div class="dropdown-label" style="font-weight: bold; font-size: 15pt;">
			    이글루 할래용
		    </div>
		    <hr style="border: solid 1px #81BEF7;">
		    
		<c:forEach var="tvo" items="${requestScope.tasteList}" begin="0" end="2" varStatus="status">
  			<%-- <p> id="status">${status.index}</p> --%>
  			<p id="status">여기는 또 뭐지${status.index}</p>
  			<select id="taste" name="selectbox" class="infoData" > <!-- onchange="selectTaste(this)" -->
			<option value="">맛을 선택하세요</option>
      			<c:forEach var="tvo" items="${requestScope.tasteList}">	
	              <option value="${tvo.tasteno}">${tvo.tastename}</option>
 		        </c:forEach> 
            </select>
        </c:forEach>

	  		<hr style="border: solid 1px #81BEF7;">
  
  			<div class="row justify-content-around">
				 <div class="p-0 my-auto justify-content-center">
		 			 <h4 style="font-weight: bold;" >여기는 뭐지</h4>
				     <div id="result">=== 선택한 맛이 나오는 자리 ===</div>
				 </div>
				
				 <%-- 수량 +, - --%>
				 <div class="num">
				 	<span>수량</span><br>
				 	<span class="count">
				 		<a href="#" class="minus" style="font-size: 30pt; margin-right: 10pt;">-</a>
				 		<span id="result" style="font-size: 20pt;">1</span>
				 		<a href="#" class="plus" style="font-size: 20pt; margin-left: 10pt;">+</a>
				 	</span>
				 </div>
				 
            </div>
             
			<hr style="border: solid 1px #81BEF7;">
			
			<div class="row justify-content-between mb-3">
				<div class="col-4 text-left" style="font-weight: bold; font-size: 20pt;">합계</div>
				<div class="col-4"></div>
				<div class="col-4 text-right" style="font-weight: bold; font-size: 20pt;">여기는 도대체 뭐지</div>
				<br>
			</div>
			
			<div id="button" class="mx-auto">
				<input type="button" class="btn btn-lg mr-5" value="장바구니" onclick="goCart()" />
	            <input type="button"  class="btn btn-lg" value="구매하기" onclick="goOrder()" />
	            <%-- 푸시확인용 --%>
			</div>
		</div>
	</form>
<jsp:include page="../footer.jsp"></jsp:include>
