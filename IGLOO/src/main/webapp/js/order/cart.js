$(document).ready(function() {
    
    // === 전체선택/ 해제 버튼 클릭 === //
    $("div.totalSelect > input#Allchecked").change(function(){

        let checkboxtotal = $(this).prop("checked");
        $("input[name='choicemenu']").prop("checked",checkboxtotal);

        // === 체크박스의 체크한 수량 적용시키기 === //
        let checkboxcnt = $("input:checkbox[name='choicemenu']:checked").length;

        $("span.choiceCnt").html(checkboxcnt);

    })  // end of $("div.totalSelect > input#Allchecked").change(function(){------

    $("div.choiceOneMenu").click(function() {
        // === 체크박스가 아닌 그림이나 글씨 등 옆쪽 선택시 체크박스 선택되게 하기 === //
        var checkbox = $(this).prev("input[type='checkbox']");
        checkbox.prop("checked", !checkbox.prop("checked"));

        // === 하위 체크박스 여부의 따라 전체 체크박스 체크 변동 === //
        let checkboxlist= document.querySelectorAll("input[name='choicemenu']");

        let is_all_checked = true;

        for(let checkbox of checkboxlist){

            if(!checkbox.checked){
                $("div.totalSelect > input#Allchecked").prop("checked",false);
                is_all_checked = false;
                break;
            }

            is_all_checked = true;

        }   // end of for----------

        if(is_all_checked){
            $("div.totalSelect > input#Allchecked").prop("checked",true);
        }

        // === 체크박스의 체크한 수량 적용시키기 === //
        let checkboxcnt = $("input:checkbox[name='choicemenu']:checked").length;

        $("span.choiceCnt").html(checkboxcnt);

    })  // end of $("div.choiceOneMenu").click(function() {-------------
/*    
    // === 수량 === //
    let cnt = Number($("span.productCnt").text());

    $("button.btnminus").click(function(){

        if(cnt > 1){
            cnt--;
            $("span.productCnt").text(cnt);    
        }
        $("input[type='checkbox']").prop("checked",true);

    })  // end of $("button.btnminus").click(function(){})-------------

    $("button.btnplus").click(function(){

        cnt++;
        $("span.productCnt").text(cnt);
        $("input[type='checkbox']").prop("checked",true);

    })  // end of $("button.btnplus").click(function(){})-------------
*/  
})  // end of $(document).ready(function() {--------------

///////////////////////////////////////////////////////////////////////



