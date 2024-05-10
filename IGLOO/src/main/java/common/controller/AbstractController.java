package common.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;

public abstract class AbstractController implements InterCommand {

	private boolean isRedirect = false;
	
	private String viewPage;
	
	// === Getter, Setter === //
	public boolean isRedirect() {
		return isRedirect;
	}

	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}

	public String getViewPage() {
		return viewPage;
	}

	public void setViewPage(String viewPage) {
		this.viewPage = viewPage;
	}
		
	////////////////////////////////////////////////
	
	public boolean checkLogin(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO login_user = (MemberVO)session.getAttribute("login_user");
		
		if(login_user != null) {	// 로그인한 경우
			return true;
		}
		else {	// 로그인 안한 경우
			return false;
		}	// end of if~else-----------
		
	}	// end of public boolean checkLogin(HttpServletRequest request)---

}
