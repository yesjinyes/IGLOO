package admin.controller.nr;

import admin.model.nr.AdminDAO;
import admin.model.nr.AdminDAO_imple;
import common.controller.AbstractController;
import help.domain.nr.FaqVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;

public class FaqAnswerDetail extends AbstractController {
	
	private AdminDAO adao = null;
	
	public FaqAnswerDetail() {
		adao = new AdminDAO_imple();
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		String message = "";
		String loc = "";
		
		if("post".equalsIgnoreCase(method)) {
			HttpSession session = request.getSession();
			
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser != null && "admin".equals(loginuser.getUserid())) {
			
				String fk_q_no = request.getParameter("fk_q_no");
				String goBackURL = request.getParameter("goBackURL");
				
				// System.out.println(fk_q_no);
				// System.out.println(goBackURL);
				
				FaqVO fav = adao.getFaq(fk_q_no);
				
				
				
				
				
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/admin/faqAnswerDetail.jsp");
			}
			
			else {
				message = "관리자 전용 메뉴이므로 접근 불가합니다.";
				loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}// if."post"
		
		else {
			message = "비정상적인 경로입니다.";
			loc = "javascript:history.back()";
			 
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			 
		}
		
		
	}

}
