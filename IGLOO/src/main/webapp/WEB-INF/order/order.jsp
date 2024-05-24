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
         
         const productimg = $(e.target).parent().parent().find(".selectedproductimg").val();
         const productname = $(e.target).parent().parent().find(".selectedproductname").val();
         const productprice = $(e.target).parent().parent().find(".selectedproductprice").val();
         const productimgBelow = $(e.target).parent().parent().find(".selectedproductimgBelow").val();
         const productdetail = $(e.target).parent().parent().find(".productdetail").text();
         //console.log(productdetail);
         
         const tastecount = productdetail.substr(0,1);
         //console.log(tastecount);
         
/*          console.log("확인용 productimg => " , productimg); 
         console.log("확인용 productname => " , productname); 
         console.log("확인용 productprice => " , productprice); */
         
          $("input[name='productimg']").val(productimg);
         $("input[name='productname']").val(productname);
         $("input[name='productprice']").val(productprice); 
         $("input[name='productimgBelow']").val(productimgBelow);
         $("input[name='tastecount']").val(tastecount);
         
          const frm = document.orderFrm; 
         frm.action = "order_detail.ice"; 
         frm.submit(); 
         
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
                  <img name="productimg" src="<%= ctxPath%>/images/img_yejin/cup_size/${productList.productimg}" class="card-img-top productimg" style="height: 50%;" alt="...">
                  <div class="card-body">
                    <h5 class="card-title productname">${productList.productname}</h5>
                    <p class="card-text productdetail">${productList.productdetail}</p>
                    <p class="card-text productprice" style="font-weight: bold; font-size: 15pt;"><fmt:formatNumber value="${productList.price}" pattern="###,###" />원</p>
                    <input type="hidden" class="selectedproductimg" name="productimg" value="${productList.productimg}"/>
                    <input type="hidden" class="selectedproductname" name="productname" value="${productList.productname}"/>
                    <input type="hidden" class="selectedproductprice" name="productprice" value="${productList.price}"/>
                    <input type="hidden" class="selectedproductimgBelow" name="productimgBelow" value="${productList.productimgBelow}"/>
                     <input type="hidden" name="tastecount"/>
                     <button type="button" id="btnOrder" style="float: right">주문하기</button>
                  </div>
            </div>
          </c:forEach>
        </div>
     
   </form>
   
</div>   
      
<jsp:include page="../footer.jsp"></jsp:include>