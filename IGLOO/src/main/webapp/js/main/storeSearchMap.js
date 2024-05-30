$(document).ready(function(){
	
	$("input[name='store_search']").keyup(function(e){
		if(e.keyCode == 13){
			goSearch();
		}
	});
	
//////////////////////////////////////////////////////////////////////////////////////////////////////

    // 지도를 담을 영역의 DOM 레퍼런스
    var mapContainer = document.getElementById("map");

    // 지도를 생성할때 필요한 기본 옵션
    var options = {
        center: new kakao.maps.LatLng(37.5074186, 126.7749434), // 지도의 중심좌표. 반드시 존재해야함. // 지도의 가운데가 어디냐~~
        /*
            center 에 할당할 값은 kakao.maps.LatLng 클래스를 사용하여 생성한다.
            kakao.maps.LatLng 클래스의 2개 인자값은 첫번째 파라미터는 위도(latitude)이고, 두번째 파라미터는 경도(longitude)이다.
        */
        level: 9  // 지도의 레벨(확대, 축소 정도). 숫자가 클수록 축소된다. 4가 적당함.
    };

    // 지도 생성 및 생성된 지도객체 리턴
    var mapobj = new kakao.maps.Map(mapContainer, options); // div 속에 중심좌표, 축소정도를 넣어주겠다는 뜻

    // 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성함.    
    var mapTypeControl = new kakao.maps.MapTypeControl();

    // 지도 타입 컨트롤을 지도에 표시함.
    // kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미함.   
    mapobj.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

    // 지도 확대 축소를 제어할 수 있는 줌 컨트롤을 생성함.   
    var zoomControl = new kakao.maps.ZoomControl();

    // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 지도에 표시함.
    // kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 RIGHT는 오른쪽을 의미함.    
    mapobj.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

    if(navigator.geolocation) { // 요즘은 이거 잘 안써요 지원해줘서!!
        // HTML5의 geolocation으로 사용할 수 있는지 확인한다 

        // GeoLocation을 이용해서 웹페이지에 접속한 사용자의 현재 위치를 확인하여 그 위치(위도,경도)를 지도의 중앙에 오도록 한다.
        navigator.geolocation.getCurrentPosition(function(position) {
            var latitude = position.coords.latitude;   // 현위치의 위도
            var longitude = position.coords.longitude; // 현위치의 경도
            // console.log("현위치의 위도: "+latitude+", 현위치의 경도: "+longitude);
            // 현위치의 위도: 37.556594, 현위치의 경도: 126.9196313

            // 마커가 표시될 위치를 geolocation으로 얻어온 현위치의 위.경도 좌표로 한다   
            var locPosition = new kakao.maps.LatLng(latitude, longitude);

            // 마커이미지를 기본이미지를 사용하지 않고 다른 이미지로 사용할 경우의 이미지 주소 
            var imageSrc = 'http://localhost:9090/IGLOO/images/img_hj/store/current_location.png';

            // 마커이미지의 크기 
            var imageSize = new kakao.maps.Size(40, 40);

            // 마커이미지의 옵션. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정한다. 
            var imageOption = {offset: new kakao.maps.Point(15, 39)};

            // 마커의 이미지정보를 가지고 있는 마커이미지를 생성한다. 
            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

            // == 마커 생성하기 == //
            var marker = new kakao.maps.Marker({ 
                map: mapobj, 
                position: locPosition, // locPosition 좌표에 마커를 생성 
                image: markerImage     // 마커이미지 설정
            }); 

            marker.setMap(mapobj); // 지도에 마커를 표시한다

            // === 인포윈도우(텍스트를 올릴 수 있는 말풍선 모양의 이미지) 생성하기 === //

            // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능함.
            var iwContent = "<div style='padding:5px; font-size:15pt;'>현위치<br/><a href='https://map.kakao.com/link/map/현위치,"+latitude+","+longitude+"' style='color:blue;' target='_blank'>큰지도</a> <a href='https://map.kakao.com/link/to/현위치,"+latitude+","+longitude+"' style='color:blue' target='_blank'>길찾기</a></div>";

            // 인포윈도우 표시 위치     (마커와 똑같은 위치)
            var iwPosition = locPosition;

            // removeable 속성을 true 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됨
            var iwRemoveable = true; 

            // == 인포윈도우를 생성하기 == 
            var infowindow = new kakao.maps.InfoWindow({
                position : iwPosition, 
                content : iwContent,
                removable : iwRemoveable
            });

            // == 마커 위에 인포윈도우를 표시하기 == //
            infowindow.open(mapobj, marker);

            // == 지도의 센터위치를 locPosition로 변경한다.(사이트에 접속한 클라이언트 컴퓨터의 현재의 위.경도로 변경한다.)
            mapobj.setCenter(locPosition);

        });//end of navigator.geolocation.getCurrentPosition(function(position){})-----------
    }

    else {
        // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정한다.

        var locPosition = new kakao.maps.LatLng(37.5074186, 126.7749434);     

        // 마커이미지를 기본이미지를 사용하지 않고 다른 이미지로 사용할 경우의 이미지 주소 
        var imageSrc = 'http://localhost:9090/IGLOO/images/img_hj/store/map_icecreamcon.png';

        // 마커이미지의 크기 
        var imageSize = new kakao.maps.Size(34, 39);

        // 마커이미지의 옵션. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정한다. 
        var imageOption = {offset: new kakao.maps.Point(15, 39)};

        // 마커의 이미지정보를 가지고 있는 마커이미지를 생성한다. 
        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

        // == 마커 생성하기 == //
        var marker = new kakao.maps.Marker({ 
            map: mapobj, 
            position: locPosition, // locPosition 좌표에 마커를 생성 
            image: markerImage     // 마커이미지 설정
        }); 

        marker.setMap(mapobj); // 지도에 마커를 표시한다

        // === 인포윈도우(텍스트를 올릴 수 있는 말풍선 모양의 이미지) 생성하기 === //

        // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능함.
        var iwContent = "<div style='padding:5px; font-size:15pt;'>현위치<br/><a href='https://map.kakao.com/link/map/현위치,"+latitude+","+longitude+"' style='color:blue;' target='_blank'>큰지도</a> <a href='https://map.kakao.com/link/to/현위치,"+latitude+","+longitude+"' style='color:blue' target='_blank'>길찾기</a></div>";

        // 인포윈도우 표시 위치     (마커와 똑같은 위치)
        var iwPosition = locPosition;

        // removeable 속성을 true 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됨
        var iwRemoveable = true; 

        // == 인포윈도우를 생성하기 == 
        var infowindow = new kakao.maps.InfoWindow({
            position : iwPosition, 
            content : iwContent,
            removable : iwRemoveable
        });

        // == 마커 위에 인포윈도우를 표시하기 == //
        infowindow.open(mapobj, marker);
        // 위의 
        // 마커이미지를 기본이미지를 사용하지 않고 다른 이미지로 사용할 경우의 이미지 주소 
        // 부터
        // 마커 위에 인포윈도우를 표시하기 
        // 까지 동일함.

        // 지도의 센터위치를 위에서 정적으로 입력한 위.경도로 변경한다.
        mapobj.setCenter(locPosition);

    }// end of if~else------------------------------------------

    // ============ 지도에 매장위치 마커 보여주기 시작 ============ //
    // 매장 마커를 표시할 위치와 내용을 가지고 있는 객체 배열
    var positionArr = [];

    $.ajax({
        url:"storeLocationJSON.ice",     // <%= ctxPath%>/store/storeLocationJSON.ice
        async:false, // !!!!! 지도는 비동기 통신이 아닌 동기 통신으로 해야 한다.!!!!!!
        dataType:"json",
        success:function(json){
            console.log(JSON.stringify(json));
            // JSON.stringify(json) 은 자바스크립트의 객체(배열)인 json 을 string 타입으로 변경시켜주는 것이다.
            /*
                [{"storetel":"031-111-1111","lng":126.7622,"storepage":"www.igloo.bucheon.com","storename":"이글루 부천점","storeimg":"igloo_bucheon","storeaddress":"경기 부천시 원미구 석천로177번길 12","lat":37.50353,"zIndex":1}
                ,{"storetel":"032-222-2222","lng":126.7251,"storepage":"www.igloo.bupyeong.com","storename":"이글루 부평점","storeimg":"igloo_bupyeong","storeaddress":"인천 부평구 경원대로1403번길 4","lat":37.49156,"zIndex":2}
                ,{"storetel":"031-333-3333","lng":127.1166,"storepage":"www.igloo.byeollae.com","storename":"이글루 별내점","storeimg":"igloo_byeollae","storeaddress":"경기 구리시 산마루로 19 진영트윈타워주차장 A동","lat":37.63185,"zIndex":3}
                ,{"storetel":"02-444-4444","lng":126.9182,"storepage":"www.igloo.hongdae.com","storename":"이글루 홍대점","storeimg":"igloo_hongdae","storeaddress":"서울 마포구 양화로6길 76 1층","lat":37.54837,"zIndex":4}
                ,{"storetel":"031-555-5555","lng":126.9612,"storepage":"www.igloo.gunpoyh.com","storename":"이글루 군포영학점","storeimg":"igloo_gunpo","storeaddress":"경기 안양시 동안구 귀인로190번길 152 1층","lat":37.3841,"zIndex":5}]
            */

            const ctxPath = $("div#ctxPath").text();

            $.each(json, function(index,item){

                var position = {};

                position.content=`<div class="mycontent">
                                        <div class="title">
                                            <a href="${item.storepage}" target="_blank">
                                                <strong>${item.storename}</strong>
                                            </a>
                                        </div>
                                        <div class="desc">
                                            <img src="${ctxPath}/images/img_hj/store/${item.storeimg}.jpg" />
                                            <span class="address">${item.storeaddress}</span>
                                        </div>
                                    </div>`;     // 말풍선 내용물
                position.latlng = new kakao.maps.LatLng(item.lat, item.lng);       // 위도, 경도
                position.zIndex = item.zIndex;

                positionArr.push(position);

            })  // end of each----------------------
        }
        , error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }

    })  // end of $.ajax({----------------------------------

    // infowindowArr 은 인포윈도우를 가지고 있는 객체 배열의 용도이다. 
    var infowindowArr = new Array();    // new Array() 또는 []

    // === 객체 배열 만큼 마커 및 인포윈도우를 생성하여 지도위에 표시한다. === //
    for(let i=0; i<positionArr.length; i++){

        // 마커이미지를 기본이미지를 사용하지 않고 다른 이미지로 사용할 경우의 이미지 주소 
        var imageSrc = 'http://localhost:9090/IGLOO/images/img_hj/store/map_icecreamcon.png';

        // 마커이미지의 크기 
        var imageSize = new kakao.maps.Size(34, 39);

        // 마커이미지의 옵션. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정한다. 
        var imageOption = {offset: new kakao.maps.Point(15, 39)};

        // 마커의 이미지정보를 가지고 있는 마커이미지를 생성한다. 
        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

        // == 마커 생성하기 == //
        var marker = new kakao.maps.Marker({ 
            map: mapobj, 
            position: positionArr[i].latlng,    // 위도, 경도 설정
            image: markerImage
        }); 

        // 지도에 마커를 표시한다.
        marker.setMap(mapobj);

        // == 인포윈도우를 생성하기 == 
        var infowindow = new kakao.maps.InfoWindow({
            content: positionArr[i].content,
            removable: true,
            zIndex : i+1
         });

        // 인포윈도우를 가지고 있는 객체배열에 넣기 
        infowindowArr.push(infowindow);

        // == 마커 위에 인포윈도우를 표시하기 == //
        // infowindow.open(mapobj, marker);     // 틀린 경우

        // == 마커 위에 인포윈도우를 표시하기 == //
        // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
        // 이벤트 리스너로는 클로저(closure => 함수 내에서 함수를 정의하고 사용하도록 만든것)를 만들어 등록합니다 
        // for문에서 클로저(closure => 함수 내에서 함수를 정의하고 사용하도록 만든것)를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
        kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(mapobj, marker, infowindow, infowindowArr));

    }   // end of for---------------------------

    // ============ 지도에 매장위치 마커 보여주기 끝 ============ //


});     // end of $(document).ready(function(){------------------

