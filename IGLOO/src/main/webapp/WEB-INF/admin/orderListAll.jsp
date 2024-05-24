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
	
	$("input:radio[name='pickupStatus']").change(function(e){
		
		if($("input:radio[id='2']").prop("checked")){ // 준비 중 클릭 시
			$("div#forHide").show();
			
			// 1. 기본 시간 20분 설정
			$("span#time").html("20");
			
			const orderdate = $("span#orderdate").html();
			let date = new Date(orderdate);
			date.setMinutes(date.getMinutes() + 20);
			
			let pickuptime = dateToString(date);
			
			$("span#pickuptime").html(pickuptime);
			
			// 2. + 버튼 눌렀을 때
			$("span#timePlus").click(function(){
				
				const currentTime = Number($("span#time").html());
				$("span#time").html(currentTime+20);
				
				date.setMinutes(date.getMinutes() + 20);
				
				let pickuptime = dateToString(date);
				$("span#pickuptime").html(pickuptime);
				
				if(currentTime+20>120){
					alert("최대 준비 시간은 120분입니다.");
					$("span#time").html("120");
					date.setMinutes(date.getMinutes() - 20);
					
					let pickuptime = dateToString(date);
					$("span#pickuptime").html(pickuptime);
				}
				
			});
			
			// 3. - 버튼 눌렀을 때
			$("span#timeMinus").click(function(){
				
				const currentTime = Number($("span#time").html());
				$("span#time").html(currentTime-20);
				
				date.setMinutes(date.getMinutes() - 20);
				
				let pickuptime = dateToString(date);
				$("span#pickuptime").html(pickuptime);
				
				if(currentTime-20<20){
					alert("최소 준비 시간은 20분입니다.");
					$("span#time").html("20");
					
					date.setMinutes(date.getMinutes() + 20);
					
					let pickuptime = dateToString(date);
					$("span#pickuptime").html(pickuptime);
					
				}
				
			});
			
		}
		
		if(!$("input:radio[id='2']").prop("checked")){
			$("div#forHide").hide();		
		}
		
	});
	
	
}); // document.ready

function goUpdate() {
	
	$("input:radio[name='pickupStatus']").each((index, item)=>{
		
		if($(item).prop("checked")){
			$("input:hidden[name='status']").val($(item).val());
		}
		
	});
	

	const status = $("input:hidden[name='status']").val();

	if(status == '2'){
		$("input:hidden[name='pickupTime']").val($("span#pickuptime").html());
	}
	else {
		$("input:hidden[name='pickupTime']").val("");
	}
	const pickupTime = $("input:hidden[name='pickupTime']").val();
	const orderdetailno = $("input:hidden[name='orderdetailno']").val();
	
    $.ajax({
        url: "<%=ctxPath%>/admin/updateOrderStatus.ice",
        data: {"status": status, "pickupTime": pickupTime, "orderdetailno": orderdetailno},
        type: "post",
        dataType: "json",
        success: function(json){
            console.log(JSON.stringify(json));
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
span#orderstatus {
	color: #3399ff;
	cursor: pointer;
}

span#ordercode:hover,
span#orderstatus:hover {
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
	width: 10%;
	text-align: center;
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

							<span id="orderstatus" data-toggle="modal" data-target="#orderstatus_${status.index}">
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
							      <div class="modal-body mt-5">
									  <img src="<%=ctxPath%>/images/img_narae/주문상태설정.png" style="width: 40%;"/>
									  <div align="left" id="info">
									  	※ 주문 직후 기본 설정은 '주문완료' 입니다.<br>
										※ '준비 중' 선택 시 픽업 시간을 설정할 수 있습니다.
									  </div>
									  <div align="left" class="mx-5 p-5" style="border: solid 1px red;">
									  	<div class="m-3"><input type="radio" name="pickupStatus" id="1" value="1"/> <label for="1">주문완료</label></div>
									  	<div class="m-3">
									  		<div><input type="radio" name="pickupStatus" id="2" value="2"/> <label for="2">준비 중</label></div>
									  		<div id="forHide" style="background-color: #fff7e6;">
									  			<div><span>고객 주문 시각</span><span id="orderdate">${odvo.order.orderdate}</span></div>									  		
									  			<div><span>픽업 시각</span><span id="pickuptime"></span></div>
									  			<div>※ 최소 설정 시간은 <span style="color: blue; font-weight: bold;">20분</span> 입니다.</div>
									  			
									  			<div>
									  				<span>예상 준비 시간</span>
									  				<span id="timePlus">+</span>
									  				<span id="timeCss">
									  				<span id="time"></span>
									  				분
									  				</span>
									  				<span id="timeMinus">-</span>
									  			</div>
									  		</div>
									  	</div>
									  	<div class="m-3"><input type="radio" name="pickupStatus" id="3" value="3"/> <label for="3">픽업대기</label></div>
									  	<div class="m-3"><input type="radio" name="pickupStatus" id="4" value="4"/> <label for="4">픽업완료</label></div>
									  </div>
									  <form name="hiddenFrm">
									  	<input type="hidden" name="orderdetailno" value="${odvo.orderdetailno}"/>
									  	<input type="hidden" name="status"/>
									  	<input type="hidden" name="pickupTime"/>
									  </form>
							      </div>
							      
							      <!-- Modal footer -->
							      <div class="modal-footer">
							        <button type="button" class="btn btn-primary" onclick="goUpdate()">변경</button>
							        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
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