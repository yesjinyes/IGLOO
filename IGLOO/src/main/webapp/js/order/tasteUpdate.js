$(function() {
	info();
	// === 수정 버튼 클릭하였을 경우 === //
	$("button.btnupdate").click(function(){
		
		const ctxPath = $("div#ctxPath").text();
		info();

		const frm = document.tasteUpdateFrm;
	    frm.action = `${ctxPath}/member/cart/updatetaste.ice`;
	    frm.method = "post";
	    frm.submit();
	})	// end of $("button.btn-success").click(function(){})-------------
	
	// === 수정 취소 버튼 클릭하였을 경우 === //
	$("button.btnCancel").click(function(){
		
		const ctxPath = $("div#ctxPath").text();

		const frm = document.tasteUpdateFrm;
	    frm.action = `${ctxPath}/member/cart/updatetaste.ice`;
	    frm.method = "post";
	    frm.submit();
	})	// end of $("button.btn-success").click(function(){})-------------

})

// === 선택한 맛번호 정보 === //
function info(){

	let tastenoArr = [];  // 선택한 맛번호

	$("select.selectedtaste option:selected").each(function() {
		const tasteno = $(this).val();
		tastenoArr.push(tasteno);
	});

	const tastenoJOIN = tastenoArr.join();
	$("input#updateTasteno").val(tastenoJOIN);
        
}	// end of function info(){

