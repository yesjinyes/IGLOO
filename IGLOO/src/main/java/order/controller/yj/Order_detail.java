package order.controller.yj;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.model.yj.ProductDAO;
import product.model.yj.ProductDAO_imple;
import product.domain.ProductVO;
import product.domain.TasteVO;
 
public class Order_detail extends AbstractController { 
	private ProductDAO pdao = null;
	 
	public Order_detail() {
		pdao = new ProductDAO_imple();
	}   
	
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// == 맛 목록을 조회해오기 == //
		List<TasteVO> tasteList = pdao.selectTasteList();
		request.setAttribute("tasteList", tasteList);

//	    String productimg = request.getParameter("productimg");
//	    String productimgBelow = request.getParameter("productimgBelow");
//	    String productname = request.getParameter("productname");
//	    String productprice = request.getParameter("productprice");
//		
//	    Map<String, String> paraMap = new HashMap<>();
//	    paraMap.put("productimg", productimg);
//	    paraMap.put("productimgBelow", productimgBelow);
//	    paraMap.put("productname", productname);
//	    paraMap.put("productprice", productprice);
//	    
		
		
		// == 주문상세 정보 띄우기 == //
		String productList = request.getParameter("productList");
	    
		List<ProductVO> detailList = pdao.getimgList(productList);
		request.setAttribute("detailList", detailList);

		
		
//		// == 주문상세 하단 이미지 띄우기 == //
//		List<ProductVO> imgDetailList = pdao.selectImageDetail();
//		request.setAttribute("imgDetailList", imgDetailList);



		super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/order_detail.jsp");
		
		
	}
}