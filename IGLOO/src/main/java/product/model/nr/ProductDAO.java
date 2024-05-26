package product.model.nr;

import java.sql.SQLException;

import product.domain.TasteVO;

public interface ProductDAO {

	// 아이스크림 맛 상세정보 가져오기
	TasteVO getMenuDetail(String tasteno) throws SQLException;




}
