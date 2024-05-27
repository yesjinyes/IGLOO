package member.controller.hj;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.domain.TasteVO;
import product.model.hj.ProductDAO;
import product.model.hj.ProductDAO_imple;

public class Updatetaste extends AbstractController {

	private ProductDAO pdao = null;

	public Updatetaste() {
		pdao = new ProductDAO_imple();
	}   
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();	// "GET" 또는 "POST"
		
		if("POST".equalsIgnoreCase(method)) {
		
			String selectno = request.getParameter("selectno");
			String updateTasteno = request.getParameter("updateTasteno");
			// System.out.println("확인용 선택한 tasteno : " + updateTasteno);
			
			String[] tasteno = updateTasteno.split("[,]");
			
			try {
				
				// === 기존 맛에 대한 선택내역번호 가져오기 === //
				List<TasteVO> selectTastenoList = pdao.selectTastenoList(selectno);
				
				for(int i=0; i<tasteno.length; i++) {
					// System.out.println("확인용 변경한 tasteno 번호 : " + tasteno[i]);
					Map<String,String> paraMap = new HashMap<>();
					
					paraMap.put("selectno", selectno);
					paraMap.put("tasteno", tasteno[i]);

					for(int j=0; j<selectTastenoList.size(); j++) {
						
						if(i==j) {
							paraMap.put("tasteselectno", String.valueOf(selectTastenoList.get(i).getTasteselectno()));
						}
					}
					
					// === 맛 수정 === //
					if(!pdao.updateTasteno(paraMap)) {
						System.out.println("오류남");
					}
					
				}	// end of for------------
			}catch(Exception e) {
				e.printStackTrace();
			}	// end of try~catch-------------
			/*
			String message = "수정완료되었습니다.";
	        String loc = request.getContextPath() + "/member/cart.ice";
	        boolean selfclose = true;
	        
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	        request.setAttribute("selfclose", selfclose);
	        
			super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
	        */
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/order/tasteUpdateEnd.jsp");
		}
		else {
			
			String selectno = request.getParameter("selectno");
			request.setAttribute("selectno", selectno);
			// System.out.println("확인용 selectno : " + selectno);
			// selectno 를 사용해서 선택한 맛리스트를 뽑고
			
			// === 선택한 맛 리스트 뽑기 === //
			List<TasteVO> selectTasteList = pdao.selectTasteList(selectno);
			request.setAttribute("selectTasteList", selectTasteList);
			/*
			for(int i=0; i<selectTasteList.size(); i++) {
				System.out.println("확인용 : " + selectTasteList.get(i).getTastename());
			}
			*/
			
			// == 맛 목록을 조회해오기 == //
			List<TasteVO> tasteList = pdao.tasteList();
			request.setAttribute("tasteList", tasteList);
			/*
			for(int i=0; i<tasteList.size(); i++) {
				System.out.println("확인용 : " + tasteList.get(i).getTastename());
				System.out.println("확인용 : " + tasteList.get(i).getTasteno());
			}
			*/
			
			super.setRedirect(false); 	// forward
			super.setViewPage("/WEB-INF/order/tasteUpdate.jsp");
		}

		
	}

}
