package help.controller.nr;

import java.util.List;

import common.controller.AbstractController;
import help.domain.nr.HelpVO;
import help.model.nr.HelpDAO;
import help.model.nr.HelpDAO_imple;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Help extends AbstractController {

	private HelpDAO hdao = null;
	
	public Help() {
		hdao = new HelpDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String category = request.getParameter("category");
		// System.out.println(category);
		
		List<HelpVO> hvoList = hdao.faqlist(category);
		
		// System.out.println(hvoList.get(1).getF_content());
		
		request.setAttribute("hvoList", hvoList);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/help/help.jsp");
	}

}
