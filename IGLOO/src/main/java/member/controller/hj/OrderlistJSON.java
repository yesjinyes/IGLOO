package member.controller.hj;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import cart.model.hj.CartDAO;
import cart.model.hj.CartDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import order.domain.OrderdetailVO;

public class OrderlistJSON extends AbstractController {

	private CartDAO cdao = null;
	
	public OrderlistJSON() {
		cdao = new CartDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
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
			/*
			if(searchorderList.isBlank()) {	// 검색창에 검색을 하지 않은경우
				searchorderList = null;
			}
			*/
			List<OrderdetailVO> orderdetailList = cdao.getOrderdetailList(userid);
			String haveorderlist = "none";
			
			try {
				int check = orderdetailList.size();
				if(check > 0) {
					haveorderlist = "haveorderlist";
				}
			}catch(Exception e) {
				
			}	// end of try~catch---------
			
			JSONArray jsonArr = new JSONArray();	// []
			JSONObject jsonObj = new JSONObject();	// {}
			
			try {
				
				if(searchorderList != null) {
					// === 주문조회 검색창에 검색 === //
					Map<String,String> paraMap = new HashMap<>();
					
					paraMap.put("userid", userid);
					paraMap.put("searchorderList", searchorderList);						
					
					// === 검색창 자리에 글씨 남기기용 === //
					jsonObj.put("searchorderList", searchorderList);	
					
					try {
						// === 제품, 맛 주문내역 검색하여 selectno 추출 === //
						List<String> selectnolist = cdao.searchorderlist(paraMap);
						
						String[] selectnoArr = new String[selectnolist.size()];
						
						// System.out.println(selectnolist.size());
						// 0 => 검색한 결과값이 없을 경우
						// 있을 경우는 다른 사이즈가 나옴
						
						for(int i=0; i<selectnolist.size(); i++) {
							selectnoArr[i] = selectnolist.get(i);
							// System.out.println("확인용 selectnolist : " + selectnolist.get(i));
						}
						
						String selecnoJoin = String.join(",", selectnoArr);
						// System.out.println("확인용 selecnoJoin : " + selecnoJoin);
						
						// === 추출한 selectno 가지고 list 추출 === //
						orderdetailList = cdao.finalSearchlist(selecnoJoin);
						
						// System.out.println("확인용 orderdetailList : " + orderdetailList);
						// System.out.println("확인용 orderdetailList.size() : " + orderdetailList.size());
					
						for(int i=0; i<orderdetailList.size(); i++) {
							jsonArr.put(orderdetailList);
						}	// end of for-----------
					}catch(SQLException e){		// 검색한 결과값이 없을 경우
						String noresult = "결과값없음";
						jsonObj.put("noresult",noresult);
					}
				}
			}catch(NullPointerException e) {
				// === 주문조회 기간 설정 검색 === //
				Map<String,String> paraMap = new HashMap<>();
				
				paraMap.put("userid", userid);
				paraMap.put("orderListPeriod", orderListPeriod);
				
				jsonObj.put("orderListPeriod", orderListPeriod);
				
				// === 주문조회 기간 설정 검색 === //
				orderdetailList = cdao.searchorderListPeriod(paraMap);
				jsonObj.put("orderdetailList", orderdetailList);
				
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
					// request.setAttribute("totaltastelist", totaltastelist);
					jsonObj.put("totaltastelist", totaltastelist);
				}
				jsonObj.put("haveorderlist", haveorderlist);
				
				// === 화면 띄워주기 위한 용도 === //
				// request.setAttribute("haveorderlist", haveorderlist);
				// request.setAttribute("orderdetailList", orderdetailList);
				
				// jsonObj.put("haveorderlist", haveorderlist);
				jsonObj.put("orderdetailList", orderdetailList);
				
				// === 검색 후 화면 유지해주기 위한 용도 === //
				// request.setAttribute("searchorderList", searchorderList);
				// request.setAttribute("selectPeriodindex", selectPeriodindex);
				
				jsonObj.put("selectPeriodindex", selectPeriodindex);
				
				jsonArr.put(jsonObj);
				
				String json = jsonArr.toString();	// 문자열로 변환
				System.out.println("확인용 json => " + json);
				
				request.setAttribute("json", json);
			}	// end of try~catch~finally-----------
			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
	}

}
