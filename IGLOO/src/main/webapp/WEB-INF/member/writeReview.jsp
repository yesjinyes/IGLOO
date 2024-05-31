<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 형변환 해줄때  --%>
    
   
<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>    
      
      

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQuery UI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/writeReview.css" />   

<%-- 직접 만든 JS --%>
<script type="text/javascript">
$(document).ready(function(){
	
	$('#carouselExampleIndicators').carousel({
  	  interval :10
 	});
	
	
	$("input#reset").click(()=>{
		if(confirm("리뷰작성을 취소하시겠습니까?")) {
			alert("리뷰 작성이 취소되었습니다.");
			window.close(); // 현재 창을 닫음
		}
	});
	
	// 취소하기
	$("input:reset").click(function(){
		$("span.error").hide();
		file_arr = []; // 첨부파일 담아둔 배열 초기화
		$("div#fileDrop").empty();
		$("img#previewImg").hide();
	});
});// end of $(document).ready(function(){})-----------


function goRegister() {
	
	const reviewcontent = $("textarea#reviewcontent").val();
	if( reviewcontent.trim() == "" ) {
        alert("내용을 입력하세요."); 
        $("textarea#reviewcontent").val("").focus();
        return;
    }
	
	

	var formData = new FormData($("form[name='reviewRegisterFrm']")[0]);

	const input_file = $("input[name='fileUpload']").get(0);
	let fileSize = input_file.files[0].size;
	
	// 첨부한 파일의 총량이 20MB 초과시 //   
    if( fileSize > 20*1024*1024 ) {
        alert("첨부한 파일의 크기가 20MB를 넘어 1:1 문의를 등록할 수 없습니다.");
        return; // 종료
    } 
	
    else{
    	
		const frm = document.reviewRegisterFrm;
		frm.action = "writeReview.ice";
		frm.method = "post";
		frm.submit();
		
    }
	
	
	/*
 	///////////////////////////////////////
	*/
 
}// end of function goInquiry()---------------
</script>



<div class="container">

	 <form name="reviewRegisterFrm" enctype="multipart/form-data">
	 
		     <h2>리뷰 작성</h2>
		     <hr>
			 
			 
			 <%-- 해당 주문코드의 옵션들 --%>
			 <div style="display:inline-block; color: #a6a6a6; border-radius:5px; padding:0 5px 0 5px; margin-bottom: 3px;">${requestScope.odvoOne.order.ordercode}</div>
			 <br><br>
			 
			<%-- 주문한 맛 이미지 캐러셀--%>
			<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
			    <div class="carousel-inner" align="center" >
				<c:forEach var="Img" items="${requestScope.odvoOne.tasteimglist}" varStatus="status">
					<c:if test="${status.index == 0}">
					    <div class="carousel-item active">
					      <img style="border: solid 10px #ccf2ff; width: 60%; height: 650px; border-radius: 100px;" src="<%=ctxPath%>/images/img_taste/${Img.tasteimg}" class="d-block" alt="...">
					    </div>
					</c:if>
					<c:if test="${status.index != 0 }">
						<div class="carousel-item">
					      <img style="border: solid 10px #ccf2ff; width: 60%; height: 650px; border-radius: 100px;" src="<%=ctxPath%>/images/img_taste/${Img.tasteimg}" class="d-block" alt="...">
					    </div>
					</c:if>	    
				</c:forEach>
				</div>
				<a style="margin:15% 0% 0% 15%; display: inline-block; height: 100px;" class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a>
				<a style="margin:15% 15% 0% 0%; display: inline-block; height: 100px;" class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div>
			
			
			  
		   <div class="col-md-12">
		      <div class="review">
		        
		          <%-- 선택한 제품 품목 --%>
		          <div class="option-container">
					<h3>${requestScope.odvoOne.product.productname}</h3>
		          	<ul class="list-group list-group-flush">
		            	<c:forEach var="taste" items="${requestScope.odvoOne.tastenamelist}" varStatus="jjinStatus">
		  							<li class="list-group-item">${taste.tastename}</li>
	  					</c:forEach>
		            </ul>
		          </div>
		      </div>
		  </div>
			  
	      <div class="review">
	        <div class="content" >
	        	
		        <%-- 주문한지점 이름 --%>
				<h3>홍대부평점</h3>
				
				<%-- 리뷰사진첨부 --%>
	            <div class="reviewImgs">
					<div class="form-group" style="width: 35%;">
					  <label for="fileUpload" style="margin-bottom: 2%;">파일첨부</label>
					  <input type="file" class="form-control-file" id="fileUpload" name="fileUpload" accept='image/*' style="margin-right: 5%;">
					</div>
					
	            	<%-- 첨부 사진 없는경우 
	            	<c:if test="${empty requestScope.사진}"> 
				    	<i class="fa-solid fa-image fa-10x"></i>
				    </c:if>--%>
	            </div>
		          
		        <div class="star">☆☆☆☆☆&nbsp;&nbsp;</div>
		          
		        <%-- 후기입력칸 --%>
		        <div class="form-floating">
				  <textarea class="form-control" placeholder="리뷰를 작성해주세요:)" id="reviewcontent" style="height: 100px"></textarea>
				  <label for="reviewcontent"></label>
			   </div>
	        </div>
	        
	        <%-- 리뷰동의 --%>
	        <div class="agree" style="border: solid 1px red;">
		        <input type="checkbox" class="sf_check_agree_privacy" style="border: solid 1px red;">
		        <p class="title" style="border: solid 1px red;">리뷰 수집 및 사용 권한 동의</p>
	        </div>
	        
	        <%-- 리뷰 등록버튼 --%>
	        <div class="btnregireset" style="margin-top:30px ; text-align: right;">
	        	<input id="reset" type="reset" class="btn btn-outline-secondary" value="취소" />
	        	<input id="register" type="button" class="btn btn-outline-secondary" value="등록" onclick="goRegister()"/>
		    </div>
			    
		  </div>
	</form>	  
		  
		  
		  
<form name="ordercodeFrm">
	<input type="text" name="odrcode" />
	<input type="text" style="display: none;"/>
</form>
		
	
</div>



