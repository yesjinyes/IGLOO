package login.controller.hj;

import java.util.HashMap;
import java.util.Map;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import member.model.hj.MemberDAO;
import member.model.hj.MemberDAO_imple;

public class Login extends AbstractController {

	private MemberDAO mdao = null;
	
	public Login() {
		mdao = new MemberDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();	// "GET" 또는 "POST"

		if("GET".equalsIgnoreCase(method)) {	// GET 방식
			
			super.setRedirect(false); 	// forward
			super.setViewPage("/WEB-INF/login/login.jsp");
			
		}
		else {		// POST 방식
			
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			
			String clientip = request.getRemoteAddr();	// IP 가져오기
			
			// System.out.println("확인용 userid : " + userid);
			// System.out.println("확인용 pwd : " + pwd);
			// ㅇSystem.out.println("확인용 clientip : " + clientip);
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("pwd", pwd);
			paraMap.put("clientip", clientip);
			
			MemberVO loginuser = mdao.login(paraMap);
			
			if(loginuser != null) {	
				
				if(loginuser.getIdle() == 1) {	// 휴면 상태이면
					// 마지막으로 로그인 한것이 1년 이상 지난 경우 
		            
		            String message = "로그인을 한지 1년이 지나서 휴면상태로 되었습니다.\\n휴면을 풀어주는 페이지로 이동합니다!!";
		            String loc = request.getContextPath()+"/login/dormantAccount.ice";
		            
		            request.setAttribute("message", message);
		            request.setAttribute("loc", loc);
		            
		            super.setRedirect(false); 
		            super.setViewPage("/WEB-INF/msg.jsp");
		            
		            return; // 메소드 종료
				}
				
				// === 로그인 성공 === //
				// System.out.println("확인용 => " + login_user.getName() + " 님 로그인 성공^-^");
				
				HttpSession session = request.getSession();
				
				session.setAttribute("loginuser", loginuser);
				
				if(loginuser.isRequirePwdChange()) {	// 비밀번호를 변경한지 3개월 이상된 경우 
	                
		            String message = "비밀번호를 변경하신지 3개월이 지났습니다.\\n암호를 변경하는 페이지로 이동합니다!!";
		            String loc = request.getContextPath()+"/login/pwdChange.ice";
		            
		            request.setAttribute("message", message);
		            request.setAttribute("loc", loc);
		            
		            super.setRedirect(false); 
		            super.setViewPage("/WEB-INF/msg.jsp");
		            
		            return; // 메소드 종료
				}
				// ★★★★★★★ === 3개월이 지나지 않은 경우 === ★★★★★★★ //
				////////////////////////////////////////////////
				// === 수업해주신데욤 === //
				super.setRedirect(true);
				super.setViewPage(request.getContextPath() + "/index.ice");
			
				
				////////////////////////////////////////////////
			}
			else {
				// System.out.println("확인용 => 로그인 실패ㅠㅠ");
				
				String message = "로그인 실패";
		        String loc = request.getContextPath() + "/login/login.ice";
		        // 테이블 적용 후 이동 이전페이지(get 타입 변경)할 지 메인페이지 갈지 선정해야할 것
		         
		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		        
		        super.setRedirect(false);
		        super.setViewPage("/WEB-INF/msg.jsp");
		        
			}	// end of if~else------------------------
		}
	}	// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception---


}
