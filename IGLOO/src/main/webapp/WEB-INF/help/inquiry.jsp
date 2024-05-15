<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
	//     IGLOO
%>

<jsp:include page="../header.jsp"/>
<jsp:include page="../sidebar.jsp"/>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/inquiry.css" />

<%-- 직접 만든 JS --%>
<script type="text/javascript">

	$(document).ready(function(){
		
		$("input#reset").click(()=>{
			if(confirm("문의글 작성을 취소하시겠습니까?")) {
				alert("문의글 작성이 취소되었습니다.");
				location.href="${pageContext.request.contextPath}/help/faqlist.ice";
			}
		});
		
	});// end of $(document).ready(function(){})-----------
	
	function goInquiry() {
		
		const categoryType = $("select[name='categoryType']").val();
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
		
	 //	const frm = document.member_search_frm; 
	 
	 //	frm.action = "memberList.up"; // form 태그에 action 이 명기되지 않았으면 현재보이는 URL 경로로 submit 되어진다.
	 //	frm.method = "get"; // form 태그에 method 를 명기하지 않으면 "get" 방식이다.
	 //	frm.submit(); 
		
	}// end of function goInquiry()---------------
	
</script>


<div class="container mt-2" >
	
	<h2 class="mt-5" style="margin-left: 3%;">1:1 문의하기</h2>
	<hr style="border: solid 2px #6190BC; width: 96%; margin: 4% auto 6% auto;">
	
	<%-- 카테고리 --%>
	<p style="display: inline-block; margin: 0 2% 2% 3%; font-weight: bold; font-size: 13pt">카테고리</p>
	<select name="categoryType" style="font-size: 11pt;">
      <option value="">문의유형선택</option>
      <option value="product">제품문의</option>
      <option value="pickup">픽업문의</option>
      <option value="spot">지점문의</option> 
      <option value="payment">결제문의</option>
      <option value="etc">기타문의</option>     
    </select>
	
	<%-- 아이디 --%>
	<div class="form-group">
	  <label for="title">아이디</label>
	  <div style="display: inline-block; margin: 1% 3% 3% 3%;">${requestScope.userid}</div>
	</div>
	
	<%-- 제목 --%>
	<div class="form-group">
	  <label for="title">제목</label>
	  <input type="text" class="form-control" id="title" placeholder="제목을 입력해주세요.">
	</div>
	
	<%-- 내용 --%>
	<div class="form-group">
	  <label for="content">내용</label>
	  <textarea class="form-control" id="content" rows="3"></textarea>
	</div>
	
	<%-- 사진파일 첨부 --%>
	<div class="form-group" style="width: 35%;">
	  <label for="fileUpload" style="margin-bottom: 2%;">파일첨부</label>
	  <input type="file" class="form-control-file" id="fileUpload" style="margin-right: 5%;">
	</div>
		
	<p style="text-align: right; margin: 7% 5% 4% 0; font-size: 10.5pt;"> 
		※ 내가 쓴 문의는 '마이페이지 > 내가 쓴 문의' 에서 확인 가능합니다. 
	</p>	
		
	<%-- 문의등록, 취소 버튼 --%>
    <div id="btnInquiry" class="float-right">
      <input id="reset" type="reset" class="btn btn-light btn-xs mr-3" value="취소" />
      <input id="inquiry" type="button" class="btn btn-xs mr-5" value="문의하기" onclick="goInquiry()"/>
    </div>

</div>
<%-- 사이드바 오른쪽 내용 삽입 끝  --%>



		</div>
	</div>
</div>
<%-- 사이드바 끝 --%>

<jsp:include page="../footer.jsp"></jsp:include>
