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

function goPaymentpopup(){

	// alert(${ctxPath});
    // alert(`확인용 부모창의 함수 호출함.\n 결제금액 : ${coinmoney}원, 사용자id : ${userid}`);
    
    // >>> 포트원(구 아임포트) 결제 팝업창 띄우기 <<<
    // 너비 1000, 높이 600 인 팝업창을 화면 가운데 위치시키기
    const width = 1000;
    const height = 600;

    
    const left = Math.ceil( (window.screen.width - width)/2 ); // 정수로 만든다.
    const top = Math.ceil( (window.screen.height - height)/2 ); // 정수로 만든다.

    const url = `<%=ctxPath%>/member/iglooPurchaseEnd.ice?userid=${sessionScope.loginuser.userid}&productname=${requestScope.productname_str}&totalprice=${requestScope.totalprice}`;
    
    window.open(url, "iglooPurchaseEnd",
               `left=${left}, top=${top}, width=${width}, height=${height}`);
               
} //  end of function goPaymentpopup(){}----------------------------------------

function goOrderEnd(str_cartno){
     console.log(`~~ 확인용 userid : ${sessionScope.loginuser.userid}`);
    // ~~ 확인용 userid : sonyg, coinmoney : 300000원    이게 나오고 창이 꺼져버린다.

    
    const userid = "${sessionScope.loginuser.userid}";
    console.log(userid);

    $.ajax({
        url : "<%=ctxPath%>/order/payment.ice",
        data : {"str_cartno" : "${requestScope.str_cartno}"},              // data 속성은 http://localhost:9090/MyMVC/member/coinUpdateLoginUser.up 로 전송해야할 데이터를 말한다.
        type : "post",                                 // type 을 생략하면 type : "get" 이다.
             
        async : true,                                  // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                                                       // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.
                     
        dataType : "json",                             // Javascript Standard Object Notation.  dataType은 /MyMVC/member/coinUpdateLoginUser.up 로 부터 실행되어진 결과물을 받아오는 데이터타입을 말한다. 
                                                       // 만약에 dataType:"xml" 으로 해주면 /MyMVC/member/coinUpdateLoginUser.up 로 부터 받아오는 결과물은 xml 형식이어야 한다. 
                                                       // 만약에 dataType:"json" 으로 해주면 /MyMVC/member/coinUpdateLoginUser.up 로 부터 받아오는 결과물은 json 형식이어야 한다.              

        success : function(json){
            // console.log("~~~ 확인용 json => ", json);
            // ~~~ 확인용 json =>  {loc: '/MyMVC/index.up', message: '손영관님의300,000원 결제가 완료되었습니다.', n: 1}
                alert(json.message);
                location.href=json.loc;
             // location.href=history.go(0);

        },
        
        error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }

    });

} // end of function goCoinUpdate(userid,coinmoney){}-------------------------------------------


/* function goPayment(){
	
	const frm = document.order;
    frm.action = "payment.ice";
    frm.method = "post";
    frm.submit();
	
}// end of function goPayment(){}------------------------------------------------------------
 */

function storeAddress(){
	
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
	            <input type="button"  class="btn btn-lg" value="구매하기" onclick="goPaymentpopup()" />
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
