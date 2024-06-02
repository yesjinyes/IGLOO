package member.controller.jy;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import member.domain.ReviewVO;
import member.model.jy.ReviewDAO;
import member.model.jy.ReviewDAO_imple;
import order.domain.OrderdetailVO;

public class EditReview extends AbstractController {

	
	private ReviewDAO rdao = null;
	
	public EditReview() {
		rdao = new ReviewDAO_imple();
	}

	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
//		String ordercode = request.getParameter("odrcode");
//		String reviewcontent = request.getParameter("reviewcontent");
//		
//		// System.out.println("ordercode: "+ordercode);
//		
//		HttpSession session = request.getSession();
//		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
//		
		if("get".equalsIgnoreCase(method)) {
//			
//			
//			// 해당리뷰(1개)에 대한 상세(리스트) 메소드
//			ReviewVO rvoOne = rdao.rvoOne(ordercode);
//			
//			//System.out.println("첫 번째 맛: "+odvoOne.getTastenamelist().get(0).getTastename());
//			//System.out.println("첫 번째 맛 사진: "+ odvoOne.getTasteimglist().get(0).getTasteimg());
//			
//			//System.out.println(odvoList.get(0).getOrder().getOrdercode());
//			request.setAttribute("rvoOne", rvoOne);	
//			request.setAttribute("ordercode", ordercode);
//			request.setAttribute("reviewcontent", reviewcontent);
			
			super.setViewPage("/WEB-INF/member/editReview.jsp"); //셀렉트 보내기
			
//		}
//		
//		
//		else {
//			
//			////////////////////////////////////////////////////////////////////		
//			
//			// System.out.println("왔니");
//			
//			////////////////////////////////////////////////////////////////////
//			
//			
//			String userid = loginuser.getUserid(); // 사용자ID
//			//String writeday = request.getParameter("writeday");
//			//String reviewno = request.getParameter("reviewno");
//			
//			
//			// 수정한 리뷰 update
//			Map<String, String> paraMap = new HashMap<String, String>();
//			paraMap.put("userid",userid);
//			paraMap.put("ordercode",ordercode);
//			paraMap.put("reviewcontent",reviewcontent);
//			//paraMap.put("writeday",writeday);
//			//paraMap.put("reviewno",reviewno);
//			//status 넣는거 아님
//			
//			
//			
//			int n = rdao.updateReviewOne(paraMap); // 리뷰테이블 update
//			
//			if(n == 1) {
//				
//				request.setAttribute("message", "리뷰 수정 완료!");
//				request.setAttribute("n", "1");  // 우리만의 약쏙
//				request.setAttribute("loc", request.getContextPath()+"/member/pastReview.ice"); //인서트, 업데이트 보내기
//				
//				super.setRedirect(false);
//				super.setViewPage("/WEB-INF/msg.jsp");
//
//			}
//			
//			else {
//				request.setAttribute("message", "리뷰가 정상적으로 수정되지 않았습니다.");
//				request.setAttribute("n", "1");  // 우리만의 약쏙
//				request.setAttribute("loc", request.getContextPath()+"/member/pastReview.ice");
//				
//				super.setRedirect(false);
//				super.setViewPage("/WEB-INF/msg.jsp");
//			}

		
//		}
	
		}
		

	}

}
