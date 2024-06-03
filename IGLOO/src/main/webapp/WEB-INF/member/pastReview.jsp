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
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/pastReview.css" />


<script type="text/javascript">
$(document).ready(function(){

	$("div#ordercodeDiv").hide();
    
});// end of $(document).ready(function(){})----------------------


function goEditReview(){
	
	let ordercode = $(event.target).parent().parent().parent().find("#ordercodeDiv").text(); //디비에서 가져온 리뷰번호
	
//	alert(ordercode);  
//	$("input:text[name='odrcode']").val();
	/*
	const frm = document.ordercodeFrm; //writeReview컨트롤러로 보낼 주문번호에 담음
	frm.odrcode.value = ordercode; 
	frm.action = "<%= ctxPath%>/member/editReview.ice";
	frm.method = "get";
	frm.submit();
*/
	
	//리뷰 수정 팝업창 띄우기
    const url = "<%= ctxPath%>/member/editReview.ice?odrcode="+ordercode;

    // 너비 750, 높이 670 인 팝업창을 화면 가운데 위치시키기
    const width = 850;
    const height = 670;

    const left = Math.ceil( (window.screen.width - width)/2 ) //window.screen.width 내 화면 넓이   //Math.ceil() 정수로만듬
    //           1400 - 650 = 750/2 => 375

    const top = Math.ceil( (window.screen.height - height)/2 ) //window.screen.width 내 화면 넓이   //Math.ceil() 정수로만듬
    //           900 - 570 = 330/2 => 165

	
		  
    window.open(url, "editReview",
            "left=" + left + ", top=" + top + ", width=" + width + ", height=" + height);
    
    
}//end of function goEditReview()---------------------------------
/*
function goDeleteReview(){
	
	let ordercode = $(event.target).parent().parent().parent().find("#ordercodeDiv").text(); //디비에서 가져온 리뷰번호
	
	const frm = document.ordercodeFrm; //DeleteReview컨트롤러로 보낼 리뷰번호
	frm.odrcode.value = ordercode; 
	frm.action = "<%= ctxPath%>/member/deleteReview.ice?odrcode="+ordercode;
	frm.method = "post";
	frm.submit();
	
	
}//end of function goDeleteReview()---------------------------------
*/

</script>




	<div id="content" class="col-9">

	<div id="btnReview">
		<a class="btn menufont_size" href="<%= ctxPath %>/member/ableReview.ice" >작성가능한 리뷰</a>
		<a class="btn menufont_size" href="<%= ctxPath %>/member/pastReview.ice" >작성한 리뷰</a>
	</div>
	
	<hr>
	<br>
	
	<c:if test="${not empty requestScope.pastList}">
		<c:forEach var="rvo" items="${requestScope.pastList }">
	
		    <div class="col-md-12">
		      <div class="review">
		        <div class="sumarry">
			        <div id="ordercodeDiv">${rvo.fk_ordercode }</div>
			        <%-- 작성일자 --%>
			        <div class="date" style="text-align: center;">작성일자<br>${rvo.writeday }</div>
		        
			          <div class="img-container">
			            <img src="<%= ctxPath%>/images/img_hj/cup_size/${rvo.pvo.productimg}"/>
			          </div>
			          <div class="option-container">
			            <h3>${rvo.pvo.productname }</h3>
			          	<ul class="list-group list-group-flush">
			            	<c:forEach var="taste" items="${rvo.odvo.tastenamelist}" varStatus="jjinStatus">
			  							<li class="list-group-item">${taste.tastename}</li>
		  					</c:forEach>
			            </ul>
			          </div>
			          <button class="toggleBtn" type="button" data-toggle="collapse" data-target="#${rvo.fk_ordercode }" aria-expanded="false" aria-controls="${rvo.fk_ordercode }">▼</button>
				</div>
				<div class="content collapse" id="${rvo.fk_ordercode }">
		          	<%-- 주문매장 이름
		            <h3>매장명</h3>--%>
		            
		            
		            <%-- 내용 --%>
		            <div class="text" style="border: solid 0px red;">${rvo.reviewcontent}</div>
		            
		            
		            <%-- 수정, 삭제 버튼.  모든 버튼 이벤트 alert말고 컨펌으로 바꾸기 --%>
		            <div class="btns" style="border: solid 0px blue;">
			          	<input id="edit" type="button" class="btn btn-outline-secondary" value="수정하기" onclick="goEditReview()"/>
			          	<%--<input id="delete" type="button" class="btn btn-outline-secondary" value="삭제" onclick="goDeleteReview()"/>--%>
		           </div>
			           
		          
		          
		          <%-- 별점 --%>
		          <%-- <div class="star">${requestScope.star} ☆☆☆☆☆&nbsp;&nbsp; 
		            <span class="date">${rvo.writedate}</span> 
		          </div>--%>
		      </div>
		  </div>
		  </div>
		</c:forEach>
	</c:if>
	
	
	
	<%-- 작성한 리뷰가 없을경우 --%>
    <c:if test="${empty requestScope.pastList}">
		<div style="text-align: center;" class="mt-5">
			<div id="noreview">리뷰를 작성해주세요!</div>
		</div>
	</c:if>

   
    
  
  </div>
  
  
<form name="ordercodeFrm">
	<input type="hidden" name="odrcode"/>
	<input type="text" style="display: none;"/>
</form>
  
  
  

</div>
</div>
</div>









<jsp:include page="../footer.jsp" />