package myshop.controller.hj;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.model.hj.ProductDAO;
import product.model.hj.ProductDAO_imple;

public class StoreLocationJSON extends AbstractController {

	private ProductDAO pdao = null;

	public StoreLocationJSON() {
		pdao = new ProductDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// === tbl_map(위,경도) 테이블에 있는 정보를 가져오기(select) === //
	    List<Map<String, String>> storeMapList = pdao.selectStoreMap(); 

	    JSONArray jsonArr = new JSONArray(); // []
	      
	    if(storeMapList.size() > 0) {
	    	for(Map<String, String> storeMap : storeMapList) {
	    		
	    		JSONObject jsonObj = new JSONObject(); // {}
	            
	            String storename = storeMap.get("STORENAME");
	            String storepage = storeMap.get("STOREPAGE");
	            String storeimg = storeMap.get("STOREIMG");
	            String storeaddress = storeMap.get("STOREADDRESS");
	            String storetel = storeMap.get("STORETEL");
	            double lat = Double.parseDouble(storeMap.get("LAT"));
	            double lng = Double.parseDouble(storeMap.get("LNG")) ;
	            int zIndex = Integer.parseInt(storeMap.get("ZINDEX"));
	            
	            jsonObj.put("storename", storename);
	            jsonObj.put("storepage", storepage);
	            jsonObj.put("storeimg", storeimg);
	            jsonObj.put("storeaddress", storeaddress);
	            jsonObj.put("storetel", storetel);
	            jsonObj.put("lat", lat);
	            jsonObj.put("lng", lng);
	            jsonObj.put("zIndex", zIndex);
	            
	            jsonArr.put(jsonObj); // [{},{},{},{},{}]
	        }// end of for---------------------
	    	
	    	String json = jsonArr.toString();
	        request.setAttribute("json", json);
	        
	        // super.setRedirect(false);
	        super.setViewPage("/WEB-INF/jsonview.jsp");
	        
	    }

	}

}
