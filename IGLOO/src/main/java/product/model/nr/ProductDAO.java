package product.model.nr;

import java.sql.SQLException;
import java.util.List;

import product.domain.ProductVO;
import product.domain.TasteVO;

public interface ProductDAO {

	// 아이스크림 맛 상세정보 가져오기
	TasteVO getMenuDetail(String tasteno) throws SQLException;

	// 메인페이지 제품리스트 가져오기
	List<ProductVO> getMainProduct() throws SQLException;

	// 메인페이지 맛 정보 가져오기
	List<TasteVO> getMainTaste() throws SQLException;





}
