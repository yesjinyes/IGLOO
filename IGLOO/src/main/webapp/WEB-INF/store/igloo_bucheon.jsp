<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IGLOO BUCHEON</title>

<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%-- font 감자꽃 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">

<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQuery UI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/store.css" />

</head>
<body>
	<div id="hongdae" class="mx-auto mt-3">
		<div class="representative">
			<img src="<%=ctxPath%>/images/img_hj/store/igloo_bucheon.jpg" alt="...">
		</div>

		<div class="details_location mt-5">
        	<div data-viewid="basicInfoTitle" data-root="" class="place_details" style="display: block;">
        		<span class="info_location">
                		<span class="txt_location">
                    		<span class="screen_out">분류:&nbsp;</span>
                    		아이스크림
                    	</span>
        		</span>

    			<h2 class="tit_location mt-2 mb-3">이글루 부천점</h2>

    			<div class="details_contactinfo">
        			<span class="screen_out mb-3">가게 연락처 및 위치 정보 리스트</span>
        			<ul class="list_infolocation row">
                		<li class="col-4">
		                	<i class="fa-solid fa-location-dot"></i>
		                    <span>주소 : 경기 부천시 원미구 석천로177번길 12</span>
                		</li>
                		<li class="col-4">
		                	<i class="fa-solid fa-phone"></i>
		                    <span>전화번호 : 031-111-1111</span>
                		</li>
            			<li class="col-4">
            				<a href="<%= ctxPath%>/index.ice">
            					<i class="fa-regular fa-building"></i>
               					<span>IGLOO 홈페이지</span>
               				</a>
            			</li>
        			</ul>
    			</div>
			</div>
    	</div>
	</div>
</body>
</html>