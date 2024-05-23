package product.controller.jy;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.domain.TasteVO;
import product.model.jy.MenuDAO;
import product.model.jy.MenuDAO_imple;

public class DisplayIceJSON extends AbstractController {
	
	
	private MenuDAO mdao = null;
	
	public DisplayIceJSON() {
		mdao = new MenuDAO_imple();
	}
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String start = request.getParameter("start");
		String len = request.getParameter("len");
	/*
	    맨 처음에는 sname("HIT")상품을  start("1") 부터 len("8")개를 보여준다.
	    더보기... 버튼을 클릭하면  sname("HIT")상품을  start("9") 부터 len("8")개를 보여준다.
	    또  더보기... 버튼을 클릭하면 sname("HIT")상품을  start("17") 부터 len("8")개를 보여준다.      
    */	
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("start", start);  // start  "1"  "9"  "17"  "25"  "33"
		
		String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(len) - 1); 
		paraMap.put("end", end);      // end => start + len - 1; 
                                      // end    "8"   "16"  "24"  "32"  "40"
		
		List<TasteVO> productList = mdao.selectIceAll(paraMap); 
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if( productList.size() > 0 ) {
			// DB에서 조회해온 결과물이 있을 경우 
			
			for(TasteVO tvo : productList) {
				
				JSONObject jsonObj = new JSONObject(); // {}
				
				jsonObj.put("tnum", tvo.getTasteno());   // {"pnum":36}
				jsonObj.put("timg", tvo.getTasteimg());   // {"pnum":36}
				jsonObj.put("tname", tvo.getTastename());   // {"pnum":36}
				jsonObj.put("tgredi", tvo.getIngredients());   // {"pnum":36}
				
				
				// jsonObj ==> {"pnum":36, "pname":"노트북30", "cname":"전자제품", ....... , "pinputdate":"2024-05-14", "discountPercent":17}    
				
				jsonArr.put(jsonObj); // [{"pnum":36, "pname":"노트북30", "cname":"전자제품", ....... , "pinputdate":"2024-05-14", "discountPercent":17}] 
			}// end of for--------------------
			
		}// end of if----------------------------
		
		String json = jsonArr.toString(); // 문자열로 변환 
		
	//	System.out.println("~~~ 확인용 json => " + json);
		/*
		 ~~~ 확인용 json => [{"pnum":36,"discountPercent":17,"pname":"노트북30","pcompany":"삼성전자","cname":"전자제품","saleprice":1000000,"point":60,"pinputdate":"2024-05-14","pimage1":"59.jpg","pqty":100,"pimage2":"60.jpg","pcontent":"30번 노트북","price":1200000,"sname":"HIT"}
		                  ,{"pnum":35,"discountPercent":17,"pname":"노트북29","pcompany":"레노버","cname":"전자제품","saleprice":1000000,"point":60,"pinputdate":"2024-05-14","pimage1":"57.jpg","pqty":100,"pimage2":"58.jpg","pcontent":"29번 노트북","price":1200000,"sname":"HIT"}
		                  ,{"pnum":34,"discountPercent":17,"pname":"노트북28","pcompany":"아수스","cname":"전자제품","saleprice":1000000,"point":60,"pinputdate":"2024-05-14","pimage1":"55.jpg","pqty":100,"pimage2":"56.jpg","pcontent":"28번 노트북","price":1200000,"sname":"HIT"}
		                  ,{"pnum":33,"discountPercent":17,"pname":"노트북27","pcompany":"애플","cname":"전자제품","saleprice":1000000,"point":60,"pinputdate":"2024-05-14","pimage1":"53.jpg","pqty":100,"pimage2":"54.jpg","pcontent":"27번 노트북","price":1200000,"sname":"HIT"}
		                  ,{"pnum":32,"discountPercent":17,"pname":"노트북26","pcompany":"MSI","cname":"전자제품","saleprice":1000000,"point":60,"pinputdate":"2024-05-14","pimage1":"51.jpg","pqty":100,"pimage2":"52.jpg","pcontent":"26번 노트북","price":1200000,"sname":"HIT"}
		                  ,{"pnum":31,"discountPercent":17,"pname":"노트북25","pcompany":"삼성전자","cname":"전자제품","saleprice":1000000,"point":60,"pinputdate":"2024-05-14","pimage1":"49.jpg","pqty":100,"pimage2":"50.jpg","pcontent":"25번 노트북","price":1200000,"sname":"HIT"}
		                  ,{"pnum":30,"discountPercent":17,"pname":"노트북24","pcompany":"한성컴퓨터","cname":"전자제품","saleprice":1000000,"point":60,"pinputdate":"2024-05-14","pimage1":"47.jpg","pqty":100,"pimage2":"48.jpg","pcontent":"24번 노트북","price":1200000,"sname":"HIT"}
		                  ,{"pnum":29,"discountPercent":17,"pname":"노트북23","pcompany":"DELL","cname":"전자제품","saleprice":1000000,"point":60,"pinputdate":"2024-05-14","pimage1":"45.jpg","pqty":100,"pimage2":"46.jpg","pcontent":"23번 노트북","price":1200000,"sname":"HIT"}
		                  ] 
		                  
		 ~~~ 확인용 json => []              
		*/
		
		request.setAttribute("json", json);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");

		
		
	}

}
