package admin.model.nr;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import help.domain.nr.FaqVO;
import help.domain.nr.HelpVO;
import member.domain.MemberVO;
import util.security.hj.AES256;
import util.security.hj.SecretMyKey;

public class AdminDAO_imple implements AdminDAO {

	private DataSource ds;	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 생성자
	public AdminDAO_imple() {
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

	@Override
	public int getTotalPage(Map<String, String> paramap) throws SQLException {

		int totalPage = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select ceil(count(*)/?) "
					   + "from tbl_faq_q ";
					   
			int sizePerPage = Integer.parseInt(paramap.get("sizePerPage"));
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sizePerPage);
		
			rs = pstmt.executeQuery();
		
			rs.next();
			totalPage = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalPage;
	}

	
	
	
	
	
	// 관리자 - 1:1 질문 목록 페이징처리 불러오기
	@Override
	public List<FaqVO> select_faq_paging(Map<String, String> paramap) throws SQLException {
		
		List<FaqVO> faqList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select rn, q_no, fk_userid, fk_categoryno, q_title, q_content, q_writeday, answerstatus, name "
					   + "from "
					   + "(select rownum rn, q_no, fk_userid, fk_categoryno, q_title, q_content, q_writeday, answerstatus, name "
					   + "from tbl_faq_q A join tbl_member B "
					   + "on A.fk_userid = B.userid "
					   + "order by q_writeday desc, answerstatus asc) "
					   + "where rn between ? and ? ";
					   
			int currentShowPageNo = Integer.parseInt(paramap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paramap.get("sizePerPage"));
			
			pstmt = conn.prepareStatement(sql);
			
			/*
				페이징 처리 공식
				where RNO between (조회하고자하는페이지번호 * 한페이지당보여줄행의개수) - (한페이지당보여줄행의개수 - 1) and (조회하고자하는페이지번호 * 한페이지당보여줄행의개수);
			*/
			
			pstmt.setInt(1, currentShowPageNo*sizePerPage-(sizePerPage-1));
			pstmt.setInt(2, currentShowPageNo*sizePerPage);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FaqVO fvo = new FaqVO();
				fvo.setQ_no(rs.getInt(2));
				fvo.setFk_userid(rs.getString(3));
				fvo.setFk_categoryno(rs.getInt(4));
				fvo.setQ_title(rs.getString(5));
				fvo.setQ_content(rs.getString(6));
				fvo.setQ_writeday(rs.getString(7));
				fvo.setAnswerstatus(rs.getInt(8));
				
				MemberVO mvo = new MemberVO();
				mvo.setName(rs.getString(9));
				
				fvo.setMvo(mvo);
				
				faqList.add(fvo);
			}
			
		} finally {
			close();
		}
		
		return faqList;
	}

	
	
	
	
	
	// 관리자 - 1:1 질문 총 개수 알아오기
	@Override
	public int getTotalFaqCount(Map<String, String> paramap) throws SQLException {
		
		int totalFaqCount = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select count(*) "
					   + "from tbl_faq_q ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
		
			rs.next();
			totalFaqCount = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalFaqCount;
	}

	
}
