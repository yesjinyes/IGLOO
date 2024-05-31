<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/order/payment.css" />

<jsp:include page="../header.jsp" />

<script type="text/javascript">

function goReset() {

	location.href="javascript:history.back();";
	/* 
    $("span.error").hide();
    $("span#idcheckResult").empty();
    $("span#emailCheckResult").empty(); */
} //  end of function goReset() {}----------------------------------


$(document).ready(function() {
    $("select#stselect").change(function(){
    	storeAddress();
    })
    
    
    
})

function goPayment(){
	
	const frm = document.order;
    frm.action = "payment.ice";
    frm.method = "post";
    frm.submit();
	
}// end of function goPayment(){}------------------------------------------------------------



function storeAddress(){
	
	 $.ajax({
         url: "paymentStoreAddress.ice"
         , data: {"storename":$("select#stselect").val()}
         , type:"post"
         , async:true
         , dataType:"json"     
         , success: function(json){  
        	 // console.log(JSON.stringify(json));
             console.log(json.storeaddress);
        	 $("div#staddress").html(json.storeaddress);
         },
         error: function(request, status, error){
             alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
         }
     }); // end of $.ajax({})-----------------------------
	
} // end of function storeAdrress(){}-------------------------------------------------------------------

</script>


<div class="container contents">
	
	<div id="orderProcedure" class="row justify-content-end mt-5">
		<div class="col-md-2 p-0">
			장바구니
		</div>
		<div class="col-md-2 col-lg-2 p-0">
			주문/결제
		</div>
		<div class="col-md-1 p-0">
			완료
		</div>
	</div>   

	<hr style="border: solid 2px #6190BC">


	<img src="<%= ctxPath%>/images/igloo_logo.png" style="width:130px;"/>
	<span style="margin-bottom: 1%; font-size: 25pt; font-weight: bold;">결제창</span>
	<div style="border: solid 5px black; background-color: #ccf2ff;  border-radius: 10px;" id="imgdiv">
		<div id="item_detail">
			<div style="margin-bottom: 1%; font-size: 13pt; font-weight: bold;">가게주소</div>
			
			<select style="margin-bottom: 1%" id="stselect" name="sts">
				<option>지점을 선택하세요.</option>
				
				<c:forEach var="store" items="${requestScope.storename}" varStatus="status">	
					<option value="${status.count}" id="stname">${store}</option>
		        </c:forEach>
		        
			</select>
			
			<div style="background-color: white; border: solid 0px gray; border-radius: 10px; display: flex; align-items: center;" >
				<div style="margin: 2%;">
					<div id="staddress" style="font-size: 11pt; font-weight: bold; color: gray; margin-top: 1%;"></div>
				</div>
			</div>
			<hr style="border: solid 1px #81BEF7;">
			
			<div style="margin-bottom: 1%; font-size: 13pt; font-weight: bold;">내 연락처</div>
			<div style="background-color: white; border-radius: 10px; display: flex; align-items: center;" >
				<div style="margin: 2%;">
					<div style="font-size: 11pt; font-weight: bold; color: gray; margin-top: 1%;">${requestScope.mobile.substring(0,3)}-${requestScope.mobile.substring(3,7)}-${requestScope.mobile.substring(7)}</div>
				</div>
			</div>
			<hr style="border: solid 1px #81BEF7;">
			
			<div style="margin-bottom: 1%; font-size: 13pt; font-weight: bold;">가게 사장님께</div>
			<div style="background-color: white; border-radius: 10px; display: flex; align-items: center;" >
				<div style="margin: 2%;">
					<textarea placeholder="사장님께 전할 말" name="message" rows="5" cols="60"></textarea>
				</div>
			</div>
			<hr style="border: solid 1px #81BEF7;">
			
			<div style="margin-bottom: 1%; font-size: 13pt; font-weight: bold;">결제 방법</div>
			<div style="background-color: white; border-radius: 10px; display: flex; align-items: center;" >
				<div style="margin: 2%;">
					<!-- <input id="male" type="radio" name="gender" checked/> --> <!-- checked 지정하면 디폴트값으로 선택됨. 복수개 지정가능 -->
					<input id="realmoney" type="radio" name="paymentmethod" />
					<label style="font-size: 11pt; font-weight: bold; color: gray; margin-top: 1%;" for="realmoney">만나서 결제</label>
					<br>
					<input id="mobilemoney" type="radio" name="paymentmethod" /> <!-- 같은 name 을 지정한 라벨들끼리는 그 중 하나만 선택할 수 있다. -->
					<label style="font-size: 11pt; font-weight: bold; color: gray; margin-top: 1%;" for="mobilemoney">모바일 결제</label>
				</div>
			</div>
			
			<hr style="border: solid 1px #81BEF7;">
			
			<div style="margin-bottom: 0%; font-size: 13pt; font-weight: bold;">결제 금액</div>
			<div style="background-color: white; border-radius: 10px;" >
				<div style="margin: 5% 5%;">
					<div class="row justify-content-between mb-3">
						<div class="col-4 text-left" style="font-weight: bold; font-size: 20pt;">합계</div>
						<div class="col-4"></div>
						<div class="col-4 text-right" style="font-weight: bold; font-size: 20pt;"><fmt:formatNumber value="${requestScope.totalprice}" pattern="###,###" />원</div> 
						<br>
					</div>
					
					<hr style="border: solid 1px gainsboro;">

					<div class="row justify-content-between mb-3">
						<div class="col-4 text-left" style=" font-size: 10pt;">주문상품</div>
						<div class="col-4"></div>
						<div class="col-4 text-right" style="font-size: 10pt;">${requestScope.productname}</div>
						<br>
					</div>
				</div>	
			</div>
			<div id="button" class="mx-auto">
				<input type="reset" class="btn btn-lg mr-5" value="취소하기" onclick="goReset()" />
	            <input type="button"  class="btn btn-lg" value="구매하기" onclick="goPayment()" />
			</div>
		</div>
	</div>
	
<form name="order">
	<input type="text" name="orderplay" value="play" />
	<input type="text" name="str_cartno" value="${requestScope.str_cartno}" />
	<input type="text" name="str_selectno" value="${requestScope.str_selectno}"/>
	<input type="text" name="totalprice" value="${requestScope.totalprice}"/>
</form>
	
</div>

<jsp:include page="../footer.jsp" />
