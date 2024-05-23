package admin.controller.nr;

import java.util.List;

import admin.model.nr.AdminDAO;
import admin.model.nr.AdminDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import order.domain.OrderdetailVO;

public class OrderListAll extends AbstractController {

	private AdminDAO adao = null;
	
	public OrderListAll() {
		adao = new AdminDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String message = "";
		String loc = "";
		
		
		if(loginuser != null && "admin".equals(loginuser.getUserid())) {
			
			List<OrderdetailVO> odvoList = adao.selectOrderListAll();
			
			// System.out.println(odvoList.get(1).getTastenamelist().get(0).getTastename());
			// System.out.println(odvoList.get(1).getTastenamelist().get(1).getTastename());
			// System.out.println(odvoList.get(1).getTastenamelist().get(2).getTastename()); // 확인 완료
			
			request.setAttribute("odvoList", odvoList);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/orderListAll.jsp");
			
		}
		
		else {
			message = "관리자 전용 메뉴이므로 접근 불가합니다.";
			loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
			
	}

}
