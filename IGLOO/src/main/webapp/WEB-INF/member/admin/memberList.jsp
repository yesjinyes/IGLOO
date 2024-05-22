<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<jsp:include page="../../header.jsp" />

<style type="text/css">
   
   table#memberTbl {
      width: 80%;
      margin: 0 auto;
   }
   
   table#memberTbl th {
      text-align: center;
      font-size: 14pt;
   }
   
   table#memberTbl tr.memberInfo:hover {
      background-color: #e6ffe6;
      cursor: pointer;
   }
   
   form[name="member_search_frm"] {
      border: solid 0px red;
      width: 80%;
      margin: 0 auto 3% auto;
   }
   
   form[name="member_search_frm"] button.btn-secondary {
      margin-left: 2%;
      margin-right: 32%;
   }
   
   div#pageBar {
      border: solid 0px red;
      width: 80%;
      margin: 3% auto 0 auto;
      display: flex;
   }
   
   div#pageBar > nav {
      margin: auto;
   }
   
   
   	.page-link {
	  color: #000; 
	  background-color: #fff;
	  border: 1px solid #cce6ff; 
	  font-weight: normal;
	}
	
	.page-item.active .page-link {
	 z-index: 1;
	 color: #555;
	 font-weight:bold;
	 background-color: #cce6ff;
	 border-color: #cce6ff;
	 	  font-weight: normal;
	}
	
	.page-link:focus, .page-link:hover {
	  color: #000;
	  background-color: #fafafa; 
	  border-color: #cce6ff;
		  font-weight: normal;
	}
   
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("input:text[name='searchWord']").bind("keyup", function(e){
	        if(e.keyCode == 13){
	        	goSearch();
	        }
	    });
		
		if("${requestScope.searchWord}" != "" && "${requestScope.searchType}" != ""){
			$("input:text[name='searchWord']").val("${requestScope.searchWord}");
			$("select[name='searchType']").val("${requestScope.searchType}");
		}
		
		$("select[name='sizePerPage']").val("${requestScope.sizePerPage}");
		
		$("select[name='sizePerPage']").bind('change', function(){
			const frm = document.member_search_frm;
			frm.submit();
		});
		
		// 특정 회원 클릭 시 상세 정보 보이기
		$("tbody > tr.memberInfo").click(function(e){ // 선택자는 tr이지만 클릭한 것은 td이다. 그러므로 e.target은 td태그를 가리킨다.
			// alert($(e.target).parent().text()," 클릭");
			const userid = $(e.target).parent().find(".userid").text();
			// 또는 const userid = $(e.target).parent().children(".userid").text();
			
			const frm = document.memberOneDetail_frm;
			frm.userid.value = userid;
			frm.action = "${pageContext.request.contextPath}/admin/memberOneDetail.ice";
			// 만약 상단에서 .getContextPath를 하지 않았다면 따로 쓸 필요 없이 위와 같이 해주어도 동일하다.
			frm.method = "post";
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
		
	});
	
	
	function goSearch() {
		if($("input:text[name='searchWord']").val() == ""){
			alert("검색어를 입력하세요.");
			return;
		}
		
		if($("select[name='searchType']").val() == ""){ // select태그의 option 중 value 값을 넣어야 한다.
			alert("검색 대상을 선택하세요.");
			return;
		}
		
		const frm = document.member_search_frm;
		// frm.action = "memberList.up"; // .action 생략 시 현재 머물러있는 url에 전송된다.(자기자신에게 보낼 경우 .action 생략하면 됨)
		frm.submit();
		
		
	}
</script>

<div class="container" style="padding: 3% 0;">
   <h2 class="text-center mb-5"><img style="width: 30%;" src="${pageContext.request.contextPath}/images/img_narae/회원정보목록.png"/></h2>
   
   <form name="member_search_frm">
      <select name="searchType">
         <option value="">검색대상</option>
         <option value="name">회원명</option>
         <option value="userid">아이디</option>
         <option value="email">이메일</option>
      </select>
      &nbsp;
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
      
      <span onclick="goSearch()"><img style="width: 27px; cursor:pointer;" src="${pageContext.request.contextPath}/images/img_hj/search.png"/></span>
      
      <span style="font-size: 12pt; font-weight: bold; margin-left: 40%;">페이지당 회원명수&nbsp;-&nbsp;</span>
      <select name="sizePerPage">
         <option value="10">10명</option>
         <option value="5">5명</option>
         <option value="3">3명</option>      
      </select>
   </form>
   
   <table class="table table-bordered" id="memberTbl">
      <thead>
          <tr style="background-color: #ccf3ff; ">
             <th>번호</th>
             <th>아이디</th>
             <th>회원명</th>
             <th>이메일</th>
             <th>성별</th>
          </tr>
      </thead>
      
      <%-- >>> 페이징 처리시 보여주는 순번 공식 <<<
	       데이터개수 - (페이지번호 - 1) * 1페이지당보여줄개수 - 인덱스번호 => 순번 
	    
	       <예제>
	       데이터개수 : 12
	       1페이지당보여줄개수 : 5
	    
	       ==> 1 페이지       
	       12 - (1-1) * 5 - 0  => 12
	       12 - (1-1) * 5 - 1  => 11
	       12 - (1-1) * 5 - 2  => 10
	       12 - (1-1) * 5 - 3  =>  9
	       12 - (1-1) * 5 - 4  =>  8
	    
	       ==> 2 페이지
	       12 - (2-1) * 5 - 0  =>  7
	       12 - (2-1) * 5 - 1  =>  6
	       12 - (2-1) * 5 - 2  =>  5
	       12 - (2-1) * 5 - 3  =>  4
	       12 - (2-1) * 5 - 4  =>  3
	    
	       ==> 3 페이지
	       12 - (3-1) * 5 - 0  =>  2
	       12 - (3-1) * 5 - 1  =>  1 
      --%>
      
      <tbody>
          <c:if test="${not empty requestScope.memberList}">
          	<c:forEach var="list" items="${requestScope.memberList}" varStatus="status">
          		<tr class="memberInfo">
          			<fmt:parseNumber var="currentShowPageNo" value="${requestScope.currentShowPageNo}" />
          			<fmt:parseNumber var="sizePerPage" value="${requestScope.sizePerPage}" />
          				<td>${requestScope.totalMemberCount - (currentShowPageNo-1)*sizePerPage - status.index}</td>
	          		<td class="userid">${list.userid}</td>
	          		<td>${list.name}</td>
	          		<td>${list.email}</td>
	          		<td>
	          			<c:if test="${list.gender == '1'}">남</c:if>
	          			<c:if test="${list.gender == '2'}">여</c:if>
	          		</td>
          		</tr>
          	</c:forEach>
          
          </c:if>
          
          <c:if test="${empty requestScope.memberList}">
          	<td colspan="5">데이터가 존재하지 않습니다.</td>
          </c:if>
      </tbody>
   </table>     

    <div id="pageBar">
       <nav>
          <ul class="pagination">${requestScope.pageBar}</ul>
       </nav>
    </div>
</div>

<form name="memberOneDetail_frm">
	<input type="hidden" name="goBackURL" value="${requestScope.currentURL}"/>
	<input type="hidden" name="userid" />
</form>


<jsp:include page="../../footer.jsp" />