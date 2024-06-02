package order.controller.yg;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import member.model.nr.MemberDAO;
import member.model.nr.MemberDAO_imple;
import product.model.hj.ProductDAO;
import product.model.hj.ProductDAO_imple;

public class Payment extends AbstractController {

	private ProductDAO pdao = null;
	private MemberDAO mdao = null;
	
	public Payment() {
		pdao = new ProductDAO_imple();
		mdao = new MemberDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*
			System.out.println("확인용 str_cartno : " + request.getParameter("str_cartno"));
			System.out.println("확인용 str_selectno : " + request.getParameter("str_selectno"));
			System.out.println("확인용 totalprice : " + request.getParameter("totalprice"));          전부 잘 넘어 왔습니다.
		*/
		String method = request.getMethod();
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String orderplay = request.getParameter("orderplay");
		
	    if("POST".equalsIgnoreCase(method) && orderplay == null) { // POST 방식이라면 ==> 결제창으로 이동하는 순간 이부분이 실행됨(구매하기 누르기 전)
			
	    	// 장바구니의 구매하기에서 이동해왔을 경우
	    	String str_cartno = request.getParameter("str_cartno");     // 장바구니 고유 번호
			String str_selectno = request.getParameter("str_selectno"); // 맛 선택 일련번호
			String totalprice = request.getParameter("totalprice");     // 결제 총금액
			
			String[] cartno_arr = str_cartno.split("\\,");
			
			// 문자를 보내주기 위해 정보를 넘겨주는 것
			MemberVO mvo = mdao.selectOneMember(loginuser.getUserid());
			request.setAttribute("mvo", mvo);
			
			// === 제품명 가져오는 메소드 생성하기 === //
			List<String> productname = pdao.get_productname_tbl_product(cartno_arr);
			String productname_str = String.join(",",productname);

			// === 지점명을 가져오는 메소드 생성하기 === //
			List<String> storename = pdao.get_storename();
			
			// payment.jsp 에 띄워줄 정보를 set 하는 부분
			request.setAttribute("storename", storename);
			request.setAttribute("mobile", loginuser.getMobile());
			
			request.setAttribute("str_cartno", str_cartno);
	        request.setAttribute("str_selectno", str_selectno);
	        request.setAttribute("totalprice", totalprice);
	        request.setAttribute("productname", productname);
	        request.setAttribute("productname_str", productname_str);

	        super.setRedirect(false);
			super.setViewPage("/WEB-INF/order/payment.jsp");
	    }
	    else if("POST".equalsIgnoreCase(method) && "play".equals(orderplay)) { // 구매하기를 누르면 play 가 제출면서 이 부분이 실행됨(구매하기 누른 후)
	    	
	    	String storenameOne = request.getParameter("storenameigloo");  // 선택한 지점명
	    	String require = request.getParameter("require");              // 사장님께 전할말씀
	    	
	    	// System.out.println(storenameOne + " " + require);
	    	
			loginuser = (MemberVO)session.getAttribute("loginuser");
			
			String userid = loginuser.getUserid();
			
			String cartno = request.getParameter("str_cartno");		// 확인용  ==>  5

			Map<String, Object> paraMap = new HashMap<>();
			if(cartno == null) {
				String totalprice = request.getParameter("totalprice");
				String productcode = request.getParameter("pcode");
				
				System.out.println(productcode);
				
				String ordercode = pdao.getOrdcode(productcode);
				String odrcode =  ordercode;
				String totalcount = request.getParameter("str_totalcount");
				paraMap.put("odrcode", odrcode);	// 주문코드(명세서번호) s+날짜+sequence
				paraMap.put("totalprice", totalprice);	
				paraMap.put("totalcount", totalcount);	
			}
			else {
				String totalprice = request.getParameter("totalprice");	// 확인용  ==>  8000
				String productcode = pdao.getProductcodeno(userid);
				String str_selectno = request.getParameter("str_selectno");
				String[] selectno_arr = str_selectno.split(",");
				String[] cartno_arr = cartno.split(",");
				String ordercode = pdao.getOrdcode(productcode);
				String odrcode =  ordercode;
				
				paraMap.put("odrcode", odrcode);	// 주문코드(명세서번호) s+날짜+sequence
				paraMap.put("totalprice", totalprice);  // 주문총액
				paraMap.put("selectno_arr", selectno_arr); // 맛선택에 따라 발생한 선택일련번호
				paraMap.put("cartno_arr", cartno_arr); // 장바구니 번호 
			}
	        
	        paraMap.put("userid", userid);  	// 회원아이디
	        paraMap.put("storenameOne", storenameOne);  // 선택한 지점명
	        paraMap.put("require", require);  // 사장님께 전할말씀 
	        
	        // *** Transaction 처리를 해주는 메소드 호출하기 *** //
	        int isSuccess = pdao.productOrder(paraMap); // ■■■■■■■■■■ order와 ,orderdetail 테이블에 insert 해주는 메소드 ■■■■■■■■■■■
	        
	        // **** 주문이 완료되었을시 세션에 저장되어져 있는 loginuser 정보를 갱신하고
	        //      이어서 주문이 완료되었다라는 email 보내주기  **** //
	        if(isSuccess==1) {
	        	
		    	String message = "주문조회 페이지로 이동합니다.";
		        String loc = "http://localhost:9090/IGLOO/member/mypage.ice";
		            
		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		           
		        // super.setRedirect(false);   
		        super.setViewPage("/WEB-INF/msg.jsp");
	        	
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
	    
	    
	    
		
		
		
		
		
		

	}

}
