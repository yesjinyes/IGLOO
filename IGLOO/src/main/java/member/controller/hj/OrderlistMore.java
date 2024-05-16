package member.controller.hj;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import member.model.hj.MemberDAO;
import member.model.hj.MemberDAO_imple;

public class OrderlistMore extends AbstractController {

	private MemberDAO mdao = null;
	
	public OrderlistMore() {
		mdao = new MemberDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// === Ajax(JSON) 사용하여 "더보기" 방식 페이징 처리 === //
		// int totalOrderlistCnt = mdao.totalOrderlistCnt();	// 모든 주문내역 조회
		// System.out.println("확인용 totalOrderlistCnt => " + totalOrderlistCnt);

		// super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/order_list.jsp");
	}

}
