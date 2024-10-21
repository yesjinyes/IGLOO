package member.controller.hj;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import cart.model.hj.CartDAO;
import cart.model.hj.CartDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import myshop.domain.CartVO;

public class CartJSON extends AbstractController {

	private CartDAO cdao = null;
	   
	public CartJSON() {
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
		else {
			HttpSession session = request.getSession();
		      
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		      
		    if(loginuser != null) {
		    	String userid = loginuser.getUserid();
		      
		        String cartno = request.getParameter("cartno");
		        String count = request.getParameter("count");
		        
		        // System.out.println("확인용 cartno : " + cartno);
		        // System.out.println("확인용 count : " + count);
		         
		        // === 해당 사용자의 장바구니 리스트 읽기 === //
				List <CartVO> cartList = new ArrayList<>();
				
				JSONArray jsonArr = new JSONArray();   // []
		        JSONObject jsonObj = new JSONObject();   // {}
		        
		        Map<String,String> paraMap = new HashMap<>();
		        
		        paraMap.put("userid", userid);
		        paraMap.put("cartno", cartno);
		        paraMap.put("count", count);
				
		        int n = 0;
		        try {
			        // === 카트번호에 따른 수량 업데이트 해주기 === //
			        n = cdao.updateCartlist(paraMap);
			        if(n==1){	// 업데이트 성공한 경우
			        	// === 업데이트 된 장바구니리스트부르기 === //
			        	cartList = cdao.refreshCartlist(paraMap);
			        	// System.out.println(cartList.size());
			        	
			        	int totalprice = 0;
				        for(int i=0; i<cartList.size(); i++) {
				        	
				        	int result_count = cartList.get(i).getCount();
							int result_price = cartList.get(i).getProduct().getPrice();
							// System.out.println("확인용 result_count : " + result_count);
							// System.out.println("확인용 result_price : " + result_price);
				        	totalprice += result_count * result_price;
				        
				        	// System.out.println(totalprice);
				        	if(Integer.parseInt(cartno) == cartList.get(i).getCartno()) {
				        		// System.out.println(cartno);
				        		jsonObj.put("cartno", cartList.get(i).getCartno());
				        		jsonObj.put("count", result_count);
				        		jsonObj.put("price", result_price);
				        	}
				        }	// end of for-----------
				        jsonObj.put("totalprice", totalprice);
			        }
		        }catch(SQLException e) {
		        	e.printStackTrace();
		        }
		        
		        jsonArr.put(jsonObj);
		        
		        String json = jsonArr.toString(); 
		        
		        request.setAttribute("json", json);
		        // System.out.println("확인용 json => " + json);
		        
		        // super.setRedirect(false);
		        super.setViewPage("/WEB-INF/jsonview.jsp");
		    }
		}
	}

}
