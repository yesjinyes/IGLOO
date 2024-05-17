<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	
    String ctxPath = request.getContextPath();
    //    /IGLOO
    // 반드시 변수명을 다르게 지정해주어야 한다. 같을 시 중복 될 수 있다.
%>

<jsp:include page="../header.jsp" />

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/login/login.css" />
<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/login/login.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	//=== 로그인을 하지 않은 상태일 때 
	//     로컬스토리지(localStorage)에 저장된 key가 'saveid' 인 userid 값을 불러와서 
	//     input 태그 userid 에 넣어주기 ===
	if(${empty sessionScope.loginuser}){
		
		const loginUserid = localStorage.getItem('saveid');

		// console.log(loginUserid);
		
		if(loginUserid != null){
			$("input#loginUserid").val(loginUserid);
			$("input:checkbox[id='saveid']").prop("checked", true);
		}

	}
	
	if(${requestScope.pwdeditRequest == true}){
		$("btn.passwdFindClose").click();
	}
	
})	// end of $(document).ready(function(){})----------------

window.closeModal = function(){
    $('.modal').modal('hide');
    javascript:history.go(0);
};

function changePwd() {
	closeModal();
	location.href="<%= ctxPath%>/login/pwdChange.ice";
}

</script>

<div id="loginLogo" class="text-center mb-3">
	<a href="<%= ctxPath%>/"><img src="<%= ctxPath%>/images/igloo_logo.png" style="width:200px;"/></a>
</div>

<%-- === 로그인을 하기 위한 폼을 생성 === --%>
	<form name="loginFrm" action="<%= ctxPath%>/login/login.ice" method="post">
    	<table id="loginTbl" class="my-2">
        	<thead>
            	<tr>
                	<th colspan="2">LOGIN</th>
              	</tr>
          	</thead>
          	<tbody>
              	<tr>
                  	<td class="text-center">
						<i class="fa-solid fa-user"></i>
					</td>
                  	<td><input type="text" name="userid" id="loginUserid" size="35" placeholder="아이디" autofocus autocomplete="off" /></td>
              	</tr>
              	<tr>
                  	<td class="text-center">
						<i class="fa-solid fa-key"></i>
					</td>
                  	<td><input type="password" name="pwd" id="loginPwd" size="35" placeholder="비밀번호" autoComplete="off"/></td>
                  	<%-- autoComplete="off" => password 자동입력 막기--%>
              	</tr>
              
              	<%-- === 아이디 저장 === --%>
              	<tr>
              		<td colspan="2">
              			<input type="checkbox" id="saveid" />&nbsp;<label for="saveid">아이디저장</label>
              		</td>
              	</tr>
              	<%-- === 로그인 === --%>
              	<tr>
                  	<td colspan="4">
                     	<button type="button" id="btnSubmit" class="btn btn-sm px-5">로그인</button> 
                  	</td>
              	</tr>
          	</tbody>
      	</table>
   </form>
   <%-- === 아이디 찾기, 비밀번호 찾기 === --%>
   <div class="text-center mt-2 mb-5">
   		<a style="cursor: pointer;" data-toggle="modal" data-target="#userIdfind" data-dismiss="modal">아이디찾기</a>
   		&nbsp;&nbsp;|&nbsp;
        <a style="cursor: pointer;" data-toggle="modal" data-target="#passwdFind" data-dismiss="modal" data-backdrop="static">비밀번호찾기</a>
   </div>
<%-- ****** 아이디 찾기 Modal 시작 ****** --%>
   <%-- <div class="modal fade" id="userIdfind"> --%> 
   <%-- 만약에 모달이 안보이거나 뒤로 가버릴 경우에는 모달의 class 에서 fade 를 뺀 class="modal" 로 하고서 해당 모달의 css 에서 zindex 값을 1050; 으로 주면 된다. --%> 
    
   <%-- Bootstrap s20_modal --%>
   <div class="modal fade" id="userIdfind" data-backdrop="static">
	   <%-- 
	   	data-backdrop="static" 이 있으면 바깥을 눌렀을 때 창이 안 닫히고
	   	data-backdrop="static" 이 없으면 바깥을 눌렀을 때 창이 닫힌다.
	   --%>
    
	   <div class="modal-dialog">
	   		<div class="modal-content">
	      
		        <%-- Modal header --%>
		        <div class="modal-header">
		        	<img src="<%= ctxPath%>/images/igloo_logo.png" style="width:200px;"/>
		        	<h4 class="modal-title my-auto">아이디</h4>
		          	<button type="button" class="close idFindClose" data-dismiss="modal"><%-- X 위치 --%>&times;</button>
		        </div>
		        
		        <%-- Modal body --%>
		        <div class="modal-body">
		          	<div id="idFind">
		             	<iframe id="iframe_idFind" style="border: none; width: 100%; height: 350px;" src="<%= ctxPath%>/login/idFind.ice">
		             	</iframe>
		          	</div>
		        </div>
		        
		        <%-- Modal footer --%>
		        <div class="modal-footer">
		          	<button type="button" class="btn btn-danger idFindClose" data-dismiss="modal">Close</button>
		        </div>
	    	</div>
	  	</div>
	</div>
<%-- ****** 아이디 찾기 Modal 끝 ****** --%>

<%--
  ◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆
--%>

<%-- ****** 비밀번호 찾기 Modal 시작 ****** --%>
  	<div class="modal fade" id="passwdFind"> <%-- 만약에 모달이 안보이거나 뒤로 가버릴 경우에는 모달의 class 에서 fade 를 뺀 class="modal" 로 하고서 해당 모달의 css 에서 zindex 값을 1050; 으로 주면 된다. --%>
    	<div class="modal-dialog">
      		<div class="modal-content">
      
		        <%-- Modal header --%>
		        <div class="modal-header">
		          <h4 class="modal-title">비밀번호 찾기</h4>
		          <button type="button" class="close passwdFindClose" data-dismiss="modal">&times;</button>
		        </div>
		        
		        <%-- Modal body --%>
		        <div class="modal-body">
		        	<div id="pwFind">
		             	<iframe id="iframe_pwdFind" style="border: none; width: 100%; height: 350px;" src="<%= ctxPath%>/login/pwdFind.ice">  
		             	</iframe>
		          	</div>
		        </div>
		        
		        <%-- Modal footer --%>
		        <div class="modal-footer">
		        	<button type="button" class="btn btn-danger passwdFindClose" data-dismiss="modal">Close</button>
		        </div>
      		</div>
    	</div>
  	</div> 
<%-- ****** 비밀번호 찾기 Modal 끝 ****** --%>

<jsp:include page="../footer.jsp" />
 
