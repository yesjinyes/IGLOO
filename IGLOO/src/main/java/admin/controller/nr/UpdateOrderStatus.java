package admin.controller.nr;

import admin.model.nr.AdminDAO;
import admin.model.nr.AdminDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class UpdateOrderStatus extends AbstractController {

	private AdminDAO adao = null;
	
	public UpdateOrderStatus() {
		adao = new AdminDAO_imple();
	}
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String orderdetailno = request.getParameter("orderdetailno");
		String pickupTime = request.getParameter("pickupTime");
		String status = request.getParameter("status");
		
		// System.out.println(orderdetailno+", "+pickupTime+", "+status); 확인 완료
		
		
		
		// adao.updateOrder();
		
	}

}
