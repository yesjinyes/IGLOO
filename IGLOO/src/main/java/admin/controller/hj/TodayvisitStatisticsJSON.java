package admin.controller.hj;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import member.model.hj.MemberDAO;
import member.model.hj.MemberDAO_imple;

public class TodayvisitStatisticsJSON extends AbstractController {

	private MemberDAO mdao = null;
	
	public TodayvisitStatisticsJSON() {
		mdao = new MemberDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser != null && "admin".equals(loginuser.getUserid())) {
			
			// === 최근2주 방문 통계 === //
			List<Map<String, String>> loginhistoryList = mdao.loginhistoryList();
			
            JSONArray jsonarr = new JSONArray();
			
            for(int i=0; i<loginhistoryList.size(); i++) {
            	
            	JSONObject jsonobj = new JSONObject();
            	jsonobj.put("todaylogincnt", loginhistoryList.get(i).get("todaylogincnt"));
            	jsonobj.put("logindate", loginhistoryList.get(i).get("logindate"));
            	
            	jsonarr.put(jsonobj);
            	
            }	// end of for-------------------
            
            String json = jsonarr.toString();
            
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}

	}

}
