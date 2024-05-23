$(document).ready(function() {
	
	$("select[id='taste']").change(function(){
	   
	   const selecttaste = $("select[id='taste'] option:selected").text();
	   console.log("selecttaste 선택한 맛 => ", selecttaste); 
				   
	   // option 값 다 선택되면 선택옵션 한줄로 출력
	   // $("input[name='selecttaste']").val("확인용");
	   // $("div#test > input[name='selectPeriodindex']").val(selecttaste);


	   $("div#selecttaste").text();
	   $("div#selecttaste").val();
	   $("div#selecttasteList > input[name='selecttasteList']").val(selecttaste);
	   // $("div[id='selecttasteList']").val(selecttaste);
	   $("div#selecttasteList > p#tasteresult").text(selecttaste);


   });// end of $("select[id='taste']").change(function()----------------------
	   // select 에서 선택한 맛 밑에 한번에 출력
	   // select 에서 선택한 맛 밑에 한번에 출력---------------------------------



   ///////////////////////////////////////////////////////////////////////////////////////////
   
   ///////////////////////////////////////////////////////////////////////////////////////////
   let plus = document.querySelector(".plus");
   let minus = document.querySelector(".minus");
   let result = document.querySelector("#result");
   let totalcost = document.querySelector('.productprice');
   let i = 1;
   // 플러스 버튼 클릭 이벤트
   plus.addEventListener("click", () => {
	   i++;
	   result.textContent = i;
	   let totalcostNum = i * 8000;
	   totalcost.textContent = totalcostNum.toLocaleString();
   });// end of plus.addEventListener("click", () => {})-----------
   // 마이너스 버튼 클릭 이벤트   
   minus.addEventListener("click", () => {
	   if(i>0){
		   i--;
		   result.textContent = i;
		   let totalcostNum = i * 8000;
		   totalcost.textContent = totalcostNum.toLocaleString();
	   }
	   else {
		   totalcost.textContent = 0 + "원"
	   }
   });// end of plus.addEventListener("click", () => {})-----------
	   
	   


});// end of $(document).ready(function() {})-------------------------------


// == 장바구니 연결하는 함수 == //
function goCart(ctxPath) {

   location.href = `${ctxPath}/member/cart.ice`;

   // const frm = document.orderDetailFrm;
   // frm.method = "POST"; 
   // frm.action = "/member/cart.ice";
   // frm.submit();

}// end of 주문상세 > 장바구니 연결------------------------



