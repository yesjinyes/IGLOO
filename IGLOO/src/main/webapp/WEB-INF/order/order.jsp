<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
    
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp"/> 

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/order/order.css" />

<script type="text/javascript">
	$(document).ready(function() {
		
		$("button#btnOrder").click(function(e) {
			
			const productimg = $(e.target).parent().parent().find(".selectedproductimg").text();
			const productname = $(e.target).parent().find(".selectedproductname").text();
			const productdetail = $(e.target).parent().parent().find(".selectedproductdetail").text();
			const productprice = $(e.target).parent().find(".selectedproductprice").text();
			
			$("img[name='productimg']").val(productimg);
			$("input[name='productimgBelow']").val(productimgBelow);
			$("input[name='productname']").val(productname);
			$("input[name='productprice']").val(productprice);
			$("input[name='productimgBelow']").val(productprice);
			
			const frm = document.orderFrm; 
			frm.action = "order_detail.ice"; 
			frm.submit();
			
		 /* console.log("확인용 productimg => " , productimg); 
			console.log("확인용 productname => " , productname); 
			console.log("확인용 productprice => " , productprice); */
			
		});// end of $("button").click(function() {})-----------
		
	});// end of $(document).ready(function() {})-----------------------------
</script>

 
<div class="container">
	
	<h4>주문 메뉴</h4>
	<br><br>
	
	<form name="orderFrm"> 
	
	  <div class="card-deck mb-5">
	    <c:forEach var="productList" items="${requestScope.productList}">
			<div class="card">
			  
		      <img name="productimg" src="<%= ctxPath%>/images/img_yejin/cup_size/${productList.productimg}" class="card-img-top selectedproductimg" style="height: 50%;" alt="...">
		     
		      <div class="card-body">
		        <h5 class="card-title selectedproductname">${productList.productname}</h5>
		        <p class="card-text selectedproductdetail">${productList.productdetail}</p>
		        <p class="card-text selectedproductprice" style="font-weight: bold; font-size: 15pt;"><fmt:formatNumber value="${productList.price}" pattern="###,###" />원</p>
		        <input type="text" name="productimg" value="${productList.productimg}"/>
		        <input type="text" name="productimgBelow" value="${productList.productimgBelow}"/>
		        <input type="text" name="productname" value="${productList.productname}"/>
		        <input type="text" name="productprice" value="${productList.price}"/>
		      	<button type="button" id="btnOrder" style="float: right">주문하기</button>
		      </div>
			</div>
	    </c:forEach>
	  </div>
	  
	</form>
	
</div>	
		
<jsp:include page="../footer.jsp"></jsp:include>
