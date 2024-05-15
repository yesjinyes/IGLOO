package member.controller.hj;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import member.model.hj.MemberDAO;
import member.model.hj.MemberDAO_imple;

public class Cart extends AbstractController {

	private MemberDAO mdao = null;
	
	public Cart() {
		mdao = new MemberDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// [보류] 내 정보 넘겨줘야 한다. MyMVC MemberEdit 참조
		// super.setRedirect(false);
        super.setViewPage("/WEB-INF/order/cart.jsp");


	}

}
