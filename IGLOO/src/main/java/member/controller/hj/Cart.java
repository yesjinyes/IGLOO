package member.controller.hj;

import java.util.List;

import cart.model.hj.CartDAO;
import cart.model.hj.CartDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import myshop.domain.CartVO;

public class Cart extends AbstractController {
	
	private CartDAO cdao = null;
	
	public Cart() {
		cdao = new CartDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		HttpSession session = request.getSession();
		MemberVO loginuser = null;
		
		if("GET".equalsIgnoreCase(method)) {
			loginuser = (MemberVO) session.getAttribute("loginuser");
			
			if(loginuser != null) {
				
				String userid = loginuser.getUserid();
				
				// === 해당 사용자의 장바구니 리스트 읽기 === //
				List <CartVO> cartList = cdao.getCartlist(userid);
				
				request.setAttribute("cartList", cartList);
				
				String havecart = "none";
				try {
					int check = cartList.size();
					if(check > 0) {
						havecart = "havecart";
					}
				}catch(Exception e) {
					
				}
				request.setAttribute("havecart", havecart);
				
				/* 확인용
				System.out.println(cartList.size());

				for(int i =0; i<cartList.size(); i++) {
					System.out.println(cartList.get(i).getProduct().getProductname());
					for(int j=0; j<cartList.get(i).getTalstenamelist().size(); j++) {
						System.out.println(cartList.get(i).getTalstenamelist().get(j).getTastename());	
					}
				}
				*/
				// super.setRedirect(false);
		        super.setViewPage("/WEB-INF/order/cart.jsp");
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
