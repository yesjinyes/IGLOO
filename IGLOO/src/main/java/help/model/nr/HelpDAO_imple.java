package help.model.nr;

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
import util.security.hj.AES256;
import util.security.hj.SecretMyKey;

public class HelpDAO_imple implements HelpDAO {

	
	private DataSource ds;	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 생성자
	public HelpDAO_imple() {
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

	
	
	//////////////////////////////////////////////////////////////////
	
	

	// faq q, a 얻어오기
	@Override
	public List<FaqVO> viewfaq(String userid) throws SQLException {
		
		List<FaqVO> faqlist = new ArrayList<FaqVO>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select q_no, q_title, fk_categoryno, q_content, to_char(q_writeday, 'yyyy-mm-dd HH24:mi:ss'), "
					   + "a_content, to_char(a_writeday, 'yyyy-mm-dd HH24:mi:ss') "
					   + "from tbl_faq_q A left join tbl_faq_a B "
					   + "on A.q_no = B.fk_q_no "
					   + "where fk_userid = ? "
					   + "order by q_writeday desc";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FaqVO fvo = new FaqVO();
				fvo.setQ_no(rs.getInt(1));
				fvo.setQ_title(rs.getString(2));
				fvo.setFk_categoryno(rs.getInt(3));
				fvo.setQ_content(rs.getString(4));
				fvo.setQ_writeday(rs.getString(5));
				fvo.setA_content(rs.getString(6));
				fvo.setA_writeday(rs.getString(7));
				
				faqlist.add(fvo);
			}
			
		} finally {
			close();
		}
		
		return faqlist;
	}

	
	
	
	// 페이징 처리 안 함
	@Override
	public List<HelpVO> faqlist(String category) throws SQLException {

		List<HelpVO> hvoList = new ArrayList<HelpVO>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select faqno, f_category, f_title, f_content "
					   + "from tbl_faqlist ";
			
			if(category != null) {
				sql += "where f_category = ?";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			if(category != null) {
				pstmt.setString(1, category);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				HelpVO hvo = new HelpVO();
				hvo.setFaqno(rs.getInt(1));
				hvo.setF_category(rs.getString(2));
				hvo.setF_title(rs.getString(3));
				hvo.setF_content(rs.getString(4));
				hvoList.add(hvo);
			}
			
		} finally {
			close();
		}
		
		return hvoList;
	}

	
	
	
	// 고객센터 - 자주하는 질문 총 페이지 수
	@Override
	public int getTotalPage(Map<String, String> paramap) throws SQLException {
		
		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " select ceil(count(*)/?) "
						+ " from tbl_faqlist ";
			
			if(paramap.get("category") != null) {
				sql += "where f_category = ? ";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(paramap.get("sizePerPage")));
			
			if(paramap.get("category") != null) {
				pstmt.setString(2, paramap.get("category"));
			}
						
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalPage;		
		
	}

	
	
	
	
	
	// 고객센터 - 자주하는 질문 페이징처리
	@Override
	public List<HelpVO> faqlist_paging(Map<String, String> paramap) throws SQLException {

		List<HelpVO> hvolist = new ArrayList<HelpVO>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select rno, faqno, f_category, f_title, f_content "
					   + "from "
					   + "( "
					   + "select rownum rno, faqno, f_category, f_title, f_content "
					   + "from tbl_faqlist ";
			
			String category = paramap.get("category");
			
			if(category != null) {
				sql += "where f_category = ? ";
			}
			
			sql += ") where rno between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPageNo = Integer.parseInt( paramap.get("currentShowPageNo") ); 
			int sizePerPage = Integer.parseInt( paramap.get("sizePerPage") );
			
			if(category != null) {
				pstmt.setString(1, category);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			}
			
			else {
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1) );
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) );
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				HelpVO hvo = new HelpVO();
				hvo.setFaqno(rs.getInt(2));
				hvo.setF_category(rs.getString(3));
				hvo.setF_title(rs.getString(4));
				hvo.setF_content(rs.getString(5));
				
				hvolist.add(hvo);
			}
		
		} finally {
			close();
		}
		
		return hvolist;
	}

	
	
	
	
	// 고객센터 - 자주하는 질문 총 개수
	@Override
	public int getTotalFaqCount(Map<String, String> paramap) throws SQLException {
		
		int totalFaqCount = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " select count(*) "
						+ " from tbl_faqlist ";
			
			String category = paramap.get("category");
						
			if(category != null) {
			   sql += "where f_category = ? ";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			if(category != null) {
				pstmt.setString(1, category);
			}
						
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalFaqCount = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalFaqCount;
	}

	
	
	

	
	
	

	
	
	
	
	
}
