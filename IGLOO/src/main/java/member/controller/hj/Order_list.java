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
				
				List <String> totaltastelist = new ArrayList<>();
				
				for(int i=0; i<orderdetailList.size(); i++) {
					for(int j=0; j<orderdetailList.get(i).getTastenamelist().size(); j++) {
						totaltastelist.add(orderdetailList.get(i).getTastenamelist().get(j).getTastename());
					}
				}	// end of for----------
				
				request.setAttribute("totaltastelist", totaltastelist);
				
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
		else {	// "POST" 일때
			
			if(loginuser != null) {
							
				String userid = loginuser.getUserid();
				
				String searchorderList = request.getParameter("searchorderList");
				String orderListPeriod = request.getParameter("orderListPeriod");
				String selectPeriodindex = request.getParameter("selectPeriodindex");
				/*
				System.out.println("확인용 => " + searchorderList);
				System.out.println("확인용 => " + orderListPeriod);
				System.out.println("확인용 => " + selectPeriodindex);
				*/
				
				if(searchorderList.isBlank()) {
					searchorderList = null;
				}
				
				List<OrderdetailVO> orderdetailList = null;
				String haveorderlist = "none";
				try {
					
					if(searchorderList != null) {
						// === 주문조회 검색창에 검색 === //
						Map<String,String> paraMap = new HashMap<>();
						
						paraMap.put("userid", userid);
						paraMap.put("searchorderList", searchorderList);						
						
						switch (searchorderList) {
							case "파인트":
							case "쿼터":
							case "패밀리":
							case "하프갤런":
								orderdetailList = cdao.productsearch(paraMap);
								break;
							default:	// 맛
								orderdetailList = cdao.tastesearch(paraMap);
								break;
						}	// end of switch--------------
					}
				}catch(NullPointerException e) {
					// === 주문조회 기간 설정 검색 === //
					Map<String,String> paraMap = new HashMap<>();
					
					paraMap.put("userid", userid);
					paraMap.put("orderListPeriod", orderListPeriod);
					
					orderdetailList = cdao.searchorderListPeriod(paraMap);
					// [기억] String 타입으로 받았으니 to_date() 사용하여 잘 연결하기
					
				}finally {	
					if(orderdetailList.size() > 0) {
						haveorderlist = "haveorderlist";
						
						List <String> totaltastelist = new ArrayList<>();
						
						for(int i=0; i<orderdetailList.size(); i++) {
							for(int j=0; j<orderdetailList.get(i).getTastenamelist().size(); j++) {
								totaltastelist.add(orderdetailList.get(i).getTastenamelist().get(j).getTastename());
							}
						}	// end of for----------
						// === 화면 띄워주기 위한 용도 === //
						request.setAttribute("totaltastelist", totaltastelist);
					}
					// === 화면 띄워주기 위한 용도 === //
					request.setAttribute("haveorderlist", haveorderlist);
					request.setAttribute("orderdetailList", orderdetailList);
					
					// === 검색 후 화면 유지해주기 위한 용도 === //
					request.setAttribute("searchorderList", searchorderList);
					request.setAttribute("selectPeriodindex", selectPeriodindex);
				}	// end of try~catch~finally-----------
				
				// super.setRedirect(false);	// forward
		        super.setViewPage("/WEB-INF/order/order_list.jsp");
		        
			}	// end of if(loginuser != null)------------
			
		}	// end of if~else------------

	}

}
