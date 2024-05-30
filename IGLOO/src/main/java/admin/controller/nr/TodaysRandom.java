package admin.controller.nr;

import org.json.JSONObject;

import admin.model.nr.AdminDAO;
import admin.model.nr.AdminDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.domain.TasteVO;

public class TodaysRandom extends AbstractController {

	private AdminDAO adao = null;
	
	public TodaysRandom() {
		adao = new AdminDAO_imple();
	}
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		double rnd = Math.random();
		int random = (int)(rnd*28+1);
		
		// System.out.println(random);
		
		TasteVO taste = adao.getRandomTaste(random);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("tasteno", taste.getTasteno());
		jsonObj.put("tastename", taste.getTastename());
		jsonObj.put("tasteimg", taste.getTasteimg());
		
		String json = jsonObj.toString();
		
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
