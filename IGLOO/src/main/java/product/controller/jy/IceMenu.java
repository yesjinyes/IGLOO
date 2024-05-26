package product.controller.jy;


import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.model.jy.MenuDAO;
import product.model.jy.MenuDAO_imple;


public class IceMenu extends AbstractController {

	private MenuDAO mdao = null;
	
	public IceMenu() {
		mdao = new MenuDAO_imple();
	}

	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		
		// === Ajax(JSON)를 사용하여 HIT 상품목록 "더보기" 방식으로 페이징 처리해서 보여주겠다. === // 
			int totalCount = mdao.totalCount(); // HIT 상품의 전체개수를 알아온다.
				
			System.out.println("~~~~ 확인용 totalHITCount : " + totalCount);
			// ~~~~ 확인용 totalHITCount : 36
			
			request.setAttribute("totalCount", totalCount);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/product/iceMenu.jsp");

	}

	
}









