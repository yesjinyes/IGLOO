<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
	//     IGLOO
%>

<jsp:include page="../header.jsp"/>
<jsp:include page="../sidebar.jsp"/>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/help/inquiry.css" />

<%-- 직접 만든 JS --%>
<script type="text/javascript">


	$(document).ready(function(){
		
		$("input#reset").click(()=>{
			if(confirm("문의글 작성을 취소하시겠습니까?")) {
				alert("문의글 작성이 취소되었습니다.");
				location.href="${pageContext.request.contextPath}/help/help.ice";
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
	
	function goInquiry() {
		
		const categoryType = $("select[name='q_category']").val();
	 	if(categoryType == "") { 
	 		alert("카테고리를 선택하세요.");
	 		return;
	 	}
	 	
		if( $("input#title").val().trim() == "" ) {
	        alert("제목을 입력하세요.");
	        $("input#title").val("").focus();
	        return;
	    }
		
		if( $("textarea#content").val().trim() == "" ) {
	        alert("내용을 입력하세요.");
	        $("textarea#content").val("").focus();
	        return;
	    }
		
		var formData = new FormData($("form[name='faqRegisterFrm']")[0]);

		const input_file = $("input[name='fileUpload']").get(0);
		let fileSize = input_file.files[0].size;
		
		// 첨부한 파일의 총량이 20MB 초과시 //   
        if( fileSize > 20*1024*1024 ) {
            alert("첨부한 파일의 크기가 20MB를 넘어 1:1 문의를 등록할 수 없습니다.");
            return; // 종료
        } 
		
        else{

			const frm = document.faqRegisterFrm;
			frm.action = "inquiryRegister.ice";
			frm.method = "post";
			frm.submit();

        }
		
		
		/*
     	///////////////////////////////////////
		*/
	 
	}// end of function goInquiry()---------------
	
</script>


<div class="container mt-2" >
	
	<form name="faqRegisterFrm" enctype="multipart/form-data">
	<h2 class="mt-5" style="margin-left: 3%;">1:1 문의하기</h2>
	<hr style="border: solid 2px #6190BC; width: 96%; margin: 4% auto 6% auto;">
	
	<%-- 카테고리 --%>
	<p style="display: inline-block; margin: 0 2% 2% 3%; font-weight: bold; font-size: 13pt">카테고리</p>
	<select name="q_category" style="font-size: 11pt;">
      <option value="">문의유형선택</option>
      <option value="1">제품문의</option>
      <option value="2">픽업문의</option>
      <option value="3">지점문의</option> 
      <option value="4">결제문의</option>
      <option value="5">기타문의</option>     
    </select>
	
	<%-- 아이디 --%>
	<div class="form-group">
	  <label for="title">아이디</label>
	  <div style="display: inline-block; margin: 1% 3% 3% 3%;">${requestScope.userid}</div>
	  <input type="text" name="userid" value="${requestScope.userid}" style="display: none;"/>
	</div>
	
	<%-- 제목 --%>
	<div class="form-group">
	  <label for="title">제목</label>
	  <input type="text" name="q_title" class="form-control" id="title" placeholder="제목을 입력해주세요.">
	</div>
	
	<%-- 내용 --%>
	<div class="form-group">
	  <label for="content">내용</label>
	  <textarea class="form-control" name="q_content" id="content" rows="3"></textarea>
	</div>
	
	<%-- 사진파일 첨부 --%>
	<div class="form-group" style="width: 35%;">
	  <label for="fileUpload" style="margin-bottom: 2%;">파일첨부</label>
	  <input type="file" class="form-control-file" id="fileUpload" name="fileUpload" accept='image/*' style="margin-right: 5%;">
	</div>
		
	<p style="text-align: right; margin: 7% 5% 4% 0; font-size: 10.5pt;"> 
		※ 내가 쓴 문의는 '마이페이지 > 내가 쓴 문의' 에서 확인 가능합니다. 
	</p>	
		
	<%-- 문의등록, 취소 버튼 --%>
    <div id="btnInquiry" class="float-right">
      <input id="reset" type="reset" class="btn btn-light btn-xs mr-3" value="취소" />
      <input id="inquiry" type="button" class="btn btn-primary btn-xs mr-5" value="문의하기" onclick="goInquiry()"/>
    </div>

	</form>
</div>
<%-- 사이드바 오른쪽 내용 삽입 끝  --%>



		</div>
	</div>
</div>
<%-- 사이드바 끝 --%>

<jsp:include page="../footer.jsp"></jsp:include>
