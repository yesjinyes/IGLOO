package member.model.yg;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jakarta.security.auth.message.callback.PrivateKeyCallback.Request;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import util.security.hj.AES256;
import util.security.hj.SecretMyKey;
import util.security.hj.Sha256;

public class MemberDAO_imple implements MemberDAO {

	private DataSource ds;	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 생성자
	public MemberDAO_imple() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		    
		    aes = new AES256(SecretMyKey.key);
		    // SecretMyKey.KEY 은 우리가 만든 암호화/복호화 키이다.
		    
		}catch(NamingException e) {
			e.printStackTrace();
		} catch(UnsupportedEncodingException e){
			e.printStackTrace();
		}
	}
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기 
	private void close() {
		try {
			if(rs != null)    {rs.close();    rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null)  {conn.close();  conn=null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

///////////////////////////////////////////////////////////////////////////////////
	
	// == 회원정보를 수정해주는 메소드 == //
	@Override
	public int updateMember(MemberVO member) throws SQLException {
		int result = 0;
		
		try {
			conn = ds.getConnection();	
			
			String sql = " update tbl_member set name = ?, email = ?, birthday = ? "
					   + "                      ,mobile = ?, postcode = ?, address = ?, detailaddress = ?, extraaddress = ? "
					   + " where userid = ? "; 
					
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getName());		// 단방향 암호화
			// 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다.
			pstmt.setString(2, aes.encrypt(member.getEmail()));
			pstmt.setString(3, member.getBirthday());
			// 휴대폰 번호를 AES256 알고리즘으로 양방향 암호화 시킨다.
			pstmt.setString(4, aes.encrypt(member.getMobile()));
			pstmt.setString(5, member.getPostcode());
			pstmt.setString(6, member.getAddress());
			pstmt.setString(7, member.getDetailaddress());
			pstmt.setString(8, member.getExtraaddress());
			pstmt.setString(9, member.getUserid());
			
	        result = pstmt.executeUpdate();		// return 타입은 int
	        
		} catch(UnsupportedEncodingException | GeneralSecurityException e){
			e.printStackTrace();
		}  finally {
			close();
		}	// end of try~finally---------------------
		
		return result;
	}


}
