<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
   $(document).ready(function(){
	   
	   if( ${requestScope.userid != null} ) {
		   alert("인증 성공되었습니다.");
	   }
	   
   });
</script>
</head>
<body>
	<li style="cursor: pointer;">인증 결과창</li>
	<c:if test="${requestScope.userid != null}" >
		<button type="button" id="btnSubmit" class="btn btn-sm px-5" onclick="window.parent.changePwd()">비밀번호 변경</button>
	</c:if>
</body>
</html>