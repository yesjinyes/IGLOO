<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
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

<jsp:include page="../sidebar.jsp"/>

<script type="text/javascript">
$(document).ready(function(){
    
    $("button.btn-success").click(function(){
       
       const pwd = $("input:password[name='pwd']").val();
       const pwd2 = $("input:password[id='pwd2']").val();
       
       if(pwd != pwd2) {
          alert("암호가 일치하지 않습니다.");
          $("input:password[name='pwd']").val("");
          $("input:password[id='pwd2']").val("");
          return;
       }
       
       else {
          const regExp_pwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
              // 숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성 
              
            const bool = regExp_pwd.test(pwd);   
             
            if(!bool) {
                // 암호가 정규표현식에 위배된 경우
                alert("암호는 8글자 이상 15글자 이하에 영문자,숫자,특수기호가 혼합되어야만 합니다.");
                $("input:password[name='pwd']").val("");
                $("input:password[id='pwd2']").val("");
                return; // 종료
            }
            else {
               // 암호가 정규포현식에 맞는 경우 => pwdUpdateEndFrm form 태그로 보낸다.
               const frm = document.pwdUpdateEndFrm;
               frm.action = "<%= ctxPath%>/login/pwdUpdateEnd.ice";
               frm.method = "post"; <%-- post 방식일 때만 DB 를 바꾼다. --%>
               frm.submit();
               
            }
       }
    });// end of $("button.btn-success").click(function(){})
    
    
 }); // end of $(document).ready(function(){})


</script>




<div>
비밀번호 변경 화면이 나와야 할 자리... 인데 밑에 c:if 가 안먹는건지, ${requestScope.method == 'GET'} 이 안먹는건지.. 화면이 안뜬다
</div>





<%-- get 방식일 때의 form 태그 --%>
<c:if test="${requestScope.method == 'GET'}"> 
  <form name="pwdUpdateEndFrm">
  
  	<img src="<%= ctxPath%>/images/img_yejin/lock.png" style="width: 10%; padding: 0 5% 5% 0;"/>
    <h2 style="font-weight: bold; margin-bottom: 2%; display: inline-block;">비밀번호 변경</h2>
    <p style="margin: 7% 0 15% 0; color: gray;">새롭게 지정할 비밀번호를 입력해주세요.</p>
  
    <div id="inputBox">
      	
      <div class="input-form-box">
      	<span style="font-size: 13pt; color: #262626;">새 비밀번호</span>
      	<input type="password" name="pwd" class="form-control" placeholder="8~16자 영문자, 숫자, 특수문자 조합" />
      </div>
      
      <div class="input-form-box">
      	<span style="font-size: 13pt; color: #262626;">새 비밀번호 확인</span>
      	<input type="password" id="pwd2" class="form-control" placeholder="비밀번호 재입력"/>
      </div>
      
      <%-- 새로운 암호 입력했을 때 --%>
      <input type="hidden" name="userid" value="${requestScope.userid}"/>  
      
      <div class="button-box" style="margin-top: 12%;" >
        <button type="button" class="btn btn-light btn-xs" style="width: 20%;">초기화</button>
        <button type="button" class="btn btn-success btn-xs" style="width: 30%; margin-left:2%;">비밀번호 변경</button>
      </div>
    </div>
  </form>
</c:if>


<%-- post 방식일 때의 form 태그 --%>
<c:if test="${requestScope.method == 'POST'}"> 
   <div style="text-align: center; font-size: 14pt; color: navy;">
      <c:if test="${requestScope.n == 1}">
         사용자 ID ${requestScope.userid}님의 비밀번호가 새로이 변경되었습니다.
      </c:if>
      
      <c:if test="${requestScope.n == 0}">
         SQL구문 오류가 발생되어 비밀번호를 변경할 수 없습니다.
      </c:if>
   </div>
</c:if>



<%-- 사이드바 닫기 --%>
		</div>
	</div>
</div>
<%-- 사이드바 끝 --%>

<jsp:include page="../footer.jsp"></jsp:include>
