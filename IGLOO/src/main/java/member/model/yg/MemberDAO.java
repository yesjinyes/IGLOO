package member.model.yg;

import java.sql.SQLException;
import java.util.Map;

import member.domain.MemberVO;

public interface MemberDAO {

	// == 회원정보를 수정해주는 메소드 == //
	int updateMember(MemberVO member) throws SQLException;

	// == 회원정보수정하기를 눌렀을 때 비밀번호를 확인하는 메소드 == //
	boolean updatePswCheck(Map<String, String> paraMap) throws SQLException;

	// 회원정보 수정시 email 중복검사 (tbl_member 테이블에서 다른 사용자가 email 이 존재하면 true 를 리턴해주고, email 이 존재하지 않으면 false 를 리턴한다) 
	boolean emailDuplicateCheck2(Map<String, String> paraMap) throws SQLException;

}
