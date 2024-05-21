
$(document).ready(function(){
		
    $("button#btnDel").click(function(){
        alert("작성한 리뷰를 삭제합니다.");
    });

    $("button#btnEdit").click(function(){
        alert("작성한 리뷰를 수정합니다.");

        goEditReview(); 

    });

    



    //$("span#btnAbleReview").click(function(){
		 
        
        // $.ajax({
        //     url:"ableReview.ice",
        //     data:{"reviewstatus":reviewstatus,
        //           "userid":userid}, // data 속성은 http://localhost:9090/MyMVC/member/emailDuplicateCheck.up 로 전송해야할 데이터를 말한다. 
        //     type:"post",  //  type 을 생략하면 type:"get" 이다.
            
        //     async:true,   // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
        //                    // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.   
            
        //     dataType:"json", // Javascript Standard Object Notation.  dataType은 /MyMVC/member/emailDuplicateCheck.up 로 부터 실행되어진 결과물을 받아오는 데이터타입을 말한다. 
        //                       // 만약에 dataType:"xml" 으로 해주면 /MyMVC/member/emailDuplicateCheck.up 로 부터 받아오는 결과물은 xml 형식이어야 한다. 
        //                       // 만약에 dataType:"json" 으로 해주면 /MyMVC/member/emailDuplicateCheck.up 로 부터 받아오는 결과물은 json 형식이어야 한다. 
             
        //     success:function(json){
                
        //         if(json.isExists) {
        //             // 입력한 email 이 이미 사용중이라면
        //             $("span#emailCheckResult").html($("input#email").val() + " 은 이미 사용중 이므로 다른 이메일을 입력하세요").css({"color":"red"}); 
        //             $("input#email").val(""); 
        //         }
        //         else {
        //             // 입력한 email 이 존재하지 않는 경우라면 
        //             $("span#emailCheckResult").html($("input#email").val() + " 은 사용가능 합니다").css({"color":"navy"});  
        //         }
                
        //     },
            
        //     error: function(request, status, error){
        //            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        //     }
        // });
        
   // });	
    
    });// end of $(document).ready(function(){})----------------------










function goEditReview(userid, ctxPath){

        //리뷰 수정 팝업창 띄우기
        const url = `${ctxPath}/member/editReview.ice?userid=${userid}`;

        // 너비 750, 높이 670 인 팝업창을 화면 가운데 위치시키기
        const width = 850;
        const height = 670;
    
        const left = Math.ceil( (window.screen.width - width)/2 ) //window.screen.width 내 화면 넓이   //Math.ceil() 정수로만듬
        //           1400 - 650 = 750/2 => 375
    
    
        const top = Math.ceil( (window.screen.height - height)/2 ) //window.screen.width 내 화면 넓이   //Math.ceil() 정수로만듬
        //           900 - 570 = 330/2 => 165
    
    
        window.open(url, "editReview",
                    `left=${left}, top=${top}, width=${width}, height=${height}`); //팝업띄우기
    
}//end of function goEditReview(userid, ctxPath)---------------------------------




