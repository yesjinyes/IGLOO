<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
	String ctxPath = request.getContextPath();
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

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/login/idfind.css" />





<%-- 직접 만든 JS --%>
<script type="text/javascript">



$(document).ready(function(){
	
	 $(document).on("keydown", function(e) {
	        if (e.keyCode == 13) {
	            goFind();
	        }
	    });

	    // 확인 버튼 클릭시 goFind 함수 실행
	    $("button#check").click(function(){
	        goFind();
	    });
	
})	// end of $(document).ready(function(){})----------------

// === Function Declaration === //
function goFind(){
	
	const name = $("input:password[name='pwd']").val().trim();
	if(name == ""){
		alert("비밀번호를 입력하세요!!");
		return;
	}
	
    const frm = document.idFindFrm;
    frm.action = "<%= ctxPath%>/member/updatepwdcheck.ice";
    frm.method = "post";
    frm.submit();
    
}	// end of function goFind()------------------

// === 아이디 찾기 모달창에 입력한 input 태그 value 값 초기화 === //
// => login.js 에서 실행
function func_form_reset_empty() {
   document.querySelector("form[name='idFindFrm']").reset(); // jQuery 로 작성해도 된다.
   $("div#div_findResult").empty();
}// end of function func_form_reset_empty()----------

</script>







<link type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
	
	<form name="idFindFrm">
	   <ul style="list-style-type: none;">
	      <li id="pwd" style="margin: 25px 0">
	          <label>비밀번호</label>
	          <input type="password" name="pwd" size="25" autocomplete="off" /> 
	      </li>
	   </ul> 
	
	   <div class="my-3 text-center">
	      <button id="check" type="button" class="btn btnidfind">확인</button>
	   </div>
	</form>
	
<%-- 결과창 띄우기 --%>
<div class="my-3 text-center" id="div_findResult">
<c:if test="${requestScope.check}">
	<c:choose>
    	<c:when test="${requestScope.pwdcheck}">
    	<script>document.getElementById("check").style.display = "none"; document.getElementById("pwd").style.display = "none";</script>
			비밀번호가 확인되었습니다.<br>
			수정하기를 원하시면 아래 버튼을 클릭해주세요.
			<br>
			<button type="button" style="cursor: pointer;" onclick="window.parent.goMemberUpdate()">회원정보수정</button>
    	</c:when>
    	<c:otherwise>
    		비밀번호가 일치하지 않습니다
    	</c:otherwise>
    </c:choose>
    </c:if>
	
</div>