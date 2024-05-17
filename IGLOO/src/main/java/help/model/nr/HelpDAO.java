package help.model.nr;

import java.sql.SQLException;
import java.util.List;

import help.domain.nr.FaqVO;
import help.domain.nr.HelpVO;

public interface HelpDAO {

	// 마이페이지 - 1:1 문의내역 - faq q, a 얻어오기
	List<FaqVO> viewfaq(String userid) throws SQLException;

	// 고객센터 - 자주하는 질문 select
	List<HelpVO> faqlist(String category) throws SQLException;

}
