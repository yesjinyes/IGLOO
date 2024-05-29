package help.model.nr;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import help.domain.nr.FaqVO;
import help.domain.nr.HelpVO;
import product.domain.ProductVO;
import product.domain.TasteVO;

public interface HelpDAO {

	// 마이페이지 - 1:1 문의내역 - faq q, a 얻어오기
	List<FaqVO> viewfaq(String userid) throws SQLException;

	// 고객센터 - 자주하는 질문 select
	List<HelpVO> faqlist(String category) throws SQLException;

	// 고객센터 - 자주하는 질문 총 페이지 수
	int getTotalPage(Map<String, String> paramap) throws SQLException;

	// 고객센터 - 자주하는 질문 페이징처리
	List<HelpVO> faqlist_paging(Map<String, String> paramap) throws SQLException;

	// 고객센터 - 자주하는 질문 총 개수
	int getTotalFaqCount(Map<String, String> paramap) throws SQLException;

	// 맛 검색
	List<TasteVO> searchTaste(String search) throws SQLException;

	// 제품(컵) 검색
	List<ProductVO> searchCup(String search) throws SQLException;

	// 자주하는 질문 검색
	List<HelpVO> searchFaq(String search) throws SQLException;

	// 검색결과 더보기 - 페이지 수 구하기
	int getTotalSearchPage(Map<String, String> paramap) throws SQLException;

	// 검색결과 더보기 - 페이징 처리
	List<HelpVO> search_help_paging(Map<String, String> paramap) throws SQLException;
	List<TasteVO> search_taste_paging(Map<String, String> paramap) throws SQLException;
	List<ProductVO> search_product_paging(Map<String, String> paramap) throws SQLException;

	// 전체 행 개수
	int getTotalSearchCount(Map<String, String> paramap) throws SQLException;

	// 사용자 - 1:1 문의 등록하기
	int registerFaq(Map<String, String> paramap) throws SQLException;
	
}
