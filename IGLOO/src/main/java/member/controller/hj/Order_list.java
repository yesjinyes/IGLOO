package member.controller.hj;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cart.model.hj.CartDAO;
import cart.model.hj.CartDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import order.domain.OrderdetailVO;

public class Order_list extends AbstractController {

	private CartDAO cdao = null;
	
	public Order_list() {
		cdao = new CartDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if("GET".equalsIgnoreCase(method)) {
			
			if(loginuser != null) {
				
				String userid = loginuser.getUserid();
				
				// === 해당 사용자의 주문내역 리스트 읽기 === //
				List <OrderdetailVO> orderdetailList = cdao.getOrderdetailList(userid);
				
				request.setAttribute("orderdetailList", orderdetailList);
				
				String haveorderlist = "none";
				
				try {
					int check = orderdetailList.size();
					if(check > 0) {
						haveorderlist = "haveorderlist";
					}
				}catch(Exception e) {
					
				}	// end of try~catch---------
				
				request.setAttribute("haveorderlist", haveorderlist);
				
				String[] totaltastelist = null;
				List <String[]> JJINtotaltastelist = new ArrayList<>();
				// List <Integer> orderproductpriceList = new ArrayList<>();
				
				// int orderproductprice= 0;
				for(int i=0; i<orderdetailList.size(); i++) {
					/*
					int cnt = orderdetailList.get(i).getOrdercount();
					int price = orderdetailList.get(i).getOrderprice();
					orderproductprice = cnt * price;
					*/
					totaltastelist = new String[orderdetailList.get(i).getTastenamelist().size()];
					for(int j=0; j<orderdetailList.get(i).getTastenamelist().size(); j++) {
						totaltastelist[j] = (orderdetailList.get(i).getTastenamelist().get(j).getTastename());
					}
					JJINtotaltastelist.add(totaltastelist);
					// System.out.println(JJINtotaltastelist);
					// orderproductpriceList.add(orderproductprice);
					
				}	// end of for----------
				
				request.setAttribute("jjintotaltastelist", JJINtotaltastelist);
				// request.setAttribute("orderproductpriceList", orderproductpriceList);
				
				// super.setRedirect(false);
		        super.setViewPage("/WEB-INF/order/order_list.jsp");
			
			}
			else {
				
				super.goBackURL(request);
				
				String message = "로그인이 필요합니다.";
		        String loc = request.getContextPath() + "/login/login.ice";
		        // 테이블 적용 후 이동 이전페이지(get 타입 변경)할 지 메인페이지 갈지 선정해야할 것
		         
		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		        
				super.setRedirect(false);
		        super.setViewPage("/WEB-INF/msg.jsp");
			}
		}
		

	}

}
