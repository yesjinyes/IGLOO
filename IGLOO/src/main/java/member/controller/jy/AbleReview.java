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
import myshop.domain.CartVO;
import order.domain.OrderdetailVO;

public class AbleReview extends AbstractController {

	
	private ReviewDAO rdao = null;
	
	public AbleReview() {
		rdao = new ReviewDAO_imple();
	}

	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		

		
		// 리뷰보기는 반드시 해당사용자가 로그인을 해야만 볼 수 있다.
		if(!super.checkLogin(request)) {
			request.setAttribute("message", "장바구니를 보려면 먼저 로그인 부터 하세요!!");
			request.setAttribute("loc", "javascript:history.back()"); 
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		else { // 로그인을 했을 경우 
			
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
		// 전체 주문내역 불러오기(선택 맛 제외)
		List<OrderdetailVO> odvoList = rdao.selectOrderListAll(loginuser.getUserid());
		// System.out.println(odvoList.get(0).getTastenamelist().get(0).getTastename()); 
		request.setAttribute("odvoList", odvoList);	
		
		
		
		super.setViewPage("/WEB-INF/member/ableReview.jsp");

		}
		
	}
}
