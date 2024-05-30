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

public class PwdUpdateEnd extends AbstractController {

   private MemberDAO mdao = null;
   
   public PwdUpdateEnd() {
      mdao = new MemberDAO_imple();
   }
   
   
   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      String userid = request.getParameter("userid");
      String ctxPath = request.getContextPath();
      
      String method = request.getMethod();
      
//      System.out.println(userid);
//      System.out.println("method : "+method);

      Map<String, String> paraMap = new HashMap<>(); 
      
      // == 비밀번호 찾기에서 비밀번호 변경으로 이동 == //
      if("POST".equalsIgnoreCase(method) && userid != null) {
         // "비밀번호변경" 버튼을 클릭했을 때
         String new_pwd = request.getParameter("pwd");
         
         // System.out.println("new_pwd:"+new_pwd);
         
         
         paraMap.put("userid", userid);
         paraMap.put("new_pwd", new_pwd);
         System.out.println("new_pwd : "+new_pwd);
         
         int n = 0;
         
         try {
            n = mdao.pwdUpdateEnd(paraMap);
         } catch(SQLException e) {
            e.printStackTrace();
         }
         
         request.setAttribute("n", n); 
         
         if(n==1) {
        	 super.setRedirect(true);
             super.setViewPage(ctxPath+"/index.ice");
         }
         // System.out.println("n:"+n);
            
         request.setAttribute("userid", userid);
         request.setAttribute("method", method); 
         
         
         super.setRedirect(true);
         super.setViewPage(request.getContextPath() + "/index.ice");

      }// end of if("POST".equalsIgnoreCase(method))--------------
      
      else { // 마이페이지에서 '비밀번호 변경' 클릭한 경우
    	  
    	  HttpSession session = request.getSession();
    	  MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
    	  userid = loginuser.getUserid();
    	  
    	  request.setAttribute("userid", userid);
    	  
    	  // '마이페이지 > 비번변경' 할 때만 사이드바 생기도록 조건 거는 key값 생성
    	  request.setAttribute("mypage", "mypage"); 
    	  
    	  ///////////////////////////////////////////////////////////////////
    	  String checkpwd = mdao.checkPwd_mypage(paraMap);
     	  //System.out.println(checkpwd); // 이전과 같은 비밀번호를 입력했을 때는 fail, 새로운 비밀번호를 입력했을 때는 통과
     	  if("fail".equals(checkpwd)) {
     		 
     		 String message = "비밀번호가 이전과 같습니다. 새로운 비밀번호를 입력해주세요.";	// 메시지
     		 String loc = request.getContextPath()+"/login/pwdUpdateEnd.ice";	// 다시 비밀번호 변경창으로 이동
     		 
     		 request.setAttribute("message", message);
     		 request.setAttribute("loc", loc);
     		 
     		 super.setRedirect(false); 
		         super.setViewPage("/WEB-INF/msg.jsp");
     		 return;
     		 
     	 }
    	  
    	  
    	  
//    	  super.setRedirect(false);
//        super.setViewPage("/WEB-INF/login/pwdUpdateEnd.jsp");
    	  
      }
      
      
      
      
   }// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception

   
   
}