package member.model.jy;

import java.sql.SQLException;
import java.util.List;

import order.domain.OrderdetailVO;

public interface ReviewDAO {
	
	//주문상세번호를 가지고서 주문한 제품, 맛을 조회해오기 
	//List<ReviewVO> reviewlist(String userid) throws SQLException;
	
	
	//로그인한 사용자의 주문상세목록 조회해기 
	List<OrderdetailVO> selectOdetailByuserid(String userid) throws SQLException;

	
	
	

}
