package product.model.yj;

import java.sql.SQLException;
import java.util.Map;

import product.domain.ProductVO;

public interface ProductDAO {

	// == 컵 사이즈, 상세정보, 가격 알아오는 메소드 ==
	ProductVO getproduct(Map<String, String> paraMap) throws SQLException;

	
	
}
