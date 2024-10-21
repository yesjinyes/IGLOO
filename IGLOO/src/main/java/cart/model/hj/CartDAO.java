package cart.model.hj;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import myshop.domain.CartVO;
import order.domain.OrderdetailVO;
import product.domain.TasteVO;

public interface CartDAO {

	// === 해당 사용자의 장바구니 리스트 읽기 === //
	List<CartVO> getCartlist(String userid) throws SQLException;

	// === 해당 사용자의 주문내역 리스트 읽기 === //
	List<OrderdetailVO> getOrderdetailList(String userid) throws SQLException;

	// === 제품, 맛 주문내역 검색 === //
	List<String> searchorderlist(Map<String, String> paraMap) throws SQLException;
		
	// === 주문조회 기간 설정 검색 === //
	List<OrderdetailVO> searchorderListPeriod(Map<String, String> paraMap) throws SQLException;

	// === 추출한 selectno 가지고 list 추출 === //
	List<OrderdetailVO> finalSearchlist(String selecnoJoin) throws SQLException;

	// === 카트번호에 따른 수량 업데이트 해주기 === //
	int updateCartlist(Map<String, String> paraMap) throws SQLException;

	// === 업데이트 된 장바구니리스트부르기 === //
	List<CartVO> refreshCartlist(Map<String, String> paraMap)throws SQLException;

	// === 장바구니에서 제거 === //
	int deleteCartno(String cartno) throws SQLException;

	// == 맛 목록을 조회해오기 == //
	List<TasteVO> selectTasteList() throws SQLException;

	


}
