<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<%-- 직접 만든 CSS --%>
<style type="text/css">

#main {
	margin-top: 5%;
	height:700px;
}
#video {
	background-color: #9beafd;
	height:700px;
	padding-top: 4%;
	opacity: 0.8;
	background-image:  radial-gradient(#ffffff 1px, transparent 0.5px), radial-gradient(#ffffff 1px, #9beafd 0.5px);
	background-size: 20px 20px;
	background-position: 0 0,10px 10px;
}
#ourProduct {
	background-color: #f7fde7;
	height:700px;
	display: flex;
	align-items: center;
	text-align: center;
}
#ourTaste {
	height:550px;
	display: flex;
	align-items: center;
	text-align: center;
}
#shortcut {
	height:450px;
}

img#mainImg {
	width: 50%;
}

.cup {
display: inline-block;
width: 20%;
height: 320px;
text-align: center;
}

#forCenter > div:nth-child(2) > span:nth-child(1) > span.cupBackground {
	background-color: #fff9e1;
}

#forCenter > div:nth-child(2) > span:nth-child(2) > span.cupBackground {
	background-color: #ffffff;
}

#forCenter > div:nth-child(2) > span:nth-child(3) > span.cupBackground {
	background-color: #e4d09c;
}

#forCenter > div:nth-child(2) > span:nth-child(4) > span.cupBackground {
	background-color: #f4df87;
}

@font-face {
    font-family: 'TAEBAEKmilkyway';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.0/TAEBAEKmilkyway.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: 'SUITE-Regular';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
    font-weight: 400;
    font-style: normal;
}

@font-face {
    font-family: 'seolleimcool-SemiBold';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2312-1@1.1/seolleimcool-SemiBold.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: 'HSSanTokki20-Regular';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2405@1.0/HSSanTokki20-Regular.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

#forCenter > div.title > span {
	font-family: 'TAEBAEKmilkyway';
	font-size: 30pt;
}

.productname {
	font-family: 'SUITE-Regular';
}

.productdetail {
	font-family: 'SUITE-Regular';
	font-size: 15pt;
}

div#helpDesk > div:nth-child(2),
div#map > div:nth-child(2) {
    font-family: 'TAEBAEKmilkyway';
    font-weight: bolder;
    font-size: 40pt;
}

.tasteimg:hover {
	-webkit-transform: scale(1.3);
	transform: scale(1.3);
}

div#todayTaste {
	position: fixed;
	right: 50px;
	top: 480px;
	cursor: context-menu;
}

div#todayTaste span,
div#tastename {
    font-family: 'HSSanTokki20-Regular';
}

</style>

<jsp:include page="header.jsp" />

<script type="text/javascript">

$(document).ready(function(){
	$('#carouselExampleIndicators').carousel({
    	  interval :2000
   	});
});

function goProduct(codeno){
	location.href = "<%=ctxPath%>/order/order_detail.ice?pcode="+codeno;
}

function goTaste(tasteno){
	location.href = "<%=ctxPath%>/product/menuDetail.ice?tasteno="+tasteno;
}

function goStore(){
	location.href = "<%=ctxPath%>/store/searchList.ice" ;
}

function goFaq(){
	location.href = "<%=ctxPath%>/help/help.ice" ;
}

function goClose(){
	$("div#todayTaste").css("display", "none");
}

