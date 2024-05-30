package login.controller.yj;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import member.model.yj.MemberDAO;
import member.model.yj.MemberDAO_imple;

public class PwdUpdate_3months extends AbstractController {

	private MemberDAO mdao = null;
	   
    public PwdUpdate_3months() {
    	mdao = new MemberDAO_imple();
    }
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");

		String userid = loginuser.getUserid();
		
	    String method = request.getMethod();
	    
	    // == 비밀번호 변경으로 이동 == //
	    if("POST".equalsIgnoreCase(method) && userid != null) {

	    	 // "비밀번호변경" 버튼을 클릭했을 때
	         String pwd1 = request.getParameter("pwd1");
	 		 String pwd2 = request.getParameter("pwd2");
	 		 //String pwd3 = request.getParameter("pwd3");
	         
	         Map<String, String> paraMap = new HashMap<>(); 
	         paraMap.put("userid", userid);
	         paraMap.put("pwd1", pwd1);
	         paraMap.put("pwd2", pwd2);
	         
	         String checkpwd = mdao.checkPwd(paraMap);
        	 //System.out.println(checkpwd); // 이전과 같은 비밀번호를 입력했을 때는 fail, 새로운 비밀번호를 입력했을 때는 통과
        	 if("fail".equals(checkpwd)) {
        		 
        		 String message = "비밀번호가 이전과 같습니다. 새로운 비밀번호를 입력해주세요.";	// 메시지
        		 String loc = request.getContextPath()+"/login/pwdUpdate_3months.ice";	// 다시 비밀번호 변경창으로 이동
        		 
        		 request.setAttribute("message", message);
        		 request.setAttribute("loc", loc);
        		 
        		 super.setRedirect(false); 
		         super.setViewPage("/WEB-INF/msg.jsp");
        		 return;
        		 
        	 }
        	 
        	 else {
		         int n = 0;
		         
		         try {
		        	 n = mdao.pwdUpdate_3months(paraMap);
		         } catch(SQLException e) {
		             e.printStackTrace();
		         }
		         
		         request.setAttribute("n", n); 
		         //System.out.println("확인용 n : " + n);
		         
		         if(n == 1) {
		        	 String message = "비밀번호 변경이 완료되었습니다.";	// 메시지
	        		 String loc = request.getContextPath()+"/index.ice";  // 새로운 비밀번호 입력하여 변경 성공 시 메인 페이지로 이동
	        		 
	        		 request.setAttribute("message", message);
	        		 request.setAttribute("loc", loc);
	        		 
	        		 super.setRedirect(false); 
			         super.setViewPage("/WEB-INF/msg.jsp");
			         
		             return;
		         }
        	 }// end of if("fail".equals(checkpwd)) ~ else ------------------------
        	 
	    }// end of if("POST".equalsIgnoreCase(method))--------------
	    
	    else { 
			request.setAttribute("userid", userid);
			
			session.removeAttribute("userid");
			
			super.setRedirect(false);	// forward
			super.setViewPage("/WEB-INF/login/pwdUpdate_3months.jsp");
	    }
	}

}
