
$(document).ready(function(){

	$('#menuAlign').val("name");

	$("span#totalCount").hide();
	$("span#count").hide();

	$('select#menuAlign').change(function(){
		$("div#displayAlign").empty();
		$("span#count").html(0);
		displayAlign("1");
	});
	

    // **** 특정 아이스크림을 클릭하면 그것의 상세정보를 보여주도록 한다. **** //
    $("div.hoverBorder").click( e => {
            alert($(e.target).html());
     //	const userid = $(e.target).parent().find(".userid").text(); 
     // 또는
        const iceName = $(e.target).parent().find(".iceName").text();	
             alert(iceName);
     
        const frm = document.align_frm;
        frm.iceName.value = iceName;
        
        frm.action = "IGLOO/product/menuDetail.ice";
        frm.method = "get";
        frm.submit();
    });



    //$("span#totalCount").hide();
    //$("span#count").hide();
   
    // HIT상품 게시물을 더보기 위하여 "더보기..." 버튼 클릭액션에 대한 초기값 호출하기 
    // 즉, 맨처음에는 "더보기..." 버튼을 클릭하지 않더라도 클릭한 것 처럼 8개의 HIT상품을 게시해주어야 한다는 말이다.
    displayAlign("1");
    

    // HIT 상품 게시물을 더보기 위하여 "더보기..." 버튼 클릭액션 이벤트 등록하기  
    $("button#btnMore").click(function(){
       
       if($(this).text() == "처음으로") {
           $("div#displayAlign").empty();
           $("span#end").empty();
           displayAlign("1");
           $(this).text("MORE🍦");
       }
       else {
            displayAlign($(this).val());
           // displayHIT("9");   첫번째로 더보기를 클릭한 경우
           // displayHIT("17");  두번째로 더보기를 클릭한 경우
           // displayHIT("25");  세번째로 더보기를 클릭한 경우
           // displayHIT("33");  네번째로 더보기를 클릭한 경우
       }
    });
   
}); // end of $(document).ready(function(){})-------------------


// Function Declaration

let lenAlign = 8;
// HIT 상품 "더보기..." 버튼을 클릭할때 보여줄 상품의 개수(단위)크기 

function displayAlign(start) { // start가  1 이라면   1~ 8  까지 상품 8개를 보여준다.
                            // start가  9 이라면   9~16  까지 상품 8개를 보여준다.
                            // start가 17 이라면  17~24  까지 상품 8개를 보여준다.
                            // start가 25 이라면  25~32  까지 상품 8개를 보여준다.
                            // start가 33 이라면  33~36  까지 상품 4개를 보여준다.(마지막 상품)
	
	const menuAlign = $("select[name='menuAlign']").val();

   $.ajax({
       url:"displayIceJSON.ice",
       data:{
             "menuAlign": menuAlign,
             "start":start,  //  "1"  "9"  "17"  "25"  "33"
             "len":lenAlign},  //   8    8     8     8     8 
       dataType:"json",
       success:function(json){
           	
       
          let v_html = ``;

          if(start == "1" && json.length == 0) {
               // 처음부터 데이터가 존재하지 않는 경우
 
               v_html = `현재 상품 준비중 입니다...`;
               $("div#displayAlign").html(v_html);
           }
           
           else if(json.length > 0) {
               // 데이터가 존재하는 경우 

               $.each(json, function(index, item){
                   v_html += `<div class='col-md-3'>
                                    <div class='hoverBorder' >
                                        <a href='/IGLOO/product/menuDetail.ice?tasteno=${item.tnum}'>
                                            <img src='/IGLOO/images/img_taste/${item.timg}' class='menu-list__image' class='img-fluid mx-auto d-block' alt='슈팅톡톡' />    
                                            <span class='menu-list__hash' >${item.tgredi}</span>
                                        </a>
                                    </div>
                                    <div class='iceName text-center pt-3'>${item.tname}</div>
                                </div> `;
               });// end of $.each(json, function(index, item){})--------------
            
               // HIT 상품 결과를 출력하기
               $("div#displayAlign").append(v_html);

               // !!!!! 중요 !!!!!
               // 더보기... 버튼의 value 속성에 값을 지정하기
               $("button#btnMore").val(Number(start) + lenAlign);
               // 더보기... 버튼의 value 값이  "9" 로 변경된다.
               // 더보기... 버튼의 value 값이 "17" 로 변경된다.
               // 더보기... 버튼의 value 값이 "25" 로 변경된다.
               // 더보기... 버튼의 value 값이 "33" 로 변경된다.
               // 더보기... 버튼의 value 값이 "41" 로 변경된다.(존재하지 않는 것이다)

               // span#countHIT 에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
               $("span#count").text(Number($("span#count").text()) + json.length); 

               // 더보기... 버튼을 계속해서 클릭하여 countHIT 값과 totalHITCount 값이 일치하는 경우 
               if( $("span#count").text() == $("span#totalCount").text() ) {
                   $("span#end").html("더이상 조회할 제품이 없습니다.");
                   $("button#btnMore").text("처음으로");
                   $("span#count").text("0");
               }

           }// end of else if(json.length > 0)--------------------- 

       },       
       error: function(request, status, error){
           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
       } 
   });	
			 
}
