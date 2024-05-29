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
}
#ourProduct {
	background-color: #f7fde7;
	border: solid 1px red;
	height:700px;
	display: flex;
	align-items: center;
	text-align: center;
}
#ourTaste {
	border: solid 1px red;
	height:700px;
	display: flex;
	align-items: center;
	text-align: center;
}
#shortCut {
	border: solid 1px red;
	height:700px;
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

.carousel-inner .carousel-item.active,
.carousel-inner .carousel-item-next,
.carousel-inner .carousel-item-prev {
 /* display: flex;*/
}

.carousel-inner .carousel-item-right.active,
.carousel-inner .carousel-item-next {
  transform: translateX(25%);
}

.carousel-inner .carousel-item-left.active, 
.carousel-inner .carousel-item-prev {
  transform: translateX(-25%);
}
  
.carousel-inner .carousel-item-right,
.carousel-inner .carousel-item-left{ 
  transform: translateX(0);
}


</style>

<jsp:include page="header.jsp" />

<script type="text/javascript">
        $(document).ready(function(){
        	
        	$('#recipeCarousel').carousel({
          	  interval :1500
          	});

          	$('.carousel .carousel-item').each(function(){
          	    var next = $(this).next();
          	    if (!next.length) {
          	        next = $(this).siblings(':first');
          	    }
          	next.children(':first-child').clone().appendTo($(this));
          	    
          	for (var i=0;i<2;i++) {
          	    next=next.next();
          	    if (!next.length) {
          	     	next = $(this).siblings(':first');
          	   	}
          	        
          	 next.children(':first-child').clone().appendTo($(this));
          	}
        });
          	
    });
  </script>

<div id="main">
<div style="width: 100%;" align="center"><img id="mainImg" src="<%=ctxPath%>/images/img_narae/mainImg.png"/></div>
</div>

<div id="video" align="center">
	<div class="embed-responsive embed-responsive-16by9" style="width: 50%;">
		<iframe width="560" height="315" src="https://www.youtube.com/embed/o6fmlY9cGcw?si=-0YSRt1kRhl88J-D&amp;controls=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
    </div>
</div>

<div id="ourProduct">
	<div id="forCenter" style="width: 100%;">
		<div style="width: 100%; margin: 3% 0%;"><span>Our Products</span></div>
		<div>
			<c:forEach var="product" items="${requestScope.productList}">
				<span class="cup" style="width: 15%; margin-right: 2%;">
					<span style="display: block; background-color: #f7c87c; width: 100%; height: 270px; border-top-left-radius: 150px; border-top-right-radius: 150px;">
						<img style="width: 50%; margin-top: 18%;" src="<%=ctxPath%>/images/img_narae/cup_size/${product.productimg}"/>
					</span>
					<span style="display: block; padding-top: 5%; font-size: 15pt;">${product.productname}</span>
					<hr style="border: solid 1px #e3e3e3;">
					<span style="display: block;">${product.productdetail }</span>
				</span>
			</c:forEach>
		</div>
	</div>
</div>

<div id="ourTaste">
	<div id="forCenter" style="width: 100%;">
		<div style="width: 100%; margin: 3% 0%;"><span>Our Tastes</span></div>
	
	<%-- 캐러셀 --%>
	
	<div class="row mx-auto my-auto">
	        <div id="recipeCarousel" class="carousel slide w-100" data-ride="carousel">
	            <div class="carousel-inner w-100" role="listbox">
	                <c:forEach var="taste" items="${requestScope.tasteList}" varStatus="status">
		                <c:if test="${status.index == 0}">
			                <div class="carousel-item active">
			                    <img class="col-3 img-fluid" src="<%=ctxPath%>/images/img_narae/icecream_image/${taste.tasteimg}" />
			                </div>
		                </c:if>
		                <c:if test="${status.index != 0}">
			                <div class="carousel-item">
		                    	<img class="col-3 img-fluid" src="<%=ctxPath%>/images/img_narae/icecream_image/${taste.tasteimg}" />
		                	</div>
		                </c:if>
	                </c:forEach>
	            </div>
	            <a class="carousel-control-prev" href="#recipeCarousel" role="button" data-slide="prev">
	                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	                <span class="sr-only">Previous</span>
	            </a>
	            <a class="carousel-control-next" href="#recipeCarousel" role="button" data-slide="next">
	                <span class="carousel-control-next-icon" aria-hidden="true"></span>
	                <span class="sr-only">Next</span>
	            </a>
	        </div>
	    </div>
	
	
	
	
	
	
	
	
	</div>
</div>

<div id="shortCut"></div>

<jsp:include page="footer.jsp" />
