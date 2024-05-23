package admin.controller.yg;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ProductRegister extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) { // "GET" 이라면    // ■■■■■ 이건 헤더에서 제품등록을 눌렀을 때, get방식으로 보낼경우.  ■■■■■
            
            super.setRedirect(false);
            super.setViewPage("/WEB-INF/admin/productRegister.jsp"); 
        }
        else { // "POST" 이라면 
       	 
        }
		
	}

}
