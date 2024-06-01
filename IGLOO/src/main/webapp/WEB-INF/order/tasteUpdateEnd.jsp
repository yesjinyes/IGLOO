<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- font 감자꽃 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">

<%-- 직접 만든 CSS --%>
<style>
*{
	font-family: "Gamja Flower", sans-serif;
}
</style>

<%-- 직접 만든 JS --%>
<script type="text/javascript">

window.onload = function(){
	   
   $("button#btnSubmit").click(function(){

       const iframe_updatetaste = document.getElementById("iframe_updatetaste");     
       
       const iframe_window = iframe_updatetaste.contentWindow;                  
       
       iframe_window.func_form_reset_empty();

   })  // end of $("button#btnSubmit").click(function(){})-------------
   
}	// end of window.onload = function()-------
</script>

<%-- 직접 만든 CSS --%>
<style rel="stylesheet" type="text/css">
div:first-child{
	margin: 100px auto;
	margin-bottom: 0;
	text-align: center;
}
div#tasteUpdateResult{
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

*{
	font-size: 30pt;
}
</style>

<div>
	<div id="tasteUpdateResult" style="font-size:30pt;">수정이 완료되었습니다.</div>
	<button type="button" id="btnSubmit" onclick="window.parent.changetaste()">장바구니로 이동</button>
</div>