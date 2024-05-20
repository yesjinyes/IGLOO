package product.controller.jy;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.domain.TasteVO;
import product.model.jy.MenuDAO;
import product.model.jy.MenuDAO_imple;

public class MenuListJSON extends AbstractController {

	private MenuDAO mdao = null;
	
	public MenuListJSON() {
		mdao = new MenuDAO_imple();
	}

	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		List<TasteVO> menuList = mdao.getMenuList();
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if(menuList.size() > 0) {
			// DB에서 조회해온 결과물이 있을 경우
			
			for(TasteVO tvo : menuList) {
				
				JSONObject jsonObj = new JSONObject(); // {}
				
				jsonObj.put("timg", tvo.getTasteimg());   // {"cnum":1}
				jsonObj.put("tname", tvo.getTastename());   // {"cnum":1, "code":"100000"} 
				jsonObj.put("tno", tvo.getTasteno()); // {"cnum":1, "code":"100000", "cname":"전자제품"}  
				
				jsonArr.put(jsonObj);  // [{"cnum":1, "code":"100000", "cname":"전자제품"},
				                       //  {"cnum":2, "code":"200000", "cname":"의류"},
				                       //  {"cnum":3, "code":"300000", "cname":"도서"}]
			}// end of for------------------------
			
		}// end of if-----------------------------
		
		String json = jsonArr.toString(); // 문자열로 변환 
		// 데이터가 없을시 "[]" 로 된다.
		
	//	System.out.println("~~~ 확인용 json => " + json);
		// ~~~ 확인용 json => [{"code":"100000","cname":"전자제품","cnum":1},{"code":"200000","cname":"의류","cnum":2},{"code":"300000","cname":"도서","cnum":3}]
		
		request.setAttribute("json", json);
		
    //	super.setRedirect(false);
        super.setViewPage("/WEB-INF/jsonview.jsp");

		
		
		
	}

}
