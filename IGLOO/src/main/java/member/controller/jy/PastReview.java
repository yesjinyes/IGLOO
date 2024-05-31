package member.controller.jy;

import java.util.List;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import member.domain.ReviewVO;
import member.model.jy.ReviewDAO;
import member.model.jy.ReviewDAO_imple;

public class PastReview extends AbstractController {

	private ReviewDAO rdao = null;
	
	public PastReview() {
		rdao = new ReviewDAO_imple();
	}

	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(super.checkLogin(request)) {
			
			String userid = loginuser.getUserid();
			
			//작성한 리뷰 보이기
			List<ReviewVO> pastList = rdao.viewPreviewList(userid);
			
			if(pastList.size() > 0) {
				request.setAttribute("pastList", pastList);
			}
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/pastReview.jsp");
			
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
