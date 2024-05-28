package help.controller.nr;

import common.controller.AbstractController;
import help.model.nr.HelpDAO;
import help.model.nr.HelpDAO_imple;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class InquiryRegister extends AbstractController {

private HelpDAO hdao = null;
	
	public InquiryRegister() {
		hdao = new HelpDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String q_category = request.getParameter("q_category");
		String userid = request.getParameter("userid");
		String q_title = request.getParameter("q_title");
		String q_content = request.getParameter("q_content");
		
		// System.out.println(q_category+"\n"+userid+"\n"+q_title+"\n"+q_content); 확인완료
		
	}

}
