//
//package product.controller.jy;
//
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import org.json.JSONArray;
//import org.json.JSONObject;
//
//import common.controller.AbstractController;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import product.domain.TasteVO;
//import product.model.jy.MenuDAO;
//import product.model.jy.MenuDAO_imple;
//
//public class MenuListJSON extends AbstractController {
//
//	private MenuDAO mdao = null;
//	
//	public MenuListJSON() {
//		mdao = new MenuDAO_imple();
//	}
//
//	
//
//	@Override
//	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		
//		String start = request.getParameter("start");
//		String len = request.getParameter("len");
//		
//		
//		Map<String, String> paraMap = new HashMap<>();
//		paraMap.put("start", start);  // start  "1"  "9"  "17"  "25"  "33"
//		
//		String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(len) - 1); 
//		paraMap.put("end", end);      // end => start + len - 1; 
//
//		
//		List<TasteVO> menuList = mdao.getMenuList(paraMap);
//		
//		JSONArray jsonArr = new JSONArray(); // []
//		
//		if(menuList.size() > 0) {
//			//DB에 데이터가 있을 경우 더보기 방식으로 상품정보 8개씩 잘라서 조회해오기
//			
//			for(TasteVO tvo : menuList) {
//				
//				JSONObject jsonObj = new JSONObject(); // {}
//				
//				jsonObj.put("timg", tvo.getTasteimg());   // {"cnum":1}
//				jsonObj.put("tname", tvo.getTastename());   // {"cnum":1, "code":"100000"} 
//				jsonObj.put("tno", tvo.getTasteno()); // {"cnum":1, "code":"100000", "cname":"전자제품"}  
//				jsonObj.put("tgredi", tvo.getIngredients()); // {"cnum":1, "code":"100000", "cname":"전자제품"}  
//				
//				jsonArr.put(jsonObj);  // [{"cnum":1, "code":"100000", "cname":"전자제품"},
//				                       //  {"cnum":2, "code":"200000", "cname":"의류"},
//				                       //  {"cnum":3, "code":"300000", "cname":"도서"}]
//			}// end of for------------------------
//			
//		}// end of if-----------------------------
//		
//		String json = jsonArr.toString(); // 문자열로 변환 
//		// 데이터가 없을시 "[]" 로 된다.
//		
//	//	System.out.println("~~~ 확인용 json => " + json);
//		// ~~~ 확인용 json => [{"code":"100000","cname":"전자제품","cnum":1},{"code":"200000","cname":"의류","cnum":2},{"code":"300000","cname":"도서","cnum":3}]
//		
//		request.setAttribute("json", json);
//		
//    //	super.setRedirect(false);
//        super.setViewPage("/WEB-INF/jsonview.jsp");
//
//		
//		
//		
//	}
//
//}