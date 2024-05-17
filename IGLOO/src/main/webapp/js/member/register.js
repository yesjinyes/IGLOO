// === 아이디 중복확인 클릭확인 용도 === //
let b_idcheck_click = false;

// === 이메일 중복확인 클릭확인 용도 === //
let b_emailcheck_click = false;

// === 우편번호찾기 클릭확인 용도 === //
let b_zipcodeSearch_click = false;

$(document).ready(function(){
	
    $("iframe#iframe_agree").hide();

    // === 약관 내용 보기 === //
    $("button#checkagreeContents").click(function(){
        // alert("확인용 => 이용약관 자세히보기 버튼 클릭");
        $("iframe#iframe_agree").toggle();
    })

	$("span.error").hide();

    $("input[name='userid']").focus();

    // === 아이디 focus === //
    $("input#userid").blur(e => {
        const userid = $(e.target).val().trim();
        if(userid == ""){     // 입력하지 않거나 공백만 입력했을 경우

            $(e.target).val("");
            
            $(e.target).parent().find("span.error").show();

        }
        else{   // 공백이 아닌 글자를 입력했을 경우

            $(e.target).parent().find("span.error").hide(); 
            
        }   // end of if~else----------------
        
    }); // end of $("input#userid").blur(e => {----------------------

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // === 비밀번호 focus === //
    $("input#pwd").blur(e => {

        // 숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
        const regExp_pwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);

        const bool = regExp_pwd.test($(e.target).val());

        if(!bool){     // 암호가 정규표현식에 위배된 경우
            
            $(e.target).val("");
            
            $(e.target).parent().find("span.error").show();

        }
        else{   // 암호가 정규표현식에 맞는 경우

            $(e.target).parent().find("span.error").hide();

        }   // end of if~else----------------
        
    });     // end of $("input#pwd").blur(e => {---------------------------

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // === 비밀번호 확인 focus === //
    $("input#pwdcheck").blur(e => {

        if($("input#pwd").val() != $(e.target).val()){     // 값이 다른 경우
            
            $(e.target).val("");
            $("input#pwd").val("");
            
            $(e.target).parent().find("span.error").show();

        }
        else{   // 암호가 정규표현식에 맞는 경우

            $(e.target).parent().find("span.error").hide(); 
            
        }   // end of if~else----------------
        
    });     // end of $("input#pwdcheck").blur(e => {---------------------------

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // === 이메일 focus === //
    $("input#email").blur(e => {

        const regExp_email = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);  

        const bool = regExp_email.test($(e.target).val());

        if(!bool){     // 이메일이 정규표현식에 위배된 경우
            
            $(e.target).val("");
            
            $(e.target).parent().find("span.error").show();

        }
        else{   // 이메일이 정규표현식에 맞는 경우

            $(e.target).parent().find("span.error").hide();    

        }   // end of if~else----------------
        
    });     // end of $("input#email").blur(e => {------------------------------

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // === 성명 focus === //
    $("input#name").blur(e => {
        const name = $(e.target).val().trim();
        if(name == ""){     // 입력하지 않거나 공백만 입력했을 경우
            
            $(e.target).val("");
            
            $(e.target).parent().find("span.error").show();

        }
        else{   // 공백이 아닌 글자를 입력했을 경우

            $(e.target).parent().find("span.error").hide();   
            
        }   // end of if~else----------------

    });     // end of $("input#name").blur(e => {-------------------

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // === hp2 focus === //
    $("input#hp2").blur( (e) => {
      
        const regExp_hp2 = new RegExp(/^[1-9][0-9]{3}$/);  
        // 연락처 국번( 숫자 4자리인데 첫번째 숫자는 1-9 이고 나머지는 0-9) 정규표현식 객체 생성 
        
        const bool = regExp_hp2.test($(e.target).val());   
        
        if(!bool) {     // 연락처 국번이 정규표현식에 위배된 경우 
            
            $(e.target).parent().find("span.error").show();
            
            $(e.target).val(""); 
        }
        else {      // 연락처 국번이 정규표현식에 맞는 경우 

            $(e.target).parent().find("span.error").hide();
        }
           
    });     // end of $("input#hp2").blur( (e) => {-----------------------
        
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // === hp3 focus === //
    $("input#hp3").blur( (e) => {
        
        const regExp_hp3 = new RegExp(/^\d{4}$/);  
        // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성 
        
        const bool = regExp_hp3.test($(e.target).val());   
        
        if(!bool) {     // 마지막 전화번호 4자리가 정규표현식에 위배된 경우 
            
            $(e.target).parent().find("span.error").show();
                
            $(e.target).val(""); 
        }
        else {      // 마지막 전화번호 4자리가 정규표현식에 맞는 경우 
            
            $(e.target).parent().find("span.error").hide();
        }
        
    });     // end of $("input#hp3").blur( (e) => {-------------------------

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // === 우편번호 focus === //
    $("input#postcode").blur( (e) => {
    
        const regExp_postcode = new RegExp(/^\d{5}$/);  
        // 숫자 5자리만 들어오도록 검사해주는 정규표현식 객체 생성 
        
        const bool = regExp_postcode.test($(e.target).val());   
        
        if(!bool) {     // 우편번호가 정규표현식에 위배된 경우 
            
            $(e.target).parent().find("span.error").show();
              
            $(e.target).val(""); 
        }
        else {      // 우편번호가 정규표현식에 맞는 경우 
            
            $(e.target).parent().find("span.error").hide();
        }
            
    });     // end of $("input#postcode").blur( (e) => {----------------------------------

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // === 우편번호를 읽기전용(readonly) 으로 변경 === //
    $("input#postcode").attr("readonly", true);

    // === 주소를 읽기전용(readonly) 으로 변경 === //
    $("input#address").attr("readonly", true);          // 필드에 값이 부여된 이후 읽기전용으로 변경
      
    // === 참고항목을 읽기전용(readonly) 으로 변경 === //
    $("input#extraAddress").attr("readonly", true);     // 필드에 값이 부여된 이후 읽기전용으로 변경

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // === "우편번호찾기" 클릭 === //
   $("span#zipcodeSearch").click(function(){
      
        b_zipcodeSearch_click = true;   
    
        new daum.Postcode({
            oncomplete: function(data) {
                
                let addr = ''; // 주소 변수
                let extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
      
    // ----------------------------------------------------------------------------------------------

        // === 우편번호를 읽기전용(readonly) 으로 변경 === //
        $("input#postcode").attr("readonly", true);

        // === 주소를 읽기전용(readonly) 으로 변경 === //
        $("input#address").attr("readonly", true);          // 필드에 값이 부여된 이후 읽기전용으로 변경
      
        // === 참고항목을 읽기전용(readonly) 으로 변경 === //
        $("input#extraAddress").attr("readonly", true);     // 필드에 값이 부여된 이후 읽기전용으로 변경
      
    });// end of $("span#zipcodeSearch").click()------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // === jQuery UI 의 datepicker === //
    $('input#datepicker').datepicker({
        dateFormat: 'yy-mm-dd'  //Input Display Format 변경
        ,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
        ,changeYear: true        //콤보박스에서 년 선택 가능
        ,changeMonth: true       //콤보박스에서 월 선택 가능                
      // ,showOn: "both"          //button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
      // ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
      // ,buttonImageOnly: true   //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
      // ,buttonText: "선택"       //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
        ,yearSuffix: "년"         //달력의 년도 부분 뒤에 붙는 텍스트
        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
    //  ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
    //  ,maxDate: "+1M" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)                
    });

    // 초기값을 오늘 날짜로 설정
    // $('input#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
    // $('input#datepicker').datepicker('setDate', '-1D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // === 전체 datepicker 옵션 일괄 설정하기 ===  
    //     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
    $(function() {
        
        //모든 datepicker에 대한 공통 옵션 설정
        $.datepicker.setDefaults({
             dateFormat: 'yy-mm-dd' //Input Display Format 변경
            ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
            ,changeYear: true //콤보박스에서 년 선택 가능
            ,changeMonth: true //콤보박스에서 월 선택 가능                
        //  ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
        //  ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
        //  ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
        //  ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
            ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
            ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
        //  ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
        //  ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
        });
        
        // input을 datepicker로 선언
        $("input#fromDate").datepicker();                    
        $("input#toDate").datepicker();
        
     });

   ///////////////////////////////////////////////////////////////////////

    // 키보드로 입력못하게 하기
    $('input#datepicker').keydown(e => {

        $(e.target).val("").next().show();

    })  // end of $('input#datepicker').keydown(e => {})-------------

////////////////////////////////////////////////////////////////////////////

    // 생년월일에 마우스로 달력에 있는 날짜를 선택한 경우 이벤트 처리 한것 
    $('input#datepicker').bind("change", e =>{
        if($(e.target).val() != ""){
            $(e.target).next().hide();
        }
    })

    ///////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////

    // === "아이디 중복확인" 을 클릭 === //
    $("span#idcheck").click(function(){

        if($("input#userid").val() == "" || $("input#userid").val() == null){
            $("span#idcheckResult").html(" - 입력한 값이 존재하지 않습니다. ").css({"color":"red"});
            return;
        }

        b_idcheck_click = true;     
        
        $.ajax({

            url: "idDuplicateCheck.ice"
            , data: {"userid":$("input#userid").val()}    
            , type:"post"       // type을 생략하면 type: "get" 이다.   
            // [주의] method 가 아닌 type 작성!!

            , async:true   // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                          // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.
            
            , dataType : "json"     

            , success: function(json){ 

                // console.log("json => ", json);
                // json => {"isExists":true}
                // json => {"isExists":false}
                // json 는 idDuplicateCheck.ice 을 통해 가져온 결과물인 "{"isExists":true}" 또는 "{"isExists":false}" 로 되어지는 string 타입의 결과물이다.

                // console.log("~~~ json 의 데이터타입 : ", typeof json);
                // ~~~ json 의 데이터타입 : object

                if(json.isExists){      // DB 에 존재하는 아이디인 경우     
                    $("span#idcheckResult").html(" - " + $("input#userid").val()
                        + " 은 이미 사용중 이므로 다른 아이디를 입력하세요");
                    $("input#userid").val("").focus();
                }
                else{                   // DB 에 존재하지 않는 아이디인 경우
                    $("span#idcheckResult").html(" - " + $("input#userid").val()
                        + " 은 사용가능합니다. ").css({"color":"rgb(89, 200, 236)"});
                }

            },

            // 잘못되어지면 알람
            error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }

        }); // end of $.ajax({})-----------------------------

    })  // end of $("span#idcheck").click(function(){})-------------------------
   
    // === 아이디 값 변경시 "아이디 중복확인" 클릭 해제 === //
    $("input#userid").bind("change",function(){

        $("span#idcheckResult").empty();
        b_idcheck_click = false;

    })  // end of $("input#userid").bind("change",function(){})----------------

    ///////////////////////////////////////////////////////////////////////

    // === "이메일 중복확인" 을 클릭 === //
    $("span#emailcheck").click(function(){

        if($("input#email").val() == "" || $("input#email").val() == null){
            $("span#emailcheck").html(" - 입력한 값이 존재하지 않습니다. ").css({"color":"red"});
            return;
        }

        b_emailcheck_click = true;  // 클릭 유무 파악

        $.ajax({

            url: "emailDuplicateCheck.ice"
            , data: {"email":$("input#email").val()}
            , type:"post"       // type을 생략하면 type: "get" 이다.   
            // [주의] method 가 아닌 type 작성!!

            , async:true   // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                          // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.
            
            , dataType : "json"     

            , success: function(json){  

                // console.log("json => ", json);
                // json => {"isExists":true}
                // json => {"isExists":false}
                // json 는 EmailDuplicateCheck.ice 을 통해 가져온 결과물인 "{"isExists":true}" 또는 "{"isExists":false}" 로 되어지는 string 타입의 결과물이다.


                // console.log("~~~ json 의 데이터타입 : ", typeof json);
                // ~~~ json 의 데이터타입 :  object

                if(json.isExists){      // DB 에 존재하는 이메일인 경우
                    $("span#emailCheckResult").html(" - " + $("input#email").val()
                        + " 은 이미 사용중 이므로 다른 이메일을 입력하세요").css({"color":"red"});
                    $("input#email").val("").focus();

                }
                else{                   // DB 에 존재하지 않는 이메일인 경우
                    $("span#emailCheckResult").html(" - " + $("input#email").val()
                        + " 은 사용가능합니다. ").css({"color":"rgb(89, 200, 236)"});
                }

            },

            // 잘못되어지면 알람
            error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
        }); // end of $.ajax({})-----------------------------

    })  // end of $("span#emailcheck").click(function(){})-------------------------

    // === 이메일 값 변경시 "이메일 중복확인" 클릭 해제 === //
    $("input#email").bind("change",function(){

        $("span#emailCheckResult").empty();
        b_emailcheck_click = false;

    })  // end of $("input#email").bind("change",function(){})----------------

    // === 성별 선택에 따른 배경색 변경 === //
    $('input[name="gender"]').change(function() {
        // 선택된 라디오 버튼의 값 가져오기
        const gender_value = $(this).val();

        // 해당하는 카드의 배경색 변경
        if (gender_value == "1") {      // 남자일 경우
            $(this).closest('.card').addClass('bg-gender').removeClass('bg-outline-secondary');
            
            // 여자  배경색 초기화
            $('#female').closest('.card').removeClass('bg-gender').addClass('bg-outline-secondary');
        }
        else if (gender_value == "2") {     // 여자일 경우
            $(this).closest('.card').addClass('bg-gender').removeClass('bg-outline-secondary');
            
            // 남자 배경색 초기화
            $('#male').closest('.card').removeClass('bg-gender').addClass('bg-outline-secondary');
        }
    })

    // === 남자 div 클릭하였을 때 해당값 클릭 적용 === //
    $("div#divmale").click(function(){

        // console.log("divmale클릭");

        $(this).find("input:radio[name='gender']").prop("checked",true);
        
        // console.log($("input:radio[name='gender']:checked").length);

        $('input[name="gender"]').closest('.card').addClass('bg-gender').removeClass('bg-outline-secondary');
            
        // 여자 배경색 초기화
        $('#female').closest('.card').removeClass('bg-gender').addClass('bg-outline-secondary');
        
    })  // end of $("div#divmale").click(function(){--------------------

    // === 여자 div 클릭하였을 때 해당값 클릭 적용 === //
    $("div#divfemale").click(function(){

        // console.log("divfemale클릭");

        $(this).find("input:radio[name='gender']").prop("checked",true);
        
        // console.log($("input:radio[name='gender']:checked").length);

        $('input[name="gender"]').closest('.card').addClass('bg-gender').removeClass('bg-outline-secondary');
            
        // 남자 배경색 초기화
        $('#male').closest('.card').removeClass('bg-gender').addClass('bg-outline-secondary');
   
    })  // end of $("div#divmale").click(function(){--------------------

})	// end of $(document).ready(function(){})--------------------

