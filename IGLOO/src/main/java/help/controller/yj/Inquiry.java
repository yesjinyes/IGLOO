package help.controller.yj;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;

public class Inquiry extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(super.checkLogin(request)) {
			
			String userid = loginuser.getUserid();
			request.setAttribute("userid", userid);
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/help/inquiry.jsp");
			
		}
		
		else {
			
			String message = "1:1 문의는 로그인 후 가능합니다.";
			String loc = "/IGLOO/login/login.ice";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
	}

}
