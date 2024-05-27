<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 형변환 해줄때  --%>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<jsp:include page="../header.jsp" />


<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/iceSearch.css" />

<%-- 직접 만든 JS --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>



<script type="text/javascript">
	$(document).ready(function(){
		
		if( "${requestScope.searchWord}" != ""	) {
				$("input:text[name='searchWord']").val("${requestScope.searchWord}");
		}
		
		if( "${requestScope.sizePerPage}" != "" ) {
			$("select[name='sizePerPage']").val("${requestScope.sizePerPage}");
		}
		
		$("input:text[name='searchWord']").bind("keydown", function(e){
			
			if(e.keyCode == 13){
				goSearch();
			}
			
		});
		
		
		
		// **** select 태그에 대한 이벤트는 click 이 아니라 change 이다. **** // 
		$("select[name='sizePerPage']").bind("change", function(){
			const frm = document.member_search_frm;
		//	frm.action = "memberList.up";  // form 태그에 action 이 명기되지 않았으면 현재보이는 URL 경로로 submit 되어진다. 
		//	frm.method = "get";  // form 태그에 method 를 명기하지 않으면 "get" 방식이다. 
			frm.submit();
		});
		
		
		// **** 특정 회원을 클릭하면 그 회원의 상세정보를 보여주도록 한다. **** //
		$("div.hoverBorder").click( e => {
			// alert($(e.target).parent().html());
		 //	const userid = $(e.target).parent().find(".userid").text(); 
		 // 또는
		     const iceName = $(e.target).parent().find(".iceName").text();	
             alert(iceName);
     
	        const frm = document.member_search_frm;
	        frm.iceName.value = iceName;
		    
	  		frm.action = "<%= ctxPath%>/product/menuDetail.ice"; 
		    frm.method = "get";
		    frm.submit();
		});
		
		<%--  .jsp 파일에서 사용되어지는 것들 
		  console.log('${pageContext.request.contextPath}');  // 컨텍스트패스   /MyMVC
		  console.log('${pageContext.request.requestURL}');   // 전체 URL     http://localhost:9090/MyMVC/WEB-INF/member/admin/memberList.jsp
		  console.log('${pageContext.request.scheme}');       // http        http
		  console.log('${pageContext.request.serverName}');   // localhost   localhost
		  console.log('${pageContext.request.serverPort}');   // 포트번호      9090
		  console.log('${pageContext.request.requestURI}');   // 요청 URI     /MyMVC/WEB-INF/member/admin/memberList.jsp 
		  console.log('${pageContext.request.servletPath}');  // 파일명       /WEB-INF/member/admin/memberList.jsp 
		--%>
		
});// end of $(document).ready(function(){})------------------

