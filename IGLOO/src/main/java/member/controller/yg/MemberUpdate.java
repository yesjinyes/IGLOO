package member.controller.yg;

import java.sql.SQLException;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import member.domain.MemberVO;
import member.model.yg.MemberDAO;
import member.model.yg.MemberDAO_imple;

public class MemberUpdate extends AbstractController {

	private MemberDAO mdao = null;
	
	public MemberUpdate() {
		mdao = new MemberDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod(); 
		
		if("GET".equalsIgnoreCase(method)) {
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberUpdate.jsp");
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
			String birthday = request.getParameter("birthday");
			
			String mobile = hp1+hp2+hp3;
			
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
			member.setBirthday(birthday);

			// 회원정보 수정이 성공되면 자동로그인
	        try {
	        	int n = mdao.updateMember(member);
	            
	            if(n==1) { 
	               request.setAttribute("userid", userid);
	               request.setAttribute("pwd", pwd);
	               
	               super.setRedirect(false);
	               super.setViewPage("/WEB-INF/login/register_after_autoLogin.jsp");
	            }
	            
	         } catch(SQLException e) {
	            e.printStackTrace();
	            String message = "회원정보수정 실패";
	            String loc = "javascript:history.back()"; 
	            
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	               
	            super.setRedirect(false);
	            super.setViewPage("/WEB-INF/msg.jsp");
	         }	// end of try~catch---------
	        
		}	// end of if~else()---------------
	}

}