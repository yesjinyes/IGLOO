package order.controller.yg;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import product.domain.SelectlistVO;
import product.model.hj.ProductDAO;
import product.model.hj.ProductDAO_imple;

public class Payment extends AbstractController {

	private ProductDAO pdao = null;
	
	public Payment() {
		pdao = new ProductDAO_imple();
	}

	// === 전표(주문코드)를 생성해주는 메소드 생성하기 === //
		private String getOrdercode() {	// 컬럼명
			
			// 날짜 생성
			Date now = new Date();
			SimpleDateFormat smdatefm = new SimpleDateFormat("yyyyMMdd"); 
			String today = smdatefm.format(now);
			
			int seq = 0;
			String productcodeno = "";
			try {
				SelectlistVO selectlist = new SelectlistVO();
			
				productcodeno = selectlist.getFk_productcodeno();

				// 주문코드를 위한 시퀀스 번호 select 해오기
				seq = pdao.get_seq_tbl_order();

			} catch(SQLException e) {
				
				super.setRedirect(false);
				super.setViewPage("javascript:history.back()");
			}
			
			return productcodeno +"-" +  today + "-" + seq;
			// P-20240528-10
		} //  end of private String getOrdercode() {}-----------------------------------------------
		
		
		// === price와 count 컬럼을 가져와서 곱해주고 set 해주는 메소드 생성하기 === //
		/*
		private String getordercount() { // 컬럼명
			
			String orderCount = ""; // 이걸로 메소드 리턴값 저장해줄거임!!
			try {
				SelectlistVO selectlist = new SelectlistVO();
				
				productcodeno = selectlist.getFk_productcodeno();
				
				// 주문코드를 위한 시퀀스 번호 select 해오기
				orderCount = pdao.get_seq_tbl_order();
				
			} catch(SQLException e) {
				
				super.setRedirect(false);
				super.setViewPage("javascript:history.back()");
			}
			return productcodeno +"-" +  today + "-" + seq;
			// P-20240528-10
		} //  end of private String getOrdercode() {}-----------------------------------------------
		 */
		
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*
			System.out.println("확인용 str_cartno : " + request.getParameter("str_cartno"));
			System.out.println("확인용 str_selectno : " + request.getParameter("str_selectno"));
			System.out.println("확인용 totalprice : " + request.getParameter("totalprice"));          전부 잘 넘어 왔습니다.
		*/
		String method = request.getMethod();
		
	    if("POST".equalsIgnoreCase(method)) {	// POST 방식이라면
				
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
				
				String userid = loginuser.getUserid();
				String totalPrice = request.getParameter("totalPrice");
				String cartno = request.getParameter("cartno");
				String odrcode =  getOrdercode();
				String str_selectno = request.getParameter("str_selectno");
				
				Map<String, Object> paraMap = new HashMap<>();
		        
		        paraMap.put("odrcode", odrcode);	// 주문코드(명세서번호) s+날짜+sequence
		        // getOdrcode() 메소드는 위에서 정의한 전표(주문코드)를 생성해주는 것이다. 
		        
		        paraMap.put("userid", userid);  	// 회원아이디
		        paraMap.put("totalPrice", totalPrice);  // 주문총액
		        
		        String[] selectno_arr = str_selectno.split(",");
		        String[] cartno_arr = cartno.split(",");
		        
		        paraMap.put("selectno_arr", selectno_arr); // 맛선택에 따라 발생한 선택일련번호
		        paraMap.put("cartno_arr", cartno_arr); // 장바구니 번호 
		        
		        // === 장바구니테이블(tbl_cart)에 delete 할 데이터 ===
		        if(cartno != null) {
		        	// 특정제품을 바로주문하기를 한 경우라면 str_cartno_join 의 값은 null 이 된다.
		        	
		        	paraMap.put("cartno_arr", cartno_arr);
		        }
		        
		        // *** Transaction 처리를 해주는 메소드 호출하기 *** //
		        int isSuccess = pdao.productOrder(paraMap); // ■■■■■■■■■■ order와 ,orderdetail 테이블에 insert 해주는 메소드 ■■■■■■■■■■■
		        
		        // **** 주문이 완료되었을시 세션에 저장되어져 있는 loginuser 정보를 갱신하고
		        //      이어서 주문이 완료되었다라는 email 보내주기  **** //
		        if(isSuccess==1) {
		        	// 세션에 저장되어져 있는 loginuser 정보를 갱신... 수업때는 이거 했는데 실제로 이거 해야하는지는 생각해보자
		        	
		        	//////////////////////////////////////////////////////////////////////////////////
		        	// === 주문이 완료되었다는 email 보내기 시작 === //
		        	
		        	// === 주문이 완료되었다는 email 보내기 끝 === //
		        	//////////////////////////////////////////////////////////////////////////////////
		        }
	         
	    }
	    else {	// GET 방식이라면
	    	
	    	String message = "비정상적인 경로로 들어왔습니다";
	        String loc = "javascript:history.back()";
	            
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	           
	        // super.setRedirect(false);   
	        super.setViewPage("/WEB-INF/msg.jsp");
	        
	    }
	    
	    
	    
		
		
		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/payment.jsp");

	}

}
