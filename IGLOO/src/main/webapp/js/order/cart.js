$(document).ready(function() {

    // === 전체선택/ 해제 버튼 클릭 === //
    $("div.totalSelect > input#Allchecked").change(function(){

        let checkboxtotal = $(this).prop("checked");
        $("input[name='choicemenu']").prop("checked",checkboxtotal);

        // === 체크박스의 체크한 수량 적용시키기 === //
        let checkboxcnt = $("input:checkbox[name='choicemenu']:checked").length;

        $("span.choiceCnt").html(checkboxcnt);

        // alert("확인용 checkboxtotal 체크유무 : " + $("input[name='choicemenu']").prop("checked"));

        if($("input[name='choicemenu']").prop("checked") == true){

            let price = $(this).parent().find("span#cartTotalprice").text();
            // alert("확인용 price : " + price);

            $("span.totalPrice").text(price.toLocaleString());
            $("span.navtotalPrice").text(price.toLocaleString());

        }
        else{
            $("span.totalPrice").text(0);
            $("span.navtotalPrice").text(0);
        }

    })  // end of $("div.totalSelect > input#Allchecked").change(function(){------

    // === 선택에 따른 체크박스 변동 === //
    $("div.choiceMenu").click(function(){

        let checkbox = $(this).find("input[type='checkbox']");
        checkbox.prop("checked", !checkbox.prop("checked"));

    })  // end of $(div.choiceMenu).click(function(){------------

    $("div.choiceOneMenu").click(function(e) {

        // === 하위 체크박스 여부의 따라 전체 체크박스 체크 변동 === //
        let checkboxlist= document.querySelectorAll("input[name='choicemenu']");

        let truecheckcnt = 0;
        let falsecheckcnt = 0;
        let check = 0;

        // === 현재 상태 false -> true 로 변동될 예정 === //
        if($(this).prev().prop("checked") == false){
            check = 1;
        }   
    
        for(let checkbox of checkboxlist){
            
            // alert($(checkbox).prop("checked"));     // 변동하기 전 체크박스 상태
            if(!checkbox.checked){
                $("div.totalSelect > input#Allchecked").prop("checked",false);
                falsecheckcnt += 1;
            }
            else{
                truecheckcnt += 1;
            }

        }   // end of for----------

        if(check == 1 && truecheckcnt == 1 && falsecheckcnt == 1){
            $("div.totalSelect > input#Allchecked").prop("checked",true);
        }
        else if(truecheckcnt == 2 || falsecheckcnt == 2){
            $("div.totalSelect > input#Allchecked").prop("checked",false);
        }

        // === 체크박스의 체크한 수량 적용시키기 === //
        let checkboxcnt = $("input:checkbox[name='choicemenu']:checked").length;

        if($(this).prev().prop("checked") == false){
            $("span.choiceCnt").html(Number(checkboxcnt) + 1);
        }
        else{
            $("span.choiceCnt").html(Number(checkboxcnt) - 1);
        }

    })  // end of $("div.choiceOneMenu").click(function() {-------------

    // === 제품삭제 버튼 클릭되게 하기 === //
    $("div.choiceOneMenu > div.menuclick button.delete").click(function(){
        alert("삭제버튼 클릭");
        
        // === 다른 체크박스 선택의 영향을 주지 않게하기(확인용) === //
        let choiceMenucheckbox = $(this).parent().parent().parent().parent().find("input[type='checkbox']");
        choiceMenucheckbox.prop("checked", false);

    })  // end of $("div.choiceOneMenu > div.menuclick i").click(function(){---------

    // === 수량 마이너스 버튼 클릭했을 때 변경 === //
    $("div.choiceOneMenu > div.selectMenucnt button.btnminus").click(function(){

        // === 수량변경 버튼을 클릭할 시 무조건 제품선택되게 하기 === //
        // === 다른 체크박스 선택의 영향을 주지 않게하기 === //
        let choiceMenucheckbox = $(this).parent().parent().parent().parent().find("input[type='checkbox']");
        choiceMenucheckbox.prop("checked", false);

        let count = $(this).next().text();
        // alert("확인용 이전 수량 : " + count);
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

        }
        
    })  // end of $("div.choiceOneMenu > div.selectMenucnt button.btnminus").click(function(){----

    // === 수량 플러스 버튼 클릭했을 때 변경 === //
    $("div.choiceOneMenu > div.selectMenucnt button.btnplus").click(function(){

        // === 수량변경 버튼을 클릭할 시 무조건 제품선택되게 하기 === //
        // === 다른 체크박스 선택의 영향을 주지 않게하기 === //
        let choiceMenucheckbox = $(this).parent().parent().parent().parent().find("input[type='checkbox']");
        choiceMenucheckbox.prop("checked", false);
        
        let count = $(this).prev().text();
        // alert("확인용 이전 수량 : " + count);
        
        $(this).prev().text(Number(count) + 1);
        $("form[name='sendinfo'] > input[name='count']").val(Number(count) + 1);
        
        let cartno = $(this).parent().find("div#cartno").text();
        $("form[name='sendinfo'] > input[name='cartno']").val(cartno);
        // alert("확인용 : cartno" + cartno);

        // === 금액 변동 시키기 === //
        let Productprice = $(this).parent().find("span.Productprice").text();
        Productprice = Productprice.replaceAll(",","");
        // alert("확인용 : Productprice : " + Productprice);

        let choiceproductprice = $(this).parent().parent().parent().find("div.choiceproductprice").text();
        choiceproductprice = choiceproductprice.replaceAll(",","");

        choiceproductprice = (Number(count) + 1) * Number(Productprice);
        // alert("확인용 : choiceproductprice : " + choiceproductprice);

        $(this).parent().parent().parent().find("div.choiceproductprice").text(choiceproductprice.toLocaleString()); 

    })  // end of $("div.choiceOneMenu > div.selectMenucnt button.btnplus").click(function(){-------

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

