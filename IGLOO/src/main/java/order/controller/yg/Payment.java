package order.controller.yg;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import product.model.hj.ProductDAO;
import product.model.hj.ProductDAO_imple;

public class Payment extends AbstractController {

	private ProductDAO pdao = null;
	
	public Payment() {
		pdao = new ProductDAO_imple();
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
		
	    if("POST".equalsIgnoreCase(method) && orderplay == null) { // POST 방식이라면
			String str_cartno = request.getParameter("str_cartno");
			String str_selectno = request.getParameter("str_selectno");
			String totalprice = request.getParameter("totalprice");
			
//			System.out.println("확인용 str_cartno ==>  "+str_cartno);
			
			String[] cartno_arr = str_cartno.split("\\,");
			
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
	    else if("POST".equalsIgnoreCase(method) && "play".equals(orderplay)) {
	    	
			loginuser = (MemberVO)session.getAttribute("loginuser");
			
			String userid = loginuser.getUserid();
			System.out.println("확인용  ==>  " + userid);				// 확인용  ==>  jjoung
			String totalprice = request.getParameter("totalprice");	// 확인용  ==>  8000
			String cartno = request.getParameter("str_cartno");		// 확인용  ==>  5

			
			System.out.println("확인용  ==>  " +totalprice);					
	        System.out.println("확인용  ==>  " +cartno);
	        
			String productcode = pdao.getProductcodeno(userid);
			System.out.println("확인용  ==>  " +productcode);			// 확인용  ==>  P
			
			String ordercode = pdao.getOrdcode(productcode);
			String odrcode =  ordercode;
			System.out.println("확인용  ==>  " + odrcode);	    		// 확인용  ==>  P-20240530-14
			String str_selectno = request.getParameter("str_selectno");
			String[] selectno_arr = str_selectno.split(",");
			String[] cartno_arr = cartno.split(",");
			
			Map<String, Object> paraMap = new HashMap<>();

	        paraMap.put("odrcode", odrcode);	// 주문코드(명세서번호) s+날짜+sequence
	        paraMap.put("userid", userid);  	// 회원아이디
	        paraMap.put("totalprice", totalprice);  // 주문총액
	        paraMap.put("selectno_arr", selectno_arr); // 맛선택에 따라 발생한 선택일련번호
	        paraMap.put("cartno_arr", cartno_arr); // 장바구니 번호 
	        
	        // *** Transaction 처리를 해주는 메소드 호출하기 *** //
	        int isSuccess = pdao.productOrder(paraMap); // ■■■■■■■■■■ order와 ,orderdetail 테이블에 insert 해주는 메소드 ■■■■■■■■■■■
	        
	        
	        // **** 주문이 완료되었을시 세션에 저장되어져 있는 loginuser 정보를 갱신하고
	        //      이어서 주문이 완료되었다라는 email 보내주기  **** //
	        if(isSuccess==1) {
	        	// 세션에 저장되어져 있는 loginuser 정보를 갱신... 수업때는 이거 했는데 실제로 이거 해야하는지는 생각해보자
	        	System.out.println("■■■■■■■■■■■■■■여기서부터 이제 들어왔다면 결제하는 페이지로 이동시켜야한다■■■■■■■■■■■■■■■");
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
	    
	    
	    
		
		
		
		
		
		

	}

}
