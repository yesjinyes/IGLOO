package order.controller.yj;

import java.util.List;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.model.yj.ProductDAO;
import product.model.yj.ProductDAO_imple;
import product.domain.ProductVO;
import product.domain.TasteVO;

public class Order_detail extends AbstractController { 

	private ProductDAO pdao = null;

	public Order_detail() {
		pdao = new ProductDAO_imple();
	}   

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			String pcode = request.getParameter("pcode");
			
			ProductVO pvo = pdao.getproductList_2(pcode);
			
			request.setAttribute("pvo", pvo);
			
			// == 맛 목록을 조회해오기 == //
			List<TasteVO> tasteList = pdao.selectTasteList();
			request.setAttribute("tasteList", tasteList);
		}
		
		if("POST".equalsIgnoreCase(method)) {
			
			if(!super.checkLogin(request)) {
		
				super.goBackURL(request);
				
				String message = "로그인이 필요합니다.";
		        String loc = request.getContextPath() + "/login/login.ice";
		        // 테이블 적용 후 이동 이전페이지(get 타입 변경)할 지 메인페이지 갈지 선정해야할 것
		         
		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		        
				super.setRedirect(false);
		        super.setViewPage("/WEB-INF/msg.jsp");
			}
		/*
			else {
				
				
				
			}
			*/
		}// end of if("POST".equalsIgnoreCase(method))-----------------
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/order_detail.jsp");

	}
}



