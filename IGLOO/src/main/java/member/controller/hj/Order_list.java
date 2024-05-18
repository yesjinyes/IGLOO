package member.controller.hj;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import member.model.hj.MemberDAO;
import member.model.hj.MemberDAO_imple;

public class Order_list extends AbstractController {

	private MemberDAO mdao = null;
	
	public Order_list() {
		mdao = new MemberDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if("GET".equalsIgnoreCase(method)) {
			
			if(loginuser != null) {
				
				super.setRedirect(false);
		        super.setViewPage("/WEB-INF/order/order_list.jsp");
			
			}
			else {
				
				String message = "로그인이 필요합니다.";
		        String loc = request.getContextPath() + "/login/login.ice";
		        // 테이블 적용 후 이동 이전페이지(get 타입 변경)할 지 메인페이지 갈지 선정해야할 것
		         
		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		        
				super.setRedirect(false);
		        super.setViewPage("/WEB-INF/msg.jsp");
			}
		}

	}

}
