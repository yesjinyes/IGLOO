package member.model.jy;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import help.domain.nr.FaqVO;
import member.domain.ReviewVO;
import util.security.hj.AES256;
import util.security.hj.SecretMyKey;

public class ReviewDAO_imple implements ReviewDAO {

	private DataSource ds;	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 생성자
	public ReviewDAO_imple() {
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
	
	
	
	
	//회원의 주문내역 조회해오기
//	@Override
//	public List<ReviewVO> reviewlist(String userid) throws SQLException {
//		
//		List<ReviewVO> reviewlist = null;
//		
//		try {
//			
//			conn = ds.getConnection();
//			
//			String sql = "   select ordercode, fk_userid, orderdate, reviewstatus "
//						+"   from tbl_order "
//						+" where fk_userid = ? ";
//			
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, userid);
//			
//			rs = pstmt.executeQuery();
//			
//			if(rs.next()) {
//				ReviewVO rvo = new ReviewVO();
//				rvo.setFk_ordercode(rs.getString(1));
//				rvo.setFk_userid(userid);
//				rvo.setFk_ordercode(rs.getString(1));
//				rvo.setFk_ordercode(rs.getString(1));
//				
//				reviewlist.add(rvo);
//			}
//			
//		} finally {
//			close();
//		}
//		
//		
//		return reviewlist;
//	}

}
