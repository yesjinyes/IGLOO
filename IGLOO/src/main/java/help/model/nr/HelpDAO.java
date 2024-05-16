package help.model.nr;

import java.sql.SQLException;
import java.util.List;

import help.domain.nr.FaqVO;

public interface HelpDAO {

	// faq q, a 얻어오기
	List<FaqVO> viewfaq(String userid) throws SQLException;

}
