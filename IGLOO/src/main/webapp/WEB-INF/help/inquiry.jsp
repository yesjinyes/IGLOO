<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
	//     IGLOO
%>

<jsp:include page="../header.jsp"/>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/inquiry.css" />

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/sidebar.css" />

<%-- 직접 만든 JS --%>
<script type="text/javascript">
	$(document).ready(function(){
		
		$("input#reset").click(()=>{
			location.href="${pageContext.request.contextPath}/help/faqlist.ice";
		});
		
		$("input#inquiry").click(()=>{
			alert("문의가 등록되었습니다.");
			goInquiry();
		});
		
	});// end of $(document).ready(function(){})-----------
	
	function goInquiry() {
		
		const categoryType = $("select[name='searchType']").val();
	 	
	 	if(searchType == "") { // 검색대상을 선택하지 않았을 경우 
	 		alert("검색대상을 선택하세요.");
	 		return;
	 	}
	 	
	 	const frm = document.member_search_frm; // 회원을 찾는 폼에 보내겠다. // document.member_search_frm 뒤에 () 안넣게 조심,,
	 	 
	 //	frm.action = "memberList.up"; // form 태그에 action 이 명기되지 않았으면 현재보이는 URL 경로로 submit 되어진다.
	 //	frm.method = "get"; // form 태그에 method 를 명기하지 않으면 "get" 방식이다.
	 	frm.submit(); 
		
		
		
		if( $("input#title").val().trim() == "" ) {
	        alert("제목을 입력하세요!!");
	        $("input#title").val("").focus();
	        return;
	    }
		
		if( $("input#content").val().trim() == "" ) {
	        alert("내용을 입력하세요!!");
	        $("input#content").val("").focus();
	        return;
	    }
		
		
	}// end of function goInquiry() ---------------
	
</script>



<%-- 사이드바 시작 --%>
<div id="container" class="mx-auto">
	<div class="row">
		<div id="sidebar" class="col-3" style="border:solid 1px blue; text-align:center;">
			<div id="sidebar" style="border:solid 3px #81BEF7; border-radius: 10px 10px; width:45%; margin-left:30%;">
				<div style="font-weight: bold; margin-top:5%;">마이페이지</div>
				<hr style="width: 80%;">
				<div style="font-weight: bold;">주문관리</div>
				<a style="color:black; text-decoration: none;" href="<%= ctxPath %>.up"><div>-주문조회</div></a>
				<br>
				<div style="font-weight: bold;">게시물 관리</div>
				<a style="color:black; text-decoration: none;" href="<%= ctxPath %>.up"><div>-내가 쓴 리뷰</div></a>
				<a style="color:black; text-decoration: none;" href="<%= ctxPath %>.up"><div>-1:1 문의 내역</div></a>
				<br>
				<div style="font-weight: bold;">정보관리</div>
				<a style="color:black; text-decoration: none;" href="<%= ctxPath %>.up"><div>-회원정보 변경</div></a>
				<a style="color:black; text-decoration: none;" href="<%= ctxPath %>.up"><div style="margin-bottom:5%;">-비밀번호 변경</div></a>
			</div>
		</div>
		
		<div id=”content” class="col-9" style="border:solid 1px red;">
<%-- 사이드바 여기까지 --%>



  <div class="container mt-2" >
	
	<h2 class="mt-5" style="margin-left: 3%;">1:1 문의하기</h2>
	<hr style="border: solid 2px #6190BC; width: 96%; margin: 4% auto 6% auto;">
	
	<%-- 카테고리 선택 --%>
	<div class="dropdown">
	  <p style="display: inline-block; margin-left: 3%;">카테고리</p>
	  <button class="btn btn-secondary btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
	          style="margin: -0.7% 0 0 2%;">
	    문의유형 선택
	  </button>
	  
	  <div class="dropdown-menu" aria-labelledby="dropdownMenu2" >
	    <button class="dropdown-item" type="button">제품문의</button>
	    <button class="dropdown-item" type="button">픽업문의</button>
	    <button class="dropdown-item" type="button">지점문의</button>
	    <button class="dropdown-item" type="button">결제문의</button>
	    <button class="dropdown-item" type="button">기타문의</button>
	  </div>
	</div>
	
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
		
	<p style="text-align: right; margin: 5% 5% 5% 0; font-size: 10.5pt;"> 
		※ 내가 쓴 문의는 '마이페이지 > 내가 쓴 문의' 에서 확인 가능합니다. 
	</p>	
		
	<%-- 문의등록, 취소 버튼 --%>
    <div id="btnInquiry" class="float-right">
      <input id="reset" type="reset" class="btn btn-light btn-xs mr-3" value="취소" />
      <input id="inquiry" type="button" class="btn btn-xs mr-5" value="문의하기" onclick="goInquiry()"/>
    </div>

  </div>
<%-- 사이드바 오른쪽 내용(1:1 문의하기) 삽입 끝  --%>


		</div>
	</div>
</div>
<%-- 사이드바 끝 --%>

<jsp:include page="../footer.jsp"></jsp:include>
