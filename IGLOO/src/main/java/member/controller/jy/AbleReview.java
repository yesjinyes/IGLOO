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
import order.domain.OrderdetailVO;

public class AbleReview extends AbstractController {

	
	private ReviewDAO rdao = null;
	
	public AbleReview() {
		rdao = new ReviewDAO_imple();
	}

	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(super.checkLogin(request)) { // 아이디 일치하는지 확인 
			
			String userid = loginuser.getUserid();
			
			// 주문상세번호를 가지고서 제품의 정보를 조회해오기 
			//OrderdetailVO odvo = odvo.selectOdetailByuserid(userid);
			
			
			//List<ReviewVO> reviewlist = rdao.reviewlist(userid);
			
//			if(reviewlist.size() > 0) {
//				request.setAttribute("reviewlist", reviewlist);
//			}

		
		
		super.setViewPage("/WEB-INF/member/ableReview.jsp");

		}

	}
}
