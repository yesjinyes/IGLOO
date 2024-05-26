package admin.model.yg;

import java.sql.SQLException;
import java.util.Map;

import product.domain.ProductVO;

public interface ProductRegisterDAO {

	// tbl_product 테이블에 제품정보 insert 하기 
	int productInsert(ProductVO pvo) throws SQLException;

}
