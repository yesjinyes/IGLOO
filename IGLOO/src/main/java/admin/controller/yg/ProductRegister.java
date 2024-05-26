package admin.controller.yg;

import java.io.File;
import java.util.Calendar;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

import admin.model.yg.ProductRegisterDAO;
import admin.model.yg.ProductRegisterDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.ServletContext;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import member.domain.MemberVO;
import product.domain.ProductVO;

@MultipartConfig(location = "C:\\git\\IGLOO\\IGLOO\\images_temp_upload",
fileSizeThreshold = 1024)  // 이 크기 값을 넘지 않으면 업로드된 데이터를 메모리상에 가지고 있지만, 이값을 넘는 경우 위의 location 로 지정된 경로에 임시파일로 저장된다.  
                           // 메모리상에 저장된 파일 데이터는 언젠가 제거된다. 하지만 크기가 큰 파일을 메모리상에 올리게 되면 서버에 부하를 줄 수 있으므로 적당한 크기를 지정해주고, 그 이상크기의 파일은 임시파일로 저장하는것이 좋다.    
                           // 만약에 기재 하지 않으면 기본값은 0 이다. 0 을 쓰면 무조건 임시디렉토리에 저장된다. 
public class ProductRegister extends AbstractController {
     
      private ProductRegisterDAO prdao = null;
      
      public ProductRegister() {
         prdao = new ProductRegisterDAO_imple();
      }
      
      private String extractFileName(String partHeader) {
           for(String cd : partHeader.split("\\;")) {
              if(cd.trim().startsWith("filename")) {
                 String fileName = cd.substring(cd.indexOf("=") + 1).trim().replace("\"", ""); 
                 int index = fileName.lastIndexOf(File.separator); // File.separator 란? OS가 Windows 이라면 \ 이고, OS가 Mac, Linux, Unix 이라면 / 을 말하는 것이다.
                 return fileName.substring(index + 1);
              }
           }
           return null;
      }// end of private String extractFileName(String partHeader)-------------------
      
   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      // == 관리자(admin)로 로그인 했을 때만 제품등록이 가능하도록 한다. == //
      HttpSession session = request.getSession();
      
      MemberVO loginuser = (MemberVO) session.getAttribute("loginuser"); 
      
