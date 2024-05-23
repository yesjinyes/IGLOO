package admin.controller.nr;

import java.util.HashMap;
import java.util.Map;

import admin.model.nr.AdminDAO;
import admin.model.nr.AdminDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class FaqAnswerRegister extends AbstractController {

	private AdminDAO adao = null;
	
	public FaqAnswerRegister() {
		adao = new AdminDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String input = request.getParameter("answerText");
		input = input.replaceAll("\r\n", "<br>");		
		String q_no = request.getParameter("q_no");
		// System.out.println(input);
		// System.out.println(q_no);
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("input", input);
		paramap.put("q_no", q_no);
		
		int n = adao.insertAnswer(paramap);
		
		String message = "";
		String loc = "";
		
		if(n==1) {
			message = "1:1 답변이 등록되었습니다.";
			loc = request.getContextPath()+"/admin/faqAnswer.ice";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		else {
			message = "1:1 답변 등록이 실패했습니다.";
			loc = request.getContextPath()+"/admin/faqAnswer.ice";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
	}

}
