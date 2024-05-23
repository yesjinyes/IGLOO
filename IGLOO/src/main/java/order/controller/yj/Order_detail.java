package order.controller.yj;

import java.sql.SQLException;
import java.util.List;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.model.yj.ProductDAO;
import product.model.yj.ProductDAO_imple;
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

//		// == 주문상세 상단 이미지 띄우기 == //
//		List<ProductVO> imgList = pdao.getimgList();
//		request.setAttribute("imgList", imgList);
//
//
//		// == 주문상세 하단 이미지 띄우기 == //
//		List<ProductVO> imgDetailList = pdao.selectImageDetail();
//		request.setAttribute("imgDetailList", imgDetailList);
		
		// == 주문상세에서 불러올 값들 == //
		String productimg = request.getParameter("productimg");
		String productname = request.getParameter("productname");
		String productprice = request.getParameter("productprice");
		String productimgBelow = request.getParameter("productimgBelow");
		String tastecount = request.getParameter("tastecount");
		
//		System.out.println("확인용 productimg : " + productimg);
//		System.out.println("확인용 productname : " + productname);
//		System.out.println("확인용 productprice : " + productprice);
//		System.out.println("확인용 productimgBelow : " + productimgBelow);
//		System.out.println("확인용 tastecount : " + tastecount);
		
		request.setAttribute("productimg", productimg);
		request.setAttribute("productname", productname);
		request.setAttribute("productprice", productprice);
		request.setAttribute("productimgBelow", productimgBelow);
		request.setAttribute("tastecount", tastecount);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/order_detail.jsp");

	}
}



