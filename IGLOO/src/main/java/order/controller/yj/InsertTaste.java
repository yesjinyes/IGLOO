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
		//System.out.println("pcode : " + pcode);
		
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
		    
		    	int selectListResult = 0;
		    	try {
		    		// == TBL_SELECTLIST 에 insert 하는 메소드 생성 == //
		    		Map<String, Integer> map  = pdao.insertSelectList(paraMap);
		    		selectListResult = map.get("selectListResult");
		    		
		    		if(selectListResult == 1) {
		    			//System.out.println("selectList 띄우기 성공 ^^~~");
		    			
		    			paraMap.put("selectno", map.get("selectno")); // selectList 에서 알아낸 selectno를 paraMap 에 넣어주기
		    			
		    			
		    			// == TBL_TASTESELECT 에 insert 하는 메소드 생성 == //
		    			int tasteListResult = pdao.insertTasteList(paraMap);
		    			
		    			if(tasteListResult == tasteno_arr.length) { // tbl_tasteselect 에 insert 되었는지 확인
		    				//System.out.println("tasteList insert 성공~~^^");
		    			}
		    			
		    			
		    			// == TBL_CART 에 insert 하는 메소드 생성 == //
		    			int cartListResult = pdao.insertCartList(paraMap);
		    			
		    			if(cartListResult == 1) { // tbl_cart 에 insert 되었는지 확인
		    				// System.out.println("tbl_cart 에 insert 성공 ~~^^");
		    			}
		    			
		    			super.setRedirect(false);
		    			super.setViewPage("/WEB-INF/order/payment.jsp");
		    			
//		    			super.setRedirect(true);
//		    			super.setViewPage(request.getContextPath() + "/member/order/payment.ice");
		    		}
		    		
		    	} catch(SQLException e) {
		    		
		    		String message = "구매 실패";
			        String loc = request.getContextPath() + "/order/order_detail.ice";
			        // 테이블 적용 후 이동 이전페이지(get 타입 변경)할 지 메인페이지 갈지 선정해야할 것
			         
			        request.setAttribute("message", message);
			        request.setAttribute("loc", loc);
			        
					super.setRedirect(false);
			        super.setViewPage("/WEB-INF/msg.jsp");
		    		
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
