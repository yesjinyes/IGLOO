package member.model.jy;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import order.domain.OrderdetailVO;

public interface ReviewDAO {
	
	
	// 전체 주문내역 불러오기(선택 맛 제외)
	List<OrderdetailVO> selectOrderListAll(String userid) throws SQLException;
	
	
	// 작성한 리뷰 insert
	int insertReviewOne(Map<String, String> paraMap) throws SQLException;

	

	
	

}
