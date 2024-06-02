<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />

<script type="text/javascript">

$(document).ready(function(){
	
	$("div#forHide").hide();
	
	// 모달 열었을 때
	$("span.orderstatus").click(function(e){

		// 라디오 원상복구
		const radio = $(e.target).parent().find(".radio");
		
		const orderstatus = $(e.target).parent().find("#hidden_orderstatus").val();
		
		// console.log(orderstatus);
		
		radio.eq(orderstatus).prop("checked", true);
		
		
		// 준비 중 내 시간 원상복구
		
		$(e.target).parent().find("#time").html("");
		$(e.target).parent().find("#time").html("20");
		
		const orderdate = $(e.target).parent().find("#orderdate").html();
		let date = new Date(orderdate);
		date.setMinutes(date.getMinutes() + 20);
		
		let pickuptime = dateToString(date);
		
		$(e.target).parent().find("#pickuptime").html(pickuptime);
		
	});
	
	
	
	
	
	$("input:radio").change(function(e){

		const radioId = $(e.target).parent().parent().parent().parent().find("#hidden_statusindex").val();
		
		// console.log(radioId);
		if($("input:radio[id="+radioId+"]").prop("checked")){ // 준비 중 클릭 시
			
			$("div#forHide").show();
			
			// 1. 기본 시간 20분 설정
			$(e.target).parent().parent().find("#time").html("20");
			
			const orderdate = $(e.target).parent().parent().find("#orderdate").html();
			
			let date = new Date(orderdate);
			date.setMinutes(date.getMinutes() + 20);
			
			let pickuptime = dateToString(date);
			
			$(e.target).parent().parent().find("#pickuptime").html(pickuptime);
			
			// 2. + 버튼 눌렀을 때
			$(e.target).parent().parent().find("#timePlus").off("click").on('click', function(e){
				
				const currentTime = Number($(e.target).parent().parent().find("#time").html());
				// console.log("currentTime: "+currentTime);
				$(e.target).parent().parent().find("#time").html(currentTime+20);
				
				date.setMinutes(date.getMinutes() + 20);
				
				let pickuptime = dateToString(date);
				$(e.target).parent().parent().find("#pickuptime").html(pickuptime);
				
				if(currentTime+20>120){
					alert("최대 준비 시간은 120분입니다.");
					$(e.target).parent().parent().find("#time").html("120");
					date.setMinutes(date.getMinutes() - 20);
					
					let pickuptime = dateToString(date);
					$(e.target).parent().parent().find("#pickuptime").html(pickuptime);
				}
				
				return false;
				
			});
			
			// 3. - 버튼 눌렀을 때
			$(e.target).parent().parent().find("#timeMinus").off("click").on('click', function(e){
				
				const currentTime = Number($(e.target).parent().parent().find("#time").html());
				$(e.target).parent().parent().find("#time").html(currentTime-20);
				
				date.setMinutes(date.getMinutes() - 20);
				
				let pickuptime = dateToString(date);
				$(e.target).parent().parent().find("#pickuptime").html(pickuptime);
				
				if(currentTime-20<20){
					alert("최소 준비 시간은 20분입니다.");
					$(e.target).parent().parent().find("#time").html("20");
					
					date.setMinutes(date.getMinutes() + 20);
					
					let pickuptime = dateToString(date);
					$(e.target).parent().parent().find("#pickuptime").html(pickuptime);
					
				}
				
				return false;
				
			});
			
		}
		
		if(!$("input:radio[id="+radioId+"]").prop("checked")){
			$("div#forHide").hide();		
		}
		
	});
	
	
	$("button#cancelBtn").click(function(){
		
		// 20분으로 초기화
		$(event.target).parent().parent().find("#time").html("20");
		
		// 픽업 시각 초기화
		const orderdate = $(event.target).parent().parent().find("#orderdate").html();
		
		let date = new Date(orderdate);
		date.setMinutes(date.getMinutes() + 20);
		let pickuptime = dateToString(date);
		$(event.target).parent().parent().find("#pickuptime").html(pickuptime);
		
		// 라디오버튼 원상복구 및 히든 div 숨기기
		const radio = $("input:radio");
		radio.each(function(index, item){
			item.checked = false;
		});
		
		$(event.target).parent().parent().find("#time").html("");
		$(event.target).parent().parent().find("#time").html("20");
		
		$("div#forHide").hide();
		
	});


	
}); // document.ready


