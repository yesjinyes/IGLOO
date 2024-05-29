package myshop.controller.hj;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.model.hj.StoreDAO;
import myshop.model.hj.StoreDAO_imple;

public class SearchMapJSON extends AbstractController {

	private StoreDAO sdao = null;
	
	public SearchMapJSON() {
		sdao = new StoreDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String searchInput = request.getParameter("searchInput");
		// System.out.println(searchInput);
		
		List<Map<String, String>> storeList = sdao.getSearchStore(searchInput);
		
		JSONArray jsonArr = new JSONArray();
		
		if(storeList.size() > 0) {
			for(Map<String, String> storemap : storeList) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("storeno", storemap.get("storeno"));
				jsonObject.put("storename", storemap.get("storename"));
				jsonObject.put("storepage", storemap.get("storepage"));
				jsonObject.put("storeimg", storemap.get("storeimg"));
				jsonObject.put("storeaddress", storemap.get("storeaddress"));
				jsonObject.put("storetel", storemap.get("storetel"));
				jsonObject.put("latitude", storemap.get("latitude"));
				jsonObject.put("longitude", storemap.get("longitude"));
			
				jsonArr.put(jsonObject);
			}
		}
		
		String json = jsonArr.toString();
		
		request.setAttribute("json", json);
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");

	}

}
