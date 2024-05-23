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
        
        $("span#selectdate").text("");
        $("form[name='sendinfo'] > input[name='orderListPeriod']").val("");
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
    
        $("form[name='sendinfo'] > input[name='selectPeriodindex']").val("1");
        submitfrm();

    })  // end of $("div#Periodgroup > div > button:nth-child(2)").click(function(){----
    
    $("div#Periodgroup > div > button:nth-child(3)").click(function(){
        $("div#Periodgroup > div > button").not(this).css("background-color", "");
        $(this).css("background-color", "#AFD485");
        $("span#selectdate").text(func_lastmonthDate(3));

        let date1 = func_lastmonthDate(1).substring(0,4);
        let date2 = func_lastmonthDate(1).substring(5,7);
        let date3 = func_lastmonthDate(1).substring(8,10);

        $("form[name='sendinfo'] > input[name='orderListPeriod']").val(date1+"/"+date2+"/"+date3);
    
        $("form[name='sendinfo'] > input[name='selectPeriodindex']").val("2");
        submitfrm();

    })  // end of $("div#Periodgroup > div > button:nth-child(3)").click(function(){----

    $("div#Periodgroup > div > button:nth-child(4)").click(function(){
        $("div#Periodgroup > div > button").not(this).css("background-color", "");
        $(this).css("background-color", "#82CBC4");
        $("span#selectdate").text(func_lastmonthDate(6));

        let date1 = func_lastmonthDate(1).substring(0,4);
        let date2 = func_lastmonthDate(1).substring(5,7);
        let date3 = func_lastmonthDate(1).substring(8,10);

        $("form[name='sendinfo'] > input[name='orderListPeriod']").val(date1+"/"+date2+"/"+date3);
    
        $("form[name='sendinfo'] > input[name='selectPeriodindex']").val("3");
        submitfrm();

    })  // end of $("div#Periodgroup > div > button:nth-child(4)").click(function(){----

    $("div#Periodgroup > div > button:last-child").click(function(){
        $("div#Periodgroup > div > button").not(this).css("background-color", "");
        $(this).css("background-color", "#58CCFF");
        $("span#selectdate").text(func_lastmonthDate(12));

        let date1 = func_lastmonthDate(1).substring(0,4);
        let date2 = func_lastmonthDate(1).substring(5,7);
        let date3 = func_lastmonthDate(1).substring(8,10);

        $("form[name='sendinfo'] > input[name='orderListPeriod']").val(date1+"/"+date2+"/"+date3);
    
        $("form[name='sendinfo'] > input[name='selectPeriodindex']").val("4");
        submitfrm();

    })  // end of $("div#Periodgroup > div > button:last-child").click(function(){----

    // === 주문내역 검색 시 input 태그에 담아주기(1) === //
    $("input#orderlist_search").bind("keydown",function(e){
        if(e.keyCode == 13){
            $("form[name='sendinfo'] > input[name='searchorderList']").val($("input#orderlist_search").val());
            submitfrm();
        }
    })  // end of $("input#orderlist_search").bind("keydown",function(e){-------

    // === 주문내역 검색 시 input 태그에 담아주기(2) === //
    $("button#btnorderlistSearch").click(function(){

        if($("input#orderlist_search").text() == ""){
            alert("검색내용을 입력해주세요.");
            return;
        }
        $("form[name='sendinfo'] > input[name='searchorderList']").val($("input#orderlist_search").val());
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
  
  	if(month < 10){		// 10 이하인 경우
    	month = "0" + month;
    }
  	if(date < 10){		// 10 이하인 경우
    	date = "0" + date;
    }
  
  	const day = now.getDay();	// 현재요일명(0~6) ( 일 ~ 토 )
  
  	let dayName;
  	switch(day){
    	case 0:	// "0" 이 아닌 0 이다. 주의!
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
    }	// end of switch(day)-------------
  return `${year}.${month}.${date} (${dayName})`;
}   // end of function func_currentDate(){--------

//////////////////////////////////////////////////////

// === 날짜 찾는 함수 === //
function func_lastmonthDate(choice){
	const now = new Date();
  	
  	let year = now.getFullYear();
  	let month = now.getMonth() + 1 - choice;
  	let date = now.getDate();
  
    if(month < 0){
        year -= 1;
        month += 12;
    }
  	if(month < 10){		// 10 이하인 경우
    	month = "0" + month;
    }
  	if(date < 10){		// 10 이하인 경우
    	date = "0" + date;
    }
  
    const newDate = new Date(year, month - 1, date);

  	const day = newDate.getDay();	// 현재요일명(0~6) ( 일 ~ 토 )
  
  	let dayName;
  	switch(day){
    	case 0:
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
    }	// end of switch(day)-------------
  return `${year}.${month}.${date} (${dayName})`;
}   // end of func_lastmonthDate(choice){--------

///////////////////////////////////////////////////////////

function submitfrm(){
/*
    const ctxPath = $("div#ctxPath").text();

    const frm = document.sendinfo;
    frm.method = "post";
    frm.action = `${ctxPath}/member/mypage.ice`;
    frm.submit();
*/
    
    const searchorderList = $("form[name='sendinfo'] > input[name='searchorderList']").val();
    const orderListPeriod = $("form[name='sendinfo'] > input[name='orderListPeriod']").val();
    const selectPeriodindex = $("form[name='sendinfo'] > input[name='selectPeriodindex']").val();
    
        $.ajax({
            url:"orderlistJSON.ice"
            , data:{"searchorderList":searchorderList
                , "orderListPeriod":orderListPeriod
                , "selectPeriodindex":selectPeriodindex
            }
            // , async : true  // 돌아가는동안 화면정지
            , dataType:"json"
            , success:function(json){
                const str_json = JSON.stringify(json);  // json 객체를 string 타입으로 변경
                let v_html = ``;
                alert("jsonCheck");
/*
                $.each(json, function(index, item){
                        
                    let searchinput = json[index].searchorderList;

                    if(searchinput == ""){  // 기간 설정한 경우
                        $("input#orderlist_search").html(searchinput);
                        v_html = `<div class="mx-auto text-center">
                                    <h3 class="mt-5 font-weight-bolder">해당하는 상품이 없습니다.</h3>
                                    <div class="h-50 p-5 m-3"></div>
                                </div>`;
                    }
                    $("input#orderlist_search").html(v_html);

                    console.log(index);

                })
                /*
                if(json[0].haveorderlist == "none" && json[0].searchorderList == ""){
                    alert("주문내역 없음");
                    
                    $("div#SearchorderlistContents").hide();
                    $("div#noorderlist").hide();
                    v_html = `<div class="mx-auto text-center">
                                <h3 class="mt-5 font-weight-bolder">주문내역에 담긴 상품이 없습니다.</h3>
                                <div class="h-50 p-5 m-3"></div>
                            </div>`; 
                    $("div#orderlist").html(v_html);
                    
                }
                
                else if(json[0].haveorderlist == "haveorderlist" && json[0].searchorderList != ""){
                    alert("검색내용 있음");

                    if(json[0].orderdetailList.size() < 1){
                        $("input#orderlist_search").html(searchinput);
                            v_html = `<div class="mx-auto text-center">
                                        <h3 class="mt-5 font-weight-bolder">해당하는 상품이 없습니다.</h3>
                                        <div class="h-50 p-5 m-3"></div>
                                    </div>`;
                        $("input#orderlist_search").html(v_html);
                    }
                    
                }
                */
                
                // div 안에 꽂아주기
            }
            /*
            , error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
            */

        })  // end of $.ajax-------------
    
}   // end of function submitfrm(){-----------
