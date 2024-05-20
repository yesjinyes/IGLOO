package member.model.nr;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import member.domain.MemberVO;

public interface MemberDAO {

	// 페이지 수 알아오기
	int getTotalPage(Map<String, String> paramap) throws SQLException;

	// 회원 조회(모든 회원, 검색 회원) -- 페이징 O
	List<MemberVO> select_member_paging(Map<String, String> paramap) throws SQLException;
	
	// 회원의 총 개수 알아오기
	int getTotalMemberCount(Map<String, String> paramap) throws SQLException;
	
	// 회원목록에서 선택한 한 명의 회원정보 보기
	MemberVO selectOneMember(String userid) throws SQLException;
	
}
