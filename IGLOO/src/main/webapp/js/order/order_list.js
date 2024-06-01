$(document).ready(function(){

    // === 기간 현재날짜 지정 === //
    let now = func_currentDate();   // 현재 시각

    $("span#nowdate").text(now);

    // $("span#selectdate").text(func_lastyearDate());

////////////////////////////////////////////////////////////////////////////////////////////

    // === 기간 설정 버튼 색상 지정 === //
    $("div#Periodgroup > div > button:first-child").css("background-color", "#FD8A69");

    $("div#Periodgroup > div > button:first-child").click(function(){
        $("div#Periodgroup > div > button").not(this).css("background-color", "");
        $(this).css("background-color", "#FD8A69");

        $("input#orderlist_search").val("");
        $("span#selectdate").text("");
        
        $("form[name='sendinfo'] > input[name='searchorderList']").val("");
        $("form[name='sendinfo'] > input[name='orderListPeriod']").val('2000/01/01');
        $("form[name='sendinfo'] > input[name='selectPeriodindex']").val("0");
        
        submitfrm();

    })  // end of $("div#Periodgroup > div > button:first-child").click(function(){-----

    $("div#Periodgroup > div > button:nth-child(2)").click(function(){
        $("div#Periodgroup > div > button").not(this).css("background-color", "");
        $(this).css("background-color", "#FFCD4A");
        $("span#selectdate").text(func_lastmonthDate(1));

        let date1 = func_lastmonthDate(1).substring(0,4);
        let date2 = func_lastmonthDate(1).substring(5,7);
        let date3 = func_lastmonthDate(1).substring(8,10);

        $("form[name='sendinfo'] > input[name='orderListPeriod']").val(date1+"/"+date2+"/"+date3);
    
        $("input#orderlist_search").val("");
        $("form[name='sendinfo'] > input[name='searchorderList']").val("");
        submitfrm();

    })  // end of $("div#Periodgroup > div > button:nth-child(2)").click(function(){----
    
    $("div#Periodgroup > div > button:nth-child(3)").click(function(){
        $("div#Periodgroup > div > button").not(this).css("background-color", "");
        $(this).css("background-color", "#AFD485");
        $("span#selectdate").text(func_lastmonthDate(3));

        let date1 = func_lastmonthDate(3).substring(0,4);
        let date2 = func_lastmonthDate(3).substring(5,7);
        let date3 = func_lastmonthDate(3).substring(8,10);

        $("form[name='sendinfo'] > input[name='orderListPeriod']").val(date1+"/"+date2+"/"+date3);
    
        $("input#orderlist_search").val("");
        $("form[name='sendinfo'] > input[name='searchorderList']").val("");
        submitfrm();

    })  // end of $("div#Periodgroup > div > button:nth-child(3)").click(function(){----

    $("div#Periodgroup > div > button:nth-child(4)").click(function(){
        $("div#Periodgroup > div > button").not(this).css("background-color", "");
        $(this).css("background-color", "#82CBC4");
        $("span#selectdate").text(func_lastmonthDate(6));

        let date1 = func_lastmonthDate(6).substring(0,4);
        let date2 = func_lastmonthDate(6).substring(5,7);
        let date3 = func_lastmonthDate(6).substring(8,10);

        $("form[name='sendinfo'] > input[name='orderListPeriod']").val(date1+"/"+date2+"/"+date3);
    
        $("input#orderlist_search").val("");
        $("form[name='sendinfo'] > input[name='searchorderList']").val("");
        submitfrm();

    })  // end of $("div#Periodgroup > div > button:nth-child(4)").click(function(){----

    $("div#Periodgroup > div > button:last-child").click(function(){
        $("div#Periodgroup > div > button").not(this).css("background-color", "");
        $(this).css("background-color", "#58CCFF");
        $("span#selectdate").text(func_lastmonthDate(12));

        let date1 = func_lastmonthDate(12).substring(0,4);
        let date2 = func_lastmonthDate(12).substring(5,7);
        let date3 = func_lastmonthDate(12).substring(8,10);

        $("form[name='sendinfo'] > input[name='orderListPeriod']").val(date1+"/"+date2+"/"+date3);
    
        $("input#orderlist_search").val("");
        $("form[name='sendinfo'] > input[name='searchorderList']").val("");
        submitfrm();

    })  // end of $("div#Periodgroup > div > button:last-child").click(function(){----

    // === 주문내역 검색 시 input 태그에 담아주기(1) === //
    $("input#orderlist_search").bind("keydown",function(e){
        if(e.keyCode == 13){
            $("form[name='sendinfo'] > input[name='searchorderList']").val($("input#orderlist_search").val());
            $("form[name='sendinfo'] > input[name='orderListPeriod']").val("none");
            submitfrm();
        }
    })  // end of $("input#orderlist_search").bind("keydown",function(e){-------

    // === 주문내역 검색 시 input 태그에 담아주기(2) === //
    $("button#btnorderlistSearch").click(function(){

        if($("input#orderlist_search").val() == ""){
            alert("검색내용을 입력해주세요.");
            return;
        }
        $("form[name='sendinfo'] > input[name='searchorderList']").val($("input#orderlist_search").val());
        $("form[name='sendinfo'] > input[name='orderListPeriod']").val("none");
        submitfrm();
    })  // end of $("button#btnorderlistSearch").click(function{--------------

})  // end of $(document).ready(function(){----------

