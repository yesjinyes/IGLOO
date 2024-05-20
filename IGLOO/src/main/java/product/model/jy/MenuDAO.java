package product.model.jy;

import java.sql.SQLException;
import java.util.List;

import product.domain.TasteVO;


public interface MenuDAO {

	//아이스크림 맛의 전체개수를 알아오기
	int totalCount() throws Exception;

	//아이스크림 정보 조회
	List<TasteVO> getMenuList()  throws Exception;



}
