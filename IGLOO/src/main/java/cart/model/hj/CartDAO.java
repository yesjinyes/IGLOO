package cart.model.hj;

import java.sql.SQLException;
import java.util.List;

import myshop.domain.CartVO;
import order.domain.OrderdetailVO;

public interface CartDAO {

	// === 해당 사용자의 장바구니 리스트 읽기 === //
	List<CartVO> getCartlist(String userid) throws SQLException;

	// === 해당 사용자의 주문내역 리스트 읽기 === //
	List<OrderdetailVO> getOrderdetailList(String userid) throws SQLException;

}
