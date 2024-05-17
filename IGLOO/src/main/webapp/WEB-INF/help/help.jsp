<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- J Query UI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>



<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/help/help.css" />

<%-- 직접 만든 JS --%>
<script type="text/javascript">
	$(document).ready(function(){
		
		$("div#question_mark").click(()=>{
			location.href="${pageContext.request.contextPath}/help/inquiry.ice";
		});
		
		$("button#storebtn").click(()=>{
			location.href="${pageContext.request.contextPath}/store/searchList.ice";
		});
		
	});
</script>

<jsp:include page="../header.jsp" />

<div class="container">

	<div id="helptop">
		<span>고객센터</span>
		<h5>고객의 소리를 적극 경청하고<br>소비자 중심 경영활동을 지속적으로 실천합니다.</h5>
	</div>
	<hr style="border: solid 0.2px rgb(89, 200, 236);">
	<div id="faq">
		<div style="display: flex; border: solid 0px blue;">
			<div style="border: solid 0px red; padding: 1% 0; margin: 0 1%;">
				<img src="<%= ctxPath%>/images/img_narae/4403555.png" style="width: 50px;"/>
			</div>
			<div style="border: solid 0px red; text-align: left;">
				<h6 style="font-weight: bold; color: rgb(89, 200, 236)">자주하는 질문</h6>
				<span style="font-size: 9pt; color: grey;">제품과 포인트, 회원 혜택 등 제품과 사이트에 대해<br>궁금한 점이 있다면 FAQ를 확인하세요!</span>
			</div>
			<form style="border: solid 0px red; margin: auto 0 auto 45%;">
				<input name="faqsearch" type="text" size="20" maxlength="50"/>
				<button type="button" style="width: 25px; height: 25px; padding: 0; border: none;"><img src="<%= ctxPath%>/images/img_narae/다운로드.png" style="width: 25px;"/></button>
			</form>
		</div>
	</div>
	
	<div id="faqtab">
		<%--
		<ul class="nav nav-tabs justify-content-center"  style="text-align: center;">
		  <li class="nav-item" style="width: 10%;">
		    <a class="nav-link active" data-toggle="tab" href="#">전체</a>
		  </li>
		  <li class="nav-item" style="width: 10%;">
		    <a class="nav-link" data-toggle="tab" href="help.ice?category=제품">제품</a>
		  </li>
		  <li class="nav-item" style="width: 10%;">
		    <a class="nav-link" data-toggle="tab" href="help.ice?category=포인트">포인트</a>
		  </li>
		  <li class="nav-item" style="width: 10%;">
		    <a class="nav-link" data-toggle="tab" href="help.ice?category=회원">회원</a>
		  </li>
		  <li class="nav-item" style="width: 10%;">
		    <a class="nav-link" data-toggle="tab" href="help.ice?category=기타">기타</a>
		  </li>
		</ul>
		 --%>
		<ul class="nav nav-tabs justify-content-center" style="text-align: center;">
		  <li class="nav-item" style="width: 10%;">
		    <a data-toggle="tab" class="nav-link active" aria-current="page"  href="#">전체</a>
		  <li class="nav-item" style="width: 10%;">
		    <a data-toggle="tab" class="nav-link" href="help.ice?category=제품">제품</a>
		  </li>
		  <li class="nav-item" style="width: 10%;">
		    <a data-toggle="tab" class="nav-link" href="help.ice?category=포인트">포인트</a>
		  </li>
		  <li class="nav-item" style="width: 10%;">
		    <a data-toggle="tab" class="nav-link" href="help.ice?category=회원">회원</a>
		  </li>
		  <li class="nav-item" style="width: 10%;">
		    <a data-toggle="tab" class="nav-link" href="help.ice?category=기타">기타</a>
		  </li>
		</ul>
	
	<br><br>
	
	<%-- 아코디언 --%>
	
		<div class="accordion" id="accordionExample">
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="headingOne">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
		        가격 인상 후 모바일 교환권 사용 시 해피포인트는 어떻게 적립되나요?
		      </button>
		    </h2>
		    <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
		      <div class="accordion-body">
		        <strong>This is the first item's accordion body.</strong> It is shown by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
		      </div>
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="headingTwo">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
		        가격 인상 후 단종된 제품의 모바일 교환권은 어떻게 사용하나요?
		      </button>
		    </h2>
		    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
		      <div class="accordion-body">
		        <strong>This is the second item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
		      </div>
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="headingThree">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
		        모든 제품의 가격이 인상되었나요?
		      </button>
		    </h2>
		    <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
		      <div class="accordion-body">
		        <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
		      </div>
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="headingFour">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
		        와플콘 전용매장은 무엇인가요?
		      </button>
		    </h2>
		    <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#accordionExample">
		      <div class="accordion-body">
		        <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
		      </div>
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="headingFive">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
		        벨지안 와플콘이 무엇인가요?
		      </button>
		    </h2>
		    <div id="collapseFive" class="accordion-collapse collapse" aria-labelledby="headingFive" data-bs-parent="#accordionExample">
		      <div class="accordion-body">
		        <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
		      </div>
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="headingSix">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
		        맛보기 서비스
		      </button>
		    </h2>
		    <div id="collapseSix" class="accordion-collapse collapse" aria-labelledby="headingSix" data-bs-parent="#accordionExample">
		      <div class="accordion-body">
		        <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
		      </div>
		    </div>
		  </div>
		</div>

	<br><br>
	<%-- 페이지네이션 --%>

		<nav aria-label="Page navigation example">
		  <ul class="pagination justify-content-center">
		    <li class="page-item">
		      <a class="page-link" href="#" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		    <li class="page-item"><a class="page-link" href="#">1</a></li>
		    <li class="page-item"><a class="page-link" href="#">2</a></li>
		    <li class="page-item"><a class="page-link" href="#">3</a></li>
   		    <li class="page-item"><a class="page-link" href="#">4</a></li>
   		    <li class="page-item"><a class="page-link" href="#">5</a></li>
		    <li class="page-item">
		      <a class="page-link" href="#" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		  </ul>
		</nav>
	</div>
	
	<br><br>
	
	<div id="channel">
		<div class="mb-1" style="text-align: left;"><span style="font-weight: bold;">고객 문의 접수채널</span></div>
		<div class="pt-2 mb-5" style="border: solid 1px grey; border-radius: 10px 10px; display: flex;">
			<div id="tel" style="margin: auto; display:flex;">
				<div><img src="<%= ctxPath%>/images/img_narae/call.png"/></div>
				<div class="pt-2" style="text-align: left;">
					<div style="font-size: 13pt; font-weight: bold;">전화</div>
					<div style="font-weight: bold; color: rgb(89, 200, 236)">080-1234-1234</div>
					<div style="font-size: 8pt;">(주말·공휴일 휴무 / 수신자 부담)</div>
				</div>
			</div>
			<div id="homepage" style="margin: auto; display:flex;">
				<div><img src="<%= ctxPath%>/images/img_narae/homepage.png"/></div>
				<div class="pt-2" style="text-align: left;">
					<div style="font-size: 13pt; font-weight: bold;">홈페이지</div>
					<div style="font-weight: bold; color: rgb(89, 200, 236)">고객센터 1:1 문의</div>
					<div>상담 접수 시간: 24시간</div>
				</div>
			</div>
			<div id="store" style="margin: auto; display:flex;">
				<div><img src="<%= ctxPath%>/images/img_narae/store.png"/></div>
				<div class="pt-2" style="text-align: left;">
					<div style="font-size: 13pt; font-weight: bold;">점포</div>
					<div style="font-weight: bold; color: rgb(89, 200, 236)">구매점포 연락처 확인</div>
					<div style="text-align: right;"><button id="storebtn" type="button">매장정보 확인</button></div>
				</div>
			</div>
		</div>
	
	
	</div>
	

</div>

<div id="question_mark"><img style="width: 50%;" src="<%= ctxPath%>/images/img_narae/question_mark.png" /></div>

<jsp:include page="../footer.jsp" />