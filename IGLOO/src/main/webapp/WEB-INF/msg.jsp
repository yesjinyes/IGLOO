<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">

	alert("${requestScope.message}");       
	location.href = "${requestScope.loc}"; 

	if("${requestScope.message}" == "로그인 실패"){
		localStorage.removeItem('saveid');
	}
	
	if(${requestScope.selfclose == true}){
		
		opener.history.go(0);  // 부모창 새로고침  
		self.close();
	}
</script>    