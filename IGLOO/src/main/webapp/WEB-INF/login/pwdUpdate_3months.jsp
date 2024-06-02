<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
	//     IGLOO
%>

<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/login/pwdUpdate_3months.css" />

<jsp:include page="../header.jsp"/>

<jsp:include page="../sidebar.jsp"/>

<script type="text/javascript">
$(document).ready(function(){
	
	// == 취소 클릭한 경우 (메인페이지로 이동)== //
	$("button.btn-light").click(function() {
		location.href = "<%= ctxPath%>/index.ice"
	});
	
	
	// == 비밀번호 변경 클릭한 경우 == //
    $("button.btn-info").click(function(){
    	goPwdUpdate_3months();
    });
    
    
 	// == 엔터키 눌러도 버튼 클릭되도록 == //
	$("input#pwd3").bind("keyup", function(e){
		if(e.keyCode == 13){
			goPwdUpdate_3months();
		}
	});
    
}); // end of $(document).ready(function(){})-------------
 
function goPwdUpdate_3months() {
	
    const pwd2 = $("input:password[name='pwd2']").val();
    const pwd3 = $("input:password[name='pwd3']").val();

    // 비밀번호 입력란이 공란일 경우 
    if(pwd2.trim()== "" || pwd3.trim()== "") {
    	alert("새로 설정할 비밀번호를 입력해주세요.");
    }
    
    // 새롭게 입력한 비밀번호 2개가 서로 일치하는지 확인
    else if(pwd2 != pwd3) {
		alert("새로 입력한 암호가 일치하지 않습니다.");
		$("input:password[name='pwd2']").val("");
		$("input:password[name='pwd3']").val("");
		$("input:password[name='pwd2']").focus();
		return;
	}
		    
		// 암호 정규표현식 체크
    else {
		const regExp_pwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
         // 숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성 
           
        const bool = regExp_pwd.test(pwd2);   
          
        if(!bool) {
             // 암호가 정규표현식에 위배된 경우
             alert("암호는 8글자 이상 15글자 이하에 영문자,숫자,특수기호가 혼합되어야만 합니다.");
             $("input:password[name='pwd2']").val("");
             $("input:password[name='pwd3']").val("");
             $("input:password[name='pwd2']").focus();
             return; // 종료
        }
        else {
             // 암호가 정규포현식에 맞는 경우 => pwdUpdateEndFrm form 태그로 보낸다.
             const frm = document.pwdUpdate3monthsFrm;
             frm.action = "<%= ctxPath%>/login/pwdUpdate_3months.ice";
             frm.method = "post"; <%-- post 방식일 때만 DB 를 바꾼다. --%>
             frm.submit();
        }
    }
	 
 }// end of function goPwdUpdate_3months()-----------------------
 
</script>

<form name="pwdUpdate3monthsFrm">
	<div id="container_pwd" class="mt-5">
		
		<div id="loginBox">
			
			<div style="display: flex; justify-content: center;">
				<div style="width: 12%; margin-right: 3.5%;">
		 			<img src="<%= ctxPath%>/images/img_yejin/lock.png" style="width: 100%;"/>
		    	</div>
		    	<h2 style="text-align: left;">개인정보 보호를 위해<br>비밀번호를 변경해주세요</h2>
			</div> 
	
			<p>회원님은 <span style="color: #fc6136;">3개월 이상 동일한 비밀번호</span>를 사용하고 있습니다.<br>소중한 개인정보 보호를 위해 비밀번호를 주기적으로 변경해주세요.</p>
		
			<%-- 비밀번호 입력 박스 --%>
	  		<div id="inputBox">
	    	
			<!-- <div class="input-form-box">
					<span style="font-size: 13pt;">현재 비밀번호</span>
					<input type="password" name="pwd1" class="form-control"  placeholder="현재 비밀번호 입력" />
				</div> -->  
	    	
				<div class="input-form-box">
					<span style="font-size: 13pt;">새 비밀번호</span>
					<input type="password" name="pwd2" class="form-control"  placeholder="8~16자 영문, 숫자, 특수문자 중 2개 조합" />
				</div>
	    
				<div class="input-form-box">
					<span style="font-size: 13pt;">새 비밀번호 확인</span>
					<input type="password" id="pwd3" name="pwd3" class="form-control" placeholder="비밀번호 재입력"/>
				</div>
	    
				<div class="button-box" style="margin-top: 13%;" >
					<button type="button" class="btn btn-light btn-xs" style="width: 30%;">취소</button>
					<button type="button" class="btn btn-info btn-xs" style="width: 30%; margin-left:2%;">비밀번호 변경</button> 
				</div>
			</div>
	  
		</div>
	</div>
</form>
    
<%-- 사이드바 닫기 --%>
		</div>
	</div>
</div>    
<%--------------%>

<jsp:include page="../footer.jsp"></jsp:include>
