package login.controller.yj;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.model.yj.MemberDAO;
import member.model.yj.MemberDAO_imple;

public class PwdChange_3months extends AbstractController {

	private MemberDAO mdao = null;
	   
    public PwdChange_3months() {
    	mdao = new MemberDAO_imple();
    }
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		String userid = (String) session.getAttribute("userid");
		String ctxPath = request.getContextPath();
		
		request.setAttribute("userid", userid);
		
		session.removeAttribute("userid");
		
		super.setRedirect(false);	// forward
		super.setViewPage("/WEB-INF/login/pwdUpdate_3months.jsp");

	}

}
