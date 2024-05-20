package myshop.model.nr;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface StoreDAO {

	// 점포 정보 불러오기
	List<Map<String, String>> viewStoreList() throws SQLException;

}
