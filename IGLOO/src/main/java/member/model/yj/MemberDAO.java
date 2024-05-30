package member.model.yj;

import java.sql.SQLException;
import java.util.Map;

import member.domain.MemberVO;

public interface MemberDAO {

	// === userid 의 존재유무 파악 === //
	boolean idDuplicateCheck(String userid) throws SQLException;

	// === email 의 존재유무 파악 === //
	boolean EmailDuplicateCheck(String email) throws SQLException;
	
	// === 회원가입 === //
	int registerMember(MemberVO member) throws SQLException;
	
	// === 로그인 === //
	MemberVO login(Map<String, String> paraMap) throws SQLException;
	
	// === 아이디 찾기 === //
	String findUserid(Map<String, String> paraMap) throws SQLException;

	// === 비밀번호 찾기 (회원 존재유무 확인) === //
	boolean isUserExist(Map<String, String> paraMap)throws SQLException;

	//////////////////////////////////////////////////////////////////////////////
	
	// === 비밀번호 변경 === //
	int pwdUpdateEnd(Map<String, String> paraMap) throws SQLException;

	// === 비밀번호 변결 - 3개월 == //
	int pwdUpdate_3months(Map<String, String> paraMap) throws SQLException;

	// == 비밀번호 변경 시 동일여부 확인 === //
	String checkPwd(Map<String, String> paraMap) throws SQLException ;

	
}
