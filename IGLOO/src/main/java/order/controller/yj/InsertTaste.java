package order.controller.yj;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import product.model.yj.ProductDAO;
import product.model.yj.ProductDAO_imple;
public class InsertTaste extends AbstractController {
	
// == 주문상세 페이지에서 '장바구니' 클릭 시 이동하는 controller == //	
	
	private ProductDAO pdao = null;
	
	public InsertTaste() {
	      pdao = new ProductDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			String message = "(insertTaste.java GET 방식으로 전송됨)비정상적인 경로로 들어왔습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// super.setRedirect(false);	// forward
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}

		else {
			// System.out.println("확인");
			HttpSession session = request.getSession();

			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
		    if(loginuser != null) {

		    	String userid = loginuser.getUserid();
		    	String pcode = request.getParameter("pcode");
		    	
		    	// 맛번호, 수량은 선택한 상품이 몇개일지 모르기 때문에 배열에 담아줬다.
		    	String[] tastenoArr = request.getParameterValues("tasteselectListNo"); // 맛번호를 담아주는 배열
		    	String[] countArr = request.getParameterValues("tasteselectListCount"); // 수량을 담아주는 배열
		    	
		    	
//		    	if(tastenoArr == null) {
//		    		
//		    		System.out.println("총수량 0개여서 return 됨 => 장바구니에 담을 메뉴를 선택해주세요 경고 띄우기!");
//		    		super.goBackURL(request);
//		    		return;
//		    	}
		    	
		    	
		    	String str_totalcount = request.getParameter("str_totalcount"); // 총수량
		    	String str_totalprice = request.getParameter("str_totalprice"); // 총합계금액
		    	
		    	// == 맛번호, 수량, 담아주는 맛정보List == //
		    	List<Map<String, Integer>> tasteinfoList = new ArrayList<>();
		    	
		    	// 맛번호, 수량 짝꿍 만들어주기
		    	for(int i = 0; i < tastenoArr.length; i++) {
		    		
		    		Map<String, Integer> map = new HashMap<>();
		    		
		    		String[] str_tastenoarr = tastenoArr[i].split(","); // 1,3,27 형태의 tastenoArr 를 , 으로 split
		    		
		    		for(int j = 0; j < str_tastenoarr.length; j++) { // 선택된 맛 개수만큼 반복 (파인트면 3, 쿼터면 4)
		    			map.put("taste"+(j+1), Integer.parseInt(str_tastenoarr[j])); // map 에 split 된 값 넣어주기
		    		}
		    		map.put("count", Integer.parseInt(countArr[i])); // map에 수량 담아주기
		    		/*
		    		System.out.println("i:" + i);
		    		System.out.println("맛:" + tastenoArr[i]);
		    		System.out.println("수량:" + countArr[i]);
		    		System.out.println();
		    		*/
		    		
		    		/*
		    		 	i:0
						맛:1,7,21
						수량:3
						
		    		 */
		    		
		    		tasteinfoList.add(map);
		    	}
		    	
		    	// System.out.println("tasteinfoList : "+ tasteinfoList);
		    	// tasteinfoList : [{taste3=25, taste2=7, taste1=5, count=3}, {taste3=15, taste2=6, taste1=2, count=6}]
		    	
		    	///////////////////////////////////////////////////////////////////////////////////////////////
		    	int tasteListSize = tasteinfoList.size(); // 맛선택 개수만큼 반복하기 위해 생성
		    	
		    	try {
		    		// == TBL_SELECTLIST 에 insert 하는 메소드 생성 == //
		    		List<Map<String, Integer>> resultList  = pdao.insertSelectList(tasteListSize, userid, pcode);
//		    		selectListResult = map.get("selectListResult");

		    		///////////////////////////////////////////////////////////////////////
		    		
		    		// resultList 에 값이 잘 들어왔는지 확인하고, 잘 들어왔으면 insert 하기
		    		//  resultList 의 값은 아래와 같다
		    		// 	{str_selectno=45, selectListResult=1}
					//	{str_selectno=46, selectListResult=1}
		    		 
		    		boolean success = true;
		    		for(Map<String, Integer> selectListMap : resultList) {
		    			if(selectListMap.get("selectListResult") != 1) {
		    				success = false;
		    				break;
		    			}
		    		}
		    		
		    		// TBL_SELECTLIST 에 insert 할 조건이 충족됐다면
		    		if(success == true) { 
		    			
		    			// == TBL_TASTESELECT 에 insert 하는 메소드 생성 == //
		    			int tasteListResult = pdao.insertTasteList(resultList, tasteinfoList);
		    		
		    			if(tasteListResult == 1) {
		    				//System.out.println("tasteList 띄우기 성공 ^^~~");
		    				
		    				// == 장바구니 뷰단으로 연결 == //
		    				int cartListResult = pdao.insertCartList(userid, tasteinfoList, resultList);
		    				
		    				if(cartListResult == 1) { // 장바구니에 담은 리스트가 있는 경우
		    					//System.out.println("cartList 띄우기 성공 ^^~~");
		    					
				    			super.setRedirect(true);
		    					super.setViewPage(request.getContextPath() + "/member/cart.ice");
		    					return;
		    				}
		    				
		    			}
		    			
		    			/////////////////////////////////////////////////////////////////////////////////////
		    			
		    			request.setAttribute("str_totalcount", str_totalcount); // 총수량
		    			request.setAttribute("str_totalprice", str_totalprice); // 총합계금액
		    	
		    		}
		    		
		    	} catch(SQLException e) {
		    		
		    		String message = "구매 실패";
			        String loc = request.getContextPath() + "/order/order_detail.ice";
			        // 테이블 적용 후 이동 이전페이지(get 타입 변경)할 지 메인페이지 갈지 선정해야할 것
			         
			        request.setAttribute("message", message);
			        request.setAttribute("loc", loc);
			        
					super.setRedirect(false);
			        super.setViewPage("/WEB-INF/msg.jsp");
		    		
		    	}
		    	
		    	super.setRedirect(false);
				super.setViewPage("/WEB-INF/jsonview.jsp");
		    	
		    }// end of if(loginuser != null)--------------------
		    
		    else {
		    	System.out.println("로그인이 되지 않았음.");
		    	String message = "주문하시려면 먼저 로그인을 해주세요.";
		        String loc = request.getContextPath() + "/login/login.ice";

		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		        
		        super.setRedirect(false);
		        super.setViewPage("/WEB-INF/msg.jsp");

		    }

		}// end of else --------------------------------------
		
		
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception--------------
}

