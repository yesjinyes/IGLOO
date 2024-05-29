package common.controller;


import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.domain.ProductVO;
import product.domain.TasteVO;
import product.model.nr.ProductDAO;
import product.model.nr.ProductDAO_imple;

public class IndexController extends AbstractController {

	private ProductDAO pdao = null;
	
	public IndexController() {
		pdao = new ProductDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		List<ProductVO> productList = pdao.getMainProduct();
	
		request.setAttribute("productList", productList);
		
		List<TasteVO> tasteList = pdao.getMainTaste();
	
		request.setAttribute("tasteList", tasteList);
		
		super.setRedirect(false);	// 값을 담아서 이동하므로 false
		super.setViewPage("/WEB-INF/homepage.jsp");

		
	}

}
