package admin.controller.hj;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;

public class TodayvisitStatistics extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser != null && "admin".equals(loginuser.getUserid())) {
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/todayvisitStatistics.jsp");
			
		}
		else {
			
			super.goBackURL(request);
			
			String message = "관리자만 접근가능합니다. 관리자로 로그인해주세요";
			
			String loc = request.getContextPath() + "/login/login.ice";
	        // 테이블 적용 후 이동 이전페이지(get 타입 변경)할 지 메인페이지 갈지 선정해야할 것
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	        
			super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
		}

	}

}
