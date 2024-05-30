package member.model.jy;

import java.sql.SQLException;
import java.util.List;

import order.domain.OrderdetailVO;

public interface ReviewDAO {
	
	
	// 전체 주문내역 불러오기(선택 맛 제외)
	List<OrderdetailVO> selectOrderListAll(String userid) throws SQLException;

	// 리뷰쓰기를 위해 주문목록에서 해당 주문상세 불러오기
	List<OrderdetailVO> selectOrderDetailOne(String userid) throws SQLException;

	
	

}