function goUpdate(e) {
	
	$("input:radio").each((index, item)=>{
		
		if($(item).prop("checked")){
			$("input:hidden[name='status']").val($(item).val());
		}
		
	});
	

	const status = $("input:hidden[name='status']").val();
	
	console.log(status);

	if(status == '2'){
		$("input:hidden[name='pickupTime']").val($(event.target).parent().parent().find("#pickuptime").html());
	}
	else {
		$("input:hidden[name='pickupTime']").val("");
	}
	const pickupTime = $("input:hidden[name='pickupTime']").val();
	const orderdetailno = $(e).parent().parent().find("#orderdetailno").val();

	
    $.ajax({
        url: "<%=ctxPath%>/admin/updateOrderStatus.ice",
        data: {"status": status, "pickupTime": pickupTime, "orderdetailno": orderdetailno},
        type: "post",
        dataType: "json",
        success: function(json){
            if(json.n == "1"){
            	alert("변경 완료되었습니다!");
            	
            	const modal = $("div.modal");
            	modal.css("display", "none");
            	location.reload(true);
            }
        }
    });


}

function dateToString(date){

	var dd = date.getDate();
	var mm = date.getMonth()+1; //January is 0!

	var yyyy = date.getFullYear();
	if(dd<10){dd='0'+dd} if(mm<10){mm='0'+mm}
	
	yyyy = yyyy.toString();
	mm = mm.toString();
	dd = dd.toString();
	
	var m = date.getHours();
	var s = date.getMinutes();
	var ss = date.getSeconds();

	if(m<10){m='0'+m} if(s<10){s='0'+s} if(ss<10){ss='0'+ss}
	m = m.toString();
	s = s.toString();
	ss = ss.toString();

	var s1 = yyyy+'-'+mm+'-'+dd+' '+m+':'+s+':'+ss;
	return s1;
}


</script>


<style type="text/css">
span#ordercode,
span.orderstatus {
	color: #3399ff;
	cursor: pointer;
}

span#ordercode:hover,
span.orderstatus:hover {
	text-decoration: underline;
}

tbody td {
	vertical-align : middle;
}

div#detailInfo > div > span:nth-child(1) {
	margin: 0% 2% 2% 10%;
	display: inline-block;
	background-color: #ffb3b3;
	color: white;
	width: 15%;
	height: 40px;
	border-radius: 20px;
	text-align: center;
	padding-top: 1%;
	font-weight: bold;
}

span#address {
	position: relative;
	top: -10px;
}

div#detailInfo > div > span:nth-child(2) {
	display: inline-block;
	margin: 0% 10% 2% 0%;
	
}

span#timePlus {
	cursor: pointer;
	margin: 3%;
}

span#timeMinus {
	cursor: pointer;
	margin: 3%;
} 

span#timeCss {
	display: inline-block;
	width: 25%;
	text-align: center;
	font-size: 20pt;
}

div#infoDiv {
	font-size: 10pt;
	margin-top: 3%;
	margin-left: 18%;
	color: #808080;
	margin-bottom: 1%;
}

div#modalWrapDiv {
	background-color: #fff7e6;
	width: 70%;
	border-radius: 20px;
	
}

div#forHide {
	border-radius: 15px;
	padding: 5%;
}

div#forHide > div > span:nth-child(1) {
	display: inline-block;
	background-color: white;
	font-weight: bold;
	font-size: 10pt;
	width: 30%;
	text-align: center;
	height: 30px;
	padding-top: 1.5%;
	border-radius: 20px;
	margin-right: 5%;
}

div#forHide > div {
	margin-bottom: 2%;
}

@font-face {
  font-family: 'SUITE-Regular';
  src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
  font-weight: 400;
  font-style: normal;
}