function goSearch(){
	
	const searchWord = $("input:text[name='searchWord']").val();
	
	if(searchWord == "") {
		alert("검색대상을 입력하세요!!");
		return; // goSearch() 함수를 종료한다.
	}
	
	const frm = document.member_search_frm;
//	frm.action = "memberList.up";  // form 태그에 action 이 명기되지 않았으면 현재보이는 URL 경로로 submit 되어진다. 
//	frm.method = "get";  // form 태그에 method 를 명기하지 않으면 "get" 방식이다. 
	frm.submit();
}// end of function goSearch(){}-----------------------

		
</script>








    <div class="container pt-5" >
      <h2 class="page-header__title">Search</h2>
      <h2 id="search_result" > <%-- ${requestScope.검색어}  --%> 검색결과 총 <%-- ${requestScope.검색결과개수} --%> 건</h2>
      
      
      
      <form name="member_search_frm">
      
      <input type="text" name="searchWord" />
		<%--
	          form 태그내에서 데이터를 전송해야 할 input 태그가 만약에 1개 밖에 없을 경우에는
	          input 태그내에 값을 넣고나서 그냥 엔터를 해버리면 submit 되어져 버린다.
	          그래서 유효성 검사를 거친후 submit 을 하고 싶어도 input 태그가 만약에 1개 밖에 없을 경우라면 
	          유효성검사가 있더라도 유효성검사를 거치지 않고 바로 submit 되어진다. 
	          이것을 막으려면 input 태그가 2개 이상 존재하면 된다.  
	          그런데 실제 화면에 보여질 input 태그는 1개 이어야 한다.
	          이럴 경우 아래와 같이 해주면 된다. 
	          또한 form 태그에 action 이 명기되지 않았으면 현재보이는 URL 경로로 submit 되어진다.   
        --%>
        <input type="text" style="display: none;" /> <%-- 조심할 것은 type="hidden" 이 아니다. --%> 
		
		<button type="button" class="btn btn-secondary" onclick="goSearch()">검색</button>
      
      
	      <span style="font-size: 12pt; font-weight: bold;">페이지당 아이스크림수&nbsp;-&nbsp;</span>
	      <select name="sizePerPage">
	         <option value="10">12개</option>
	         <option value="5">8개</option>
	         <option value="3">4개</option>      
	      </select>
   	  </form>
   	  
   	  
   	 
	<c:if test="${not empty requestScope.memberList}">
       <c:forEach var="membervo" items="${requestScope.memberList}" varStatus="status">
       
        
      
      
       <fmt:parseNumber var="currentShowPageNo" value="${requestScope.currentShowPageNo}" />
        <fmt:parseNumber var="sizePerPage" value="${requestScope.sizePerPage}" /> 
        <%-- fmt:parseNumber 은 문자열을 숫자형식으로 형변환 시키는 것이다. 
        <div class="col-md-3">${(requestScope.totalMemberCount) - (currentShowPageNo - 1) * sizePerPage - (status.index)}</div>
       --%>
       
       
                
        
        
        </c:forEach>
	</c:if>
        
        
       
      
      
      <%-- 페이징 처리
      
            <c:if test="${!empty requestScope.아이스크림총개수}">
             <c:forEach var="membervo" items="${requestScope.아이스크림총개수}" varStatus="status"> fvarStatus="status"  인덱스 
                   <tr>
                      
                      <fmt:parseNumber var="currentShowPageNo" value="${requestScope.currentShowPageNo}" />
                      <fmt:parseNumber var="sizePerPage" value="${requestScope.sizePerPage}" />
                       fmt:parseNumber 은 문자열을 숫자형식으로 형변환 시키는 것이다. 
                      
                      <td>${(requestScope.아이스크림총개수) - ( currentShowPageNo - 1 ) * sizePerPage - (status.index)}</td> status.index"  인덱스 가져오깅    currentShowPageNo는 컨트롤러에서 string으로 했기때문에 빼기하려면 타입바꿔줘야함  
                           페이징 처리시 보여주는 순번 공식 
                           데이터개수 - (페이지번호 - 1) * 1페이지당보여줄개수 - 인덱스번호 => 순번 
                       
                       
                      <td>${membervo.샤베트}</td>
                      <td>${membervo.심플}</td>
                      <td>${membervo. ...}</td>
                      
                   </tr>
             </c:forEach>
          </c:if>
          
          <c:if test="${empty requestScope.아이스크림리스트}">
                <td colspan="5">데이터가 존재하지 않습니다</td>
          </c:if>
      
    --%>
      
      <%-- 페이지 바
      <div aria-label="Page navigation" class="pn">
	   <div class="pagination" >
		  <a href="#">&laquo;</a>
		  <a href="#">1</a>
		  <a class="active" href="#">2</a>
		  <a href="#">3</a>
		  <a href="#">4</a>
		  <a href="#">5</a>
		  <a href="#">6</a>
		  <a href="#">&raquo;</a>
		</div>
      </div> --%>
      
      
      
    <c:if test="${empty requestScope.memberList}">
	    <div class="row pt-5">데이터가 존재하지 않습니다.</div>
	</c:if>
      
      
      
    <div id="pageBar">
	    <nav>
	    	<ul class="pagination">${requestScope.pageBar}</ul>
	    </nav>
    </div>
    
    
      
 </div>
 
 
 <form name="memberOneDetail_frm">
   <input type="hidden" name="userid" />
   <input type="hidden" name="goBackURL" value="${requestScope.currentURL}" />
</form>


  
<%-- Header 마무리에 따라 div 추가 닫기 --%>
<jsp:include page="../footer.jsp" />