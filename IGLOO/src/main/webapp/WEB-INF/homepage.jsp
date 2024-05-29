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

@media (min-width: 768px) {

    /* show 4 items */
    .carousel-inner .active,
    .carousel-inner .active + .carousel-item,
    .carousel-inner .active + .carousel-item + .carousel-item,
    .carousel-inner .active + .carousel-item + .carousel-item + .carousel-item  {
        display: block;
    }
    
    .carousel-inner .carousel-item.active:not(.carousel-item-right):not(.carousel-item-left),
    .carousel-inner .carousel-item.active:not(.carousel-item-right):not(.carousel-item-left) + .carousel-item,
    .carousel-inner .carousel-item.active:not(.carousel-item-right):not(.carousel-item-left) + .carousel-item + .carousel-item,
    .carousel-inner .carousel-item.active:not(.carousel-item-right):not(.carousel-item-left) + .carousel-item + .carousel-item + .carousel-item {
        transition: none;
    }
    
    .carousel-inner .carousel-item-next,
    .carousel-inner .carousel-item-prev {
      position: relative;
      transform: translate3d(0, 0, 0);
    }
    
    /* last visible item + 1 */
    .carousel-inner .active.carousel-item + .carousel-item + .carousel-item + .carousel-item + .carousel-item {
        position: absolute;
        top: 0;
        right: -25%;
        z-index: -1;
        display: block;
        visibility: visible;
    }
    
    /* left or forward direction */
    .active.carousel-item-left + .carousel-item-next.carousel-item-left,
    .carousel-item-next.carousel-item-left + .carousel-item,
    .carousel-item-next.carousel-item-left + .carousel-item + .carousel-item,
    .carousel-item-next.carousel-item-left + .carousel-item + .carousel-item + .carousel-item,
    .carousel-item-next.carousel-item-left + .carousel-item + .carousel-item + .carousel-item + .carousel-item {
        position: relative;
        transform: translate3d(-100%, 0, 0);
        visibility: visible;
    }
    
    /* farthest right hidden item must be abso position for animations */
    .carousel-inner .carousel-item-next.carousel-item-left {
        position: absolute;
        top: 0;
        left: 0;
        z-index: -1;
        display: block;
        visibility: visible;
    }
    
    .carousel-inner .carousel-item-prev.carousel-item-right {
        position: absolute;
        top: 0;
        left: -25%;
        z-index: -1;
        display: block;
        visibility: visible;
    }
    
    /* right or prev direction */
    .active.carousel-item-right + .carousel-item-prev.carousel-item-right,
    .carousel-item-prev.carousel-item-right + .carousel-item,
    .carousel-item-prev.carousel-item-right + .carousel-item + .carousel-item,
    .carousel-item-prev.carousel-item-right + .carousel-item + .carousel-item + .carousel-item,
    .carousel-item-prev.carousel-item-right + .carousel-item + .carousel-item + .carousel-item + .carousel-item {
        position: relative;
        transform: translate3d(100%, 0, 0);
        display: block;
        visibility: visible;
    }

}


</style>

<jsp:include page="header.jsp" />

<script type="text/javascript">

        	$('#carouselExample').on('slide.bs.carousel', function (e) {

        	    var $e = $(e.relatedTarget);
        	    var idx = $e.index();
        	    var itemsPerSlide = 4;
        	    var totalItems = $('.carousel-item').length;
        	    
        	    if (idx >= totalItems-(itemsPerSlide-1)) {
        	        var it = itemsPerSlide - (totalItems - idx);
        	        for (var i=0; i<it; i++) {
        	            // append slides to end
        	            if (e.direction=="left") {
        	                $('.carousel-item').eq(i).appendTo('.carousel-inner');
        	            }
        	            else {
        	                $('.carousel-item').eq(0).appendTo('.carousel-inner');
        	            }
        	        }
        	    }
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
	
	
	
	
	
	
	
	
	
	
	</div>
</div>


<div class="container-fluid">
    <div id="carouselExample" class="carousel slide" data-ride="carousel" data-interval="12000">
        <div class="carousel-inner row w-100 mx-auto flex-nowrap" role="listbox">
            <div class="carousel-item col-md-3 active">
                <img class="img-fluid mx-auto d-block" src="//via.placeholder.com/600x400/000/fff?text=1" alt="slide 1">
            </div>
            <div class="carousel-item col-md-3">
                <img class="img-fluid mx-auto d-block" src="//via.placeholder.com/600x400?text=2" alt="slide 2">
            </div>
            <div class="carousel-item col-md-3">
                <img class="img-fluid mx-auto d-block" src="//via.placeholder.com/600x400?text=3" alt="slide 3">
            </div>
            <div class="carousel-item col-md-3">
                <img class="img-fluid mx-auto d-block" src="//via.placeholder.com/600x400?text=4" alt="slide 4">
            </div>
            <div class="carousel-item col-md-3">
                <img class="img-fluid mx-auto d-block" src="//via.placeholder.com/600x400?text=5" alt="slide 5">
            </div>
            <div class="carousel-item col-md-3">
                <img class="img-fluid mx-auto d-block" src="//via.placeholder.com/600x400?text=6" alt="slide 6">
            </div>
            <div class="carousel-item col-md-3">
                <img class="img-fluid mx-auto d-block" src="//via.placeholder.com/600x400?text=7" alt="slide 7">
            </div>
            <div class="carousel-item col-md-3">
                <img class="img-fluid mx-auto d-block" src="//via.placeholder.com/600x400?text=8" alt="slide 7">
            </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExample" role="button" data-slide="prev">
            <i class="fa fa-chevron-left fa-lg text-muted"></i>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next text-faded" href="#carouselExample" role="button" data-slide="next">
            <i class="fa fa-chevron-right fa-lg text-muted"></i>
            <span class="sr-only">Next</span>
        </a>
    </div>
</div>



<div id="shortCut"></div>

<jsp:include page="footer.jsp" />
