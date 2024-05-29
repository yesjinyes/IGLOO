package help.controller.nr;

import java.io.File;
import java.util.Calendar;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.apache.catalina.webresources.war.Handler;

import common.controller.AbstractController;
import help.model.nr.HelpDAO;
import help.model.nr.HelpDAO_imple;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import member.domain.MemberVO;

public class InquiryRegister extends AbstractController {

private HelpDAO hdao = null;
	
	public InquiryRegister() {
		hdao = new HelpDAO_imple();
	}
	
	private String extractFileName(String partHeader) {
		  for(String cd : partHeader.split("\\;")) {
			  if(cd.trim().startsWith("filename")) {
				  String fileName = cd.substring(cd.indexOf("=") + 1).trim().replace("\"", ""); 
				  int index = fileName.lastIndexOf(File.separator); // File.separator: OS가 Windows라면 \(구분자), Mac이나 Linux, Unix라면 /를 의미한다. 
				  return fileName.substring(index + 1);
		      }
		  }
		  return null;
	   }// end of private String extractFileName(String partHeader)-------------------
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(super.checkLogin(request)) {
		
			if(!"get".equalsIgnoreCase(method)) {
			
				// --------------------------------------------------------------- //
				
				// 파일 받아오기
				
				ServletContext svlCtx = session.getServletContext();
				String uploadFileDir = svlCtx.getRealPath("/images");
				
				String faq_img = null;
				
				Collection<Part> parts = request.getParts();
				
				for(Part part:parts) {
					
					if(part.getHeader("Content-Disposition").contains("filename=")) { // form 태그에서 전송되어온 것이 파일일 경우
					
						String fileName = extractFileName(part.getHeader("Content-Disposition"));
						
						if(part.getSize()>0) {
							
							String newFilename = fileName.substring(0, fileName.lastIndexOf(".")); // 확장자를 뺀 파일명 알아오기
							newFilename += "_"+String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
						    newFilename += System.nanoTime();
						    newFilename += fileName.substring(fileName.lastIndexOf(".")); // 확장자 붙이기
						    
						    System.out.println("==== 확인용 실제 업로드 되어질 newFilename : " + newFilename);
						    
						   // >>> 파일을 지정된 디스크 경로에 저장해준다. 이것이 바로 파일을 업로드 해주는 작업이다. <<<
						   part.write(uploadFileDir + File.separator + newFilename); // 운영경로+ "/" + 새로운 파일이름 ===> 파일 업로드
						   part.delete();
						   
						   faq_img = newFilename;
						   
						}
						
						
					}
					
				} // end of for
				
				// --------------------------------------------------------------- //
				

				String q_category = request.getParameter("q_category");
				String userid = request.getParameter("userid");
				String q_title = request.getParameter("q_title");
				String q_content = request.getParameter("q_content");
				
				q_title = q_title.replaceAll("<", "&lt;");
				q_title = q_title.replaceAll(">", "&gt;");
				
				q_content = q_content.replaceAll("<", "&lt;");
				q_content = q_content.replaceAll(">", "&gt;");
				q_content = q_content.replaceAll("\r\n", "<br>");
				// System.out.println(q_category+"\n"+userid+"\n"+q_title+"\n"+q_content); 확인완료
				
				Map<String, String> paramap = new HashMap<String, String>();
				paramap.put("q_category", q_category);
				paramap.put("userid", userid);
				paramap.put("q_title", q_title);
				paramap.put("q_content", q_content);
				paramap.put("faq_img", faq_img);
				
				int n = hdao.registerFaq(paramap);
				
				if(n == 1) {
					request.setAttribute("message", "1:1 문의 등록 완료!");
					request.setAttribute("loc", request.getContextPath()+"/help/myFaqlist.ice");
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				
				else {
					request.setAttribute("message", "1:1 문의 등록이 실패했습니다.");
					request.setAttribute("loc", request.getContextPath()+"/index.ice");
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}

		
			}
			
			else {
				
				String message = "비정상적인 접근입니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				
			}
		
		
		
		}
		
		else {
			 // 로그인을 안한 경우 
	         String message = "로그인이 필요합니다.";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
		
		
		
	}

}
