$(document).ready(function(){

    // showMore("1");

})  // end of $(document).ready(function(){------------

///////////////////////////////////////////////////////////////

// === Function Declaration === //
let More_length = 5;
/*
function showMore(start){
    
    $.ajax({
        url:""      // mallDisplayJSON.up   -> url 생성한 후 properties 하고, 파일 생성[MyMVC 에 MallDisplayJSON 참고]
        , type:"post"
        , data:{"start":start
            , "len":More_length        
        }
        , dataType:"json"
        , success:function(json){
            const str_json = JSON.stringify(json);  // json 객체를 string 타입으로 변경
            // console(typeof str_json);    // string
            // console(str_json);

            let v_html = ``;

            $.each(json, function(index, item){
                v_html += ``;

                // 주문내역 결과 쌓기
                $("주문내역들어갈 위치").append(v_html);
            })
        }
        // 잘못되어지면 알람
        , error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
    })
    

}   // end of function showMore(start)------------
*/