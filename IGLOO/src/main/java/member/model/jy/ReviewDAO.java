package member.model.jy;

import java.sql.SQLException;
import java.util.List;

import order.domain.OrderdetailVO;

public interface ReviewDAO {
	
	//주문상세번호를 가지고서 주문한 제품, 맛을 조회해오기 
	//List<ReviewVO> reviewlist(String userid) throws SQLException;
	
	
	//로그인한 사용자의 주문상세목록 조회해기 
	//List<OrderdetailVO> selectOdetailByuserid(String userid) throws SQLException;

	//로그인한 사용자의 주문한 맛 목록 조회하기
	//List<OrderdetailVO> selectOtasteByuserid(String userid) throws SQLException;

	
	
	
	// 전체 주문내역 불러오기(선택 맛 제외)
	List<OrderdetailVO> selectOrderListAll(String userid) throws SQLException;

	// 주문내역에서 맛 이미지 불러오기
	//List<OrderdetailVO> selectOrderTasteList(String userid) throws SQLException;
	
	

}
