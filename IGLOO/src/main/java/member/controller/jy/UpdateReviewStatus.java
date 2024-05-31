package member.controller.jy;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import member.model.jy.ReviewDAO;
import member.model.jy.ReviewDAO_imple;

public class UpdateReviewStatus extends AbstractController {

	private ReviewDAO rdao = null;
	
	public UpdateReviewStatus() {
		rdao = new ReviewDAO_imple();
	}

	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		
		
	}

}
