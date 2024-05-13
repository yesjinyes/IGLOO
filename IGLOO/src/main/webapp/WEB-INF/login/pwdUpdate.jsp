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
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/login/pwdUpdate.css" />

<jsp:include page="../header.jsp"/>



<div id="container">
  <div id="loginBox">
  
  	<img src="<%= ctxPath%>/images/img_yejin/lock.png" style="width: 10%; padding: 0 5% 5% 0;"/>
    <h2 style="font-weight: bold; margin-bottom: 2%; display: inline-block;">비밀번호 변경</h2>
    <p style="margin: 7% 0 15% 0; color: gray;">새롭게 지정할 비밀번호를 입력해주세요.</p>
  
    <div id="inputBox">
      	
      <div class="input-form-box">
      	<span style="font-size: 13pt; color: #262626;">새 비밀번호</span>
      	<input type="password" name="pwd" class="form-control"  placeholder="8~16자 영문, 숫자, 특수문자 중 2개 조합" />
      </div>
      
      <div class="input-form-box">
      	<span style="font-size: 13pt; color: #262626;">새 비밀번호 확인</span>
      	<input type="password" name="pwd_check" class="form-control" placeholder="비밀번호 재입력"/>
      </div>
      
      <div class="button-box" style="margin-top: 12%;" >
        <button type="button" class="btn btn-light btn-xs" style="width: 20%;">초기화</button>
        <button type="button" class="btn btn-primary btn-xs" style="width: 30%; margin-left:2%;">비밀번호 변경</button>
      </div>
      
    </div>
    
  </div>
</div>

    

<jsp:include page="../footer.jsp"></jsp:include>
