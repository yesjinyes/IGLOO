package member.model.hj;

import java.sql.SQLException;
import java.util.Map;

import member.domain.MemberVO;

public interface MemberDAO {

	// === 아이디 찾기 === //
	String findUserid(Map<String, String> paraMap) throws SQLException;

	// === 비밀번호 찾기 (회원 존재유무 확인) === //
	boolean isUserExist(Map<String, String> paraMap)throws SQLException;

	// === 회원가입 === //
	int registerMember(MemberVO member) throws SQLException;

	// === 로그인 === //
	MemberVO login(Map<String, String> paraMap) throws SQLException;

}
