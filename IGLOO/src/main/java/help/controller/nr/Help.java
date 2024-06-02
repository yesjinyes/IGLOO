package help.controller.nr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.controller.AbstractController;
import help.domain.nr.HelpVO;
import help.model.nr.HelpDAO;
import help.model.nr.HelpDAO_imple;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import my.util.MyUtil;

public class Help extends AbstractController {

	private HelpDAO hdao = null;
	
	public Help() {
		hdao = new HelpDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		
		String category = request.getParameter("category");
		String searchWord = request.getParameter("faqsearch");
		String sizePerPage = "10";
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(!"10".equals(sizePerPage)) {
			sizePerPage = "10";
		}
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("category", category);
		paramap.put("sizePerPage", sizePerPage);
		paramap.put("currentShowPageNo", currentShowPageNo);
		paramap.put("searchWord", searchWord);
		
		int totalPage = hdao.getTotalPage(paramap);
		
		try {
			 if( Integer.parseInt(currentShowPageNo) > totalPage || 
				 Integer.parseInt(currentShowPageNo) <= 0 ) {
				 currentShowPageNo = "1";
				 paramap.put("currentShowPageNo", currentShowPageNo);
			 }
		} catch(NumberFormatException e) {
			currentShowPageNo = "1";
			paramap.put("currentShowPageNo", currentShowPageNo);
		}
		
		String pageBar = "";
		
		int blockSize = 5;
		
		int loop = 1;
		
		int pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
		
		
		// 카테고리가 없는 경우 ===================================================================
		
		if(category == null) {
			pageBar += "<li class='page-item'><a class='page-link' href='help.ice?&sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[처음으로]</a></li>";
			if(pageNo != 1) {
				pageBar += "<li class='page-item'><a class='page-link' href='help.ice?&sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>"; 
			}
			
			
			while( !(loop > blockSize || pageNo > totalPage) ) {
				
				if(pageNo == Integer.parseInt(currentShowPageNo)) {
					pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='help.ice?&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
				}
				
				loop++;    // 1 2 3 4 5 6 7 8 9 10
				
				pageNo++;  //  1  2  3  4  5  6  7  8  9 10
				           // 11 12 13 14 15 16 17 18 19 20
				           // 21 22 23 24 25 26 27 28 29 30
				           // 31 32 33 34 35 36 37 38 39 40
				           // 41 42 
				            
			}// end of while( !( ) )--------
			
			if(pageNo <= totalPage) { 
				pageBar += "<li class='page-item'><a class='page-link' href='help.ice?&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			}
			pageBar += "<li class='page-item'><a class='page-link' href='help.ice?&sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
		}
		
		
		// 카테고리가 있는 경우 ===========================================================
		
		else {
			pageBar += "<li class='page-item'><a class='page-link' href='help.ice?category="+category+"&sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[처음으로]</a></li>";
			if(pageNo != 1) {
				pageBar += "<li class='page-item'><a class='page-link' href='help.ice?category="+category+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>"; 
			}
			
			
			while( !(loop > blockSize || pageNo > totalPage) ) {
				
				if(pageNo == Integer.parseInt(currentShowPageNo)) {
					pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='help.ice?category="+category+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
				}
				
				loop++;    // 1 2 3 4 5 6 7 8 9 10
				
				pageNo++;  //  1  2  3  4  5  6  7  8  9 10
				           // 11 12 13 14 15 16 17 18 19 20
				           // 21 22 23 24 25 26 27 28 29 30
				           // 31 32 33 34 35 36 37 38 39 40
				           // 41 42 
				            
			}// end of while( !( ) )--------
			
			if(pageNo <= totalPage) { 
				pageBar += "<li class='page-item'><a class='page-link' href='help.ice?category="+category+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			}
			pageBar += "<li class='page-item'><a class='page-link' href='help.ice?category="+category+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
		}
		
		String currentURL = MyUtil.getCurrentURL(request);
		
		List<HelpVO> hvoList = hdao.faqlist_paging(paramap);
		
		request.setAttribute("hvoList", hvoList);
		
		if(category != null && ("제품".equals(category) || "포인트".equals(category) || "회원".equals(category) || "기타".equals(category) )) {
			request.setAttribute("category", category);
		}
		
		request.setAttribute("sizePerPage", sizePerPage);
		request.setAttribute("pageBar", pageBar);
		request.setAttribute("currentURL", currentURL);
		
		int totalFaqCount = hdao.getTotalFaqCount(paramap);
		
		request.setAttribute("totalFaqCount", totalFaqCount);
		request.setAttribute("currentShowPageNo", currentShowPageNo);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/help/help.jsp");
	}

}
