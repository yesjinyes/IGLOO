package order.controller.yj;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import product.model.yj.ProductDAO;
import product.model.yj.ProductDAO_imple;

public class InsertTaste extends AbstractController {

	private ProductDAO pdao = null;
	
	public InsertTaste() {
	      pdao = new ProductDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
		String pcode = request.getParameter("pcode");
		
		//System.out.println(method);
		//System.out.println(pcode);
		
		if(!"POST".equalsIgnoreCase(method)) {
			String message = "비정상적인 경로로 들어왔습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// super.setRedirect(false);	// forward
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		
		else {
			HttpSession session = request.getSession();
			
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
		    if(loginuser != null) {
		    	
		    	String userid = loginuser.getUserid();
		    	String tasteno = request.getParameter("tasteno");
		    	
		    	String[] tasteno_arr = tasteno.split(",");
		    	
		    	Map<String, Object> paraMap = new HashMap<>();
		    	paraMap.put("userid", userid);
		    	paraMap.put("tasteno_arr", tasteno_arr);
		    	paraMap.put("pcode", pcode);
		    
		    	int n = 0;
		    	try {
		    		n = pdao.insertTaste(paraMap);
		    		
		    		if(n == 1) {
		    			super.setRedirect(true);
		    			super.setViewPage(request.getContextPath() + "/member/order/payment.ice");
		    		}
		    		
		    	} catch(SQLException e) {
		    		request.setAttribute("message", "장바구니 담기 실패!!");

		    		
		    	}
		    	
		    	super.setRedirect(false);
				super.setViewPage("/WEB-INF/jsonview.jsp");
		    	
		    }// end of if(loginuser != null)--------------------
		    
		    else {
		    	System.out.println("로그인이 되지않았음.");
		    }
		    
		}// end of else --------------------------------------
		
		
		
		
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception--------------

}
