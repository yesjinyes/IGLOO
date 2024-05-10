<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IGLOO</title>

<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQuery UI CSS 및 JS --%>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/menuDetail.css" />

<%-- 직접 만든 JS --%>

<jsp:include page="../header.jsp" />

<%-- 여기까지 헤더 --%>
<div class="container contents">

	<div id="imgdiv">
		<div id="item_img">
			<img id="shootingstar" src="images/1 행복한 나라의 슈팅스타.png" />
		</div>
		
		<div id="item_detail">
			<div class="mt-5"><span style="color: #0099ff; font-size: 10pt;">ICE CREAM</span></div>
			<h6 class="my-3">Shooting Star in Wonderland</h6>
			<h2 class="my-3" style="font-weight: bolder;">이상한 나라의 슈팅스타</h2>
			<div class="my-3"><span style="line-height: 200%;">딸기와 블루베리가 들어간 솜사탕 아이스크림에<br>톡톡 튀는 팝핑캔디로 입안 가득 즐거운 맛</span></div>
			<div id="detail_ingredient" class="mt-5">
				<div>
					<img style="height: 60px;" src="images/blueberry.png"/>
					<div>블루베리</div>
				</div>
				<div>
					<img style="height: 60px;" src="images/strawberry.png"/>
					<div>딸기</div>
				</div>
				<div>
					<img style="height: 60px;" src="images/poppingcandy.png"/>
					<div>팝핑 캔디</div>
				</div>
			</div>
		</div>
	</div>
	
	<hr>

	<div id="Nutrition">
		<div class="row">
			<div class="col-md-3" style="font-weight: bold;">영양정보</div>
			<div class="col-md-1 nu">
				<div>1회 제공량</div>
				<div>115</div>
			</div>
			<div class="col-md-1 nu">
				<div>열량(kcal)</div>
				<div>276</div>
			</div>
			<div class="col-md-1 nu">
				<div>당류(g)</div>
				<div>32</div>
			</div>
			<div class="col-md-1 nu">
				<div>단백질(g)</div>
				<div>4</div>
			</div>
			<div class="col-md-1 nu">
				<div>포화지방(g)</div>
				<div>9</div>
			</div>
			<div class="col-md-1 nu">
				<div>나트륨(mg)</div>
				<div>78</div>
			</div>
			<div class="col-md-3" id="allergy">
					<div style="font-weight: bold;">알레르기 성분</div>
					<div>우유, 대두</div>
			</div>
		</div>
	</div>


</div>
<%-- 여기까지 컨텐츠 --%>

<jsp:include page="../footer.jsp" />
