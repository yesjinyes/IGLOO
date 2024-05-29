$(document).ready(function(){
	
	$("input[name='store_search']").keyup(function(e){
		if(e.keyCode == 13){
			goSearch();
		}
	});
	
});     // end of $(document).ready(function(){------------------

//////////////////////////////////////////////////////////////////////////////////////////////

// === 매장 검색 === //
function goSearch(){
	
    $("div#nostoresearch").hide();

	const searchInput = $("input[name='store_search']").val();

    const ctxPath = $("div#ctxPath").text();

	if(searchInput == ""){
		alert("검색어를 입력하세요.");
		return;
	}
	
	$.ajax({
		url: "searchMapJSON.ice",
        type: "get",
        data: {"searchInput": searchInput},
        dataType: "json",
        success: function(json){
        
        	if(json.length == 0){
        		alert("검색 결과가 없습니다.");
        	}
        	
        	else{ // 검색 결과가 있을 경우
        		
        		let html = ``;
        		
        		$.each(json, function(index, item){
        			
        			html += `<div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                    <div class="card-body">
                        <div class="card-columns m-5 row">
                            <div class="card text-white col-lg-4 p-0">
                                <div class="card-body text-center ">
                                    <img src="${ctxPath}/images/img_hj/map.png" class="img-fluid" alt="Responsive image" >
                                </div>
                            </div>
                            <div class="ml-5 pt-5 col-lg-5 col-md-4">
                                <h1 class="card-text">${item.storeno}호점
                                    <br>
                                    ${item.storename}
                                </h1>
                                <p class="card-text storeinfoDetails">주소 : ${item.storeaddress}</p>
                                <p class="card-text storeinfoDetails">전화번호 : ${item.storetel}</p>
                                <p class="card-text storeinfoDetails">홈페이지 : ${item.storepage}</p>
                            </div>
                          </div>
                    </div>
                </div>`;
        			
        		});
        		
        		$("div#searchDIV").html(html);
        		
        	}

        },
        error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
    });
	
}