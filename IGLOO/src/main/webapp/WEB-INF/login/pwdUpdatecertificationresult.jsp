<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<script type="text/javascript">

window.onload = function(){
	   
   if( ${requestScope.userid != null} ) {
	   //alert("인증 성공되었습니다.");
   }
	   
   $("button#btnSubmit").click(function(){

       const iframe_pwdFind = document.getElementById("iframe_pwdFind");     
       
       const iframe_window = iframe_pwdFind.contentWindow;                  
       
       iframe_window.func_form_reset_empty();

   })  // end of $("button#btnSubmit").click(function(){})-------------
   
}	// end of window.onload = function()-------
</script>

<style rel="stylesheet" type="text/css">
div:first-child{
	margin: 100px auto;
	margin-bottom: 0;
	text-align: center;
}
div#certificationResult{
	font-size:13pt;
	font-weight: bold;
}

button#btnSubmit{
	margin-top: 10px;
	background-color: #99ccff;
	font-weight: bold;
	border: solid 1px #063460;
	border-radius: 5px;
	padding: 5px;
}
</style>

<div>
	<div id="certificationResult">인증이 성공되었습니다.</div>
	<c:if test="${requestScope.userid != null}" >
		<button type="button" id="btnSubmit" onclick="window.parent.changePwd()">비밀번호 변경</button>
	</c:if>
</div>
