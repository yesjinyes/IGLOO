package product.controller.jy;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import my.util.MyUtil;
import product.domain.TasteVO;
import product.model.jy.MenuDAO;
import product.model.jy.MenuDAO_imple;

public class IceSearch extends AbstractController {

	private MenuDAO mdao = null;
	
	public IceSearch() {
		mdao = new MenuDAO_imple();
	}
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String searchWord = request.getParameter("searchWord");
		String sizePerPage = request.getParameter("sizePerPage");
		String currentShowPageNo = request.getParameter("currentShowPageNo"); 
		
		
		
		if(searchWord == null || 
				   (searchWord != null && searchWord.trim().isEmpty()) ) {
					searchWord = "";
				}
		
		if(sizePerPage == null ||
				   (!"12".equals(sizePerPage) &&
				    !"8".equals(sizePerPage) &&
				    !"4".equals(sizePerPage)) ) {
					sizePerPage = "12";
		}
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		
		Map<String, String> paraMap = new HashMap<>();
				
		paraMap.put("currentShowPageNo", currentShowPageNo);
		paraMap.put("sizePerPage", sizePerPage); // 한페이지당 보여줄 행의 개수 
		paraMap.put("searchWord", searchWord);
		
		// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 회원에 대한 총페이지수 알아오기 //
		int totalPage = mdao.getTotalPage(paraMap);
		
		try {
			 if( Integer.parseInt(currentShowPageNo) > totalPage || 
				 Integer.parseInt(currentShowPageNo) <= 0 ) {
				 currentShowPageNo = "1";
				 paraMap.put("currentShowPageNo", currentShowPageNo);
			 }
		} catch(NumberFormatException e) {
			currentShowPageNo = "1";
			paraMap.put("currentShowPageNo", currentShowPageNo);
		}

		String pageBar = "";  
		
		int blockSize = 10;
		// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
		
		int loop = 1;
		// loop 는 1 부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다. 
		
		// ==== !!! 다음은 pageNo 구하는 공식이다. !!! ==== // 
		int pageNo  = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1; 
		// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
		
		// *** [맨처음][이전] 만들기 *** //
		pageBar += "<li class='page-item'><a class='page-link' href='memberList.up?searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[맨처음]</a></li>"; 
		
		if(pageNo != 1) {
			pageBar += "<li class='page-item'><a class='page-link' href='memberList.up?searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>"; 
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.up?searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;    // 1 2 3 4 5 6 7 8 9 10
			
			pageNo++;  //  1  2  3  4  5  6  7  8  9 10
			           // 11 12 13 14 15 16 17 18 19 20
			           // 21 22 23 24 25 26 27 28 29 30
			           // 31 32 33 34 35 36 37 38 39 40
			           // 41 42 
			            
		}// end of while( !( ) )--------
		
		// *** [다음][마지막] 만들기 *** //
		// pageNo ==> 11
		
		if(pageNo <= totalPage) { 
			pageBar += "<li class='page-item'><a class='page-link' href='memberList.up?searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
		}
		pageBar += "<li class='page-item'><a class='page-link' href='memberList.up?searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
		
		
		// *** ======= 페이지바 만들기 끝 ======= *** //
		
		
		// *** ====== 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 ======= *** //
		String currentURL = MyUtil.getCurrentURL(request);
		// 회원조회를 했을시 현재 그 페이지로 그대로 되돌아가길 위한 용도로 쓰임.

		
		List<TasteVO> memberList = mdao.select_Member_paging(paraMap);
		
		request.setAttribute("memberList", memberList);
		
		if(searchWord != null && 
				   !searchWord.trim().isEmpty() ) {
					request.setAttribute("searchWord", searchWord);
		}
		
		
		request.setAttribute("sizePerPage", sizePerPage);
		
		request.setAttribute("pageBar", pageBar);
		
		request.setAttribute("currentURL", currentURL);
		
		/* >>> 뷰단(memberList.jsp)에서 "페이징 처리시 보여주는 순번 공식" 에서 사용하기 위해 
	       검색이 있는 또는 검색이 없는 회원의 총개수 알아오기 시작 <<< */
		   int totalMemberCount = mdao.getTotalMemberCount(paraMap);  
		// System.out.println("~~~ 확인용 totalMemberCount : " + totalMemberCount); 
		   request.setAttribute("totalMemberCount", totalMemberCount);
		   request.setAttribute("currentShowPageNo", currentShowPageNo);
		/* 검색이 있는 또는 검색이 없는 회원의 총개수 알아오기 끝 */

		
		   super.setViewPage("/WEB-INF/product/iceSearch.jsp");

	}

}
