
$(document).ready(function() {

	$("select[class='selectedtaste']").change(function(){
	
		var result = "";
		var tasteList = [];
		const tastecount = $("input#tastecount").val();
		
		// option 값 다 선택되면 선택옵션 한줄로 출력
		const selecttaste = $("select[class='selectedtaste'] option:selected").text();
		if(!selecttaste.includes('맛을 선택하세요')){
			//console.log("selecttaste 선택한 맛 => ", selecttaste);
			//$("div#selecttasteList > p#tasteresult").text(selecttaste);
			
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
					result += str_taste + ", ";
				}
				
			}// end of for-------------------
			console.log(result);

			$("p#tasteresult").text(result);
		}

	});// end of $("select[id='taste']").change(function()----------------------
	   // select 에서 선택한 맛 밑에 한번에 출력
	

	///////////////////////////////////////////////////////////////////////////////////////////
	
	// == 수량 +, - 버튼 클릭에 대한 함수 == //
	let plus = document.querySelector(".plus");
	let minus = document.querySelector(".minus");
	let result = document.querySelector("#result");
	
	let i = 1;

	var price = Number($("h6").text());
	//console.log("price 확인 :" ,price);

	// 플러스 버튼 클릭 이벤트
	plus.addEventListener("click", () => {
		//let totalcost = document.querySelector('.productprice');
		var totalcost = Number($("div.productprice").text());
		totalcost += price;
		$("div.productprice").html(totalcost);

	});// end of plus.addEventListener("click", () => {})-----------

	// 마이너스 버튼 클릭 이벤트   
	minus.addEventListener("click", () => {
		if(i>0){
			var totalcost = Number($("div.productprice").text());
			totalcost -= price;
			$("div.productprice").html(totalcost);
		}
		else {
			$("div.productprice").html(0+"원");
		}
	});// end of plus.addEventListener("click", () => {})-----------


});// end of $(document).ready(function() {})----------------------------------------------
	
	
	// == 장바구니 연결하는 함수 == //
	function goCart(ctxPath) {
	
	   location.href = `${ctxPath}/member/cart.ice`;
	
	   // const frm = document.orderDetailFrm;
	   // frm.method = "POST"; 
	   // frm.action = "/member/cart.ice";
	   // frm.submit();
	
	}// end of 주문상세 > 장바구니 연결------------------------
	
	
	
	
	
	