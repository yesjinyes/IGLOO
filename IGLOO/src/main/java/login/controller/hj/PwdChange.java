package login.controller.hj;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class PwdChange extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		String userid = (String) session.getAttribute("userid");
		
		request.setAttribute("userid", userid);
		
		session.removeAttribute("userid");
		
		super.setRedirect(false);	// forward
		super.setViewPage("/WEB-INF/login/pwdUpdate_3months.jsp");

	}

}
