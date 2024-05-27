package help.controller.nr;

import java.util.List;

import common.controller.AbstractController;
import help.domain.nr.HelpVO;
import help.model.nr.HelpDAO;
import help.model.nr.HelpDAO_imple;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.domain.ProductVO;
import product.domain.TasteVO;

public class Search extends AbstractController {

private HelpDAO hdao = null;
	
	public Search() {
		hdao = new HelpDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String search = request.getParameter("search");
		// System.out.println(search);
		
		List<TasteVO> tasteList = hdao.searchTaste(search);
		int tasteList_size = tasteList.size();
		
		List<ProductVO> productList = hdao.searchCup(search);
		int productList_size = productList.size();
		
		List<HelpVO> faqList = hdao.searchFaq(search);
		int faqList_size = faqList.size();
		
		request.setAttribute("tasteList", tasteList);
		request.setAttribute("productList", productList);
		request.setAttribute("faqList", faqList);
		
		request.setAttribute("tasteList_size", tasteList_size);
		request.setAttribute("productList_size", productList_size);
		request.setAttribute("faqList_size", faqList_size);
		
		request.setAttribute("search", search);
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/help/search.jsp");
		
		
	}

}