.container *{
	font-family: 'SUITE-Regular';
}


</style>

<div class="container mt-5 pt-5">

	<div id="top" style="text-align: center;">
		<img style="width: 30%;" src="<%= ctxPath%>/images/img_narae/전체주문내역.png"/>
	</div>

	<div class="mt-5 mb-2" style="font-size: 10pt; color: #808080;">
		※ 주문자 정보는 주문코드 클릭 시 확인 가능합니다.<br>
		※ 주문상태 변경은 주문상태 클릭 시 변경 가능합니다.
	</div>
	
	

	<div id="tableDiv">
		<table class="table table-bordered" style="text-align: center;">
			<thead style="background-color: #ccf3ff; ">
				<tr>
					<th>주문코드</th>
					<th>주문일자</th>
					<th>제품정보</th>
					<th>주문수량</th>
					<th>총 금액</th>
					<th>주문상태</th>
				</tr>
			</thead>
		
			<tbody>
				<c:forEach var="odvo" items="${requestScope.odvoList}" varStatus="status">
					<tr>
						<td class="align-middle">
							<span id="ordercode" data-toggle="modal" data-target="#ordercode_${status.index}">
							  ${odvo.order.ordercode}
							</span>
							<!-- Modal -->
							<div class="modal fade" id="ordercode_${status.index}">
							  <div class="modal-dialog modal-lg modal-dialog-scrollable">
							  <!-- .modal-dialog 클래스를 사용하여 <div> 요소에 크기 클래스를 추가합니다. -->
							    <div class="modal-content">

							      <!-- Modal body -->
							      <div class="modal-body mt-5">
									  <img src="<%=ctxPath%>/images/img_narae/주문고객정보조회.png" style="width: 40%;"/>
									  <div class="mt-5" align="left" id="detailInfo">
									  	<%-- 주문자 상세 정보 --%>
									  	<div><span>아이디</span><span>${odvo.order.fk_userid}</span></div>
									  	<div><span>성명</span><span>${odvo.order.member.name}</span></div>
									  	<div><span>연락처</span><span>${fn:substring(odvo.order.member.mobile, 0, 3)}-${fn:substring(odvo.order.member.mobile, 3, 7)}-${fn:substring(odvo.order.member.mobile, 7, 11)}</span></div>
									  	<div><span>이메일</span><span>${odvo.order.member.email}</span></div>
									  	<div><span>성별</span><span><c:if test="${odvo.order.member.gender == '1'}">남</c:if>
									  							  <c:if test="${odvo.order.member.gender == '2'}">여</c:if></span></div>
									  	<div><span>생년월일</span><span>${fn:substring(odvo.order.member.birthday, 0, 4)}년 ${fn:substring(odvo.order.member.birthday, 5, 7)}월 ${fn:substring(odvo.order.member.birthday, 8, 10)}일</span></div>
									  	<div><span>우편번호</span><span>${odvo.order.member.postcode}</span></div>
									  	<div><span id="address">주소</span><span>${odvo.order.member.address} ${odvo.order.member.detailaddress}<br>${odvo.order.member.extraaddress}</span></div>
									  </div>
							      </div>
							      
							      <!-- Modal footer -->
							      <div class="modal-footer">
							        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
							      </div>
							    </div>
							  </div>
							</div>
						</td>
						<td class="align-middle">${odvo.order.orderdate}</td>
						<td class="align-middle">
							<div style="font-size: 18pt; font-weight: bold;">${odvo.product.productname}</div>
							<div style="font-size: 10pt; text-align: center; background-color: #ffcc66; color: white; font-weight: bold; width: 30%; border-radius: 5px;">선택옵션</div>
							<div class="pl-3 py-1" style="background-color: #fff7e6; border-radius: 5px;">
							<c:forEach var="taste" items="${odvo.tastenamelist}">
								<div align="left" class="my-1" style="font-size: 10pt;">💕 ${taste.tastename}</div>
							</c:forEach>
							</div>
						</td>
						<td class="align-middle">${odvo.ordercount}</td>
						<td class="align-middle"><fmt:formatNumber value="${odvo.order.totalprice}" pattern="###,###" />원</td>
						<td class="align-middle">

							<span class="orderstatus" data-toggle="modal" data-target="#orderstatus_${status.index}">
							  <c:choose>
									<c:when test="${odvo.pickupstatus == 1}">주문완료</c:when>
									<c:when test="${odvo.pickupstatus == 2}">준비 중</c:when>
									<c:when test="${odvo.pickupstatus == 3}">픽업대기</c:when>
									<c:otherwise>픽업완료</c:otherwise>
								</c:choose>
							</span>
							<!-- Modal -->
							<div class="modal fade" id="orderstatus_${status.index}">
							  <div class="modal-dialog modal-lg modal-dialog-scrollable">
							  <!-- .modal-dialog 클래스를 사용하여 <div> 요소에 크기 클래스를 추가합니다. -->
							    <div class="modal-content">

							      <!-- Modal body -->
							      <div class="modal-body mt-5" align="center">
							      	  <input type="hidden" id="hidden_orderstatus" value="${odvo.pickupstatus-1}" />
							      	  <input type="hidden" id="hidden_statusindex" value="2_${status.index}" />
									  <img src="<%=ctxPath%>/images/img_narae/주문상태설정.png" style="width: 40%;"/>
									  <div align="left" id="infoDiv">
									  	※ 주문 직후 기본 설정은 '주문완료' 입니다.<br>
										※ '준비 중' 선택 시 픽업 시간을 설정할 수 있습니다.
									  </div>
									  <div id="modalWrapDiv" align="left" class="mx-5 px-5 py-2">
									  	<div class="m-3"><input type="radio" class="radio" name="pickupStatus_${status.index}" id="1_${status.index}" value="1"/> <label for="1_${status.index}">주문완료</label></div>
									  	<div class="m-3">
									  		<div><input type="radio" class="radio ready" name="pickupStatus_${status.index}" id="2_${status.index}" value="2"/> <label for="2_${status.index}">준비 중</label></div>
									  		<div id="forHide" style="background-color: #e6f3ff;">
									  			<div><span style="margin-right: 10%;">고객 주문 시각</span><span id="orderdate" class="orderdate">${odvo.order.orderdate}</span></div>									  		
									  			<div><span style="margin-right: 10%;">픽업 시각</span><span id="pickuptime" style="color: red;"></span></div>
									  			
									  			<div>
									  				<span>예상 준비 시간</span>
									  				<span id="timePlus" style="color: #ff8080; font-size: 25pt; font-weight: bold;">+</span>
									  				<span id="timeCss">
									  				<span id="time" style="font-weight: bolder;"></span>
									  				분
									  				</span>
									  				<span id="timeMinus" style="color: #ff8080; font-size: 25pt; font-weight: bold;">-</span>
									  			</div>
									  			<div style="font-size: 10pt; margin-top: 3%;">※ 최소 설정 시간은 <a style="color: blue; font-weight: bold;">20분</a>입니다.</div>
									  		</div>
									  	</div>
									  	<div class="m-3"><input type="radio" class="radio" name="pickupStatus_${status.index}" id="3_${status.index}" value="3"/> <label for="3_${status.index}">픽업대기</label></div>
									  	<div class="m-3"><input type="radio" class="radio" name="pickupStatus_${status.index}" id="4_${status.index}" value="4"/> <label for="4_${status.index}">픽업완료</label></div>
									  </div>
									  <form name="hiddenFrm">
									  	<input type="hidden" name="orderdetailno" id="orderdetailno" value="${odvo.orderdetailno}"/>
									  	<input type="hidden" name="status"/>
									  	<input type="hidden" name="pickupTime"/>
									  </form>
									  
							      </div>
							      
							      <!-- Modal footer -->
							      <div class="modal-footer">
							        <button type="button" class="btn btn-primary" onclick="goUpdate(this)">변경</button>
							        <button type="button" id="cancelBtn" class="btn btn-danger" data-dismiss="modal">취소</button>
							      </div>
							    </div>
							  </div>
							</div>
	
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

</div>

<jsp:include page="../footer.jsp" />