package admin.controller.nr;

import java.util.HashMap;
import java.util.Map;

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
		
		// System.out.println(orderdetailno+", "+pickupTime+", "+status); //확인 완료
		// pickupTime은 설정하지 않을 시 null이 아닌 ""으로 넘어옴.
		
		Map<String, String> paramap = new HashMap<String, String>();
		
		paramap.put("orderdetailno", orderdetailno);
		paramap.put("pickupTime", pickupTime);
		paramap.put("status", status);
		
		int n = adao.updateOrder(paramap);
		
		if(n==1) {
			System.out.println("성공");
		}
		
		else {
			System.out.println("실패");
		}
	}

}
