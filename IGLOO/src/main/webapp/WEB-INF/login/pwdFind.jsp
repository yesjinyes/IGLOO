<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

<%-- font 감자꽃 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">

<%-- 직접 만든 CSS --%>
<style>
*{
	font-family: "Gamja Flower", sans-serif;
	font-size: 30pt;
}
</style>

<%-- 직접 만든 JS --%>
<script type="text/javascript">
$(document).ready(function(){
	
	const method = "${requestScope.method}";
	
	// console.log("~~ 확인용 method : " + method);
	/*
		~~ 확인용 method : GET
	*/
	
	if(method == "GET"){
		$("div#div_findResult").hide();
	}
	if(method == "POST"){
		$("input:text[name='userid']").val("${requestScope.userid}");
		$("input:text[name='email']").val("${requestScope.email}");
		
		// === 올바르게 입력하여, 인증코드 보낼 시 찾기 버튼 숨기기 === //
		if(${requestScope.isUserExist && requestScope.sendMailSuccess}){
			$("button.btnpwdfind").hide();
		}
		
	}
	
	$("div#spin").hide();
	
	// === 찾기 버튼 클릭 === //
	$("button.btnpwdfind").click(function(){
		goFind();		
	})	// end of $("button.btn-success").click(function(){})-------------
	
	$("input:text[name='email']").bind("keyup", function(e){
		
		if(e.keyCode == 13){
			goFind();
		}
	})	// end of $("input:text[name='email']").binde("keydown", function(e){})-----
	
	// === 인증하기 버튼 클릭시 이벤트 처리해주기 시작 === //
	$("button.btn-info").click(function(){
		
		const input_confirmCode = $("input:text[name='input_confirmCode']").val().trim();
		
		if(input_confirmCode == ""){
			alert("인증코드를 입력하세요!!")
			return;		// 종료
		}
		
		<%-- 인증하기 form --%>
		const frm = document.verifyCertificationFrm;
		frm.userCertificationCode.value = input_confirmCode;
		frm.userid.value = $("input:text[name='userid']").val().trim();
		
		frm.action = "<%= ctxPath%>/login/verifyCertification.ice";
		frm.method = "post";
		frm.submit();
		
	})	// end of $("button.btn-info").click(function(){})----------
	// === 인증하기 버튼 클릭시 이벤트 처리해주기 끝 === //	
	
})	// end of $(document).ready(function(){})----------------

// === Function Declaration === //
function goFind(){
	
	const userid = $("input:text[name='userid']").val().trim();
	if(userid == ""){
		alert("아이디를 입력하세요!!");
		return;
	}
	
	const email = $("input:text[name='email']").val();
	const regExp_email = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
    const bool = regExp_email.test(email);

    if(!bool){     // 이메일이 정규표현식에 위배된 경우
    	alert("이메일을 올바르게 입력하세요!!");
		return;
    }
    
    $("button.btnpwdfind").hide();
    $("div#spin").show();
    
    const frm = document.pwdFindFrm;
    frm.action = "<%= ctxPath%>/login/pwdFind.ice";
    frm.method = "post";
    frm.submit();
    
}	// end of function goFind()------------------

</script>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/login/pwdFind.css" />

<form name="pwdFindFrm">
	<ul style="list-style-type: none;">
      <li style="margin: 25px 0">
          <label>아이디</label>
          <input type="text" name="userid" size="25" autocomplete="off" /> 
      </li>
      <li style="margin: 25px 0">
          <label>이메일</label>
          <input type="text" name="email" size="25" autocomplete="off" /> 
      </li>
   </ul> 

   <div class="my-3 text-center">
   		<button type="button" class="btn btnpwdfind">찾기</button>
      	<div id="spin" class="spinner-border text-info" role="status">
  			<span class="visually-hidden"></span>
		</div>
   </div>
</form>
<%-- 결과창 띄우기 --%>
<div class="my-3 text-center" id="div_findResult">
	
	<c:if test="${requestScope.isUserExist == false}">
   		<span style="color: red; font-size:30pt;">해당 정보의 사용자가 존재하지 않습니다.</span>
   	</c:if>
   
   	<c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == true}">
   		<span style="font-size:30pt;">
   			인증코드가
   			<span style="color: blue; font-size:30pt;">${requestScope.email}</span>로 발송되었습니다.
   			<br>
           	인증코드를 입력해주세요
       	</span>
       	<br><br>
       	<input type="text" name="input_confirmCode"/>
       	<button type="button" class="btn btn-sm btn-info mb-1" style="font-size:30pt;">인증하기</button>
    </c:if> 
    
    <c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == false}">
    	<span style="color: red; font-size:30pt;">메일발송이 실패했습니다</span>
	</c:if>
</div>

<%-- 인증하기 form --%>
<form name="verifyCertificationFrm">
	<input type="hidden" name="userCertificationCode" />	<%-- 인증코드 --%>
	<input type="hidden" name="userid"/>	<%-- DB WHERE 절에 활용될 아이디 --%>
</form>