function goRandom() {
	
	$("div#first").empty();
	
	$.ajax({
		url: "<%=ctxPath%>/admin/todaysRandom.ice",
		type: "post",
		dataType: "json",
		success: function(json){
			// console.log("json: "+JSON.stringify(json));
			
			let html = "<div onclick='goRandom()' style='cursor: pointer;'>"+
					   		"<img style='width: 200px; margin: 5% 0% 0% 20%;' src='<%=ctxPath%>/images/img_narae/icecream_image/"+json.tasteimg+"' />"+
							"<div id='tastename' style='text-align: center; font-size: 20pt; position: relative; top: -20px;'>"+json.tastename+"</div>"+	
					   "</div>";
			
			$("div#todayTasteImg").html(html);
		},
		error: function(request, status, error){
             alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
		
	});
	
}
</script>



<div id="main">
	<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
	    <div class="carousel-inner" align="center" >
		<c:forEach var="mainImg" items="${requestScope.mainImgList}" varStatus="status">
			<c:if test="${status.index == 0}">
			    <div class="carousel-item active">
			      <img style="border: solid 10px #ccf2ff; width: 60%; height: 650px; border-radius: 100px;" src="<%=ctxPath%>/images/img_narae/${mainImg.imgfilename}" class="d-block" alt="...">
			    </div>
			</c:if>
			<c:if test="${status.index != 0 }">
				<div class="carousel-item">
			      <img style="border: solid 10px #ccf2ff; width: 60%; height: 650px; border-radius: 100px;" src="<%=ctxPath%>/images/img_narae/${mainImg.imgfilename}" class="d-block alt="...">
			    </div>
			</c:if>	    
		</c:forEach>
		</div>
		<a style="margin:15% 0% 0% 15%; display: inline-block; height: 100px;" class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			<span class="sr-only">Previous</span>
		</a>
		<a style="margin:15% 15% 0% 0%; display: inline-block; height: 100px;" class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>
</div>

<div id="video" align="center">
	<div class="embed-responsive embed-responsive-16by9" style="width: 50%;">
		<iframe width="560" height="315" src="https://www.youtube.com/embed/o6fmlY9cGcw?si=-0YSRt1kRhl88J-D&amp;controls=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
    </div>
</div>

<div id="ourProduct">
	<div id="forCenter" style="width: 100%;">
		<div class="title" style="width: 100%; margin: 0% 0% 3% 0%;"><span>Our Products</span></div>
		<div>
			<c:forEach var="product" items="${requestScope.productList}">
				<span class="cup" style="width: 15%; margin-right: 2%; cursor: pointer;" onclick="goProduct('${product.productcodeno}')">
					<span class="cupBackground" style="display: block; width: 100%; height: 270px; border-top-left-radius: 150px; border-top-right-radius: 150px;">
						<img style="width: 50%; margin-top: 18%;" src="<%=ctxPath%>/images/img_narae/cup_size/${product.productimg}"/>
					</span>
					<span class="productname" style="display: block; padding-top: 5%; font-size: 20pt;">${product.productname}</span>
					<hr style="border: solid 1px #e3e3e3;">
					<span class="productdetail" style="display: block;">${product.productdetail }</span>
				</span>
			</c:forEach>
		</div>
	</div>
</div>

<div id="ourTaste">
	<div id="forCenter" style="width: 100%;">
		<div class="title" style="width: 100%; margin: 3% 0% 5% 0%;"><span>Our Tastes</span></div>
	
	<%-- 캐러셀 --%>
		<div style="display: flex; margin-bottom: 8%;">
		<c:forEach var="taste" items="${requestScope.tasteList}">
		<div><img class="tasteimg" style="width: 100%; cursor: pointer;" src="<%=ctxPath%>/images/img_narae/icecream_image/${taste.tasteimg}" onclick="goTaste('${taste.tasteno}')"/></div>
		</c:forEach>
		</div>
	
	</div>
</div>





<div id="shortcut" class="mb-5">
	<div style="display: flex; height: 450px; overflow: hidden; ">
		<div id="map" align="center" style="width: 45%; margin: 0% 1% 0% 6%; cursor: pointer;" onclick="goStore()">
			<div style="position: relative; top: -10px; background-color: #ffe7e5; width: 80%; height: 300px; border-radius: 150px; margin-top: 10%;"></div>
			<div style="position: relative; top: -340px; left: -100px;">찾아오는 길</div>
			<img style="position: relative; top: -350px; width: 60%;" src="<%=ctxPath%>/images/img_narae/3d-casual-life-trail-map.png"/>
		</div>
		
		<div id="helpDesk" style="width: 45%; padding-left: 5%; overflow: hidden; height: 450px; cursor: pointer;" onclick="goFaq()">
			<div style="position: relative; top: -10px; background-color: #ffe7e5; width: 80%; height: 300px; border-radius: 150px; margin-top: 10%;"></div>
			<div style="position: relative; top: -340px;">C/S CENTER</div>
			<img style="width: 65%; position: relative; top: -430px; margin-left: 7%;" src="<%=ctxPath%>/images/img_narae/coworking-customer-service-person-answering-question.gif"/>
		</div>
	
	</div>
</div>

<div id="todayTaste">
	<img style="width: 50px; position: relative; left: 400px; top: -200px; cursor: pointer;" src="<%=ctxPath%>/images/img_narae/close.png" onclick="goClose()"/>
	<img style="width: 400px;" src="<%=ctxPath%>/images/img_narae/오늘의맛추천.png"/>
	<div id="todayTasteImg" style="width: 80%; height: 270px; position: relative; left: 80px; top: -300px;">
		<div id="first" style="font-size: 20pt; text-align: center; margin-top: 100px; cursor: pointer;" onclick="goRandom()"><span>무슨 맛을 고를지 고민된다면?<br>이곳을 눌러 보세요!</span></div>
	</div>
</div>

			
<jsp:include page="footer.jsp" />
