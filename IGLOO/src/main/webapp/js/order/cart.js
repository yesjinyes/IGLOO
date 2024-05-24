$(document).ready(function() {

/*
    $("div#choiceTotalMenu").each(function() {

        const count = $(this).find("span.productCnt").text();
        const price = $(this).find("div.selectOneprice input[class:'productPrice']").text();
        const resultprice = Number(count) * Number(price);

        $(this).find("span.resultprice").text(resultprice.toLocaleString()+"원");

    })
*/

    // === 전체선택/ 해제 버튼 클릭 === //
    $("div.totalSelect > input#Allchecked").change(function(){

        let checkboxtotal = $(this).prop("checked");
        $("input[name='choicemenu']").prop("checked",checkboxtotal);

        // === 체크박스의 체크한 수량 적용시키기 === //
        let checkboxcnt = $("input:checkbox[name='choicemenu']:checked").length;

        $("span.choiceCnt").html(checkboxcnt);

    })  // end of $("div.totalSelect > input#Allchecked").change(function(){------

    $("div.choiceOneMenu").click(function() {
        
        // === 체크박스가 아닌 그림이나 글씨 등 옆쪽 선택시 체크박스 선택되게 하기 === //
        var checkbox = $(this).prev("input[type='checkbox']");
        checkbox.prop("checked", !checkbox.prop("checked"));

        // === 하위 체크박스 여부의 따라 전체 체크박스 체크 변동 === //
        let checkboxlist= document.querySelectorAll("input[name='choicemenu']");

        let is_all_checked = true;

        for(let checkbox of checkboxlist){

            if(!checkbox.checked){
                $("div.totalSelect > input#Allchecked").prop("checked",false);
                is_all_checked = false;
                break;
            }

            is_all_checked = true;

        }   // end of for----------

        if(is_all_checked){
            $("div.totalSelect > input#Allchecked").prop("checked",true);
        }

        // === 체크박스의 체크한 수량 적용시키기 === //
        let checkboxcnt = $("input:checkbox[name='choicemenu']:checked").length;

        $("span.choiceCnt").html(checkboxcnt);

    })  // end of $("div.choiceOneMenu").click(function() {-------------

    // === 제품삭제 버튼 클릭되게 하기 === //
    $("div.choiceOneMenu > div.menuclick button.delete").click(function(){
        alert("삭제버튼 클릭");
        let checkbox = $("div.choiceOneMenu").prev("input[type='checkbox']");
        checkbox.prop("checked", false);
    })  // end of $("div.choiceOneMenu > div.menuclick i").click(function(){---------

    // === 수량변경 버튼을 클릭할 시 무조건 제품선택되게 하기 === //
    $("div.choiceOneMenu > div.selectMenucnt button").click(function(){
        let checkbox = $("div.choiceOneMenu").prev("input[type='checkbox']");
        checkbox.prop("checked", false);
    })      // end of $("div.choiceOneMenu > div.selectMenucnt button").click(function(){-----

    // === 수량 마이너스 버튼 클릭했을 때 변경 === //
    $("div.choiceOneMenu > div.selectMenucnt button.btnminus").click(function(){
        let count = $(this).next().text();
        // alert("확인용 수량 : " + count);
        if(count > 1){
            $(this).next().text(Number(count) - 1);
            $("form[name='sendinfo'] > input[name='count']").val(Number(count) - 1);
            
            let cartno = $(this).parent().find("div#cartno").text();
            $("form[name='sendinfo'] > input[name='cartno']").val(cartno);
            // alert("확인용 : cartno" + cartno);
        }
    })  // end of $("div.choiceOneMenu > div.selectMenucnt button.btnminus").click(function(){----

    // === 수량 플러스 버튼 클릭했을 때 변경 === //
    $("div.choiceOneMenu > div.selectMenucnt button.btnplus").click(function(){
        let count = $(this).prev().text();
        // alert("확인용 수량 : " + count);
        
        $(this).prev().text(Number(count) + 1);
        $("form[name='sendinfo'] > input[name='count']").val(Number(count) + 1);
        
        let cartno = $(this).parent().find("div#cartno").text();
        $("form[name='sendinfo'] > input[name='cartno']").val(cartno);
        // alert("확인용 : cartno" + cartno);
    })  // end of $("div.choiceOneMenu > div.selectMenucnt button.btnminus").click(function(){----

    $("button.orderbtn").click(function(){
        continueOrder();
    })  // end of $("button.orderbtn").click(function(){--------

})  // end of $(document).ready(function() {--------------

///////////////////////////////////////////////////////////////////////

// === 장바구니가 없는경우 주문하기 버튼 클릭시 주문하기 창으로 이동 === //
function continueShopping(ctxPath){

    location.href = `${ctxPath}/order/order.ice`;

}   // end of function continueShopping(ctxPath){----------

// === 주문하기 창 이동 === //
function continueOrder(ctxPath){
    location.href = `order/payment.ice`;
}   // end of function continueOrder(ctxPath){--------
