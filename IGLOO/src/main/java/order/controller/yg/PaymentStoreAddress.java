package order.controller.yg;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.model.hj.ProductDAO;
import product.model.hj.ProductDAO_imple;

public class PaymentStoreAddress extends AbstractController {

	private ProductDAO pdao = null;
	
	public PaymentStoreAddress() {
		pdao = new ProductDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod(); // "GET" 또는 "POST" 
		
		if("POST".equalsIgnoreCase(method)) {
		
			String stname = request.getParameter("storename");
			
			// System.out.println(request.getParameter("storename"));
			
			// === 지점명에 따른 주소를 가져오는 메소드 === //
			Map<String, String> stAddress = pdao.getStaddress(stname); 
			
			String storename  = stAddress.get("storename");
			String storeaddress  = stAddress.get("storeaddress");
			
			JSONArray jsonArr = new JSONArray(); // []
			JSONObject jsonObject = new JSONObject(); // {}
			
			jsonObject.put("storename", storename);
			jsonObject.put("storeaddress", storeaddress);
			
			jsonArr.put(jsonObject); // [{"storename":지점명}, {"storeaddress":주소}]
			
			String json = jsonArr.toString();

			System.out.println("json ==>  " + json);
			
	        request.setAttribute("json", json);
			
		//	super.setRedirect(false); 
			super.setViewPage("/WEB-INF/jsonview.jsp");
		
		}		

	}

}
