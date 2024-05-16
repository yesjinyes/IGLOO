<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp"/>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/register.css" /> 

<%-- 우편번호 JS --%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/member/register.js"></script>

<link type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
	
	<div class="row" id="divRegisterFrm" style="margin: 10% auto 0 auto; width: 40%;">
	   <div class="mx-auto p-0">
	      <form name="registerFrm" >
	      	<table id="tblRegister">
	        	<thead>
	            	<tr>
	            		<th colspan="2" class="mb-3">
	            			<a href="<%= ctxPath%>/"><img src="<%= ctxPath%>/images/igloo_logo.png" style="width:200px;"/></a>
	                	</th>
	                </tr>
	             </thead>
	             <tbody>
	                <tr>
	                    <td colspan="2" style="line-height: 50%;">&nbsp;</td>
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
	                       	<div>
	                       		<span class="error"> - 생년월일은 마우스로만 클릭하세요.</span>
	                    	</div>
	                    </td>
	                </tr>
	                <%-- 휴대폰 번호 --%>
	                <tr>
	                    <td class="text-center">
	                    	<i class="fa-solid fa-mobile-screen-button"></i>
	                    </td>
	                    <td>
	                       	<input type="text" name="hp1" id="hp1" maxlength="3" value="010" readonly />&nbsp;-&nbsp; 
	                       	<input type="text" name="hp2" id="hp2" maxlength="4" />&nbsp;-&nbsp;
	                       	<input type="text" name="hp3" id="hp3" maxlength="4" />    
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
	                       	<div>
	                       		<span class="error"> - 우편번호 형식에 맞지 않습니다.</span>
	                    	</div>
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
	                       	<div>
	                       		<span class="error">주소를 입력하세요.</span>
	                    	</div>
	                    </td>
	                </tr>
				</tbody>
			</table>
			<%-- 회원가입 및 취소 버튼 --%>
	        <div id="btnRegister" class="text-center justify-content-center mb-5">
	        	<input type="reset"  class="btn btn-light btn-xs mr-5" value="취소하기" onclick="goReset()" />
	            <input type="button" class="btn btn-xs " value="수정하기" onclick="goRegister()" />
	        </div>
		  </form>
		</div>
	</div>
<jsp:include page="../footer.jsp" />
