$(document).ready(function(){
    
    // 버튼 클릭과 엔터 클릭 할 시 로그인 시도하는 함수 만들기
    $("button#btnSubmit").click(function(){
        goLogin();      // 로그인 시도
        location.href="javascript:history.go(-1)";
    })

    $("input#loginPwd").bind("keydown",function(e){

        if(e.keyCode == 13){    // 암호 입력란에 엔터를 했을 경우
            goLogin();      // 로그인 시도
        }

    })  // end of $("input#loginPwd").bind("keydown",function(e){})-------

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // === 아이디 찾기 버튼 === //
    $("button.idFindClose").click(function(){

        const iframe_idFind = document.getElementById("iframe_idFind");     
        
        const iframe_window = iframe_idFind.contentWindow;                  
        
        iframe_window.func_form_reset_empty();

    })  // end of $("button.idFindClose").click(function(){})-------------

    // === 비밀번호 찾기 버튼 === //
    $("button.passwdFindClose").click(function(){
    
        javascript:history.go(0);

    })  // end of $("button.passwdFindClose").click(function(){})----------------------

})  // end of $(document).ready(function(){})--------------------

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// === Function Declaration === //

// === 로그인 처리 함수 === //
function goLogin(){
    
    // alert("확인용 => 로그인 처리 진행");

    // === 아이디, 비번 입력하지 않은 경우 === //
    if($("input#loginUserid").val().trim() == ""){
        alert("아이디를 입력하세요!!");
        $("input#loginUserid").val("").focus();
        return;     // goLogin() 함수 종료
    }

    if($("input#loginPwd").val().trim() == ""){
        alert("암호를 입력하세요!!");
        $("input#loginPwd").val("").focus();
        return;     // goLogin() 함수 종료
    }

/////////////////////////////////////////////////////////////////////////////////////

    // === 로그인을 하지 않은 상태일 때 
    if($("input:checkbox[id='saveid']").prop("checked")){   // 체크하였으면
        // alert("아이디 저장 체크를 하였습니다.");
        localStorage.setItem('saveid',$("input#loginUserid").val());
    }
    else{
        // alert("아이디 저장 체크를 해제 하였습니다.");
        localStorage.removeItem('saveid');
    }
    	
    const frm = document.loginFrm;
    frm.submit();   // () 반드시 쓰기!

}   // end of function goLogin(){}-----------------

