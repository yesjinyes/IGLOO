package member.controller.hj;


import org.json.JSONObject;

import cart.model.hj.CartDAO;
import cart.model.hj.CartDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CartnodeleteJSON extends AbstractController {

	private CartDAO cdao = null;
	   
	public CartnodeleteJSON() {
      cdao = new CartDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			String message = "비정상적인 경로로 들어왔습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// super.setRedirect(false);	// forward
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		else if("POST".equalsIgnoreCase(method) && super.checkLogin(request)) {
			
			String cartno = request.getParameter("cartno");
			
			// === 장바구니에서 제거 === //
			int n = cdao.deleteCartno(cartno);
			
			JSONObject jsobj = new JSONObject();
			jsobj.put("n", n);
			
			String json = jsobj.toString();
			
			request.setAttribute("json", json);
			
			// super.setRedirect(false);	// forward
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}

	}

}
