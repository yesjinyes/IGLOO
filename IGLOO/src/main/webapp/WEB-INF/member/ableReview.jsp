<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 형변환 해줄때  --%>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<%-- 폰트어썸 --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-Avb2QiuDEEvB4bZJYdft2mNjVShBftLdPG8FJ0V7irTLQ8Uo0qcPxh4Plq7G5tGm0rU+1SPhVotteLpBERwTkw==" crossorigin="anonymous" referrerpolicy="no-referrer" />



<jsp:include page="../sidebar.jsp" /> 

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/ableReview.css" />


<script type="text/javascript">
$(document).ready(function(){
	

    
});// end of $(document).ready(function(){})----------------------


function goWriteReview(){
	
	let ordercode = $(event.target).parent().parent().find("#ordercodeDiv").text(); //디비에서 가져온 주문번호
	
//	alert(ordercode);  
//	$("input:text[name='odrcode']").val();
	/*
	const frm = document.ordercodeFrm; //writeReview컨트롤러로 보낼 주문번호에 담음
	frm.odrcode.value = ordercode; 
	frm.action = "<%= ctxPath%>/member/writeReview.ice";
	frm.method = "get";
	frm.submit();
*/
	
	//리뷰 작성 팝업창 띄우기
    const url = "<%= ctxPath%>/member/writeReview.ice?odrcode="+ordercode;

    // 너비 750, 높이 670 인 팝업창을 화면 가운데 위치시키기
    const width = 850;
    const height = 670;

    const left = Math.ceil( (window.screen.width - width)/2 ) //window.screen.width 내 화면 넓이   //Math.ceil() 정수로만듬
    //           1400 - 650 = 750/2 => 375

    const top = Math.ceil( (window.screen.height - height)/2 ) //window.screen.width 내 화면 넓이   //Math.ceil() 정수로만듬
    //           900 - 570 = 330/2 => 165

	
		  
    window.open(url, "ableReview",
            "left=" + left + ", top=" + top + ", width=" + width + ", height=" + height);

}//end of function goEditReview(userid, ctxPath)---------------------------------
</script>




<div id="content" class="col-9">

	<div id="btnReview">
		<a class="btn menufont_size" href="<%= ctxPath %>/member/ableReview.ice" >작성가능한 리뷰</a>
		<a class="btn menufont_size" href="<%= ctxPath %>/member/pastReview.ice" >작성한 리뷰</a>
	</div>
	
	<hr>
	<br>
	
	<c:if test="${not empty requestScope.odvoList}">
		<c:forEach var="odvo" items="${requestScope.odvoList }">
		    <div class="col-md-12">
		      <div class="review">
		        
		        
		        <%-- 해당 날짜 주문시간과 주문코드 --%>
				<div class="dateorderlist my-3 ml-4">
					<div style="display:inline-block; color: #a6a6a6; border-radius:5px; padding:0 5px 0 5px; margin-bottom: 3px;" id="ordercodeDiv">${odvo.order.ordercode}</div>
					<br>
					<div style="display:inline-block; border: solid 1px lightgray; background-color:lightgray; border-radius:5px; padding:0 5px 0 5px;">
						${odvo.order.orderdate} 구매
					</div>
					
					<br><br>
					
					<%-- 주문한 지점 이름 --%>
					<h3>홍대부평점</h3> <%-- 배열로 랜덤돌리기 --%>
				</div>
				
				
				<%-- 선택한 메뉴 이미지 --%>
				<div class="img-container">
					<img class="img-fluid mt-5" src="<%= ctxPath%>/images/img_hj/cup_size/${odvo.product.productimg}" alt="Responsive image">
				</div>
				
		          
		          <div class="option-container">
			        <%-- 선택한 제품 품목 --%>
					<h3>${odvo.product.productname}</h3>
		          	<ul class="list-group list-group-flush">
		            	<c:forEach var="taste" items="${odvo.tastenamelist}" varStatus="jjinStatus">
		  							<li class="list-group-item">${taste.tastename}</li>
	  					</c:forEach>
		            </ul>
		          </div>
		          
		          <div class="btnwrite" style="margin-top:30px ; text-align: right;">
		          	<input id="write" type="button" class="btn btn-outline-secondary" value="작성하기" onclick="goWriteReview()"/>
		          	<input id="send" type="hidden" />
		          </div>
		        
		      </div>
		  </div>
		</c:forEach>
    </c:if>
    
    
	<%-- 주문목록이 없을경우 --%>
    <c:if test="${empty requestScope.odvoList}">
		<div style="text-align: center;" class="mt-5">
			<div id="noreview">작성가능한 리뷰가 존재하지 않습니다.</div>
		</div>
	</c:if>

	<%-- 더보기 버튼
	<div class="more col-md-12 ">
    	 <span id="end" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: red;"></span> 
         <button type="button" class="btn btn-outline-secondary" id="btnMoreReview" value="">더보기</button>
         <span id="totalReview"></span>   
         <span id="countReview">0</span>
    </div>
	 --%>
    
</div>

<form name="ordercodeFrm">
	<input type="text" name="odrcode" style="display: none;"/>
	<input type="text" style="display: none;"/>
</form>


		</div>
	</div>
</div>







<jsp:include page="../footer.jsp" />