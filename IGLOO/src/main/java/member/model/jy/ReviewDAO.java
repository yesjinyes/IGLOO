package member.model.jy;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import member.domain.ReviewVO;
import order.domain.OrderdetailVO;

public interface ReviewDAO {
	
	
	// 전체 주문내역 불러오기(선택 맛 제외)
	List<OrderdetailVO> selectOrderListAll(String userid) throws SQLException;
	
	// 해당주문내역(1개)에 대한 상세(리스트) 메소드
	OrderdetailVO odvoOne(String ordercode) throws SQLException;
	
	
	// 작성한 리뷰 insert
	int insertReviewOne(Map<String, String> paraMap) throws SQLException;

	
	//작성한 리뷰 불러오기
	List<ReviewVO> selectPreviewListAll(Map<String, String> paraMap) throws SQLException;



	

	

	
	

}
