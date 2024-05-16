package login.controller.hj;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.model.hj.MemberDAO;
import member.model.hj.MemberDAO_imple;

public class PwdUpdate extends AbstractController {
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		boolean certification_ok = (Boolean) session.getAttribute("certification_ok");
		String userid = (String) session.getAttribute("userid");
		
		if( certification_ok == true ) {
			request.setAttribute("userid", userid);
		}
		
		// === 활용다하면 제거하기(현재 위치X, 이동 예정) === //
		// session.removeAttribute("certification_ok");
		// session.removeAttribute("userid");
		
		super.setRedirect(false);	// forward
		super.setViewPage("/WEB-INF/login/pwdUpdatecertificationresult.jsp");
		
	}

}
