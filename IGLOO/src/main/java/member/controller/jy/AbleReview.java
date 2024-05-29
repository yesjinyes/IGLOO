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
		
		/////////////////////////////////////////////////////////
		// **** GET 방식을 막는 또 다른 방법 ==> 웹브라우저 주소창에서 직접입력하지 못하게 막아버리면 된다. **** //
		// 이것의 단점은 웹브라우저에서 북마크(즐겨찾기)를 했을 경우 접속이 안된다는 것이다.
		// 왜냐하면 이전 페이지가 없이 웹브라우저 주소창에서 직접입력한 것과 동일하기 때문이다.
		
		String referer = request.getHeader("referer"); 
		// request.getHeader("referer"); 은 이전 페이지의 URL을 가져오는 것이다.
				
		if(referer == null) {
		// referer == null 은 웹브라우저 주소창에 URL 을 직접 입력하고 들어온 경우이다. 
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/index.up");
			return;
		}

		
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
			
		//로그인한 사용자의 주문상세목록 조회해기 
		List<OrderdetailVO> odList = rdao.selectOdetailByuserid(loginuser.getUserid());
		request.setAttribute("odList", odList);	
		
		//로그인한 사용자의 주문한 맛 목록 조회하기
		List<OrderdetailVO> otasteList = rdao.selectOtasteByuserid(loginuser.getUserid());
		request.setAttribute("otasteList", otasteList);	
			
			//List<ReviewVO> reviewlist = rdao.reviewlist(userid);
			
//			if(reviewlist.size() > 0) {
//				request.setAttribute("reviewlist", reviewlist);
//			}

		
		
		super.setViewPage("/WEB-INF/member/ableReview.jsp");

		}
		
	}
}
