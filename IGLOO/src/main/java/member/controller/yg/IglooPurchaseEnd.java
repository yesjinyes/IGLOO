package member.controller.yg;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;

public class IglooPurchaseEnd extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 원포트(구 아임포트) 결제창을 하기 위한 전제조건은 먼저 로그인을 해야 하는 것이다. 
		
		if(super.checkLogin(request)) {
			// 로그인을 했으면
			
			String userid = request.getParameter("userid");
			String totalprice = request.getParameter("totalprice");
			String productname = request.getParameter("productname");
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser.getUserid().equals(userid)) {
				// 로그인한 사용자가 자신의 코인을 수정하는 경우
				
				// request.setAttribute("productPrice", 8000);
				request.setAttribute("email", loginuser.getEmail());
				request.setAttribute("name", loginuser.getName());
				request.setAttribute("mobile", loginuser.getMobile());
				request.setAttribute("totalprice", totalprice);
				request.setAttribute("productname", productname);
				
				String address = loginuser.getAddress() + loginuser.getDetailaddress() + loginuser.getExtraaddress();
				
				request.setAttribute("address", address);
				request.setAttribute("postcode", loginuser.getPostcode());
				
				
//				System.out.println("~~~ 확인용 email => " + loginuser.getEmail());
//				System.out.println("~~~ 확인용 email => " + loginuser.getMobile());
				
				request.setAttribute("userid", userid);
				
				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/member/paymentGateway.jsp");
			}
			else {
				// 로그인한 사용자가 다른 사용자의 코인을 충전하려고 결제를 시도하는 경우 
	            String message = "다른 사용자의 코인충전 결제 시도는 불가합니다.";
	            String loc = "javascript:history.back()";
	            
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	            
	         // super.setRedirect(false);
	            super.setViewPage("/WEB-INF/msg.jsp");
			}
		}
		else {
			// 로그인을 안했으면 
	         String message = "결제를 하기 위해서는 먼저 로그인을 하세요.";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	        // super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
		}

	}

}
