package product.model.yj;

import java.sql.SQLException;
import java.util.Map;

public interface ProductDAO {

	// == 컵 사이즈 알아오는 메소드 ==
	String getproduct(Map<String, String> paraMap) throws SQLException;

	
	
}
