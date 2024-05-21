package admin.controller.nr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import admin.model.nr.AdminDAO;
import admin.model.nr.AdminDAO_imple;
import common.controller.AbstractController;
import help.domain.nr.FaqVO;
import help.domain.nr.HelpVO;
import help.model.nr.HelpDAO;
import help.model.nr.HelpDAO_imple;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import my.util.MyUtil;

public class FaqAnswer extends AbstractController{

private AdminDAO adao = null;
	
	public FaqAnswer() {
		adao = new AdminDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String message = "";
		String loc = "";
		
		
		if(loginuser != null && "admin".equals(loginuser.getUserid())) {
		
			String sizePerPage = request.getParameter("sizePerPage");
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			
			if(sizePerPage == null || !"3".equals(sizePerPage) && !"5".equals(sizePerPage) && !"10".equals(sizePerPage)) {
				sizePerPage = "10";
			}
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			Map<String, String> paramap = new HashMap<String, String>();
			paramap.put("sizePerPage", sizePerPage);
			paramap.put("currentShowPageNo", currentShowPageNo);
			
			int totalPage = adao.getTotalPage(paramap);
			
			// System.out.println(totalPage);
			
			try {
				if(Integer.parseInt(currentShowPageNo) > totalPage || Integer.parseInt(currentShowPageNo) < 0) {
					currentShowPageNo = "1";
					paramap.put("currentShowPageNo", currentShowPageNo);
				}
			}catch (NumberFormatException e) {
				currentShowPageNo = "1";
				paramap.put("currentShowPageNo", currentShowPageNo);
			}
			
			String pageBar = "";
			int blockSize = 10; // blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
			int loop = 1;  // loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다.

			// pageNo  ==> ( (currentShowPageNo - 1)/blockSize ) * blockSize + 1
			int pageNo = ((Integer.parseInt(currentShowPageNo)-1)/blockSize)*blockSize+1;
			// pageNo는 페이지바에서 보여지는 첫 번째 번호이다.
			
			
			// *** [맨처음][이전] 만들기 *** //
			   
			pageBar += "<li class='page-item'><a class='page-link' href='faqAnswer.ice?sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[맨처음]</a></li>";

			if(pageNo != 1) {
				pageBar += "<li class='page-item'><a class='page-link' href='faqAnswer.ice?sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
			}
   
			while(!(loop > blockSize || pageNo > totalPage)) {
              
				if(pageNo ==  Integer.parseInt(currentShowPageNo)) {
					pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
				}
				
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='faqAnswer.ice?sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
				}
  
				loop++; // 1 2 3 4 5 6 7 8 9 10
  
				pageNo++; //  1  2  3  4  5  6  7  8  9 10
      
			}// end of while(!( )) {}------------------- 
   
			// *** [다음][마지막] 만들기 *** //
			// pageNo ==> 11
			if(pageNo <= totalPage) {
				pageBar += "<li class='page-item'><a class='page-link' href='faqAnswer.ice?sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			}
			pageBar += "<li class='page-item'><a class='page-link' href='faqAnswer.ice?sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"'>[맨마지막]</a></li>";
	           
			String currentURL = MyUtil.getCurrentURL(request);
			
			List<FaqVO> faqList = adao.select_faq_paging(paramap);
			request.setAttribute("faqList", faqList);
			
			request.setAttribute("sizePerPage", sizePerPage);
			request.setAttribute("pageBar", pageBar);
			
			request.setAttribute("currentURL", currentURL);
			
			int totalFaqCount = adao.getTotalFaqCount(paramap);
			
			// System.out.println(totalFaqCount);

			request.setAttribute("totalFaqCount", totalFaqCount);
			request.setAttribute("currentShowPageNo", currentShowPageNo);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/faqAnswer.jsp");
		}
		
		else {
			message = "관리자 전용 메뉴이므로 접근 불가합니다.";
			loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
			
		
	}

}
