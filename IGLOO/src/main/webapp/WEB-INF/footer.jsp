<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>
<style type="text/css">

@font-face {
    font-family: 'ChosunGu';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@1.0/ChosunGu.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

div#footer {
	background-image: url('<%=ctxPath%>/images/img_narae/footerimg.png');
	 background-size: cover;
	/*background-color: #111e45;*/
}

div#sns > div {
	margin-left: auto;
	cursor: pointer;
}

div#info {
	background-color: white;
	opacity: 0.6;
	border-radius: 15px;
	width: 65%;
	margin: 1% 0% 0% 10%;
	padding: 1%;
	height: 120px;
}

div#wrap {
	width: 60%;
}

div#info > span {
	font-family: 'ChosunGu';
	display: block;
}


div#info > span > span{
	font-family: 'ChosunGu';
	display: inline-block;
	width: 30%;
	text-align: center;
}

div#sns {
	width: 12%;
	margin-left: 20%;
}

</style>

<script type="text/javascript">
function goInsta(){
	window.open("https://www.instagram.com/baskinrobbinskorea/");
}

function goKakao(){
	window.open("https://pf.kakao.com/_xjXcmM");
}

function goYoutube(){
	window.open("https://www.youtube.com/channel/UCdUlCaxi7gx9Q-WDVDe30YA");
}
</script>

			</div>
		</div>
	</div>
</div>
	<div id="footer" style="height: 300px; display: flex;">
		<div id="wrap">
			<div id="logo"><img style="width: 20%; margin: 3% 0% 0% 10%;" src="<%=ctxPath%>/images/igloo_logo.png"/></div>
			<div id="info">
			<span><span>사&nbsp;업&nbsp;자&nbsp;&nbsp;등&nbsp;록&nbsp;&nbsp;번&nbsp;호</span> │ 303-81-09535</span>
			<span><span>정&nbsp;&nbsp;&nbsp;&nbsp;보</span> │ IGLOO(주) 대표이사 서영학</span>
			<span><span>주&nbsp;&nbsp;&nbsp;&nbsp;소</span> │ 서울 마포구 월드컵북로 21 풍성빌딩 2, 3, 4층</span>
			<span><span>T&nbsp;&nbsp;e&nbsp;&nbsp;l</span> │ 02-336-8546</span>
			<br>
			<span style="color: white; opacity: 0.7; margin-top: 1.5%;">Copyright &copy; 2024 IGLOO Company. All Rights Reserved.</span>
			</div>
		</div>
		<div id="sns" style="display: flex; padding-top: 0.7%; align-items: center; ">
				<div id="insta" onclick="goInsta()"><img width="48" height="48" src="https://img.icons8.com/doodle/48/instagram--v1.png" alt="instagram--v1"/></div>
				<div id="kakao" onclick="goKakao()"><img width="48" height="48" src="https://img.icons8.com/doodle/48/kakaotalk.png" alt="kakaotalk"/></div>
				<div id="youtube" onclick="goYoutube()"><img width="48" height="48" src="https://img.icons8.com/doodle/48/youtube-play--v2.png" alt="youtube-play--v2"/></div>
			</div>
	</div>