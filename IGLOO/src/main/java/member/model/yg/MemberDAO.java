package member.model.yg;

import java.sql.SQLException;

import member.domain.MemberVO;

public interface MemberDAO {

	// == 회원정보를 수정해주는 메소드 == //
	int updateMember(MemberVO member) throws SQLException;

	// == 헤더에 표시될 이름을 불러와주는 메소드 == //
	MemberVO loginnamepull(String userid) throws SQLException;

}
