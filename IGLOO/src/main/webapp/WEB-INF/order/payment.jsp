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
    	$("#warning").hide();
    });
    
    
    $("#button input[type='button']").click(function() {
        var selectedValue = $("#stselect").val();
        var warningMsg = $("#warning");

        // 선택된 값이 지점을 선택하세요. 라는 값이거나 선택된 값이 없을 경우
        if (selectedValue === "" || selectedValue === "지점을 선택하세요.") {
            warningMsg.text("반드시 선택하셔야 합니다.");
            $("#warning").attr("tabindex", -1).focus().show();
            
        } else {
           // 팝업창 띄우기
            const url = `<%=ctxPath%>/member/iglooPurchaseEnd.ice?pcode=${requestScope.pcode}&userid=${sessionScope.loginuser.userid}&productname=${requestScope.productname_str}&totalprice=${requestScope.totalprice}`;
            
            window.open(url, "iglooPurchaseEnd", "width=1000, height=600, left=400, top=200");
        }
    }); //  end of $("#button input[type='button']").click(function() {}-----------------------------------
    
}); // end of $(document).ready(function() {}--------------------------------------------

// ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 여기부터 결제 관련 메소드 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
function goOrderEnd(){

	let dataObj;
   
	 dataObj = {"mobile":"${requestScope.mvo.mobile}",
             "smsContent":$("textarea#smsContent").val()};
	 $.ajax({
          url:"${pageContext.request.contextPath}/admin/smsSend.ice",
          type:"get",
          data:dataObj,
          dataType:"json",
          success:function(json){ 
             // json 은 {"group_id":"R2GWPBT7UoW308sI","success_count":1,"error_count":0} 처럼 된다. 
             
             if(json.success_count == 1) {
                $("div#smsResult").html("<span style='color:red; font-weight:bold;'>문자전송이 성공하였습니다.</span>");
             }
             else if(json.error_count != 0) {
                $("div#smsResult").html("<span style='color:red; font-weight:bold;'>문자전송이 실패하였습니다.</span>");
             }
          },
          error: function(request, status, error){
             alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
          }
       });

	    const frm = document.order;
	    frm.action = "payment.ice";
	    frm.method = "post";
	    frm.submit();
	    
	   
} // end of function goCoinUpdate(userid,coinmoney){}-------------------------------------------
// ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 여기까지 결제 관련 메소드 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

function storeAddress(){
	
	 var selectedValue = $("#stselect").val();

     // 선택된 값이 지점을 선택하세요. 라는 값이거나 선택된 값이 없을 경우
     if (!(selectedValue == "지점을 선택하세요.")) {
		
    	 $.ajax({
	         url: "paymentStoreAddress.ice"
	         , data: {"storename":$("select#stselect").val()}
	         , type:"post"
	         , async:true
	         , dataType:"json"     
	         , success: function(json){  
	        	 // console.log(JSON.stringify(json));
	             // console.log(json.storeaddress);
		         $("div#staddress").html(json.storeaddress);
	         },
	         error: function(request, status, error){
	             alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	         }
	         
	     }); // end of $.ajax({})-----------------------------
	     
     }
     else{
    	 $("#staddress").text("");
     }// end of if-------------------------------
	
	
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
			<span style="color:red;" id="warning"></span>
			<div style="background-color: white; border: solid 0px gray; border-radius: 10px; display: flex; align-items: center;" >
				<div style="margin: 2%;">
					<div id="staddress" style="font-size: 11pt; font-weight: bold; color: gray; margin-top: 1%;"></div>
				</div>
			</div>
			<hr style="border: solid 1px #81BEF7;">
			
			<div style="margin-bottom: 1%; font-size: 13pt; font-weight: bold;">내 연락처</div>
			<div style="background-color: white; border-radius: 10px; display: flex; align-items: center;" >
				<div style="margin: 2%;">
					<div style="font-size: 11pt; font-weight: bold; color: gray; margin-top: 1%;">${sessionScope.loginuser.mobile.substring(0,3)}-${sessionScope.loginuser.mobile.substring(3,7)}-${sessionScope.loginuser.mobile.substring(7)}</div>
				</div>
			</div>
			<hr style="border: solid 1px #81BEF7;">
			
			<div style="margin-bottom: 1%; font-size: 13pt; font-weight: bold;">가게 사장님께</div>
			<div style="background-color: white; border-radius: 10px; display: flex; align-items: center;" >
				<div style="margin: 2%;">
					<textarea style="width:100%;" placeholder="사장님께 전할 말" id="message" maxlength="50" rows="5" cols="60"></textarea>
				</div>
			</div>
			<hr style="border: solid 1px #81BEF7;">
			
			<!-- <div style="margin-bottom: 0%; font-size: 13pt; font-weight: bold;">결제 금액</div> -->
			<div style="background-color: white; border-radius: 10px; padding-bottom: 0.1%; margin-bottom: 5%;" >
				<div style="margin: 5% 5%;">
					<div class="row justify-content-between mb-3">
						<div class="col-5 text-left mt-3" style="font-weight: bold; font-size: 20pt;">결제 금액</div>
						<div class="col-3"></div>
						<div class="col-4 text-right mt-3" style="font-weight: bold; font-size: 20pt;"><fmt:formatNumber value="${requestScope.totalprice}" pattern="###,###" />원</div> 
						<br>
					</div>
					
					<hr style="border: solid 1px gainsboro;">

					<div class="text-left" style=" font-size: 13pt; font-weight: bold;">주문상품</div>
					
					<div class="row justify-content-between mt-3">
						<div class="col-3" style="font-size: 12pt;">${requestScope.productname}</div>
						<div class="col-9" style="font-size: 12pt;">${requestScope.tasteList} 선택한 맛이 나올 자리</div>
						<br>
					</div>
				</div>	
			</div>
			<div id="button" class="mx-auto">
				<input type="reset" class="btn btn-lg mr-5" value="취소하기" onclick="goReset()" />
	            <input type="button"  class="btn btn-lg" value="구매하기" />
			</div>
		</div>
	</div>
	
	<%-- ==== 휴대폰 SMS(문자) 보내기 ==== --%>
	<textarea rows="4" id="smsContent" style="width: 100%; display: none;">${sessionScope.loginuser.name}님 구매해주신 ${requestScope.productname} 상품 금액 <fmt:formatNumber value="${requestScope.totalprice}" pattern="###,###" /> 원이 결제되었습니다.</textarea>
	
<form name="order" style="display:none;">
	<input type="text" name="orderplay" value="play" />
	<input type="text" name="str_cartno" value="${requestScope.str_cartno}" />
	<input type="text" name="str_selectno" value="${requestScope.str_selectno}"/>
	<input type="text" name="totalprice" value="${requestScope.totalprice}"/>
	
	<input type="text" name="str_totalprice" value="${requestScope.totalprice}"/>
	<input type="text" name="str_totalcount" value="${requestScope.str_totalcount}"/>
	<input type="text" name="pcode" value="${requestScope.pcode}"/>
	
	<input type="text" name="storenameigloo" id="storenameInput" value=""/>
	<input type="text" name="require" id="requiremessage" value=""/>
</form>


<script>

$("#stselect").change(function() {
	
	var selectedText = $(this).find("option:selected").text();

    $("#storenameInput").val(selectedText);

});

$("#message").on("input", function() {

	var textAreaValue = $(this).val();

    $("#requiremessage").val(textAreaValue);
});

</script>
	
</div>

<jsp:include page="../footer.jsp" />
