
$(document).ready(function() {

	var count = 1;
	var price = Number($("input[name='productprice']").val());
	var totalcost = Number($("span.productprice").text().replace(",", ""));

	$("select[class='selectedtaste']").change(function(){
	
		var result = ""; // 선택한 값이 한줄로 출력될 자리
		var tasteList = []; // 선택한 맛이 담기는 배열
		const tastecount = $("input#tastecount").val(); // 파인트:3, 쿼터:4, 패밀리:5, 하프갤런:6
		
		// == option 값 다 선택되면 선택옵션 한줄로 출력하기 == //
		const selecttaste = $("select[class='selectedtaste'] option:selected").text();

		if(!selecttaste.includes('맛을 선택하세요')){
			
			for(let i=1; i<=tastecount; i++) {
				tasteList.push('taste'+ i);
			}// end of for------------------

			for(let i=0; i<tastecount; i++) {
				var str_taste = $("select[id='"+ tasteList[i] +"'] option:selected").text();
				console.log(str_taste);
				
				if(i == tastecount - 1) {
					result += str_taste;
				}
				else {
					result += str_taste + " / ";
				}
				
			}// end of for-------------------
			console.log(result);
			
			// == option 이 다 선택되면 option 값 초기화 == //
			$("select[name='selectbox'] option").prop("selected", false);
			count = 1;
			
			// == 선택한 맛 리스트 쌓아주기 == //
			let html = `<div style="border: solid 0px orange;">
							<div class="resultEach" style="display: inline-block; width: 100%; ">
								<div style="display: flex;">
									<div style="border: solid 0px blue; width: 63%; margin: 0 3%;">
										<div id="selecttasteList">
											<p id="tasteresult">` + result + `</p>
											<input type="hidden" name="selecttasteList"/>
										</div>
									</div>

									<div class="num" style="border: solid 0px red; width:37%; float: right; text-align: center; vertical-align: center;" >
										<span class="count" style="vertical-align: center;">
											<button type="button" class="minus" style="margin-right: 1%; background-color: #f6fafe; border: none; font-size: 15pt;">-</button>
											<span id="result" style="font-size: 14pt;">1</span>
											<button type="button" class="plus" style="margin-left: 1%; background-color: #f6fafe; border: none; font-size: 15pt;">+</button>
										</span>
										<button type="button" id="delete" style="background-color: #f6fafe; font-weight: bold; float: right; font-size: 15pt; border: none;">x</button>
									</div> 
								</div> 
								<hr id="line" style="border: solid 1px #81BEF7; width: 100%;">
								<input type="hidden" name="result" value="`+result+`" />
							</div>
						</div>`;
						
						$("div#resultList").append(html);
						

			totalcost = Number($("span.productprice").text().replace(",", ""));
			//console.log("totalcost 확인 :" , totalcost)
			totalcost += price;

			totalcost = totalcost.toLocaleString('ko-KR');
			//console.log("price 추가된 totalcost 확인 :" , totalcost);
			$("span.productprice").text(totalcost);
			const resulttest = result.split("/");
			console.log(resulttest);
			/*
				0: "이글루요거트 "
				1: " 스트로베리 "
				2: " 오레오레오"
			*/
			
			
		
		
		}// end of if(!selecttaste.includes('맛을 선택하세요')){}----------------------
	
	});// end of $("select[id='taste']").change(function()----------------------
	  

	///////////////////////////////////////////////////////////////////////////////////////////
	
	// == 플러스 버튼 클릭 이벤트 == //
	$(document).on('click', '.plus', function(e) {
		totalcost = Number($("span.productprice").text().replace(",", ""));
		//console.log("totalcost 확인 :" , totalcost)
		totalcost += price;

		totalcost = totalcost.toLocaleString('ko-KR');
		//console.log("price 추가된 totalcost 확인 :" , totalcost);
		$("span.productprice").text(totalcost);
		
		var plus = Number($(e.target).parent().find("span#result").text());
		plus++;
		$(e.target).parent().find("span#result").text(plus);

	});// end of $(document).on('click', '.plus', function() {})------------ 

	// == 마이너스 버튼 클릭 이벤트 == // 
	$(document).on('click', '.minus', function(e) {
	
		totalcost = Number($("span.productprice").text().replace(",", ""));
		var minus = Number($(e.target).parent().find("span#result").text());
		
		if(minus > 1){
			//console.log("totalcost",totalcost-price);
			totalcost -= price;

			totalcost = totalcost.toLocaleString('ko-KR');
			$("span.productprice").text(totalcost);
			
			minus = Number($(e.target).parent().find("span#result").text());
			minus--;
			$(e.target).parent().find("span#result").text(minus);
		}
		
	});// end of $(document).on('click', '.plus', function() {})------------ 
	
	
	// == 삭제버튼 클릭 시 리스트에서 삭제 == //
	$(document).on('click', '#delete', function(e) {

		// 선택한 맛 리스트 하나씩 지우기
		$(e.target).parent().parent().parent().parent().find(".resultEach").remove();
		$(e.target).parent().parent().parent().find("#line").remove();

		// 삭제한 리스트는 합계에서 제하기
		var totalcost_sum = Number($("span.productprice").text().split(",").join(""));
		var productprice = Number($("input#productprice").val());
		var cnt = $(e.target).parent().find("#result").text();

		var totalcost_del = totalcost_sum - productprice * cnt;
		//console.log("리스트 삭제 후 합계: ",totalcost_del);
			
		$("span.productprice").text(totalcost_del.toLocaleString('ko-KR'));

	});// end of $(document).on('click', '#delete', function()---------------




});// end of $(document).ready(function() {})----------------------------------------------
	
	
// == 장바구니 연결하는 함수 == //
function goCart(ctxPath) {

    location.href = `${ctxPath}/member/cart.ice`;

    const frm = document.orderDetailFrm;
    frm.method = "POST"; 
    frm.action = "/member/cart.ice";
    frm.submit();

}// end of 주문상세 > 장바구니 연결------------------------



	

	
	