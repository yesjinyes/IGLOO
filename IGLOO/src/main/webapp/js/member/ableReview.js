





$(document).ready(function(){
		

    $("button#btnWrite").click(function(){
        alert("작성한 리뷰를 수정합니다.");

        goWriteReview(); 

    });


    
});// end of $(document).ready(function(){})----------------------


function goWriteReview(userid, ctxPath){

    //리뷰 수정 팝업창 띄우기
    const url = `${ctxPath}/member/writeReview.ice?userid=${userid}`;

    // 너비 750, 높이 670 인 팝업창을 화면 가운데 위치시키기
    const width = 850;
    const height = 670;

    const left = Math.ceil( (window.screen.width - width)/2 ) //window.screen.width 내 화면 넓이   //Math.ceil() 정수로만듬
    //           1400 - 650 = 750/2 => 375


    const top = Math.ceil( (window.screen.height - height)/2 ) //window.screen.width 내 화면 넓이   //Math.ceil() 정수로만듬
    //           900 - 570 = 330/2 => 165


    window.open(url, "ableReview",
                `left=${left}, top=${top}, width=${width}, height=${height}`); //팝업띄우기

}//end of function goEditReview(userid, ctxPath)---------------------------------








