package member.controller.hj;

import java.sql.SQLException;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import member.domain.MemberVO;
import member.model.hj.MemberDAO;
import member.model.hj.MemberDAO_imple;

public class Register extends AbstractController {

	private MemberDAO mdao = null;
	
	public Register() {
		mdao = new MemberDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); 
		
		if("GET".equalsIgnoreCase(method)) {
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/register.jsp");
		}
		else {
			String name = request.getParameter("name");
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			String email = request.getParameter("email");
			String hp1 = request.getParameter("hp1");
			String hp2 = request.getParameter("hp2");
			String hp3= request.getParameter("hp3");
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailaddress = request.getParameter("detailaddress");
			String extraaddress = request.getParameter("extraaddress");
			String gender = request.getParameter("gender");
			String birthday = request.getParameter("birthday");
			
			String mobile = hp1+hp2+hp3;
			
			// === input 장난 막기 === //
			name = name.replaceAll("<", "&lt;");
			name = name.replaceAll(">", "&gt;");
			name = name.replaceAll("\r\n", "<br>");
			
			detailaddress = detailaddress.replaceAll("<", "&lt;");
			detailaddress = detailaddress.replaceAll(">", "&gt;");
			detailaddress = detailaddress.replaceAll("\r\n", "<br>");
			
			MemberVO member = new MemberVO();
			member.setName(name);
			member.setUserid(userid);
			member.setPwd(pwd);
			member.setEmail(email);
			member.setMobile(mobile);
			member.setPostcode(postcode);
			member.setAddress(address);
			member.setDetailaddress(detailaddress);
			member.setExtraaddress(extraaddress);
			member.setGender(gender);
			member.setBirthday(birthday);

			// 회원가입이 성공되면 자동로그인
	        try {
	        	int n = mdao.registerMember(member);
	            
	            if(n==1) { 
	               request.setAttribute("userid", userid);
	               request.setAttribute("pwd", pwd);
	               
	               super.setRedirect(false);
	               super.setViewPage("/WEB-INF/login/register_after_autoLogin.jsp");
	            }
	            
	         } catch(SQLException e) {
	            e.printStackTrace();
	            String message = "회원가입 실패";
	            String loc = "javascript:history.back()"; 
	            
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	               
	            super.setRedirect(false);
	            super.setViewPage("/WEB-INF/msg.jsp");
	         }	// end of try~catch---------
	        
		}	// end of if~else()---------------
		
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception

}
