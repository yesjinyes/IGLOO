package myshop.controller.hj;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Igloo_hongdae extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// super.setRedirect(false); 	// forward
		super.setViewPage("/WEB-INF/store/igloo_hongdae.jsp");

	}

}
