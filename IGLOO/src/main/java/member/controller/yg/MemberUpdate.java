package member.controller.yg;

import java.sql.SQLException;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
			HttpSession session = request.getSession();
			
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			String name = request.getParameter("name");
			String userid = loginuser.getUserid();
			String pwd = loginuser.getPwd();
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
			
//			세션에서 userid 받아오고
//			DAO 만들어서 memberVO = new loginuser 어쩌구
//			세션 지워주고 다시 넣어서
			
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

//	            	session.removeAttribute("loginuser");
//	            	session.setAttribute("loginuser", loginuser); 시도했지만 잘 안됐던 것들의 기록
	            	
//	            	session = request.getSession();
//	                MemberVO login_user = (MemberVO) session.getAttribute("login_user"); 시도했지만 잘 안됐던 것들의 기록

	            	loginuser.setName(name);
	                loginuser.setPwd(pwd);
	                loginuser.setEmail(email);
	                loginuser.setMobile(mobile);
	                loginuser.setPostcode(postcode);
	                loginuser.setAddress(address);
	                loginuser.setDetailaddress(detailaddress);
	                loginuser.setExtraaddress(extraaddress);
	            	
	                String message = "회원정보 수정이 성공되었습니다.";
	                String loc = request.getContextPath() + "/index.ice";
	                // 테이블 적용 후 이동 이전페이지(get 타입 변경)할 지 메인페이지 갈지 선정해야할 것
	                
	                request.setAttribute("message", message);
	                request.setAttribute("loc", loc);
	                
	                super.setRedirect(false);
	                super.setViewPage("/WEB-INF/msg.jsp");
	                // where절에 아이디를 넣어서 name을 끌어오고 그걸 request.setattribute에 넣고 그걸 jsp에 넣는다.
	               
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