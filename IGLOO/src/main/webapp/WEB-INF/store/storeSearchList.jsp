<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>
<%-- 테스트 --%>
<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/main/storeSearchList.css" />

<jsp:include page="../header.jsp" />

<script type="text/javascript">

$(document).ready(function(){
	
	$("input[name='store_search']").keyup(function(e){
		if(e.keyCode == 13){
			goSearch();
		}
	});
	
});

function goSearch(){
		
	const searchInput = $("input[name='store_search']").val();

	if(searchInput == ""){
		alert("검색어를 입력하세요.");
		return;
	}
	
	$.ajax({
		url: "searchListJSON.ice",
        type: "post",
        data: {"searchInput": searchInput},
        dataType: "json",
        success: function(json){
        
        	if(json.length == 0){
        		alert("검색 결과가 없습니다.");
        	}
        	
        	else{ // 검색 결과가 있을 경우
        		
        		$("div#accordion_container").hide();
        		let html = `<div id="accordion_container" style="padding-left: 9%;"><div class="accordion" id="accordionExample" style="width: 90%;">`;
        		
        		$.each(json, function(index, item){
        			
        			html += `<div class="card">
        		   		<div class="card-header" id="heading\${index}">
    	     			<h2 class="mb-0">
    	       			<button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse\${index}" aria-expanded="false" aria-controls="collapse\${index}">
    	         				<h3>\${item.storename}</h3>
    	         				<p>\${item.storeaddress}</p>
    	       			</button>
    	     			</h2>
    	   		</div>
    			<%-- 아코디언 내부 --%>
    	   		<div id="collapse\${index}" class="collapse" aria-labelledby="heading\${index}" data-parent="#accordionExample">
    	     			<div class="card-body">
    	       			<div class="card-columns m-5 row">
    	       			<div class="card text-white col-lg-3 p-0">
    						    <div class="card-body text-center">
    						      	<img src="<%= ctxPath%>/images/img_narae/2022_135415.jpg" class="img-fluid" alt="Responsive image" >
    						    </div>
    						</div>
    						<div class="ml-5 pt-5 col-lg-5 col-md-4">
    						    <h1 class="card-text">\${item.storename}</h1>
    						    <p class="card-text storeinfoDetails">\${item.storeaddress}</p>
    						    <p class="card-text storeinfoDetails">홈페이지: \${item.storepage}</p>
    						    <p class="card-text storeinfoDetails">전화번호: \${item.storetel}</p>
    						</div>
    	       			</div>
    	     			</div>
    	   		</div>
    	  	</div>`;
        			
        		});
        		
        		html += `</div></div>`;
        		
        		$("div#searchDIV").html(html);
        		
        	}

        },
        error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
    });
	
}

</script>



<div id="storeSearch">
	<nav id="searchList" class="navbar navbar-expand-sm justify-content-center">
		<ul class="navbar-nav">
			<li class="nav-item">
		    	<a class="nav-link" href="<%= ctxPath%>/store/searchList.ice">리스트로 검색</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="<%= ctxPath%>/store/searchMap.ice">지도로 검색</a>
		    </li>
		</ul>
	</nav>
</div>

<br>
<%-- 검색창 --%>
<div class="input_text">
	<label class="my-auto">
		<input class="my-sm-0" type="text" name="store_search" id="store_search" size="50" placeholder='지점명 또는 주소를 입력하세요' required="required">
	</label>
	<%-- <button id="btnSearch" class="btn my-sm-0" type="button" onclick="goSearch()"> --%>
		<img src="<%= ctxPath%>/images/img_hj/search.png" class="img-fluid" alt="Responsive image" onclick="goSearch()">
	<%-- </button> --%>
</div>

<%-- 구분선 --%>
<br><br>
<hr>
<br>

<%-- 검색 결과 있을 시 보이는 화면 --%>
<div id="searchDIV"></div>

<%-- 아코디언 --%>
<div id="accordion_container" style="padding-left: 9%;">
	<div class="accordion" id="accordionExample" style="width: 90%;">
  	
  	<c:forEach var="store" items="${requestScope.storeList }" varStatus="status">

	  	<div class="card">
	   		<div class="card-header" id="heading${status.index }">
	     			<h2 class="mb-0">
	       			<button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse${status.index }" aria-expanded="false" aria-controls="collapse${status.index }">
	         				<h3>${store.storename }</h3>
	         				<p>${store.storeaddress }</p>
	       			</button>
	     			</h2>
	   		</div>
			<%-- 아코디언 내부 --%>
	   		<div id="collapse${status.index }" class="collapse" aria-labelledby="heading${status.index }" data-parent="#accordionExample">
	     			<div class="card-body">
	       			<div class="card-columns m-5 row">
						<div class="card text-white col-lg-3 p-0">
						    <div class="card-body text-center ">
						      	<img src="<%= ctxPath%>/images/img_hj/map.png" class="img-fluid" alt="Responsive image" >
						    </div>
						</div>
						<div class="ml-5 pt-5 col-lg-5 col-md-4">
						    <h1 class="card-text">${store.storename }</h1>
						    <p class="card-text storeinfoDetails">${store.storeaddress }</p>
						    <p class="card-text storeinfoDetails">홈페이지: ${store.storepage }</p>
						    <p class="card-text storeinfoDetails">전화번호: ${store.storetel }</p>
						</div>
	       			</div>
	     			</div>
	   		</div>
	  	</div>
  	
  	</c:forEach>
  		
	</div>
</div>

<%-- Header 마무리에 따라 div 추가 닫기 --%>
<jsp:include page="../footer.jsp" />