/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

// === Function Declaration === //

// === 현재 날짜 찾는 함수 === //
function func_currentDate(){
   const now = new Date();
     
     const year = now.getFullYear();
     let month = now.getMonth() + 1;
     let date = now.getDate();
  
     if(month < 10){      // 10 이하인 경우
       month = "0" + month;
    }
     if(date < 10){      // 10 이하인 경우
       date = "0" + date;
    }
  
     const day = now.getDay();   // 현재요일명(0~6) ( 일 ~ 토 )
  
     let dayName;
     switch(day){
       case 0:   // "0" 이 아닌 0 이다. 주의!
           dayName = "일"
           break;
        case 1:   
           dayName = "월"
           break;
        case 2:   
           dayName = "화"
           break;
        case 3:   
           dayName = "수"
           break;
        case 4:   
           dayName = "목"
           break;
        case 5:   
           dayName = "금"
           break;
        case 6:   
           dayName = "토"
           break;
    }   // end of switch(day)-------------
  return `${year}.${month}.${date} (${dayName})`;
}   // end of function func_currentDate(){--------

//////////////////////////////////////////////////////

// === 날짜 찾는 함수 === //
function func_lastmonthDate(choice){

    let date = dayjs();
    date = date.subtract(choice,"M").format("YYYY-MM-DD (ddd)");

    const dateParts = date.split(" ");

    let koreanDay;
    switch (dateParts[1]) {
    case "(Sun)":
        koreanDay = "(일)";
        break;
    case "(Mon)":
        koreanDay = "(월)";
        break;
    case "(Tue)":
        koreanDay = "(화)";
        break;
    case "(Wed)":
        koreanDay = "(수)";
        break;
    case "(Thu)":
        koreanDay = "(목)";
        break;
    case "(Fri)":
        koreanDay = "(금)";
        break;
    case "(Sat)":
        koreanDay = "(토)";
        break;
    }

    dateParts[1] = koreanDay;
    const koreanDateString = dateParts.join(" ");

    return koreanDateString;

}   // end of func_lastmonthDate(choice){--------

