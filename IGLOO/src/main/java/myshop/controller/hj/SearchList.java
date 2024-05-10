package myshop.controller.hj;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SearchList extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.setRedirect(false); 	// forward
		super.setViewPage("/WEB-INF/store/storeSearchList.jsp");

	}

}