///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

// Function Declaration
function goRegister(){

    // === 필수입력 확인 === //
    let b_requiredInfo = true;

    // === javascript === //
    const requiredInfo_list = document.querySelectorAll("input.requiredInfo");

    for(let i=0; i<requiredInfo_list.length; i++){
        const val = requiredInfo_list[i].value.trim();
        if(val == ""){
            alert("모든 항목을 필수로 입력해주세요.");
            b_requiredInfo = false;
            return false;   //  break; 라는 뜻이다.
        }
    }   // end of for-------------------------------

    if(!b_requiredInfo){    // 필수입력이 다 채워지지 않은 경우
        return;     // goRegister() 함수를 종료한다.
    }
    
    // === 생년월일 값 입력 확인 === //
    const birthday = $('input#datepicker').val().trim();

    if(birthday == ""){
        alert("생년월일을 입력하셔야 합니다.");
        return; // goRegister() 함수를 종료한다.
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////

    // === "아이디 중복확인" 클릭 유무 확인 === //
    if(!b_idcheck_click){   // "아이디 중복확인"을 클릭 안 했을 경우
        alert("아이디 중복확인을 클릭하셔야 합니다.");
        return;     // goRegister() 함수를 종료한다.
    }

    // === "이메일 중복확인" 클릭 유무 확인 === //
    if(!b_emailcheck_click){    // "이메일 중복확인"을 클릭 안 했을 경우
        alert("이메일 중복확인을 클릭하셔야 합니다.");
        return;     // goRegister() 함수를 종료한다.
    }

    // === "우편번호찾기" 클릭 유무 확인 //
    if(!b_zipcodeSearch_click){
        alert("우편번호찾기를 클릭하셔서 우편번호를 입력하셔야 합니다.");
        return; // goRegister() 함수를 종료한다.    
        // => button의 type 이 submit 이 아닌 button 타입이므로 return false 가 아니다.
    }

    //////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////
    
    // === 우편번호 및 주소 값 입력 확인 === //
    const postcode = $("input#postcode").val().trim();
    const address = $("input#address").val().trim();
    const detailAddress = $("input#detailAddress").val().trim();
    // const extraAddress = $("input#extraAddress").val().trim();
   
    if(postcode == "" || address == "" || detailAddress == "" || extraAddress == "") {
        alert("우편번호 및 주소를 입력하셔야 합니다.");
        return; // goRegister() 함수를 종료한다.
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////

    // === 성별 선택 확인 === //
    const radio_checked_length = $("input:radio[name='gender']:checked").length;

    if(radio_checked_length == 0){
        alert("성별을 선택하셔야 합니다.");
        return; // goRegister() 함수를 종료한다.
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // === 약관 동의 여부 확인 === //
    const checkbox_checked_length = $("input:checkbox[id='agree']:checked").length;

    if(checkbox_checked_length == 0){
        alert("이용약관에 동의하셔야 합니다.");
        return; // goRegister() 함수를 종료한다.
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////

    const frm = document.registerFrm;
    frm.action = "register.ice";
    frm.method = "post";
    frm.submit();

}   // end of function goRegister()----------------------

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

// Function Declaration
function goUpdate(){

    // === 필수입력 확인 === //
    let b_requiredInfo = true;

    // === javascript === //
    const requiredInfo_list = document.querySelectorAll("input.requiredInfo");

    for(let i=0; i<requiredInfo_list.length; i++){
        const val = requiredInfo_list[i].value.trim();
        if(val == ""){
            alert("모든 항목을 필수로 입력해주세요.");
            b_requiredInfo = false;
            return false;   //  break; 라는 뜻이다.
        }
    }   // end of for-------------------------------

    if(!b_requiredInfo){    // 필수입력이 다 채워지지 않은 경우
        return;     // goUpdate() 함수를 종료한다.
    }
    
    // === 생년월일 값 입력 확인 === //
    const birthday = $('input#datepicker').val().trim();

    if(birthday == ""){
        alert("생년월일을 입력하셔야 합니다.");
        return; // goUpdate() 함수를 종료한다.
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////

    // === "이메일 중복확인" 클릭 유무 확인 === //
    if(!b_emailcheck_click){    // "이메일 중복확인"을 클릭 안 했을 경우
        alert("이메일 중복확인을 클릭하셔야 합니다.");
        return;     // goUpdate() 함수를 종료한다.
    }

    // === "우편번호찾기" 클릭 유무 확인 //
    if(!b_zipcodeSearch_click){
        alert("우편번호찾기를 클릭하셔서 우편번호를 입력하셔야 합니다.");
        return; // goUpdate() 함수를 종료한다.    
        // => button의 type 이 submit 이 아닌 button 타입이므로 return false 가 아니다.
    }

    //////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////
    
    // === 우편번호 및 주소 값 입력 확인 === //
    const postcode = $("input#postcode").val().trim();
    const address = $("input#address").val().trim();
    const detailAddress = $("input#detailAddress").val().trim();
    // const extraAddress = $("input#extraAddress").val().trim();
   
    if(postcode == "" || address == "" || detailAddress == "" || extraAddress == "") {
        alert("우편번호 및 주소를 입력하셔야 합니다.");
        return; // goRegister() 함수를 종료한다.
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////

    const frm = document.updateFrm;
    frm.action = "memberUpdate.ice";
    frm.method = "post";
    frm.submit();

}   // end of function goUpdate()----------------------

// ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 에러메시지나 중복체크여부 지우기
function goReset(){

    javascript:history.back();

    /* 
    // === 리셋 할 경우 === //
    $("span.error").hide();

    $("span#idcheckResult").empty();

    $("span#emailCheckResult").empty();

    $("input#userid").val("");
    $("input#pwd").val("");
    $("input#pwdcheck").val("");
    $("input#email").val("");
    $("input#name").val("");
    $("input#hp2").val("");
    $("input#hp3").val("");
    $("input#postcode").val(""); 
    $("input#datepicker").val(""); 
    $("input#address").val(""); 
    $("input#detailaddress").val(""); 
    $("input#extraaddress").val(""); 
    */

}   // end of function goReset(){}------------

function goGaib() {
    alert("회원가입에 대한 유효성검사를 한후에 통과되면 submit 하려고 함");
 }