package order.controller.yj;

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
	
	private void redirect(HttpServletRequest request) { // 중복되는 내용이 있어서 밖에 함수 만들어서 빼준것임
		super.setRedirect(true);
        super.setViewPage(request.getContextPath() + "/myshop/mallHomeMore.up");
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		
		// == 맛 목록을 조회해오기 == //
		List<TasteVO> tasteList = pdao.selectTasteList();
		request.setAttribute("tasteList", tasteList);
		
		// == 주문상세 상단 이미지 띄우기 == //
		// String productimg = pdao.getproductimg();
		//request.setAttribute("productimg", productimg);
		
		// == 주문상세 하단 이미지 띄우기 == //
		List<ProductVO> imgDetailList = pdao.selectImageDetail();
		request.setAttribute("imgDetailList", imgDetailList);
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/order_detail.jsp");
		
		
		
		
		
		
		
	}

}
