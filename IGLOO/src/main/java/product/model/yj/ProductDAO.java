package product.model.yj;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import product.domain.ProductVO;
import product.domain.TasteVO;
public interface ProductDAO {
	
	List<ProductVO> getproductList() throws SQLException;
	
	// == 맛 목록 조회해오기 == //
	List<TasteVO> selectTasteList() throws SQLException;

	// == 정보 한 개만 불러오기 == //
	ProductVO getproductEach(String pcode) throws SQLException;

	// == TBL_SELECTLIST 에 insert 하는 메소드 생성 == //
	List<Map<String, Integer>> insertSelectList(int tasteListSize, String userid, String pcode) throws SQLException;

	// == TBL_TASTESELECT 에 insert 하는 메소드 생성 == //
	int insertTasteList(List<Map<String, Integer>> resultList, List<Map<String, Integer>> tasteinfoList) throws SQLException;

	// == TBL_CART 에 insert 하는 메소드 생성 == //
	int insertCartList(String userid, List<Map<String, Integer>> tasteinfoList, List<Map<String, Integer>> resultList) throws SQLException;
	
}

