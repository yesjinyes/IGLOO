package product.model.hj;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import product.domain.ProductVO;
import product.domain.TasteVO;
public interface ProductDAO {
	
	// === 선택한 맛 리스트 뽑기 === //
	List<TasteVO> selectTasteList(String selectno) throws SQLException;
	
	// == 맛 목록을 조회해오기(선택한 맛 제외) == //
	List<TasteVO> tasteList() throws SQLException;

	// === 기존 맛에 대한 선택내역번호 가져오기 === //
	List<TasteVO> selectTastenoList(String selectno) throws SQLException;

	// === 맛 수정 === //
	boolean updateTasteno(Map<String, String> paraMap) throws SQLException;

	// === 주문코드를 위한 시퀀스 번호 select 해오기 === //
	int get_seq_tbl_order() throws SQLException;

	// order와 ,orderdetail 테이블에 insert 해주는 메소드
	int productOrder(Map<String, Object> paraMap) throws SQLException;

	// === 제품명 가져오는 메소드 생성하기 === //
	List<String> get_productname_tbl_product(String[] cartno_arr) throws SQLException;

}