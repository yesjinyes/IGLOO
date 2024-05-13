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


<div id="container">
  <div id="loginBox">
  
  	<img src="<%= ctxPath%>/images/lock.png" style="width: 12%; margin-top: -10%;"/>
    <h2>개인정보 보호를 위해<br><span style="color: red;">비밀번호를 변경</span>해주세요</h2>
    <p>회원님은 <span style="color: #4d94ff;">3개월 이상 동일한 비밀번호</span>를 사용하고 계십니다.<br>소중한 개인정보 보호를 위해 비밀번호를 주기적으로 변경해주세요.</p>
  
    <div id="inputBox">
      	
      <div class="input-form-box">
      	<span style="font-size: 13pt;">현재 비밀번호</span>
      	<input type="password" name="pwd" class="form-control"  placeholder="현재 비밀번호 입력" />
      </div>	
      	
      <div class="input-form-box">
      	<span style="font-size: 13pt;">새 비밀번호</span>
      	<input type="password" name="pwd" class="form-control"  placeholder="8~16자 영문, 숫자, 특수문자 중 2개 조합" />
      </div>
      
      <div class="input-form-box">
      	<span style="font-size: 13pt;">새 비밀번호 확인</span>
      	<input type="password" name="pwd_check" class="form-control" placeholder="비밀번호 재입력"/>
      </div>
      
      <div class="button-box" style="margin-top: 13%;" >
        <button type="button" class="btn btn-light btn-xs" style="width: 25%;">초기화</button>
        <button type="button" class="btn btn-primary btn-xs" style="width: 30%; margin-left:2%;">비밀번호 변경</button>
      </div>
      
    </div>
    
  </div>
</div>

    

<jsp:include page="../footer.jsp"></jsp:include>
