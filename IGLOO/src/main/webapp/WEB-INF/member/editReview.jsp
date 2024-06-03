<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 형변환 해줄때  --%>
    
   
<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>    
      
      

<%-- Required meta tags --%> 
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

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
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/editReview.css" />    
    
  
<script type="text/javascript">
$(document).ready(function(){
	
	const content = $("textarea[name='reviewcontent']").val();
	$("textarea[name='reviewcontent']").val(content);
	
	$("input#reset").click(()=>{
		if(confirm("리뷰수정을 취소하시겠습니까?")) {
			alert("리뷰 수정이 취소되었습니다.");
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


function goEditRegister() {
	
	const reviewcontent = $("textarea#reviewcontent").val();
	if( reviewcontent.trim() == "" ) {
        alert("내용을 입력하세요."); 
        $("textarea#reviewcontent").val("").focus();
        return;
    }
	
	

//	var formData = new FormData($("form[name='reviewRegisterFrm']")[0]);

//	const input_file = $("input[name='fileUpload']").get(0);
//	let fileSize = input_file.files[0].size;
	
	// 첨부한 파일의 총량이 20MB 초과시 //   
//    if( fileSize > 20*1024*1024 ) {
//        alert("첨부한 파일의 크기가 20MB를 넘어 1:1 문의를 등록할 수 없습니다.");
//        return; // 종료
//    } 
	
//    else{
    	
		const frm = document.reviewEditFrm;
		frm.action = "editReview.ice";
		frm.method = "post";
		frm.submit();
		
		// opener.location.href="<%=ctxPath%>/member/editReview.ice";
		// window.close(); // 현재 창을 닫음
//    }
	
	
	/*
 	///////////////////////////////////////
	*/
 
}// end of function goInquiry()---------------
</script>  
    
    
    
<div class="container">

 <form name="reviewEditFrm" enctype="multipart/form-data">
     <h2>리뷰 수정</h2>
     <hr>
	 <br><br>
	 
       <div class="review">
        <div class="sumarry">
        <%-- 
          <div class="img-container">
            <img src="<%= ctxPath%>/images/img_narae/cup_size/${requestScope.rvoOne.pvo.productimg}"/>
          </div>--%>
          <div class="option-container">
            <h3>${requestScope.rvoOne.pvo.productname}</h3>
          	
            <ul class="list-group list-group-flush">
            	<c:forEach var="taste" items="${requestScope.rvoOne.odvo.tastenamelist}" varStatus="jjinStatus">
						<li class="list-group-item">${taste.tastename}</li>
				</c:forEach>
            </ul>
          </div>
        </div>
        <div class="content" >
            <%-- <h3>이글루 ...점</h3>
          </div>
          <div class="reviewImgs">
			<i class="fa-solid fa-image fa-10x"></i> 리뷰사진 없을때 
          </div>--%>
            <span class="date">작성일자: ${requestScope.rvoOne.writeday }</span>
          <div class="form-floating">
			  <textarea class="form-control" id="reviewcontent" name="reviewcontent" style="height: 100px">${requestScope.rvoOne.reviewcontent}</textarea>
			  <label for="floatingTextarea2"></label>
		  </div>
        </div>
        <div class="btneditreset" style="margin-top:30px ; text-align: right;">
        	<input id="reset" type="reset" class="btn btn-outline-secondary" value="취소" />
        	<input id="editregi" type="button" class="btn btn-outline-secondary" value="수정" onclick="goEditRegister()"/>
		</div>
      
      
    <input type="hidden" name="odrcode" value="${requestScope.ordercode}"/>
	<input type="text" style="display: none;"/>
	
 </form>	
 
</div>
   
   
   
   	  
		  
		  
		  



		
	

   