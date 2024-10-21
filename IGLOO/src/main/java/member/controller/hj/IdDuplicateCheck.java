package member.controller.hj;

import org.json.JSONObject;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import member.model.hj.MemberDAO;
import member.model.hj.MemberDAO_imple;

public class IdDuplicateCheck extends AbstractController {

	private MemberDAO mdao = null;
	
	public IdDuplicateCheck() {
		mdao = new MemberDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();	// "GET" 또는 "POST"
		
		if("POST".equalsIgnoreCase(method)) {
		
			String userid = request.getParameter("userid");
			
			// === userid 의 존재유무 파악 === //
			boolean isExists = mdao.idDuplicateCheck(userid);
			
			JSONObject jsonObj = new JSONObject();	// {}	// JSONObject import
			// {"key":value}
			
			jsonObj.put("isExists", isExists);	// {"isExists": true} 또는 {"isExists": false}
			
			String json = jsonObj.toString();
			
			// System.out.println(">> 확인용 json => " + json);
			/*
				>> 확인용 json => {"isExists":true}
				>> 확인용 json => {"isExists":false}
			*/
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
	}

}
