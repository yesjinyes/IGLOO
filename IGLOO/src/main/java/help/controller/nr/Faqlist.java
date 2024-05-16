package help.controller.nr;

import java.util.List;

import common.controller.AbstractController;
import help.domain.nr.FaqVO;
import help.model.nr.HelpDAO;
import help.model.nr.HelpDAO_imple;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;

public class Faqlist extends AbstractController {

private HelpDAO hdao = null;
	
	public Faqlist() {
		hdao = new HelpDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(super.checkLogin(request)) {
			
			String userid = loginuser.getUserid();
			
			List<FaqVO> faqlist = hdao.viewfaq(userid);
			
			if(faqlist.size() > 0) {
				request.setAttribute("faqlist", faqlist);
			}
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/help/faqlist.jsp");
			
		}
		
		else {
			String message = "로그인 후 조회 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}

	}

}
