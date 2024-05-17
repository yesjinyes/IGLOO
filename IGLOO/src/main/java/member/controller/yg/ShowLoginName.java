package member.controller.yg;

import org.json.JSONObject;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import member.model.yg.MemberDAO;
import member.model.yg.MemberDAO_imple;

public class ShowLoginName extends AbstractController {
	
	private MemberDAO mdao = null;
	
	public ShowLoginName() {
		mdao = new MemberDAO_imple();
	}
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();	// "GET" 또는 "POST"
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		
		if("POST".equalsIgnoreCase(method)) {
		
			// === userid 의 존재유무 파악 === //
			MemberVO mvo  = mdao.loginnamepull(userid);
			
			request.setAttribute("name", mvo.getName());
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
	}

}
