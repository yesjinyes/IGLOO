package admin.controller.nr;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import member.model.nr.MemberDAO;
import member.model.nr.MemberDAO_imple;

public class MemberOneDetail extends AbstractController {

	private MemberDAO mdao = null;
	
	public MemberOneDetail() {
		mdao = new MemberDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// === 관리자(admin)로 로그인 했을때만 조회가 가능하도록 한다. === //
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser.getUserid() != null && "admin".equals(loginuser.getUserid())) {
			// 관리자로 로그인 했을 경우
		
			String method = request.getMethod();
			
			if("post".equalsIgnoreCase(method)) {
				String userid = request.getParameter("userid");
				String goBackURL = request.getParameter("goBackURL");
				// System.out.println(goBackURL);
				
				MemberVO mvo = mdao.selectOneMember(userid);
				request.setAttribute("mvo", mvo);
				request.setAttribute("goBackURL", goBackURL);
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/member/admin/memberOneDetail.jsp");
			}
			
		}
		
		else {
			// 로그인을 안 했거나 관리자가 아닐 경우
			String message = "관리자 전용 메뉴이므로 접근 불가합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
		
	}

}
