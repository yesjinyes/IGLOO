package member.model.yg;

import java.sql.SQLException;

import member.domain.MemberVO;

public interface MemberDAO {

	// == 회원정보를 수정해주는 메소드 == //
	int updateMember(MemberVO member) throws SQLException;

}