///////////////////////////////////////////////////////////
// === 화면전환 === //
function submitfrm(){
        
    const searchorderList = $("form[name='sendinfo'] > input[name='searchorderList']").val();
    const orderListPeriod = $("form[name='sendinfo'] > input[name='orderListPeriod']").val();
    
    $.ajax({
        url:"orderlistJSON.ice"
        , data:{"searchorderList":searchorderList
            , "orderListPeriod":orderListPeriod
        }
        , dataType:"json"
        , success:function(json){
            const str_json = JSON.stringify(json);  // json 객체를 string 타입으로 변경
            // console.log("확인용 str_json : " + str_json);
            let v_html = ``;
            // alert("jsonCheck");

            if(str_json == "[]"){
                // alert("결과값없음");
                v_html = `<div class="mx-auto text-center">
                                    <h3 class="mt-5 font-weight-bolder">해당하는 상품이 없습니다.</h3>
                                    <div class="h-50 p-5 m-3"></div>
                                </div>`;
                $("div#SearchorderlistContents").html(v_html);
            }
            else{
                $.each(json, function(index, item){
                        
                    v_html += `<div class="orderdate ml-4"></div>
                            <div class="Oneorderdate">
                            
                                    <div class="dateorderlist my-3 ml-4">
                                        <div style="font-weight:bold;">${item.orderdate}</div>
                                        <div>주문코드 : ${item.ordercode}</div>
                                    </div>
                                    <div id="orderlist" class="row justify-content-center mb-3">
                                        <div class="col-xl-2 col-lg-2 ">
                                            <img class="img-fluid mt-5" src="/IGLOO/images/img_hj/cup_size/${item.productimg}" alt="Responsive image">
                                        </div>
                                        <div class="orderMenu col-xl-3 col-lg-3 ">
                                            <label class="text-center mx-auto mt-3">${item.productname}</label>
                                            <div class="choiceAlltaste my-auto">
                                                <ul class="list-group list-group-flush">
                                                `;
                                                    item.tastenamelist.forEach(elmt => {
                                                    
                                                        v_html += `<li class="list-group-item">${elmt}</li>`
                                                    })
                                    v_html += `</ul>
                                            </div>
                                        </div>
                                        <div class="selectMenucnt justify-content-center text-center col-xl-2 col-lg-2 p-0">
                                            <div class="mt-5">
                                                <div class="d-inline-block"></div>
                                                <div style="font-weight:bold;">수량</div>
                                                <span style="font-weight:bold;">${item.ordercount}</span>
                                            </div>
                                        </div>
                                        <div class="selectOrderprice justify-content-center text-center col-xl-2 col-lg-2 p-0">
                                            <div class="mt-5 mb-5">
                                                <div class="d-inline-block"></div>
                                                <div style="font-weight:bold;">
                                                    ${Number(item.orderprice).toLocaleString()}     <!-- #,###-->
                                                    원
                                                </div>
                                            </div>
                                        </div>
                                        <div class="Ordersituation justify-content-center text-center col-xl-2 col-lg-2 p-0">
                                            <div class="mt-5 mb-5">
                                                <div class="d-inline-block"></div>
                                                <div>`;
                                                if(item.pickupstatus == "1"){
                                                    v_html += `<span style="font-weight:bold;">주문완료</span>`;
                                                }
                                                else if(item.pickupstatus == "2"){
                                                    v_html += `<span style="font-weight:bold;">준비중</span>
                                                                <br>
                                                                <span style="font-size:10pt;">예상 준비시간
                                                                    <br>
                                                                    ${item.pickuptime}
                                                                </span>`;
                                                }
                                                else if(item.pickupstatus == "3"){
                                                    v_html += `<span style="font-weight:bold;">픽업대기</span>`;
                                                }
                                                else if(item.pickupstatus == "4"){
                                                    v_html += `<span style="font-weight:bold;">픽업완료</span>`;
                                                }
                                                v_html +=  `
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                                `;
                })  // end of $.each(json, function(index, item){
            $("div#SearchorderlistContents").html(v_html);
            }   // end of if~else---------------
        }   // end of success-------------------
        , error: function(request, status, error){
            // alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            alert("code: " + request.status);
        }
    })  // end of $.ajax-------------
        
}   // end of function submitfrm(){-----------