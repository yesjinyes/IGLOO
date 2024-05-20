package product.model.yj;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import product.domain.ProductVO;
import product.domain.TasteVO;

public interface ProductDAO {

	// == 컵 사이즈, 상세정보, 가격 알아오는 메소드 == //
	ProductVO getproduct(String productcodeno) throws SQLException;

	// == 맛 목록을 조회해오기 == //
	List<TasteVO> selectTasteList() throws SQLException;

	
	
}
