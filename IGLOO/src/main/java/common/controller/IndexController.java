package common.controller;

import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.domain.ImageVO;
import myshop.model.ProductDAO;
import myshop.model.ProductDAO_imple;

public class IndexController extends AbstractController {

	private ProductDAO pdao = null;
	
	public IndexController() {
		pdao = new ProductDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*
		try {
			
			List<ImageVO> imgList = pdao.imageSelectAll();
			request.setAttribute("imgList", imgList);
			*/
			super.setRedirect(false);	// 값을 담아서 이동하므로 false
			super.setViewPage("/WEB-INF/homepage.jsp");
			/*
		}catch(SQLException e) {
			e.printStackTrace();
			super.setRedirect(true);	// 주소이동이므로
			super.setViewPage(request.getContextPath() + "/error.ice");
			
		}	// end of try~catch-------------------
		*/
		
	}

}
