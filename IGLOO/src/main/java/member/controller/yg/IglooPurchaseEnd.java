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
			
//			System.out.println("userid ==> " + userid);           // leenr
//			System.out.println("totalprice ==> " + totalprice);   // 18000
//			System.out.println("productname ==> " + productname); // 쿼터, 파인트
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser.getUserid().equals(userid)) {
				// 로그인한 사용자가 자신의 물건을 결제하는 경우
				
				request.setAttribute("email", loginuser.getEmail());
				request.setAttribute("name", loginuser.getName());
				request.setAttribute("mobile", loginuser.getMobile());
				request.setAttribute("totalprice", totalprice);
				request.setAttribute("productname", productname);
				
				String address = loginuser.getAddress() + loginuser.getDetailaddress() + loginuser.getExtraaddress();
				
				request.setAttribute("address", address);
				request.setAttribute("postcode", loginuser.getPostcode());
				request.setAttribute("userid", userid);
				/*
						System.out.println("email  ==> " + loginuser.getEmail());
						System.out.println("name  ==> " + loginuser.getName());
						System.out.println("Mobile  ==> " + loginuser.getMobile());
						System.out.println("totalprice  ==> " + totalprice);
						System.out.println("productname  ==> " + productname);
						System.out.println("address  ==> " + address);
						System.out.println("Postcode  ==> " + loginuser.getPostcode());
						System.out.println("userid  ==> " + userid);
						
						email  ==> 2nrlee@naver.com
						name  ==> 이나래
						Mobile  ==> 01063755956
						totalprice  ==> 18000
						productname  ==> 쿼터,파인트
						address  ==> 서울 관악구 남부순환로234길 6234 (봉천동)
						Postcode  ==> 08789
						userid  ==> leenr
				*/
				
				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/member/paymentGateway.jsp");
			}
			else {
				// 로그인한 사용자가 다른 사용자의 코인을 충전하려고 결제를 시도하는 경우 
	            String message = "다른 사용자의 결제 시도는 불가합니다.";
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
