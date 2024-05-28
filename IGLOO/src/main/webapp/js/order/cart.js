$(document).ready(function() {

    // === 숫자 ###,### 형태 만들기 === //
    let cartTotalprice = $("span.cartTotalprice").text();
    $("span.cartTotalprice").text(Number(cartTotalprice).toLocaleString());

    $('div.choiceOneMenu').each(function() {

        let choiceproductprice = $(this).find("span.choiceproductprice").text();
        // alert("확인용 choiceproductprice : " + choiceproductprice);

        $(this).find("span.choiceproductprice").text(Number(choiceproductprice).toLocaleString());

    });
    
    // === 전체선택/ 해제 버튼 클릭 === //
    $("div.totalSelect > input#Allchecked").change(function(){

        let checkboxtotal = $(this).prop("checked");
        $("input[name='choicemenu']").prop("checked",checkboxtotal);

        // === 체크박스의 체크한 수량 적용시키기 === //
        let checkboxcnt = $("input:checkbox[name='choicemenu']:checked").length;

        $("span.choiceCnt").html(checkboxcnt);

        // alert("확인용 checkboxtotal 체크유무 : " + $("input[name='choicemenu']").prop("checked"));

        if($("input[name='choicemenu']").prop("checked") == true){

            let price = $(this).parent().find("span.cartTotalprice").text();
            price = price.replaceAll(",","");
            price = Number(price);
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
    
        let cnt = 0;

        for(let checkbox of checkboxlist){
            cnt = checkboxlist.length;
            // alert(checkboxlist.length);             // 체크박스 길이
            
            // alert($(checkbox).prop("checked"));     // 변동하기 전 체크박스 상태
            if(!checkbox.checked){
                $("div.totalSelect > input#Allchecked").prop("checked",false);
                falsecheckcnt += 1;
            }
            else{
                truecheckcnt += 1;
            }

        }   // end of for----------

        if(check == 1 && truecheckcnt == cnt-1 && falsecheckcnt == 1){
            $("div.totalSelect > input#Allchecked").prop("checked",true);
        }
        else if(truecheckcnt == cnt){
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

        if ($(e.target).is("button")) {
            // button 클릭 시에는 아무것도 하지 않음
            return;
        }


        // === 금액 변동시키기 === //
        if($(this).prev().prop("checked") == false){
            let choiceproductprice = $(this).find("span.choiceproductprice").text();
            choiceproductprice = choiceproductprice.replaceAll(",","");
            // alert(choiceproductprice);

            let totalPrice = $("span.totalPrice").text();
            totalPrice = totalPrice.replaceAll(",","");
            // alert(totalPrice);

            let Orderprice = Number(totalPrice) + Number(choiceproductprice)
            $("span.totalPrice").text(Orderprice.toLocaleString());
            $("span.navtotalPrice").text(Orderprice.toLocaleString());
        }
        else{
            let choiceproductprice = $(this).find("span.choiceproductprice").text();
            choiceproductprice = choiceproductprice.replaceAll(",","");
            // alert(choiceproductprice);

            let totalPrice = $("span.totalPrice").text();
            totalPrice = totalPrice.replaceAll(",","");
            // alert(totalPrice);

            let Orderprice = Number(totalPrice) - Number(choiceproductprice)
            $("span.totalPrice").text(Orderprice.toLocaleString());
            $("span.navtotalPrice").text(Orderprice.toLocaleString());
        }
       
    })  // end of $("div.choiceOneMenu").click(function() {-------------

    // === 제품삭제 버튼 클릭되게 하기 === //
    $("div.choiceOneMenu > div.menuclick button.delete").click(function(){
        alert("삭제버튼 클릭");
        
        // === 다른 체크박스 선택의 영향을 주지 않게하기(확인용) === //
        let choiceMenucheckbox = $(this).parent().parent().parent().parent().find("input[type='checkbox']");
        choiceMenucheckbox.prop("checked", false);

        let cartno = $(this).parent().parent().parent().parent().find("div#divcartno").text();
        // alert("삭제하는 장바구니 번호 : " + cartno);
        
        const productname = $(this).parent().find("div.productname").text();
        // alert("삭제하는 제품명 : " + productname);

        if(confirm(`${productname}을(를) 장바구니에서 제거하는 것이 맞습니까?`)){
            $.ajax({
                url:"cartnodeleteJSON.ice"
                , type:"post"
                , data:{"cartno":cartno}
                , dataType:"json"
                , success:function(json){
                    console.log("~~~ 확인용", JSON.stringify(json));
                    if(json.n == 1){
                        alert(`장바구니에서 제거되었습니다.`);
                        location.href="cart.ice";    // IGLOO/member/cart.ice
                    }
                }
                , error: function(request, status, error){
                    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                }
                
            })  // end of $.ajax({----------------
        }
        else{
            alert(`${productname} 제품 삭제를 취소하셨습니다.`);
        }

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
            $("form[name='sendinfo'] > input[name='prevCount']").val(Number(count));
            $("form[name='sendinfo'] > input[name='count']").val(Number(count) - 1);
            
            let cartno = $(this).parent().find("div#divcartno").text();
            $("form[name='sendinfo'] > input[name='cartno']").val(cartno);
            // alert("확인용 : cartno" + cartno);

            submitfrm();
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
        $("form[name='sendinfo'] > input[name='prevCount']").val(Number(count));
        $("form[name='sendinfo'] > input[name='count']").val(Number(count) + 1);
        
        let cartno = $(this).parent().find("div#divcartno").text();
        $("form[name='sendinfo'] > input[name='cartno']").val(cartno);
        // alert("확인용 : cartno" + cartno);

        submitfrm();

    })  // end of $("div.choiceOneMenu > div.selectMenucnt button.btnplus").click(function(){-------

    $("button.orderbtn").click(function(){
        continueOrder();
    })  // end of $("button.orderbtn").click(function(){--------

    $("button.updatetaste").click(function(){

        const ctxPath = $("div#ctxPath").text();
        let selectno = $(this).parent().find("div#selectno").text();
        // alert(selectno);

        $('#iframe_updatetaste').attr('src', `${ctxPath}/member/cart/updatetaste.ice?selectno=${selectno}`);

    })  // end of $("button.updatetaste").click(function(){--------

})  // end of $(document).ready(function() {--------------

///////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

// === Function Declaration === //
// === 장바구니가 없는경우 주문하기 버튼 클릭시 주문하기 창으로 이동 === //
function continueShopping(ctxPath){
    location.href = `${ctxPath}/order/order.ice`;
}   // end of function continueShopping(ctxPath){----------

/////////////////////////////////////////////////////////////////////////

// === 주문하기 창 이동 === //
function continueOrder(){
    const checkCnt = $("input:checkbox[name='choicemenu']:checked").length;

    if(checkCnt < 1){
        alert("주문하실 제품을 선택해주세요.");
        return;
    }
    else{
        const allcheckcnt = $("input:checkbox[name='choicemenu']").length;

        const cartnoArr = new Array();      // 장바구니 번호
        const selectnoArr = new Array();    // 선택일련번호
        let totalprice = $("span#totalPriceinfo").text();     // 주문총액
        totalprice = totalprice.replaceAll(",","");
        alert("확인용 totalprice : " + totalprice);

        for(let i=0; i<allcheckcnt; i++){
            // alert($("div#divcartno").eq(i).text());
            if($("input:checkbox[name='choicemenu']").eq(i).prop("checked")){   // 체크된 상태
                cartnoArr.push($("div#divcartno").eq(i).text());
                selectnoArr.push($("div#selectno").eq(i).text());
                alert("확인용 cartnoArr : " + cartnoArr);   // [5]  [5,6]
                alert("확인용 selectnoArr : " + selectnoArr);
                
            }
        }   // end of for-------------------

        const str_cartno = cartnoArr.join();    // 5,6
        const str_selectno = selectnoArr.join();

        alert("확인용 str_cartno : " +  str_cartno);
        alert("확인용 str_selectno : " +  str_selectno);
/*
        $.ajax({
            url:"order/payment.ice"
            , type:"post"
            , data:{"str_cartno":str_cartno
                , "selectnoArr":selectnoArr
                , "totalprice":totalprice
            }
            , success:function(json){
                
            }
            , error: function(request,status,error){
                alert("code : " + request.status);
            }
        })
    */  
        // location.href = `order/payment.ice`;
    }
    
}   // end of function continueOrder(){--------

/////////////////////////////////////////////////////////////////////////
// === 화면전환 === //
function submitfrm(){

    const cartno = $("form[name='sendinfo'] > input[name='cartno']").val();
    const prevCount = $("form[name='sendinfo'] > input[name='prevCount']").val();
    const count = $("form[name='sendinfo'] > input[name='count']").val();

    $.ajax({
        url:"cartJSON.ice"
        , type:"post"
        , data:{"cartno":cartno
            , "prevCount":prevCount     // 이전 수량
            , "count":count             // 변동후 count
        }
        , dataType:"json"
        , success:function(json){
            const str_json = JSON.stringify(json);  // json 객체를 string 타입으로 변경
            let v_html = ``;    // 장바구니 총액
            let c_html = ``;    // 선택금액 총액
            // alert("jsonCheck");

            $.each(json, function(index, item){

                v_html = Number(`${item.totalprice}`).toLocaleString();
                $("span.cartTotalprice").html(v_html);

                let totalprice = 0;
                // alert("확인용 ${item.cartno} : "`${item.cartno}`);
                $("div.choiceOneMenu").each(function() {
                    let cartno = $(this).find("div#divcartno").text();
                    // alert("확인용 cartno : " + cartno);
                    if(`${item.cartno}` == cartno){
                        // alert("${item.cartno} == cartno");
                        c_html = (Number(`${item.count}`) * Number(`${item.price}`)).toLocaleString();
                        $(this).find("span.choiceproductprice").html(c_html);
                    }

                    // === 체크 유무 파악하기 === //
                    // alert($(this).prev().prop("checked"));
                    
                    if($(this).prev().prop("checked") == true){
                        let price = $(this).find("span.choiceproductprice").text();
                        price = price.replaceAll(",","");

                        totalprice += Number(price);
                    }
                    

                })      // end of $("div.choiceOneMenu").each(function() {--------

                $("span.totalPrice").text(totalprice.toLocaleString());
                $("span.navtotalPrice").text(totalprice.toLocaleString());
                
            })  // end of $.each(json, function(index, item){-----
            
        }
        , error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
        
    })  // end of $.ajax({----------------

}   // end of function submitfrm(){---------------------
