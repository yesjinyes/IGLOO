


















////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒//
//▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒//
//▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒//
//▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

$(document).ready(function() {
	var index = 1;

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
			var tastenoarr = [];


			var test = $("select[class='selectedtaste'] option:selected").val();
			console.log("확인:"+test);
			
			for(let i=1; i<=tastecount; i++) {
				tasteList.push('taste'+ i);

				tastenoarr.push(Number($("select[id='taste"+i+"'] option:selected").val()));
			}// end of for------------------
			console.log("tastenoarr:",tastenoarr);


			const tastenoArr = new Array();
			for(let i=0; i<tastecount; i++) {
				var str_taste = $("select[id='"+ tasteList[i] +"'] option:selected").text();
				//console.log(str_taste);		// 맛이름
				
				if(i == tastecount - 1) {
					result += str_taste;
				}
				else {
					result += str_taste + " / ";
				}
				var tasteval = $("select[id='"+ tasteList[i] +"'] option:selected").val();
				// console.log(tasteval);		// 맛번호
				tastenoArr.push(tasteval);
				
			}// end of for-------------------
			//console.log(result);
			
			
			// == option 이 다 선택되면 option 값 초기화 == //
			$("select[name='selectbox'] option").prop("selected", false);
			count = 1;
			
			// == 선택한 맛 리스트 쌓아주기 == //
			let html = `<div id="resultContainer`+index+`" style="border: solid 0px orange;">
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
											<button type="button" index="`+index+`" class="minus" style="margin-right: 1%; background-color: #f6fafe; border: none; font-size: 15pt;">-</button>
											<span id="result" style="font-size: 14pt;">1</span>
											<button type="button" index="`+index+`" class="plus" style="margin-left: 1%; background-color: #f6fafe; border: none; font-size: 15pt;">+</button>
										</span>
										<button type="button" index="`+index+`" id="delete" style="background-color: #f6fafe; font-weight: bold; float: right; font-size: 15pt; border: none;">x</button>
									</div> 
								</div> 
							<!--	<input type="text" name="tasteselectListNo" value="`+tastenoarr+`" />
								<input type="text" name="tasteselectListCount" value="1" />  -->
								<hr id="line" style="border: solid 1px #81BEF7; width: 100%;">
							</div>
						</div>`;
						
						$("div#resultList").append(html);
			''
						var tasteselectList = `<input type="text" index="`+index+`" id="tasteselectListNo`+index+`" name="tasteselectListNo" value="`+tastenoarr+`" />
											   <input type="text" index="`+index+`" id="tasteselectListCount`+index+`" name="tasteselectListCount" value="1" />`
						
						$("form[name='tasteinfo']").append(tasteselectList);
						index++;
						// const resultContainerIndex = $("div#resultContainer").index();
						// console.log("resultContainerIndex : ", resultContainerIndex);

			// == 합계 금액 구하기 == //			
			totalcost = Number($("span.productprice").text().replace(",", ""));
			//console.log("totalcost 확인 :" , totalcost)
			totalcost += price;
			totalcost = totalcost.toLocaleString('ko-KR');
			//console.log("price 추가된 totalcost 확인 :" , totalcost);
			$("span.productprice").text(totalcost);
			
			// == 선택한 맛이 담겨있는 곳 == //
			const resulttest = result.split("/");
			//console.log(resulttest);
			
			const str_tasteno = tastenoArr.join(",");
			//console.log(str_tasteno);
			
			// == 총수량 구하기 == //
			const totalcount = $("span#totalcount").text();
			// console.log("확인용 총수량 totalcount :  ",totalcount);

			// const countEach = Number($("span#result").text());
			// console.log("리스트 한개당 수량 countEach : ", countEach);
		
			// == form 으로 합계금액(str_totalprice) 넘기기 == // 
			const productpriceTest = $("span.productprice").text().split(",").join("");
			//console.log("확인용 그냥 productpriceTest : ", productpriceTest); 

			$("form[name='tasteinfo'] > input[name='tasteno']").val(str_tasteno); // 선택한 맛 폼으로 넘기기
			$("form[name='tasteinfo'] > input[name='str_totalprice']").val(productpriceTest); // 총합계금액 폼으로 넘기기
			
		}// end of if(!selecttaste.includes('맛을 선택하세요')){}----------------------

	});// end of $("select[id='taste']").change(function()----------------------
	  


	///////////////////////////////////////////////////////////////////////////////////////////
	
	// == 플러스 버튼 클릭 이벤트 == //
	$(document).on('click', '.plus', function(e) {
		
		// 총합계금액에 더해주기
		totalcost = Number($("span.productprice").text().replace(",", ""));
		//console.log("totalcost 확인 :" , totalcost)
		totalcost += price;
		totalcost = totalcost.toLocaleString('ko-KR');
		//console.log("price 추가된 totalcost 확인 :" , totalcost);
		$("span.productprice").text(totalcost);
		
		var plus = Number($(e.target).parent().find("span#result").text());
		plus++;
		$(e.target).parent().find("span#result").text(plus);

		$(e.target).parent().parent().parent().parent().find("input[name='tasteselectListCount']").val(plus);


		// 플러스 버튼 클릭 시 리스트별 수량 변경
		var plusno = $(e.target).attr("index");
		console.log("plusno : "+ plusno);

		$("form[name='tasteinfo'] > input#tasteselectListCount"+plusno).val(plus);

		
		// form 으로 총합계금액 넘기기 
		const productpriceTest = $("span.productprice").text().split(",").join("");
		$("form[name='tasteinfo'] > input[name='str_count']").val(productpriceTest);

	});// end of $(document).on('click', '.plus', function() {})------------ 


	// == 마이너스 버튼 클릭 이벤트 == // 
	$(document).on('click', '.minus', function(e) {
	
		totalcost = Number($("span.productprice").text().replace(",", ""));
		var minus = Number($(e.target).parent().find("span#result").text());
		
		if(minus > 1){
			//console.log("totalcost",totalcost-price);
			// 총합계금액에서 빼주기
			totalcost -= price;
			totalcost = totalcost.toLocaleString('ko-KR');
			$("span.productprice").text(totalcost);
			
			minus = Number($(e.target).parent().find("span#result").text());
			minus--;
			$(e.target).parent().find("span#result").text(minus);
			$(e.target).parent().parent().parent().parent().find("input[name='tasteselectListCount']").val(minus);
		
			//  마이너스 버튼 클릭 시 리스트별 수량 변경
			var minusno = $(e.target).attr("index");
			console.log("minusno : "+ minusno);

			$("form[name='tasteinfo'] > input#tasteselectListCount"+minusno).val(minus);

		}

		// == form 으로 총합계금액 넘기기 == //
		const productpriceTest = $("span.productprice").text().split(",").join("");
		$("form[name='tasteinfo'] > input[name='str_count']").val(productpriceTest);

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

		///////////////////////////////////////////////////

		var deleteno = $(e.target).attr("index");
		$("form[name='tasteinfo'] > input#tasteselectListNo"+deleteno).remove();
		$("form[name='tasteinfo'] > input#tasteselectListCount"+deleteno).remove();

	});// end of $(document).on('click', '#delete', function()---------------

});// end of $(document).ready(function() {})----------------------------------------------

	

