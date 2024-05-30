package member.controller.jy;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import member.model.jy.ReviewDAO;
import member.model.jy.ReviewDAO_imple;
import order.domain.OrderdetailVO;

public class WriteReview extends AbstractController {

	private ReviewDAO rdao = null;
	
	public WriteReview() {
		rdao = new ReviewDAO_imple();
	}

	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if("get".equalsIgnoreCase(method)) {
			
			// 전체 주문내역 불러오기(선택 맛 제외)
			//List<OrderdetailVO> odvoList = rdao.selectOrderListAll(loginuser.getUserid());
			
			
			// 해당주문내역(1개)에 대한 상세(리스트) 메소드 만들어야?
			Map<String,List<String>> odvoOne = new HashMap<>();
			
			
			//System.out.println(odvoList.get(0).getOrder().getOrdercode());
			request.setAttribute("odvoOne", odvoOne);	
			
			super.setViewPage("/WEB-INF/member/writeReview.jsp"); //셀렉트 보내기
			
		}
		
		
		else {
			
			////////////////////////////////////////////////////////////////////		
			
			
			
			////////////////////////////////////////////////////////////////////
			
			
			String userid = loginuser.getUserid(); // 사용자ID
			String reviewcontent = request.getParameter("reviewcontent");
			String writeday = request.getParameter("writeday");
			String ordercode = request.getParameter("ordercode");
			
			
			
			// 작성한 리뷰 insert
			Map<String, String> paraMap = new HashMap<String, String>();
			paraMap.put("userid",userid);
			paraMap.put("ordercode",ordercode);
			paraMap.put("reviewcontent",reviewcontent);
			paraMap.put("writeday",writeday);
			
			
			
			int n = rdao.insertReviewOne(paraMap);
			
			if(n == 1) {
				request.setAttribute("message", "리뷰 등록 완료!");
				request.setAttribute("loc", request.getContextPath()+"/member/pastReview.ice"); //인서트 보내기
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
			else {
				request.setAttribute("message", "리뷰가 정상적으로 등록되지 않았습니다.");
				request.setAttribute("loc", request.getContextPath()+"/index.ice");
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}

		
		}
		
	}

}
