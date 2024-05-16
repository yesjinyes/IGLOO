package member.controller.hj;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import member.model.hj.MemberDAO;
import member.model.hj.MemberDAO_imple;

public class Order_list extends AbstractController {

	private MemberDAO mdao = null;
	
	public Order_list() {
		mdao = new MemberDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.setRedirect(false);
        super.setViewPage("/WEB-INF/order/order_list.jsp");

	}

}
