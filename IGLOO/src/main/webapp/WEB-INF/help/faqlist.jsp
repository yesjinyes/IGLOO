<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/faqlist.css" />

<jsp:include page="../sidebar.jsp" />

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("div#answer").hide();
		$("div#hidebtn").hide();
		
		$("div#togglebtn").click(function(){
			$("div#answer").show();
			$("div#question").addClass("toggleq");
			$("div#togglebtn").hide();
			$("div#hidebtn").show();
			
		});
		
		$("div#hidebtn").click(function(){
			$("div#answer").hide();
			$("div#question").removeClass("toggleq");
			$("div#togglebtn").show();
			$("div#hidebtn").hide();
		});
	});
	
</script>

<div id="content" class="mb-5">
	<div>
		<div class="mx-3 p-3 mt-4" style="display: flex; justify-content: space-between;">
			<h2 style="font-weight: bold;">1:1 문의 내역</h2>
			<button id="faqbtn" type="button">1:1 문의하기</button>
		</div>
		
			<div id="question" class="mx-3 p-3">
				<div>
					<span><span style="font-size: 15pt;">2024.05.13</span>&nbsp;&nbsp; 13:23:34</span>
					<span>｜ 제품 문의</span>
				</div>
				
				<div id="q_title" class="my-3" style="display: flex; justify-content: space-between;">
					<div>맛 품절 언제 풀리나요?</div><div id="togglebtn" class="mx-3">▼</div><div id="hidebtn" class="mx-3">▲</div>
				</div>
				<div id="q_content">이글루 홍대점 서울 치즈 케이크 품절 언제 풀려요?</div>
			</div>
			
			<div id="answer" class="mx-3 p-3">
				<div id="a_title" class="my-3" style="text-align: center; font-size: 9pt; color: gray;">―――――――――――――――――― :::  1:1 문의 답변  ::: ―――――――――――――――――――――</div>
				<div>2024.05.13&nbsp;&nbsp; 13:23:34</div>
				<div id="a_content">
					안녕하세요? 저희 이글루에 관심 주셔서 감사드립니다.<br>지점의 제품 관련 문의는 지점 문의로 작성하셔야 합니다.<br>감사합니다.
				</div>
			</div>

		
	</div>
</div>
		

		</div>
	</div>
</div>

<jsp:include page="../footer.jsp" />