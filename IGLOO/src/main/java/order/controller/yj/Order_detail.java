package order.controller.yj;

import java.util.List;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.model.yj.ProductDAO;
import product.model.yj.ProductDAO_imple;
import product.domain.TasteVO;

public class Order_detail extends AbstractController {

	private ProductDAO pdao = null;
	 
	public Order_detail() {
		pdao = new ProductDAO_imple();
	}   
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			
			List<TasteVO> tasteList = pdao.selectTasteList();
			request.setAttribute("tasteList", tasteList);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/order/order_detail.jsp");
		}
		else {
			
			
		}
		
		
		
		
		
		
	}

}
