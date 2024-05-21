<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
    String productimg = request.getParameter("productimg");
    String productname = request.getParameter("productname");
    String productprice = request.getParameter("productprice");
    
%>

<jsp:include page="../header.jsp" />

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/order/order_detail.css" />

<script type="text/javascript">
	$(document).ready(function() {
		
	 	$("select[id='taste']").change(function(){
			//console.log("value 확인 => ",$(this).val()); //value값 가져오기
			//console.log("선택된 select 태그 확인 => ", $("select[name='taste'] option:selected").text()); //text값 가져오기
			
			const selecttaste = $("select[id='taste'] option:selected").text();
			console.log("selecttaste 선택한 맛 => ", selecttaste); // 떴음
						
			$("span#selecttaste").text(selecttaste);
			
			
			const status = $(e.target).parent().parent().find("#status").text();
			console.log("확인용 status : ", status);
			
			//const status = $("input[name='status']").text();
			//console.log("확인용 status : ", status)
			
			//$("input[name='status']").val(status);
			
			// 선택된 값의 index를 불러오기
			//var index = $("#taste option").index($("taste option:selected"));
			//console.log("선택된 index => ", index);
			
			
			
		});  
	 	
		/* $("#taste").change(function(){
		    // Value값 가져오기
		    var val = $("#taste :selected").val();
		    // Text값 가져오기
		    var text = $("#taste :selected").text();
		    $("span#selecttaste").text(text);
		    var index = $("#taste :selected").index();
		    
		    console.log("@@확인용 val => ", val);
		    console.log("@@확인용 text => ",text);
		    console.log("@@확인용 index => ",index);
		   
		});  */
			
		
	});// end of $(document).ready(function() {})
	
	/* 
	function changeSelect(){
	    var langSelect = document.getElementById("selectbox");
	     
	    // select element에서 선택된 option의 value가 저장된다.
	    var selectValue = langSelect.options[langSelect.selectedIndex].val;
	 
	    // select element에서 선택된 option의 text가 저장된다.
	    var selectText = langSelect.options[langSelect.selectedIndex].text;
	    
	    console.log("확인용 langSelect : ",langSelect);
	    console.log("확인용 selectValue : ",selectValue);
	    console.log("확인용 selectText : ",selectText);
	}
	 */
	
</script>



<div class="container contents">

  <form name="orderDetailFrm">

	<div id="imgdiv" class="row">
	  
		<%-- <div id="item_img" class="col-xl-5 col-lg-5">
			<img id="cupsize" src="<%= ctxPath%>/images/images_younggwan/cupsize.png" style="width: 300px; height: 350px; border: solid 1px red;" alt="Responsive image"/>
		</div> --%>
		 
		<img src="<%= ctxPath%>/images/img_yejin/cup_size/${requestScope.imgList}" class="card-img-top" style="height: 50%;" alt="사진경로잘못됨">
		
		<div id="item_detail">
			<div class="p-0  my-auto">
				<div style="font-size: 30pt;"><%= productname%></div>
				<h6 style="font-size: 27pt; text-align: right;"><%= productprice%>원</h6>
			</div>
			<hr style="border: solid 1px #81BEF7;">
	  
			<div class="dropdown-label" style="font-weight: bold; font-size: 15pt;">
			    이글루 할래용
		    </div>
		    <hr style="border: solid 1px #81BEF7;">
		    
		<c:forEach var="tvo" items="${requestScope.tasteList}" begin="0" end="2" varStatus="status">
  			<%-- <p> id="status">${status.index}</p> --%>
  			<input type="text" name="status" ${status.index}/>
  			<select id="taste" name="selectbox" class="infoData">
			<option value="">맛을 선택하세요</option>
      			<c:forEach var="tvo" items="${requestScope.tasteList}">	
	              <option value="${tvo.tasteno}">${tvo.tastename}</option>
	              
 		        </c:forEach> 
            </select>
        </c:forEach>
      
<%-- 		<select>
			   <option value="">선택해주세요.</option>
			   <c:forEach var="list" items="${result}">
			 	  <option value="${list.beverage}" <c:if test ="${user.selectedBeberage eq list.beverage}">selected="selected"</c:if>>${list.beverage}</option>
			   </c:forEach>
			 </select>
			  --%>
			<%-- <select id="selectbox" name="selectbox" onchange="changeSelect()" class="infoData">
              <option value="">맛을 선택하세요</option>
              <c:forEach var="tvo" items="${requestScope.tasteList}">
                <option value="${tvo.tasteno}">${tvo.tastename}</option>
              </c:forEach> 
            </select>
            
			<select id="selectbox" name="selectbox" onchange="changeSelect()" class="infoData">
              <option value="">맛을 선택하세요</option>
              <c:forEach var="tvo" items="${requestScope.tasteList}">
                <option value="${tvo.tasteno}">${tvo.tastename}</option>
              </c:forEach> 
            </select> --%>
	  
	  		<hr style="border: solid 1px #81BEF7;">
  
  			<div class="row justify-content-around">
				 <div class="p-0 my-auto justify-content-center">
		 			 <h4 style="font-weight: bold;" ><%= productname%></h4>
				     <span id="selecttaste">=== 선택한 맛이 나오는 자리 ===</span> <%-- ■■■■■ 길어지면 위치 바뀜 ■■■■■--%>
				 </div>
				
				<div class="selectMenucnt justify-content-end col-xl-4 col-lg-4 col-md-2 p-0 my-auto">
	                  <div class="d-inline-block"></div>
	                  <div class="mb-5">
	                     <div>수량</div>
	                     <button type="button" class="btn ml-5">
	                        <i class="fa-solid fa-minus"></i>
	                     </button>
	                     <span>1</span>
	                     <button type="button" class="btn">
	                        <i class="fa-solid fa-plus"></i>
	                     </button>
	                  </div>
	             </div>
				 
            </div>
             
			<hr style="border: solid 1px #81BEF7;">
			
			<div class="row justify-content-between mb-3">
				<div class="col-4 text-left" style="font-weight: bold; font-size: 20pt;">합계</div>
				<div class="col-4"></div>
				<div class="col-4 text-right" style="font-weight: bold; font-size: 20pt;"><%= productprice%>원</div>
				<br>
			</div>
			
			<div id="button" class="mx-auto">
				<input type="button" class="btn btn-lg mr-5" value="장바구니" onclick="go...()" />
	            <input type="button"  class="btn btn-lg" value="구매하기" onclick="go...()" />
			</div>
		</div>
	 
	</div>
	
	<%----------------------------------------------------------------------%>
	
	<hr style="border: solid 2px #4198e8;">

	<div id="image">
	  <c:forEach var="imgDetailList" items="${requestScope.imgDetailList}">
		<div class="row justify-content-center">
			<div class="col-md-7" style="font-weight: bold;"> <img class="img-fluid" alt="..." src="<%= ctxPath%>/images/img_yejin/cup_detail/${imgDetailList.productimgBelow}"> </div>
		</div>
	  </c:forEach>
	</div>
	<hr style="border: solid 2px #4198e8;">
	<div id="image">
		<div class="row">
			<div class="col-md-3" style="font-weight: bold;">아이스크림 맛별 이미지 넣기</div>
		</div>
	</div>
	
  </form>
</div>

<jsp:include page="../footer.jsp" />
