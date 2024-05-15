<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp"/>

<%-- DataPicker --%>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/register.css" /> 

<%-- 우편번호 JS --%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/member/register.js"></script>
<link type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />

<div class="row" id="divRegisterFrm">
   <div class="mx-auto p-0">
      <form name="registerFrm">
      	<table id="tblRegister">
        	<thead>
            	<tr>
            		<th colspan="2" class="mt-5 mb-3">
            			<a href="<%= ctxPath%>/"><img src="<%= ctxPath%>/images/igloo_logo.png" style="width:200px;"/></a>
                	</th>
                </tr>
             </thead>
             <tbody>
                <tr>
                    <td colspan="2" style="line-height: 50%;">&nbsp;</td>
                </tr>
                <%-- 아이디 --%>
                <tr>
                    <td class="text-center">
                    	<i class="fa-solid fa-user"></i>
                    </td>
                    <td>
                       	<input type="text" name="userid" id="userid" maxlength="40" class="requiredInfo" placeholder="아이디" autofocus/>  
                       	<%-- 아이디중복체크 --%>
                       	<span id="idcheck">아이디중복확인</span>
                       	<div>
                      	 	<span class="error"> - 아이디는 필수입력 사항입니다.</span>
                    	</div>
                    	<span id="idcheckResult"></span>
                    </td>
                </tr>
                <%-- 비밀번호 --%>
                <tr>
                    <td class="text-center">
                    	<i class="fa-solid fa-key"></i>
                    </td>
                    <td>
                       	<input type="password" name="pwd" id="pwd" maxlength="15" class="requiredInfo" placeholder="비밀번호"/>
                    	<div>
                    		<span class="error"> - 암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로 입력하세요.</span>
                    	</div>
                    </td>
                </tr>
                <%-- 비밀번호 확인 --%>
                <tr>
                    <td></td>	<%-- 비밀번호와 이모티콘 동일함으로 공백 --%>
                    <td>
                       	<input type="password" id="pwdcheck" maxlength="15" class="requiredInfo" placeholder="비밀번호 확인"/>
                       	<div>
                       		<span class="error"> - 암호가 일치하지 않습니다.</span>
                    	</div>
                    </td>
                </tr>
                <%-- 이메일 --%>
                <tr>
                    <td class="text-center">
                    	<i class="fa-solid fa-envelope"></i>
                    </td>
                    <td>
                       <input type="text" name="email" id="email" maxlength="60" class="requiredInfo" placeholder="이메일 주소[본인확인용]"/>
                       <%-- 이메일중복체크 --%>
                       <span id="emailcheck">이메일중복확인</span>
                       <div>
                       		<span class="error">이메일 형식에 맞지 않습니다.</span>
                       </div>
                       <span id="emailCheckResult"></span>
                    </td>
                </tr>
				<%-- 성명 --%>
                <tr>
                    <td class="text-center">
                    	<i class="fa-solid fa-user"></i>
                    </td>
                    <td>
                       	<input type="text" name="name" id="name" maxlength="30" class="requiredInfo" placeholder="성명"/>
                       	<div>
                       		<span class="error"> - 성명은 필수입력 사항입니다.</span> 
                    	</div>
                    </td>
                </tr>
                <%-- 생년월일 --%>
                <tr>
                    <td class="text-center">
                    	<i class="fa-solid fa-calendar-days"></i>
                    </td>
                    <td>
                       	<input type="text" name="birthday" id="datepicker" class="datepicker" maxlength="10" placeholder="생년월일"/>
                    </td>
                </tr>
                <%-- 휴대폰 번호 --%>
                <tr>
                    <td class="text-center">
                    	<i class="fa-solid fa-mobile-screen-button"></i>
                    </td>
                    <td>
                       	<input type="text" name="hp1" id="hp1" maxlength="3" class="requiredInfo" value="010" readonly />&nbsp;-&nbsp; 
                       	<input type="text" name="hp2" id="hp2" maxlength="4" class="requiredInfo"/>&nbsp;-&nbsp;
                       	<input type="text" name="hp3" id="hp3" maxlength="4" class="requiredInfo" />    
                       	<div>
                       		<span class="error"> - 휴대폰 형식이 아닙니다.</span>
                    	</div>
                    </td>
                </tr>
                <%-- 우편번호 --%>
                <tr>
                    <td class="text-center">
						<i class="fa-solid fa-location-dot"></i>
					</td>
                    <td>
                       	<input type="text" name="postcode" id="postcode" maxlength="5" placeholder="우편번호"/>&nbsp;&nbsp;
                       	<%-- 우편번호 찾기 --%>
                       	<span id="zipcodeSearch">우편번호찾기</span>
                    </td>
                </tr>
                <%-- 주소 --%>
                <tr>
                    <td class="text-center">
                    	<i class="fa-solid fa-map-location-dot"></i>
                    </td>
                    <td>
                       	<input type="text" name="address" id="address" maxlength="200" placeholder="주소" /><br>
                       	<input type="text" name="detailaddress" id="detailAddress" maxlength="200" placeholder="상세주소" />&nbsp;
                       	<input type="text" name="extraaddress" id="extraAddress" maxlength="200" placeholder="참고항목" />            
                    </td>
                </tr>
			</tbody>
		</table>
		<%-- 성별 --%>
        <div class="card-group my-3 mx-3">
	  		<div id="divmale" class="card bg-outline-secondary">
	    		<div class="card-body text-center py-1">
	      			<input type="radio" name="gender" value="1" id="male" style="display: none;"/>
	      			<label for="male" class="my-auto">남자</label>
	    		</div>
	  		</div>
	  		<div id="divfemale" class="card bg-outline-secondary">
	    		<div class="card-body text-center py-1">
	      			<input type="radio" name="gender" value="2" id="female" style="display: none;"/>
	      			<label for="female" class="my-auto">여자</label>
	    		</div>
	  		</div>
		</div>
		<%-- 이용 약관 --%>			
        <div id="Registeragree" class="mb-3 mx-3 row">
            <div class="check-circle ml-3 my-auto col-7">
            	<input type="checkbox" id="agree"/>
                <label for="agree" class="ml-2 my-auto">
                	<span>[필수]</span>&nbsp;인증약관 동의
                </label>
            </div>
            <div class="col-2"></div>
            <button id="checkagreeContents" type="button" class="btn btn-sm col-2" aria-expended="false">
				<i class="fa-solid fa-chevron-down"></i>
			</button>
            <iframe id="iframe_agree" class="dropdown-item" src="<%= ctxPath%>/iframe_agree/agree.html" width="100%" height="150px" style="border: solid 1px navy;"></iframe>
        </div>
		<%-- 회원가입 및 취소 버튼 --%>
        <div id="btnRegister" class="text-center justify-content-center mb-5">
        	<input type="reset"  class="btn btn-light btn-xs mr-5" value="취소하기" onclick="goReset()" />
            <input type="button" class="btn btn-xs " value="가입하기" onclick="goRegister()" />
        </div>
	  </form>
	</div>
</div>
<jsp:include page="../footer.jsp" />
