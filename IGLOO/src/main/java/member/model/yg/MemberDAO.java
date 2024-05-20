package member.model.yg;

import java.sql.SQLException;
import java.util.Map;

import member.domain.MemberVO;

public interface MemberDAO {

	// == 회원정보를 수정해주는 메소드 == //
	int updateMember(MemberVO member) throws SQLException;

	// == 회원정보수정하기를 눌렀을 때 비밀번호를 확인하는 메소드 == //
	String updatePswCheck(Map<String, String> paraMap) throws SQLException;

}
