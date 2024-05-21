package cart.model.hj;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import myshop.domain.CartVO;
import order.domain.OrderdetailVO;

public interface CartDAO {

	// === 해당 사용자의 장바구니 리스트 읽기 === //
	List<CartVO> getCartlist(String userid) throws SQLException;

	// === 해당 사용자의 주문내역 리스트 읽기 === //
	List<OrderdetailVO> getOrderdetailList(String userid) throws SQLException;

	// === 주문조회 검색창에 검색(제품) === //
	List<OrderdetailVO> productsearch(Map<String, String> paraMap);

	// === 주문조회 검색창에 검색(맛) === //
	List<OrderdetailVO> tastesearch(Map<String, String> paraMap);

	// === 주문조회 기간 설정 검색 === //
	List<OrderdetailVO> searchorderListPeriod(Map<String, String> paraMap) throws SQLException;

	


}
