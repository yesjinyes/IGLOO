package order.controller.yj;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.domain.ProductVO;
import product.model.yj.ProductDAO;
import product.model.yj.ProductDAO_imple;


public class Order extends AbstractController {

	private ProductDAO pdao = null;
	   
	public Order() {
		pdao = new ProductDAO_imple();
	}
		
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			ProductVO product = pdao.getproduct();
			request.setAttribute("product", product);
			
			System.out.println("확인용 product => "+ product ); // product.domain.ProductVO@13c9675b 이런식으로 나옴......
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/order/order.jsp");
		}
		
		else {
			
		}
		
		
	}

}