//////////////////////////////////////////////////////////////////////////////////////////////

// === 매장 검색 === //
function goSearch(){
	
    $("div#map").hide();

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
                                    <img src="${ctxPath}/images/img_hj/store/${item.storeimg}.jpg" class="img-fluid" alt="Responsive image" >
                                </div>
                            </div>
                            <div class="ml-5 pt-3 col-lg-5 col-md-4">
                                <h1 class="card-text">
                                    <span style="color:#6190BC; font-weight:bold;">${item.storeno}호점</span>
                                    <br>
                                    <span style="font-weight:bold;">${item.storename}</span>
                                </h1>
                                <p class="card-text storeinfoDetails">
                                    <span style="font-weight:bold;">주소 : </span>
                                    ${item.storeaddress}
                                </p>
                                <p class="card-text storeinfoDetails">
                                    <span style="font-weight:bold;">전화번호 : </span>
                                    ${item.storetel}
                                </p>
                                <p class="card-text storeinfoDetails">
                                    <span style="font-weight:bold;">홈페이지 : </span>
                                    ${item.storepage}
                                </p>
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
	
}   // end of goSearch()----------------------------

///////////////////////////////////////////////////////////////////////////////////

// !! 인포윈도우를 표시하는 클로저(closure => 함수 내에서 함수를 정의하고 사용하도록 만든것)를 만드는 함수(카카오에서 제공해준것임)입니다 !! // 
function makeOverListener(mapobj, marker, infowindow, infowindowArr) {

    return function() {
       // alert("infowindow.getZIndex()-1:"+ (infowindow.getZIndex()-1));

       for(var i=0; i<infowindowArr.length; i++) {
          if(i == infowindow.getZIndex()-1) {
             infowindowArr[i].open(mapobj, marker);
          }
          else{
             infowindowArr[i].close();
          }
       }
    };
}// end of function makeOverListener(mapobj, marker, infowindow, infowindowArr)--------