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
         
         // System.out.println("확인용 => " + searchorderList);
         // System.out.println("확인용 => " + orderListPeriod);
         
         List<OrderdetailVO> orderdetailList = new ArrayList<>();

         JSONArray jsonArr = new JSONArray();   // []
         JSONObject jsonObj = new JSONObject();   // {}
         
         try {
	         if(searchorderList != "") {
	        	 // === 주문조회 검색창에 검색 === //
	             Map<String,String> paraMap = new HashMap<>();
	               
	             paraMap.put("userid", userid);
	             paraMap.put("searchorderList", searchorderList);                  
	               
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
	         }  
	         else{
	         
	        	// System.out.println("주문조회기간설정");
	            // === 주문조회 기간 설정 검색 === //
	        	Map<String,String> paraMap = new HashMap<>();
	            
	            paraMap.put("userid", userid);
	            paraMap.put("orderListPeriod", orderListPeriod);	// 기간 설정 값
	            
	            // === 주문조회 기간 설정 검색 === //
	            orderdetailList = cdao.searchorderListPeriod(paraMap);
	         }
         }catch(SQLException e) {
        	 
         }	// end of try~catch-------------
         
         JSONArray jsonArr_info = new JSONArray();
         for(int i=0; i<orderdetailList.size(); i++) {
        	 JSONObject jsonObj_info = new JSONObject(); 
             JSONArray jsonarrtaste = new JSONArray();
               
             jsonObj_info.put("ordercode", orderdetailList.get(i).getFk_ordercode());
             jsonObj_info.put("orderdate", orderdetailList.get(i).getOrder().getOrderdate());
             jsonObj_info.put("orderprice", orderdetailList.get(i).getOrderprice());
             jsonObj_info.put("pickupstatus", orderdetailList.get(i).getPickupstatus());
             jsonObj_info.put("pickuptime", orderdetailList.get(i).getPickuptime());
             jsonObj_info.put("ordercount", orderdetailList.get(i).getOrdercount());
             jsonObj_info.put("productname", orderdetailList.get(i).getProduct().getProductname());
             jsonObj_info.put("productimg", orderdetailList.get(i).getProduct().getProductimg());
               
             for(int j=0; j<orderdetailList.get(i).getTastenamelist().size(); j++) {
            	 jsonarrtaste.put(orderdetailList.get(i).getTastenamelist().get(j).getTastename());
             }
               
             jsonObj_info.put("tastenamelist", jsonarrtaste);
             jsonArr_info.put(jsonObj_info);
         }
            
         // === 검색 후 화면 유지해주기 위한 용도 === //
         // request.setAttribute("searchorderList", searchorderList);
         // request.setAttribute("selectPeriodindex", selectPeriodindex);
            
         // jsonObj.put("selectPeriodindex", selectPeriodindex);
            
         jsonArr.put(jsonObj);
            
         // String json = jsonArr.toString();   // 문자열로 변환
         String json = jsonArr_info.toString();
         // System.out.println("확인용 json => " + json);
         // System.out.println("확인용 json_info => " + json_info);
            
         request.setAttribute("json", json);
         
         // super.setRedirect(false);
         super.setViewPage("/WEB-INF/jsonview.jsp");
      }
   }

}