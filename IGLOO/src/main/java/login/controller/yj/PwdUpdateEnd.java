package login.controller.yj;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
      
      System.out.println("method : "+method);
      
      if("POST".equalsIgnoreCase(method)) {
         // "비밀번호변경" 버튼을 클릭했을 때
         String new_pwd = request.getParameter("pwd"); 
         
         System.out.println("new_pwd:"+new_pwd);
         
         Map<String, String> paraMap = new HashMap<>(); 
         paraMap.put("userid", userid);
         paraMap.put("new_pwd", new_pwd);
         
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
         System.out.println("n:"+n);
            
      }// end of if("POST".equalsIgnoreCase(method))
      request.setAttribute("userid", userid);
      request.setAttribute("method", method); 
      
      
      super.setRedirect(false);
      super.setViewPage("/WEB-INF/login/pwdUpdateEnd.jsp");
      
   }// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception

   
   
}