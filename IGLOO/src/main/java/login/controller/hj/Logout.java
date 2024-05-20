package login.controller.hj;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;

public class Logout extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그아웃 처리하기
		
		// 세션 불러오기
		HttpSession session = request.getSession();
		String goBackURL = (String)session.getAttribute("goBackURL"); // 로그아웃 이전에 머물렀던 페이지 url
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		if(goBackURL != null) {
			goBackURL = request.getContextPath() + goBackURL;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////

		
		// 세션 지우기
		// 첫 번째 방법: 세션을 그대로 존재하게끔 해두고, 세션에 저장되어진 어떤 값(지금은 로그인 되어진 회원객체)을 삭제하기
		// session.removeAttribute("loginuser");
		

		
		// 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
		// 두 번째 방법: WAS 메모리 상에서 세션에 저장된 모든 데이터 삭제하기(이걸 더 많이 쓴다)
		session.invalidate();

		super.setRedirect(true);
		
		if(goBackURL != null && !"admin".equals(userid)) {
			super.setViewPage(goBackURL);
		}
		

		else {
		super.setViewPage(request.getContextPath()+"/index.up");
		}

	}

}
