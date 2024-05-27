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
      
      $("button.btnOrder").click(function(e) {
         
    	 const idx = $("button.btnOrder").index($(e.target));
    	 const pcode_val = $("input[name='pcode']").eq(idx).val();
         
         const frm = document.order_frm;
         frm.pcode.value = pcode_val;
         frm.action = "<%=ctxPath%>/order/order_detail.ice"; 
         frm.submit(); 
         
      });// end of $("button").click(function() {})-----------
      
   });// end of $(document).ready(function() {})-----------------------------
</script>

 
<div class="container">
   
   <h4>주문 메뉴</h4>
   <br><br>
   
   
      <div class="card-deck mb-5">
          <c:forEach var="productList" items="${requestScope.productList}" varStatus="status">
    
            <div class="card">
                  <img name="productimg" src="${pageContext.request.contextPath}/images/${productList.productimg}" class="card-img-top productimg" style="height: 50%;" alt="...">
                  <div class="card-body">
                    <h5 class="card-title productname">${productList.productname}</h5>
                    <p class="card-text productdetail">${productList.productdetail}</p>
                    <p class="card-text productprice" style="font-weight: bold; font-size: 15pt;"><fmt:formatNumber value="${productList.price}" pattern="###,###" />원</p>
                    
                     <input type="hidden" name="pcode" value="${productList.productcodeno}" />
                     <button type="button" class="btnOrder stretched-link" style="float: right">주문하기</button>
                  </div>
            </div>
   
          </c:forEach>
        </div>
     
   
</div>   

<form name="order_frm">
   <input type="hidden" name="pcode" value=""/>
</form>
      
<jsp:include page="../footer.jsp"></jsp:include>