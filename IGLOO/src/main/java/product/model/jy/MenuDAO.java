package product.model.jy;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import product.domain.TasteVO;


public interface MenuDAO {

	//아이스크림 맛의 전체개수를 알아오기
	int totalCount() throws Exception;

	


	//더보기 방식으로 상품정보 8개씩 잘라서 조회해오기 //이름순, 인기순 정렬      
	//List<TasteVO> selectIceAll(Map<String, String> paraMap) throws Exception;



	//정보
	List<TasteVO> icejsonList(Map<String, String> paraMap) throws Exception;

	



}
