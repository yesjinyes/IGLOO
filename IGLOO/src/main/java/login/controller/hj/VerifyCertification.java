package login.controller.hj;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class VerifyCertification extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// VerifyCertification 호출한 클래스 PwdFind.jsp
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			// === 작성한 인증코드 === //
			String userCertificationCode = request.getParameter("userCertificationCode");
			
			// === 작성한 userid === //
			String userid = request.getParameter("userid");
			
			// === 세션 불러오기 === //
        	HttpSession session = request.getSession();
        	String certification_code = (String)session.getAttribute("certification_code");	// object 타입 string 으로 casting
        	
        	String message = "";
        	String loc = "";
        	
        	boolean pwdeditRequest = false;
        	
        	if(certification_code.equals(userCertificationCode)) {

        		session.setAttribute("certification_ok", true);
        		session.setAttribute("userid", userid);
        		
        		super.setRedirect(true);
        		super.setViewPage(request.getContextPath() + "/login/pwdUpdate.ice");
        		return;
                ////////////////////////////////////////////////
        	}
        	else {
        		message = "발급된 인증코드가 아닙니다.\\n인증코드를 다시 발급받으세요!!";
        		// alert의 줄바꿈 => \\n
        		loc = request.getContextPath() + "/login/pwdFind.ice";
        		request.setAttribute("pwdeditRequest", pwdeditRequest);
        		
        		request.setAttribute("message", message);
            	request.setAttribute("loc", loc);
            	
            	super.setRedirect(false);
            	super.setViewPage("/WEB-INF/msg.jsp");
        	}
        	
		}	// end of if("POST".equalsIgnoreCase(method))-------------

	}

}
