package product.controller.jy;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.model.jy.MenuDAO;
import product.model.jy.MenuDAO_imple;

public class MenuDetail extends AbstractController {

	private MenuDAO mdao = null;
	
	public MenuDetail() {
		mdao = new MenuDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		//저장소에 맛이름, 맛설명 넣기
		
		
		
		setViewPage("/WEB-INF/product/menuDetail.jsp");

	}

}
