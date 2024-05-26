package product.controller.nr;

import admin.model.nr.AdminDAO;
import admin.model.nr.AdminDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.domain.TasteVO;
import product.model.nr.ProductDAO;
import product.model.nr.ProductDAO_imple;

public class MenuDetail extends AbstractController {

	private ProductDAO pdao = null;
	
	public MenuDetail() {
		pdao = new ProductDAO_imple();
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String tasteno = request.getParameter("tasteno");
		
		// System.out.println(tasteno);
		
		TasteVO tvo = pdao.getMenuDetail(tasteno);
		
		request.setAttribute("tvo", tvo);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/menuDetail.jsp");
		
		
		
	}

}
