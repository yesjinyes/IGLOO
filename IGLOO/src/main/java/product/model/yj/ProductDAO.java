package product.model.yj;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import product.domain.ProductVO;
import product.domain.TasteVO;
public interface ProductDAO {
	
	// == 상품에 대한 정보 알아오는 메소드 == //
	List<ProductVO> getproductList() throws SQLException;
	
	// == 맛 목록 조회해오기 == //
	List<TasteVO> selectTasteList() throws SQLException;

	// == 정보 한 개만 불러오기 == //
	ProductVO getproductList_2(String pcode) throws SQLException;

	// == TBL_SELECTLIST 에 insert 하는 메소드 생성 == //
	Map<String, Integer> insertSelectList(Map<String, Object> paraMap) throws SQLException;

	// == TBL_TASTESELECT 에 insert 하는 메소드 생성 == //
	int insertTasteList(Map<String, Object> paraMap) throws SQLException;

	// == TBL_CART 에 insert 하는 메소드 생성 == //
	int insertCartList(Map<String, Object> paraMap) throws SQLException;
	
	

	
	
}