// == 장바구니 연결하는 함수 == //
function goCart() {
   
	const ctxPath = $("div#ctxPath").text();

    const frm = document.tasteinfo;
    //frm.action = ctxPath + "/order/insertTaste.ice";
	frm.action = ctxPath + "/order/insertTaste.ice";
	frm.method = "POST"; 
    frm.submit();

}// end of function goCart(ctxPath) ------------------------


// === 주문하기 창 이동 === //
function goOrder(){
console.log("주문버튼 클릭");
	// == '주문하기' 버튼 클릭 시 총수량 전송하기 == //
	var arr = $("span#result").text();

	var str_totalcount = 0;
	for(let i=0; i<arr.length; i++) {
		str_totalcount += Number(arr[i]);
	}// end of for----------------

console.log("돼라1");

	//  총수량 전송하기 
	$("form[name='tasteinfo'] > input[name='str_totalcount']").val(str_totalcount);

console.log("돼라2");
	var test = $("form[name='tasteinfo'] > input.tasteclass").attr("index");
	console.log("class 확인:",test);
	console.log("index:" + index);

	const ctxPath = $("div#ctxPath").text();
	
	const frm = document.tasteinfo;
	frm.action = ctxPath + "/order/insertTaste.ice";
	frm.method = "POST";
console.log("돼라3");
	frm.submit();
	
console.log("돼라4");

/*	const ctxPath = $("div#ctxPath").text();
	
	const frm = document.tasteinfo;
	frm.action = ctxPath + "/order/payment.ice";
	frm.method = "POST";
	frm.submit();
*/



} // end of function goOrder()------------
