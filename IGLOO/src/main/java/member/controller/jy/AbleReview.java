package member.controller.jy;

import java.util.List;

import common.controller.AbstractController;
import help.domain.nr.FaqVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import member.domain.ReviewVO;
import member.model.jy.ReviewDAO;
import member.model.jy.ReviewDAO_imple;

public class AbleReview extends AbstractController {

	
	private ReviewDAO rdao = null;
	
	public AbleReview() {
		rdao = new ReviewDAO_imple();
	}

	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(super.checkLogin(request)) {
			
			String userid = loginuser.getUserid();
			
			List<ReviewVO> reviewlist = rdao.reviewlist(userid);
			
			if(reviewlist.size() > 0) {
				request.setAttribute("reviewlist", reviewlist);
			}

		
		
		super.setViewPage("/WEB-INF/member/ableReview.jsp");

		}

	}
}
