package common.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import my.util.MyUtil;

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
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser != null) {	// 로그인한 경우
			return true;
		}
		else {	// 로그인 안한 경우
			return false;
		}	// end of if~else-----------
		
	}	// end of public boolean checkLogin(HttpServletRequest request)---
	

	
	// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임.
	public void goBackURL(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));
	} // end of public void goBackURL(HttpServletRequest request) ---

}
