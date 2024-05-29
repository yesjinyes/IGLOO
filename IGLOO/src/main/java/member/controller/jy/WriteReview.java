package member.controller.jy;

import java.util.List;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import member.model.jy.ReviewDAO;
import member.model.jy.ReviewDAO_imple;
import order.domain.OrderdetailVO;

public class WriteReview extends AbstractController {

	private ReviewDAO rdao = null;
	
	public WriteReview() {
		rdao = new ReviewDAO_imple();
	}

	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
		// 주문내역에서 맛 이미지 불러오기
		List<OrderdetailVO> odvoList = rdao.selectOrderListAll(loginuser.getUserid());
		
		// System.out.println(odvoList.get(0).getTastenamelist().get(0).getTastename()); 

		request.setAttribute("odvoList", odvoList);	
		
		super.setViewPage("/WEB-INF/member/writeReview.jsp");

	}

}
