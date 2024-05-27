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
import product.domain.ProductVO;
import product.domain.TasteVO;

public class SearchMore extends AbstractController {

	private HelpDAO hdao = null;
	
	public SearchMore() {
		hdao = new HelpDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String searchWord = request.getParameter("searchWord");
		String tagName = request.getParameter("tagName");
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		// System.out.println(searchWord+"  "+tagName); 확인 완료
		
		String sizePerPage = "5";

		if(!"5".equals(sizePerPage)) {
			sizePerPage = "5";
		}
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("sizePerPage", sizePerPage);
		paramap.put("currentShowPageNo", currentShowPageNo);
		paramap.put("searchWord", searchWord);
		paramap.put("tagName", tagName);
		
		int totalPage = hdao.getTotalSearchPage(paramap);
		
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
		
		pageBar += "<li class='page-item'><a class='page-link' href='searchMore.ice?searchWord="+searchWord+"&tagName="+tagName+"&sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[처음으로]</a></li>";
		if(pageNo != 1) {
			pageBar += "<li class='page-item'><a class='page-link' href='searchMore.ice?searchWord="+searchWord+"&tagName="+tagName+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>"; 
		}
		
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='searchMore.ice?searchWord="+searchWord+"&tagName="+tagName+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;    // 1 2 3 4 5 6 7 8 9 10
			
			pageNo++;  //  1  2  3  4  5  6  7  8  9 10
			           // 11 12 13 14 15 16 17 18 19 20
			           // 21 22 23 24 25 26 27 28 29 30
			           // 31 32 33 34 35 36 37 38 39 40
			           // 41 42 
			            
		}// end of while( !( ) )--------
		
		if(pageNo <= totalPage) { 
			pageBar += "<li class='page-item'><a class='page-link' href='searchMore.ice?searchWord="+searchWord+"&tagName="+tagName+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
		}
		pageBar += "<li class='page-item'><a class='page-link' href='searchMore.ice?searchWord="+searchWord+"&tagName="+tagName+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
		
		String currentURL = MyUtil.getCurrentURL(request);
		
		
		if("taste".equalsIgnoreCase(tagName)) {
			List<TasteVO> tasteList = hdao.search_taste_paging(paramap);
			request.setAttribute("tasteList", tasteList);
		}
		
		else if("product".equalsIgnoreCase(tagName)) {
			List<ProductVO> productList = hdao.search_product_paging(paramap);
			request.setAttribute("productList", productList);
		}
		
		else if("faqlist".equalsIgnoreCase(tagName)) {
			List<HelpVO> faqList = hdao.search_help_paging(paramap);
			request.setAttribute("faqList", faqList);
		}
		
		request.setAttribute("sizePerPage", sizePerPage);
		request.setAttribute("pageBar", pageBar);
		request.setAttribute("currentURL", currentURL);
		
		int totalSearchCount = hdao.getTotalSearchCount(paramap);
		
		request.setAttribute("totalSearchCount", totalSearchCount);
		request.setAttribute("currentShowPageNo", currentShowPageNo);
		request.setAttribute("tagName", tagName);
		request.setAttribute("search", searchWord);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/help/searchMore.jsp");
	}

}
