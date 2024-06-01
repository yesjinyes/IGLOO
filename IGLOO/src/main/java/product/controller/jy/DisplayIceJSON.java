package product.controller.jy;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.domain.CartVO;
import product.domain.TasteVO;
import product.model.jy.MenuDAO;
import product.model.jy.MenuDAO_imple;

public class DisplayIceJSON extends AbstractController {
	
	
	private MenuDAO mdao = null;
	
	public DisplayIceJSON() {
		mdao = new MenuDAO_imple();
	}
	//<a href="<%= ctxPath%>/shop/prodView.up?pnum=${cartvo.fk_pnum}"> ajax대신 사용해돟될듯
	//<img src="<%= ctxPath%>/images/${cartvo.prod.pimage1}"
//	 List<CartVO> cartList = pdao.selectProductCart(loginuser.getUserid());  
//	  
//	  request.setAttribute("cartList", cartList); //컨트롤러는 dao에서 정보를 받아와서 뷰단에 뿌려준다.  MVC - 프로덕트VO, dao 참고
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String start = request.getParameter("start");
		String len = request.getParameter("len");
		String menuAlign = request.getParameter("menuAlign");  
		
		// System.out.println("menuAlign: "+menuAlign);
		
	/*
	    맨 처음에는 sname("HIT")상품을  start("1") 부터 len("8")개를 보여준다.
	    더보기... 버튼을 클릭하면  sname("HIT")상품을  start("9") 부터 len("8")개를 보여준다.
	    또  더보기... 버튼을 클릭하면 sname("HIT")상품을  start("17") 부터 len("8")개를 보여준다.      
    */	
		if(menuAlign == null || 
				   (!"name".equals(menuAlign) &&
				    !"order".equals(menuAlign) ) ){
			menuAlign = "name";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("start", start);  // start  "1"  "9"  "17"  "25"  "33"
		
		String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(len) - 1); 
		paraMap.put("end", end);      // end => start + len - 1; 
                                      // end    "8"   "16"  "24"  "32"  "40"
		
		List<TasteVO> tasteList = new ArrayList<TasteVO>();
		
		if("name".equals(menuAlign)) {
			
			tasteList = mdao.getMenuByName(paraMap);
		}
		
		else {
			
			tasteList = mdao.getMenuByOrder(paraMap);
		}
		
		
		
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if( tasteList.size() > 0 ) {
			// DB에서 조회해온 결과물이 있을 경우 
			
			for(TasteVO tvo : tasteList) {
				
				JSONObject jsonObj = new JSONObject(); // {}
				
				jsonObj.put("tnum", tvo.getTasteno());   // {"pnum":36}
				jsonObj.put("timg", tvo.getTasteimg());   // {"pnum":36}
				jsonObj.put("tname", tvo.getTastename());   // {"pnum":36}
				jsonObj.put("tgredi", tvo.getIngredients());   // {"pnum":36}

				jsonArr.put(jsonObj); // [{"pnum":36, "pname":"노트북30", "cname":"전자제품", ....... , "pinputdate":"2024-05-14", "discountPercent":17}] 
			}// end of for--------------------
			
		}// end of if----------------------------
		
		String json = jsonArr.toString(); // 문자열로 변환 
		// System.out.println(json);
		
		request.setAttribute("json", json); //뷰단에 뿌리깅
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
		
	}
}