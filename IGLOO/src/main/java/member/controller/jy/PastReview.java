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

public class PastReview extends AbstractController {

	private ReviewDAO rdao = null;
	
	public PastReview() {
		rdao = new ReviewDAO_imple();
	}

	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		
		if("get".equalsIgnoreCase(method)) {
			if(super.checkLogin(request)) {
				
				String userid = loginuser.getUserid(); // 사용자ID
//				String orderdetailno = request.getParameter("orderdetailno");
				//String reviewno = request.getParameter("reviewno");
				
//				Map<String, String> paraMap = new HashMap<String, String>();
//				paraMap.put("userid", userid);
//				paraMap.put("orderdetailno",orderdetailno);
//				paraMap.put("reviewno",reviewno);
	
				
				//작성한 리뷰 불러오기  //리스트 안에 리스트 써야함!!!!!!!!!!!!!!!
				List<ReviewVO> pastList = rdao.selectPreviewListAll(userid);
				//System.out.println(pastList.get(0).getTastenamelist().get(0).getTastename()); 
				
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

}
