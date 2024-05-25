$(document).ready(function() {

    // === 전체선택/ 해제 버튼 클릭 === //
    $("div.totalSelect > input#Allchecked").change(function(){

        let checkboxtotal = $(this).prop("checked");
        $("input[name='choicemenu']").prop("checked",checkboxtotal);

        // === 체크박스의 체크한 수량 적용시키기 === //
        let checkboxcnt = $("input:checkbox[name='choicemenu']:checked").length;

        $("span.choiceCnt").html(checkboxcnt);

        alert("확인용 checkboxtotal 체크유무 : " + $("input[name='choicemenu']").prop("checked"));

        if($("input[name='choicemenu']").prop("checked") == true){

            let price = $(this).parent().find("span#cartTotalprice").text();
            alert("확인용 price : " + price);

            $("span.totalPrice").text(price.toLocaleString());
            $("span.navtotalPrice").text(price.toLocaleString());

        }
        else{
            $("span.totalPrice").text(0);
            $("span.navtotalPrice").text(0);
        }

    })  // end of $("div.totalSelect > input#Allchecked").change(function(){------

    $("div.choiceOneMenu").click(function() {
        
        // === 체크박스가 아닌 그림이나 글씨 등 옆쪽 선택시 체크박스 선택되게 하기 === //
        var checkbox = $(this).prev("input[type='checkbox']");
        checkbox.prop("checked", !checkbox.prop("checked"));

        // === 체크박스 체크유무 확인 === //
        alert("확인용 checkbox 체크유무 : " + checkbox.prop("checked"));

        // === 각 체크박스 선택에 따른 가격변동 === //
        if(checkbox.prop("checked") == true){
            let cartno = $(this).parent().find("div#cartno").text();
            // alert("확인용 cartno : " + cartno);

            let price = $(this).parent().find("span.resultprice").text();
            // alert("확인용 price : " + price);

            let totalPrice = $("span.totalPrice").text();
            totalPrice = totalPrice.replaceAll(",","");
            // alert("확인용 totalPrice : " + totalPrice);

            totalPrice = Number(totalPrice) + Number(price);

            $("span.totalPrice").text(totalPrice.toLocaleString());
            $("span.navtotalPrice").text(totalPrice.toLocaleString());

        }
        else{
            let price = $(this).parent().find("span.resultprice").text();

            let totalPrice = $("span.totalPrice").text();
            totalPrice = totalPrice.replaceAll(",","");

            totalPrice = Number(totalPrice) - Number(price);

            $("span.totalPrice").text(totalPrice.toLocaleString());
            $("span.navtotalPrice").text(totalPrice.toLocaleString());
        }

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
        alert("확인용 이전 수량 : " + count);
        if(count > 1){
            $(this).next().text(Number(count) - 1);
            $("form[name='sendinfo'] > input[name='count']").val(Number(count) - 1);
            
            let cartno = $(this).parent().find("div#cartno").text();
            $("form[name='sendinfo'] > input[name='cartno']").val(cartno);
            // alert("확인용 : cartno" + cartno);

            // === 금액 변동 시키기 === //
        let Productprice = $(this).parent().find("span.Productprice").text();
        // alert("확인용 : Productprice : " + Productprice);

        let choiceproductprice = $(this).parent().parent().parent().find("div.choiceproductprice").text();
        // alert("확인용 : choiceproductprice : " + choiceproductprice);

        choiceproductprice = (Number(count) - 1) * Number(Productprice);

        $(this).parent().parent().parent().find("div.choiceproductprice").text(choiceproductprice.toLocaleString());

        let totalPrice = $("span.totalPrice").text();
        totalPrice = totalPrice.replaceAll(",","");
        
        totalPrice = Number(totalPrice) - Number(Productprice);
        

        $("span.totalPrice").text(totalPrice.toLocaleString());
        $("span.navtotalPrice").text(totalPrice.toLocaleString());
        }
    })  // end of $("div.choiceOneMenu > div.selectMenucnt button.btnminus").click(function(){----

    // === 수량 플러스 버튼 클릭했을 때 변경 === //
    $("div.choiceOneMenu > div.selectMenucnt button.btnplus").click(function(){
        let count = $(this).prev().text();
        // alert("확인용 이전 수량 : " + count);
        
        $(this).prev().text(Number(count) + 1);
        $("form[name='sendinfo'] > input[name='count']").val(Number(count) + 1);
        
        let cartno = $(this).parent().find("div#cartno").text();
        $("form[name='sendinfo'] > input[name='cartno']").val(cartno);
        // alert("확인용 : cartno" + cartno);

        // === 금액 변동 시키기 === //
        let Productprice = $(this).parent().find("span.Productprice").text();
        // alert("확인용 : Productprice : " + Productprice);

        let choiceproductprice = $(this).parent().parent().parent().find("div.choiceproductprice").text();
        // alert("확인용 : choiceproductprice : " + choiceproductprice);

        choiceproductprice = (Number(count) + 1) * Number(Productprice);

        $(this).parent().parent().parent().find("div.choiceproductprice").text(choiceproductprice.toLocaleString());

        let totalPrice = $("span.totalPrice").text();
        totalPrice = totalPrice.replaceAll(",","");

        if(count == 1){
            totalPrice = Number(totalPrice) + choiceproductprice;
        }
        else{
            totalPrice = Number(totalPrice) + Number(Productprice);
        }

        $("span.totalPrice").text(totalPrice.toLocaleString());
        $("span.navtotalPrice").text(totalPrice.toLocaleString());

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
function continueOrder(){
    location.href = `order/payment.ice`;
}   // end of function continueOrder(){--------