      if( loginuser != null && "admin".equals(loginuser.getUserid()) ) {
         // 관리자(admin)로 로그인 했을 경우
         
         String method = request.getMethod();
         
         if(!"POST".equalsIgnoreCase(method)) { // "GET" 이라면    // ■■■■■ 이건 헤더에서 제품등록을 눌렀을 때, get방식으로 보낼경우.  ■■■■■
            
            super.setRedirect(false);
            super.setViewPage("/WEB-INF/admin/productRegister.jsp"); 
         }
         else { // "POST" 이라면      // ■■■■■ 이건 제품등록 페이지에 들어가서 전부 입력후 제품등록 버튼을 눌러 POST방식으로 보낼경우.  ■■■■■
            
            // 1. 첨부되어진 파일을 디스크의 어느 경로에 업로드 할 것인지 그 경로를 설정해야 한다.  
            ServletContext svlCtx = session.getServletContext();
            String uploadFileDir = svlCtx.getRealPath("/images");
          // System.out.println("=== 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> " + uploadFileDir); 
         // === 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir 
         // ==> C:\NCS\workspace_jsp\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\MyMVC\images
         
         // String uploadFileDir = "C:\\NCS\\workspace_jsp\\MyMVC\\src\\main\\webapp\\images";
         // 위와 같이 하면 파일 업로드 후에 어떤분들은 이클립스에서 새로고침을 해주어야 된다.
            
         // ==== >>> 파일을 업로드 해준다. <<< ==== //
            
             String pimage1 = null;
             String prdmanual_systemFileName = null;
             String prdmanual_originFileName = null;
             
             String attachCount = request.getParameter("attachCount");
             // attachCount 가 추가이미지 파일의 개수이다. null "1" ~ "10"
             //  System.out.println("~~~~~~~ attachCount : " + attachCount);
             // ~~~~~~~ attachCount : null
             // ~~~~~~~ attachCount : 4
             
             int n_attachCount = 0;
             
             if(attachCount != null) {
                n_attachCount = Integer.parseInt(attachCount);
             }
             
             String[] arr_attachFileName = new String[n_attachCount]; // 추가이미지 파일명들을 저장시키는 용도
             int idx_attach = 0;
             
             Collection<Part> parts = request.getParts(); // name이 없을 때
             // getParts()를 사용하여 form 태그로 부터 넘어온 데이터들을 각각의 Part로 하나하나씩 받는다.
               
               /*
                   Part
                      -----------------------------------------------------------------------------------------------------------------
                       메소드                                                설명
                      -----------------------------------------------------------------------------------------------------------------
                       public InputStream getInputStream()         Part에 대한 InputStream을 리턴한다. 직접 데이터를 꺼내어 올때 사용한다. 
                       throws IOException;

                       public String getContentType()              Content-Type을 리턴해준다.
                                                                   예를들어, 파일의 image/jpeg 또는 application/pdf 와 같은것을 말한다.

                       public String getName()                     파라미터명을 리턴해준다.

                       public String getSubmittedFileName()        업로드한 파일명을 리턴해준다. servlet 3.1(톰캣버전 8.5 이후)부터 사용 가능하다.

                       public long getSize();                      파일의 크기를 byte단위로 리턴해준다.
                       
                       public void write(String fileName)          임시저장되어 있는 파일 데이터를 복사하여 fileName 에 지정한 경로로 저장해준다.  
                       throws IOException                          임시저장 되어있는 파일데이터가 메모리상에 있든 디스크에 있든 신경쓰지 않아도 된다.
                       
                       public void delete()                        임시저장된 파일 데이터를 제거해준다.  
                       throws IOException                          HTTP요청이 처리되고 나면 자동으로 제거되지만 그 전에 메모리나 디스크 자원을 아끼고 싶다면 수동으로 제거할 수 있다. 
                       
                       public String getHeader(String name)        Part로부터 지정한 name헤더값을 리턴해준다.    
                      ------------------------------------------------------------------------------------------------------------------

               
               */
             
             
             for(Part part : parts) {
                // System.out.printf(">> 확인용   파라미터(name)명 : %s, contentType : %s, size : %d bytes \n"
                   //                  , part.getName(), part.getContentType(), part.getSize());
                
             /*
               >> 확인용   파라미터(name)명 : fk_cnum, contentType : null, size : 1 bytes 
               >> 확인용   파라미터(name)명 : pname, contentType : null, size : 3 bytes 
               >> 확인용   파라미터(name)명 : pcompany, contentType : null, size : 4 bytes 
               >> 확인용   파라미터(name)명 : pimage1, contentType : image/jpeg, size : 58889 bytes 
               >> 확인용   파라미터(name)명 : pimage2, contentType : image/jpeg, size : 71317 bytes 
               >> 확인용   파라미터(name)명 : prdmanualFile, contentType : application/pdf, size : 791567 bytes 
               >> 확인용   파라미터(name)명 : pqty, contentType : null, size : 1 bytes 
               >> 확인용   파라미터(name)명 : price, contentType : null, size : 4 bytes 
               >> 확인용   파라미터(name)명 : saleprice, contentType : null, size : 2 bytes 
               >> 확인용   파라미터(name)명 : fk_snum, contentType : null, size : 1 bytes 
               >> 확인용   파라미터(name)명 : pcontent, contentType : null, size : 8 bytes 
               >> 확인용   파라미터(name)명 : point, contentType : null, size : 1 bytes 
               >> 확인용   파라미터(name)명 : attachCount, contentType : null, size : 1 bytes 
               >> 확인용   파라미터(name)명 : attach0, contentType : image/jpeg, size : 57641 bytes 
               >> 확인용   파라미터(name)명 : attach1, contentType : image/jpeg, size : 41931 bytes 
               >> 확인용   파라미터(name)명 : attach2, contentType : image/jpeg, size : 44338 bytes 
               >> 확인용   파라미터(name)명 : attach3, contentType : image/jpeg, size : 48901 bytes 
              */
                
                if(part.getHeader("Content-Disposition").contains("filename=")) { // form 태그에서 전송되어온 것이 파일일 경우
                    // Content-Disposition 이란?
                        // 일반적인 HTTP 응답에서 Content-Disposition 헤더는 컨텐츠가 브라우저로 보여지는 웹페이지 자체이거나,
                        // 아니면 컨텐츠가 attachment 로써 다운로드 되어질 용도로 쓰이는 것인지를 알려주는 헤더이다.
                        // 첨부파일은 Header 부분에 Content-Disposition 설정을 아래와 같이 설정해준다.
                        // Content-Disposition: attachment; filename="filename.jpg"
                        
                        // 그래서, 업로드한 파일명을 구하려면 Content-Disposition 헤더의 값을 사용한다.
                   
                   String fileName = extractFileName(part.getHeader("Content-Disposition"));
                   
                   if(part.getSize() > 0) {
                       // System.out.println("~~~ 확인용  업로드한 파일명 :  " + fileName);
                      /*
                        ~~~ 확인용  업로드한 파일명 :  berkelekle심플라운드01.jpg
                        ~~~ 확인용  업로드한 파일명 :  berkelekle심플V넥02.jpg
                        ~~~ 확인용  업로드한 파일명 :  Electrolux냉장고_사용설명서.pdf
                        ~~~ 확인용  업로드한 파일명 :  berkelekle단가라포인트03.jpg
                        ~~~ 확인용  업로드한 파일명 :  berkelekle덩크04.jpg
                        ~~~ 확인용  업로드한 파일명 :  berkelekle트랜디05.jpg
                        ~~~ 확인용  업로드한 파일명 :  berkelekle디스트리뷰트06.jpg
                      */
                      
                      // 서버에 저장할 새로운 파일명을 만든다.
                      // 서버에 저장할 새로운 파일명이 동일한 파일명이 되지 않고 고유한 파일명이 되도록 하기 위해
                      // 현재의 년월일시분초에다가 현재 나노세컨즈nanoseconds 값을 결합하여 확장자를 붙여서 만든다.
                      String newFilename = fileName.substring(0, fileName.lastIndexOf(".")); // 확장자를 뺀 파일명 알아오기
                      
                      newFilename += "_"+String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance()); // 나노타임
                      newFilename += System.nanoTime();
                      newFilename += fileName.substring(fileName.lastIndexOf(".")); // 확장자 붙이기
                      
                       // System.out.println("==== 확인용 실제 업로드 되어질 newFilename : " + newFilename);
                      /*
                        ==== 확인용 실제 업로드 되어질 newFilename : berkelekle디스트리뷰트06_202405211028164693264722900.jpg
                        ==== 확인용 실제 업로드 되어질 newFilename : berkelekle심플V넥02_202405211028164693265394400.jpg
                        ==== 확인용 실제 업로드 되어질 newFilename : Electrolux냉장고_사용설명서_202405211028164693265443700.pdf
                        ==== 확인용 실제 업로드 되어질 newFilename : berkelekle단가라포인트03_202405211028164693265483800.jpg
                        ==== 확인용 실제 업로드 되어질 newFilename : berkelekle덩크04_202405211028164693265518700.jpg
                        ==== 확인용 실제 업로드 되어질 newFilename : berkelekle트랜디05_202405211028164693265552900.jpg
                        ==== 확인용 실제 업로드 되어질 newFilename : berkelekle디스트리뷰트06_202405211028164693265585700.jpg
                      */
                      
                        // >>> 파일을 지정된 디스크 경로에 저장해준다. 이것이 바로 파일을 업로드 해주는 작업이다. <<<
                        part.write(uploadFileDir + File.separator + newFilename);
                        
                        // >>> 임시저장된 파일 데이터를 제거해준다. <<<
                        // 즉, @MultipartConfig(location = "C:\\NCS\\workspace_jsp\\MyMVC\\images_temp_upload",
                        //                       fileSizeThreshold = 1024) 와 같이 설정되었다면 
                        // C:\\NCS\\workspace_jsp\\MyMVC\\images_temp_upload 폴더에 임시 저장된 파일을 제거해야 한다.
                        part.delete();
                        
                        if("pimage1".equals(part.getName())) {
                           pimage1 = newFilename;
                        }
                        else if("prdmanualFile".equals(part.getName())) {
                            prdmanual_systemFileName = newFilename;
                            prdmanual_originFileName = fileName;
                         }
                        else if(part.getName().startsWith("attach") ) {
                           arr_attachFileName[idx_attach++] = newFilename;
                        } // ■■■■■■ 드래그 앤 드롭을 이용하여 추가 이미지 파일을 업로드 할 경우 이 else if 문이 실행된다. ■■■■■■
                   }
                    
                } // end of if(part.getHeader("Content-Disposition").contains("filename="))----------------------
                
                else { 
                  // form 태그에서 전송되어온 것이 파일이 아닐 경우
                      String formValue = request.getParameter(part.getName());
                      // System.out.printf("파일이 아닌 경우 파라미터(name)명 : %s, value : %s \n"
                      //               , part.getName(), formValue);
                }
                // System.out.println("");
                /*
                  파일이 아닌 경우 파라미터(name)명 : fk_cnum, value : 2 
                  파일이 아닌 경우 파라미터(name)명 : pname, value : 좋은옷 
                  파일이 아닌 경우 파라미터(name)명 : pcompany, value : 좋은옷회사 
                  파일이 아닌 경우 파라미터(name)명 : pqty, value : 10 
                  파일이 아닌 경우 파라미터(name)명 : price, value : 2000 
                  파일이 아닌 경우 파라미터(name)명 : saleprice, value : 1900 
                  파일이 아닌 경우 파라미터(name)명 : fk_snum, value : 1 
                  파일이 아닌 경우 파라미터(name)명 : pcontent, value : 싸고 좋은 옷 팝니다. 
                  파일이 아닌 경우 파라미터(name)명 : point, value : 5 
                  파일이 아닌 경우 파라미터(name)명 : attachCount, value : 4 
                */
             } // end of for(Part part : parts)-------------------------
             
             
             // === 첨부 이미지 파일, 제품설명서 파일을 올렸으니 그 다음으로 제품정보를 (제품명, 정가, 제품수량,...) DB의 tbl_product 테이블에 insert 를 해주어야 한다.  ===
             // ■■■■■■ 여기서 DAO에 넣기 위한 변수를 선언한다. ■■■■■■
                  String productname = request.getParameter("productname");       // 제품명
                  String productcodeno = request.getParameter("productcodeno");   // 제품코드
                  String price = request.getParameter("price");                   // 제품가격
                  // String pimage = request.getParameter(pimage1);                  // 제품이미지
                  
             
                  // !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!!  
                  String productdetail = request.getParameter("productdetail");   // 제품설명
                  productdetail =  productdetail.replaceAll("<","&lt;");
                  productdetail = productdetail.replaceAll(">","&gt;");
                  productdetail = productdetail.replaceAll("\r\n","<br>");
                  // 입력한 내용에서 엔터는 <br>로 변환하기
                  
                  ProductVO pvo = new ProductVO();
                  pvo.setProductname(productname);   // 제품명
                  pvo.setProductcodeno(productcodeno); // 제품명
                  pvo.setPrice(Integer.parseInt(price)); // 가격
                  pvo.setProductdetail(productdetail); // 제품설명
                  pvo.setProductimg(pimage1);   // 제품이미지
                  
                  String attachFileName = arr_attachFileName[0];
                  pvo.setProductimgBelow(attachFileName);
                  
               // tbl_product 테이블에 제품정보 insert 하기 
                  int n = prdao.productInsert(pvo);
                  
                  int result = 0;
                  if(n == 1) {
                     result = 1;
                  }
                  
                  // === 추가이미지파일이 있다라면 tbl_product_imagefile 테이블에 제품의 추가이미지 파일명 insert 해주기 === // 
                  
                  JSONObject jsonObj = new JSONObject();  // {}
                  jsonObj.put("result", result);
                  
                  String json = jsonObj.toString(); // 문자열로 변환 
                  request.setAttribute("json", json);
                  
                  super.setRedirect(false);
                  super.setViewPage("/WEB-INF/jsonview.jsp"); 
         }// else { // "POST" 이라면--------------------------------

      } // if( loginuser != null && "admin".equals(loginuser.getUserid()) ) {}----------------------------------------
      else {
         // 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우 
         String message = "관리자만 접근이 가능합니다.";
         String loc = "javascript:history.back()";
         
         request.setAttribute("message", message);
         request.setAttribute("loc", loc);
         
      //   super.setRedirect(false);
         super.setViewPage("/WEB-INF/msg.jsp");
      }

   }

}