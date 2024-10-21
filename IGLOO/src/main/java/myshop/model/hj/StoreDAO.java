package myshop.model.hj;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface StoreDAO {

	// 점포 정보 불러오기
	List<Map<String, String>> viewStoreList() throws SQLException;

	// 점포 검색 - 리스트에서 보기
	List<Map<String, String>> getSearchStore(String searchInput) throws SQLException;

}
