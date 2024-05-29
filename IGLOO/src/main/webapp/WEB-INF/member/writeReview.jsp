<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 형변환 해줄때  --%>
    
   
<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>    
      
      

<%-- Required meta tags --%> 
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQuery UI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/editReview.css" />   




<div class="container">
	<form id="review_write_info" data-save="/dataupdate/saveReview" action="/dataupdate/isWritable" method="post" > 
	<div class="sf_close_pannel"> 
	<button type="button" class="btn board">
	<img src="https://cdn.snapfit.co.kr/review/images/board_white.png">
	</button> 
	<div class="title">리뷰 작성</div> 
	<button type="button" class="btn close">
	<img src="https://cdn.snapfit.co.kr/review/images/close.png">
	</button> <div class="sf_displaynone"> 
	<input id="token" name="token" type="hidden" value="oLnFwcu9nRx6rRYCpBpcai4Ic+MNgKhIWkjbplEiMSPsIGw89TJHMLjOUeLT21DqltBG4hJjdkem/jRaCvrU+/WRYOKBq8zVZPNPLIVfCs8dBZWgzQrtI+8n1RjJFMCe"> 
	<input id="sea" name="Sea" type="hidden" value="cEXWSuqnQCBpjD%2FVC3MGOuef6fR0ndx4FcAFbPdEGNC0kAZq6CXsKtfl6sGrs%2BTVNgVAZcNHc%2BpAMifkBXgsEc0fLj6rkCqRnceXzy3R6zd2Aye%2BFHN8iu166W870oPhJIO2NqRGv3TDUpMXh4YT7GXy63mZrRvm5ejMlClImUPTDrImpZiYossl7d%2BTRJQO8Rt%2BXej1guejnLeVJmfRZQ%3D%3D"> 
	<input id="store_username" name="store_username" type="hidden" value="wojIsh8abhFX1yI6O2wseQ%3D%3D"> 
	<input id="review_id" name="review_id" type="hidden" value=""> 
	<input id="item_id" name="item_id" type="hidden" value="2901"> 
	<input id="order_id" name="order_id" type="hidden" value="20210302-0009393-01"> 
	<input id="is_edit" name="is_edit" value="0" type="hidden"> 
	<input id="write_complete" name="write_complete" value="0" type="hidden"> 
	<input id="write_platform" name="write_platform" type="hidden" value="pc"> 
	<input id="need_upload" name="need_upload" value="0" type="hidden"> 
	<input id="upload_complete" name="upload_complete" value="0" type="hidden"> 
	<input id="upload_token" name="upload_token" type="hidden"> 
	<input id="is_simple" name="is_simple" value="0" type="hidden"> 
	<input id="list_page" name="list_page" value="0" type="hidden"> 
	<input id="list_info" name="list_info" value="0" type="hidden"> 
	<input id="delete_content" name="delete_content" value="" type="hidden"> 
	</div> 
	</div> 
	<div class="sf_popup_wrapper"> 
	<div id="swiper_order_list" class="sf_order_list_wrap"> 
	<span class="owl-carousel-nav prev">
	</span> 
	<div class="sf_order_list owl-carousel owl-loaded">
	<div class="owl-stage-outer">
	<div class="owl-stage" style="transition: all 0s ease 0s; width: 277px; transform: translate3d(0px, 0px, 0px);">
	<div class="owl-item active center" style="width: 276.5px;">
	<div class="sf_order_item" data-item_id="2901" data-order_id="20210302-0009393-01"> 
	<div class="thumbnail"> 
	<img src="https://98doci.com/web/product/medium/202009/06e980477835b7747b8e94418e18ea73.gif" class=""> 
	</div> 
	<div class="sf_buy_option"> 
	<div class="sf_review_item_name sf_one_line">팝스 와이드 데님 - 2 color</div> 
	<div class="sf_review_user_useally_selected_option sf_one_line">
	<div id="" class="option"> 
	<span class="size_wrap"> 
	<span class="key">색상</span> 
	<span class="separ"> : </span> 
	<span class="value">연청</span> 
	</span> 
	<span class="unit"></span> </div><div id="" class="option"> <span class="size_wrap"> <span class="key">사이즈</span> <span class="separ"> : </span> <span class="value">S</span> </span> <span class="unit"></span> </div></div> </div> </div></div></div></div><div class="owl-nav disabled"><button type="button" role="presentation" class="owl-prev"><span aria-label="Previous">‹</span></button><button type="button" role="presentation" class="owl-next"><span aria-label="Next">›</span></button></div><div class="owl-dots disabled"><button role="button" class="owl-dot active"><span></span></button></div></div> <span class="owl-carousel-nav next"></span> </div> <div class="main_score"><div class="score_info"> <div class="title_info clearfix"> <div class="necessary_wrap"><span class="necessary_point"></span></div> <p class="title">리뷰 평점</p> <div class="pannel clearfix"> <input class="score" name="score[]" type="hidden" value="5"> <div class="star_info"> <span class="pin_custom_font_color star">★</span> <span class="pin_custom_font_color star">★</span> <span class="pin_custom_font_color star">★</span> <span class="pin_custom_font_color star">★</span> <span class="pin_custom_font_color star">★</span> </div> <span class="now_score">5</span> <button type="button" class="btn more view_right sf_displaynone"></button> <span class="now_score_text view_right sf_displaynone">아주 좋아요</span> </div> </div> <div class="score_detail sf_displaynone"> <div id="" class="score_item" data-score="1"> <span class="score_text">별로에요</span> </div><div id="" class="score_item" data-score="2"> <span class="score_text">그냥 그래요</span> </div><div id="" class="score_item" data-score="3"> <span class="score_text">보통이에요</span> </div><div id="" class="score_item" data-score="4"> <span class="score_text">맘에 들어요</span> </div><div id="" class="score_item" data-score="5"> <span class="score_text">아주 좋아요</span> </div></div> </div></div> <div class="sf_write_wrap"> <div class="login_info"> <div class="login_data clearfix user_name"> <p class="title">이름</p> <input class="value" name="login[name]" type="text"> </div> <div class="login_data clearfix user_pass"> <p class="title">비밀번호</p> <input class="value" name="login[password]" type="password"> </div> </div> <div class="sf_write"> <p class="title">내용을 적어주세요</p> <input class="default_value" name="review_default_text" type="hidden" value=""> <textarea class="value" placeholder="리뷰를 적어주세요. :)" name="review_text"></textarea> <div class="bottom"> <p class="line"> <span class="start_text">현재</span> <span class="length">0</span> </p> <p class="line sf_displaynone"> <span class="need">30</span> <span class="end_text">자만 더쓰면 +<span class="mileage">500</span>원 이에요!</span> </p> </div> </div> </div> <div class="sf_media"> <div class="contents clearfix"> <div class="content content_wrap"> <div class="inner"> <div class="photo"> <img src="https://cdn.snapfit.co.kr/review/images/image.png"> </div> </div> </div> </div> <div class="select_content_type sf_displaynone"> <div class="popup_title">미디어 첨부</div> <button class="btn close_content" type="button"><img src="https://cdn.snapfit.co.kr/review/images/icons/cancel_image_X.png"></button> <button class="btn upload_content content_photo" type="button">사진 첨부</button> <button class="btn upload_content content_media" type="button">동영상 첨부</button> </div> </div> <div class="sub_score_wrap sf_displaynone"> <div class="sub_score"></div> </div> <div class="sf_elements_wrap folded"> <p class="title">다른 고객님들을 위해서 추가정보를 작성해주세요.(<span class="type">선택</span>)</p> <div class="sf_elements_btn_area"><button type="button" class="btn more view_right"></button></div> <div class="sf_elements"><div id="" class="element clearfix" data-id="90" data-is_necessary="0"> <div class="necessary_wrap"><span class="necessary_point"></span></div> <p class="key">사이즈 어때요?</p> <div class="value_wrap"> <input class="value" name="element[90][single]" type="hidden"> <input class="value_input text sf_displaynone" type="text"> <input class="value_input num sf_displaynone" type="number"> <select class="value_select_wrap"><option value="">사이즈 어때요? 입력해주세요</option><option value="많이 작아요"><span id="" class="element_value" data-value="많이 작아요">많이 작아요</span></option><option value="조금 작아요"><span id="" class="element_value" data-value="조금 작아요">조금 작아요</span></option><option value="잘 맞아요"><span id="" class="element_value" data-value="잘 맞아요">잘 맞아요</span></option><option value="조금 커요"><span id="" class="element_value" data-value="조금 커요">조금 커요</span></option><option value="많이 커요"><span id="" class="element_value" data-value="많이 커요">많이 커요</span></option></select> </div> </div><div id="" class="element clearfix" data-id="91" data-is_necessary="0"> <div class="necessary_wrap"><span class="necessary_point"></span></div> <p class="key">사이즈 한줄평</p> <div class="value_wrap"> <input class="value" name="element[91][single]" type="hidden"> <input class="value_input text" type="text" data-length="1000" maxlength="1000" placeholder="사이즈 한줄평을 입력해주세요"> <input class="value_input num sf_displaynone" type="number"> <select class="value_select_wrap sf_displaynone"></select> </div> </div><div id="" class="element clearfix" data-id="92" data-is_necessary="0"> <div class="necessary_wrap"><span class="necessary_point"></span></div> <p class="key">키</p> <div class="value_wrap"> <input class="value" name="element[92][range]" type="hidden"> <input class="value_input text sf_displaynone" type="text"> <input class="value_input num" type="number" data-min="0" data-length="9" max="999999999" placeholder="키를 입력해주세요"> <select class="value_select_wrap sf_displaynone"></select> </div> </div><div id="" class="element clearfix" data-id="93" data-is_necessary="0"> <div class="necessary_wrap"><span class="necessary_point"></span></div> <p class="key">몸무게</p> <div class="value_wrap"> <input class="value" name="element[93][range]" type="hidden"> <input class="value_input text sf_displaynone" type="text"> <input class="value_input num" type="number" data-min="0" data-length="9" max="999999999" placeholder="몸무게를 입력해주세요"> <select class="value_select_wrap sf_displaynone"></select> </div> </div><div id="" class="element clearfix" data-id="94" data-is_necessary="0"> <div class="necessary_wrap"><span class="necessary_point"></span></div> <p class="key">평소사이즈</p> <div class="value_wrap"> <input class="value" name="element[94][single]" type="hidden"> <input class="value_input text sf_displaynone" type="text"> <input class="value_input num sf_displaynone" type="number"> <select class="value_select_wrap"><option value="">평소사이즈를 입력해주세요</option><option value="XS"><span id="" class="element_value" data-value="XS">XS</span></option><option value="S"><span id="" class="element_value" data-value="S">S</span></option><option value="M"><span id="" class="element_value" data-value="M">M</span></option><option value="L"><span id="" class="element_value" data-value="L">L</span></option><option value="XL"><span id="" class="element_value" data-value="XL">XL</span></option></select> </div> </div></div> </div> <div class="sf_agree_privacy_wrap folded"> <div class="sf_agree_privacy_head"> <input type="checkbox" class="sf_check_agree_privacy"> <p class="title">리뷰 수집 및 사용 권한 동의</p> <button type="button" class="btn more view_right"></button> </div> <div class="sf_agree_privacy_detail sf_displaynone"> <p class="sf_agree_privacy_text">
	     
	     
	     
	     
	     
	     
	     
	     
	     <h2>리뷰 작성</h2>
	     <hr>
		 <br><br>
		 
	     <p>리뷰사진, 별점, 리뷰내용만 수정</p> 
	     
	       <div class="review">
	        <div class="sumarry">
	          <div class="img-container">
	            <img src="<%= ctxPath%>/images/img_hj/cup_size/pint.png"/>
	          </div>
	          <div class="option-container">
	            <h3>파인트</h3>
	          	
	            <ul>
	              <li>초코나무숲</li>
	              <li>초코나무숲</li>
	              <li>초코나무숲</li>
	            </ul>
	          </div>
	        </div>
	        <div class="content" >
	          <div class="bind">
	            <h3>이글루 ...점</h3>
	          </div>
	          <div class="reviewImgs">
				<i class="fa-solid fa-image fa-10x"></i><%-- 리뷰사진 없을때 --%>
	          </div>
	          <div class="star">☆☆☆☆☆&nbsp;&nbsp;
	            <span class="date">2024.05.14</span>
	          </div>
	          <div class="form-floating">
				  <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 100px">맛도리</textarea>
				  <label for="floatingTextarea2"></label>
			  </div>
	        </div>
	        <div id="btnSubmit">
	      		<input type="button" class="btn btn-success" value="수정하기" onclick="goEdit()" />
	      	</div>
	      </div>
	</form>
</div>















