package member.controller.yg;

import java.util.HashMap;
import java.util.Map;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import member.model.yg.MemberDAO;
import member.model.yg.MemberDAO_imple;

public class Updatepwdcheck extends AbstractController {
	
	private MemberDAO mdao = null;
	
	public Updatepwdcheck() {
		mdao = new MemberDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			String method = request.getMethod(); // "GET" 또는 "POST"
			
			if("POST".equalsIgnoreCase(method)) {
				// 아이디 찾기 모달창에서 "찾기"버튼을 클릭했을 경우
				
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
				
				System.out.println(loginuser.getUserid());
				
				String userid = loginuser.getUserid();
//				System.out.println(userid);
				String pwd = request.getParameter("pwd");
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("userid", userid);
				paraMap.put("pwd", pwd);
				
				String pwdcheck = mdao.updatePswCheck(paraMap); // 메소드를 만들어야한다.
				
				if(pwdcheck != null) {
					request.setAttribute("pwdcheck", pwdcheck);
				}
				else {
					request.setAttribute("pwdcheck", "비밀번호가 일치하지 않습니다.");
				}
				
			}// end of if("POST".equalsIgnoreCase(method)){}-------------------------------------------------
			
			request.setAttribute("method", method);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/updatepwdcheck.jsp");
			
		}

	}

