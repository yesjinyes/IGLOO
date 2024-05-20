package myshop.controller.hj;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.model.nr.StoreDAO;
import myshop.model.nr.StoreDAO_imple;

public class SearchList extends AbstractController {

private StoreDAO sdao = null;
	
	public SearchList() {
		sdao = new StoreDAO_imple();
	}
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
			List<Map<String, String>> storeList = sdao.viewStoreList();
			
			request.setAttribute("storeList", storeList);
			
			
			super.setRedirect(false); 	// forward
			super.setViewPage("/WEB-INF/store/storeSearchList.jsp");
		
	}

}
