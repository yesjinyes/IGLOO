package member.model.nr;

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

import member.domain.MemberVO;
import util.security.hj.AES256;
import util.security.hj.SecretMyKey;

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
	
	
	// ===============================================================
	
	
	
	// 페이지 수 알아오기
	@Override
	public int getTotalPage(Map<String, String> paramap) throws SQLException {

		int totalPage = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select ceil(count(*)/?) "
					   + "from tbl_member "
					   + "where userid != 'admin' ";
					   
			String colname = paramap.get("searchType");
			String searchWord = paramap.get("searchWord");
			int sizePerPage = Integer.parseInt(paramap.get("sizePerPage"));
			
			
			if("email".equals(colname)) {
				searchWord = aes.encrypt(searchWord);
			}
			
			if((!colname.trim().isEmpty()) && (!searchWord.trim().isEmpty())) {
				sql += "and "+colname+" like '%'||?||'%' ";
				// 컬럼명과 테이블명은 위치홀더(?)를 사용할 수 없다. 위치홀더는 오로지 데이터값만 들어온다.
			}

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sizePerPage);
			
			if((!colname.trim().isEmpty()) && (!searchWord.trim().isEmpty())) {
				pstmt.setString(2, searchWord);
			}
			rs = pstmt.executeQuery();
		
			rs.next();
			totalPage = rs.getInt(1);
			
			
		}catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return totalPage;
	}
	
	
	
	
	
	
	
	
	
	
	
	// 회원 조회(모든 회원, 검색 회원) -- 페이징 O
	@Override
	public List<MemberVO> select_member_paging(Map<String, String> paramap) throws SQLException {
		
		List<MemberVO> memberList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select rn, userid, name, email, gender "
						+"from "
						+"( "
						+"select rownum rn, userid, name, email, gender "
						+"from "
						+"( "
						+"select userid, name, email, gender "
						+"from tbl_member "
						+"where userid != 'admin' ";
					   
			String colname = paramap.get("searchType");
			String searchWord = paramap.get("searchWord");
			int currentShowPageNo = Integer.parseInt(paramap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paramap.get("sizePerPage"));
			
			if("email".equals(colname)) {
				searchWord = aes.encrypt(searchWord);
			}
			
			if((!colname.trim().isEmpty()) && (!searchWord.trim().isEmpty())) {
				sql += "and "+colname+" like '%'||?||'%' ";
				// 컬럼명과 테이블명은 위치홀더(?)를 사용할 수 없다. 위치홀더는 오로지 데이터값만 들어온다.
			}
			sql += "order by registerday desc "
				 + ")A "
				 + ")B "
				 + "where rn between ? and ? ";

			pstmt = conn.prepareStatement(sql);
			
			/*
				페이징 처리 공식
				where RNO between (조회하고자하는페이지번호 * 한페이지당보여줄행의개수) - (한페이지당보여줄행의개수 - 1) and (조회하고자하는페이지번호 * 한페이지당보여줄행의개수);
			*/
			
			// 검색을 한 경우
			if((!colname.trim().isEmpty()) && (!searchWord.trim().isEmpty())) {
				pstmt.setString(1, searchWord);
				pstmt.setInt(2, currentShowPageNo*sizePerPage-(sizePerPage-1));
				pstmt.setInt(3, currentShowPageNo*sizePerPage);
			}
			
			// 검색 안 한 경우
			else {
				pstmt.setInt(1, currentShowPageNo*sizePerPage-(sizePerPage-1));
				pstmt.setInt(2, currentShowPageNo*sizePerPage);
			}
			
			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberVO mvo = new MemberVO();
				mvo.setUserid(rs.getString(2));
				mvo.setName(rs.getString(3));
				mvo.setEmail(aes.decrypt(rs.getString(4)));
				mvo.setGender(rs.getString(5));
				
				memberList.add(mvo);
			}
			
		}catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return memberList;
	}
	
	
	
	
	
	
	
	
	
	
	// 회원 총 개수 알아오기
	@Override
	public int getTotalMemberCount(Map<String, String> paramap) throws SQLException {
		
		int totalMemberCount = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select count(*) "
					   + "from tbl_member "
					   + "where userid != 'admin' ";
					   
			String colname = paramap.get("searchType");
			String searchWord = paramap.get("searchWord");
			
			if("email".equals(colname)) {
				searchWord = aes.encrypt(searchWord);
			}
			
			if((!colname.trim().isEmpty()) && (!searchWord.trim().isEmpty())) {
				sql += "and "+colname+" like '%'||?||'%' ";
				// 컬럼명과 테이블명은 위치홀더(?)를 사용할 수 없다. 위치홀더는 오로지 데이터값만 들어온다.
			}

			pstmt = conn.prepareStatement(sql);
			if((!colname.trim().isEmpty()) && (!searchWord.trim().isEmpty())) {
				pstmt.setString(1, searchWord);
			}
			rs = pstmt.executeQuery();
		
			rs.next();
			totalMemberCount = rs.getInt(1);
			
			
		}catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return totalMemberCount;
	}
	
	
	
	
	
	
	
	
	
	
	// 회원목록에서 선택한 한 명의 회원정보 조회하기
	@Override
	public MemberVO selectOneMember(String userid) throws SQLException {

		MemberVO member = null;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql =  " select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender "
	                  + "      , birthday, to_char(registerday, 'yyyy-mm-dd') AS registerday "
	                  + " from tbl_member "
	                  + " where status = 1 and userid = ? ";
	                     
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, userid);
	         
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()) {
	            member = new MemberVO();
	            
	            member.setUserid(rs.getString(1));
	            member.setName(rs.getString(2));
	            member.setEmail( aes.decrypt(rs.getString(3)) );  // 복호화
	            member.setMobile( aes.decrypt(rs.getString(4)) ); // 복호화
	            member.setPostcode(rs.getString(5));
	            member.setAddress(rs.getString(6));
	            member.setDetailaddress(rs.getString(7));
	            member.setExtraaddress(rs.getString(8));
	            member.setGender(rs.getString(9));
	            member.setBirthday(rs.getString(10));
	            member.setRegisterday(rs.getString(11));
	         } // end of if(rs.next())-------------------
	         
	      } catch(GeneralSecurityException | UnsupportedEncodingException e) {
	         e.printStackTrace();
	      } finally {
	         close();
	      }
	      
	      return member;
	      
	}
	
	
}
