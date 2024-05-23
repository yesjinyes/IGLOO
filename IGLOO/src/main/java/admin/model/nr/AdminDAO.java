package admin.model.nr;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import help.domain.nr.FaqVO;
import order.domain.OrderdetailVO;

public interface AdminDAO {

	// 관리자 - 1:1 질문 목록 총 페이지 가져오기
	int getTotalPage(Map<String, String> paramap) throws SQLException;

	// 관리자 - 1:1 질문 목록 페이징처리 불러오기
	List<FaqVO> select_faq_paging(Map<String, String> paramap) throws SQLException;

	// 관리자 - 1:1 질문 총 개수 알아오기
	int getTotalFaqCount(Map<String, String> paramap) throws SQLException;

	// 관리자 - 1:1 질문 상세보기
	FaqVO getFaq(String fk_q_no) throws SQLException;

	// 관리자 - 1:1 답변 등록
	int insertAnswer(Map<String, String> paramap) throws SQLException;

	// 전체주문내역 불러오기(선택 맛 제외)
	List<OrderdetailVO> selectOrderListAll() throws SQLException;



}
