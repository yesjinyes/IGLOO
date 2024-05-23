<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../header.jsp" />







<div align="center" style="margin-bottom: 20px;">

   <div style="border: solid green 2px; width: 250px; margin-top: 20px; padding-top: 10px; padding-bottom: 10px; border-left: hidden; border-right: hidden;">       
      <span style="font-size: 15pt; font-weight: bold;">제품등록&nbsp;[관리자전용]</span>   
   </div>
   <br>
   
   <%-- !!!!! ==== 중요 ==== !!!!! --%>
   <%-- 폼에서 파일을 업로드 하려면 반드시 method 는 POST 이어야 하고 
        enctype="multipart/form-data" 으로 지정해주어야 한다.!! --%>
   <form name="prodInputFrm" enctype="multipart/form-data"> 
         
      <table id="tblProdInput" style="width: 80%;">
      <tbody>
         <tr>
            <td width="25%" class="prodInputName">사이즈명</td>
            <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;" >
               <input type="text" style="width: 300px;" name="pname" class="box infoData" />
               <span class="error">필수입력</span>
            </td>
         </tr>
         <tr>
            <td width="25%" class="prodInputName">제조사</td>
            <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
               <input type="text" style="width: 300px;" name="pcompany" class="box infoData" />
               <span class="error">필수입력</span>
            </td>
         </tr>
         <tr>
            <td width="25%" class="prodInputName">제품이미지</td>
            <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
               <input type="file" name="pimage1" class="infoData img_file" accept='image/*' /><span class="error">필수입력</span>
            </td>
         </tr>
         <tr>
            <td width="25%" class="prodInputName">제품판매가</td>
            <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
               <input type="text" style="width: 100px;" name="saleprice" class="box infoData" /> 원
               <span class="error">필수입력</span>
            </td>
         </tr>
         <tr>
            <td width="25%" class="prodInputName">제품스펙</td>
            <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
               <select name="fk_snum" class="infoData">
                  <option value="">:::선택하세요:::</option>
                  <%-- 
                     <option value="1">HIT</option>
                     <option value="2">NEW</option>
                     <option value="3">BEST</option> 
                  --%>
                     <c:forEach var="svo" items="${requestScope.specList}"> <%-- var인 cvo 뒤에는 get 다음 뭐뭐뭐 --%>
	                      <option value="${svo.snum}">${svo.sname}</option>
                      </c:forEach>
               </select>
               <span class="error">필수입력</span>
            </td>
         </tr>
         <tr>
            <td width="25%" class="prodInputName">제품설명</td>
            <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
               <textarea name="pcontent" rows="5" cols="60"></textarea>
            </td>
         </tr>
         <tr>
            <td width="25%" class="prodInputName" style="padding-bottom: 10px;">제품포인트</td>
            <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden; padding-bottom: 10px;">
               <input type="text" style="width: 100px;" name="point" class="box infoData" /> POINT
               <span class="error">필수입력</span>
            </td>
         </tr>
         
         <%-- ==== 추가이미지파일을 마우스 드래그앤드롭(DragAndDrop)으로 추가하기 ==== --%>
          <tr>
                <td width="25%" class="prodInputName" style="padding-bottom: 10px;">추가이미지파일(선택)</td>
                <td>
                   <span style="font-size: 10pt;">파일을 1개씩 마우스로 끌어 오세요</span>
                <div id="fileDrop" class="fileDrop border border-secondary"></div>
                </td>
          </tr>
          
          <%-- ==== 이미지파일 미리보여주기 ==== --%>
          <tr>
                <td width="25%" class="prodInputName" style="padding-bottom: 10px;">이미지파일 미리보기</td>
                <td>
                   <img id="previewImg" width="300"/>
                </td>
          </tr>
         
         <tr style="height: 70px;">
            <td colspan="2" align="center" style="border-left: hidden; border-bottom: hidden; border-right: hidden; padding: 50px 0;">
                <input type="button" value="제품등록" id="btnRegister" style="width: 120px;" class="btn btn-info btn-lg mr-5" /> 
                <input type="reset" value="취소"  style="width: 120px;" class="btn btn-danger btn-lg" />   
            </td>
         </tr>
      </tbody>
      </table>
      
   </form>
</div>








<jsp:include page="../footer.jsp" />