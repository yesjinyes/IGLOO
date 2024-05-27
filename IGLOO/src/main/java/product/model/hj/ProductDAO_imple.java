package product.model.hj;

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

import product.domain.ProductVO;
import product.domain.TasteVO;

public class ProductDAO_imple implements ProductDAO {

	private DataSource ds;	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	// 생성자
	public ProductDAO_imple() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		    
		}catch(NamingException e) {
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

/////////////////////////////////////////////////////////////////

	// === 선택한 맛 리스트 뽑기 === //
	@Override
	public List<TasteVO> selectTasteList(String selectno) throws SQLException {
		
		List<TasteVO> tasteList = new ArrayList<>();

	      try {
	         conn = ds.getConnection();
	         
	         String sql = " SELECT tastename, tasteno "
	         		+ " FROM "
	         		+ " ( "
	         		+ "    select tasteno, tastename "
	         		+ "    from tbl_taste "
	         		+ " ) "
	         		+ " JOIN "
	         		+ " ( "
	         		+ "    select fk_tasteno "
	         		+ "    from tbl_tasteselect "
	         		+ "    where fk_selectno = ? "
	         		+ " ) "
	         		+ " ON tasteno = fk_tasteno";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, selectno);
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()) {
	        	 TasteVO tvo = new TasteVO();
	             tvo.setTastename(rs.getString("tastename"));
	             tvo.setTasteno(rs.getInt("tasteno"));
	             tasteList.add(tvo);
	         }// end of while-----------------
	         
	      } finally {
	         close();
	      }
	      
	      return tasteList;
		
	}	// end of public List<TasteVO> selectTasteList() throws SQLException {----
	
////////////////////////////////////////////////////////////////////	
	
	// == 맛 목록을 조회해오기(선택한 맛 제외) == //
	@Override
	public List<TasteVO> tasteList() throws SQLException {

		  List<TasteVO> tasteList = new ArrayList<>();

	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select tasteno, tastename "
		         		+ " from tbl_taste "
		         		+ " order by tasteno ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()) {
	        	 TasteVO tvo = new TasteVO();
	             tvo.setTasteno(rs.getInt("tasteno"));
	             tvo.setTastename(rs.getString("tastename"));
	             tasteList.add(tvo);
	         }// end of while-----------------
	         
	      } finally {
	         close();
	      }
	      
	      return tasteList;

	}// end of public List<TasteVO> selectTasteList() throws SQLException

/////////////////////////////////////////////////////////////////////////////
	
	// === 맛 수정 === //
	@Override
	public boolean updateTasteno(Map<String, String> paraMap) throws SQLException {
		
		boolean result = false;

		try {
			int n = 0;
			conn = ds.getConnection();
			
			String sql = " update tbl_tasteselect set fk_tasteno = ? "
					+ " where fk_selectno = ? and tasteselectno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("tasteno"));
			pstmt.setString(2, paraMap.get("selectno"));
			pstmt.setString(3, paraMap.get("tasteselectno"));
			
			/*
			 * System.out.println(paraMap.get("tasteno"));
			 * System.out.println(paraMap.get("selectno"));
			 * System.out.println(paraMap.get("basetasteno"));
			 */

			n = pstmt.executeUpdate();
			if(n==1) {
				result = true;
			}
			
		}finally {
			close();
		}
		
		return result;
		
	}	// end of public boolean updateTasteno(Map<String, String> paraMap) throws SQLException {----

/////////////////////////////////////////////////////////////////////////////	
	
	// === 기존 맛에 대한 선택내역번호 가져오기 === //
	@Override
	public List<TasteVO> selectTastenoList(String selectno) throws SQLException {

		List<TasteVO> selectTastenoList = new ArrayList<>();

	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select tasteselectno "
	         		+ " from tbl_tasteselect "
	         		+ " where fk_selectno = ? "
	         		+ " order by tasteselectno ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, selectno);
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()) {
	        	 TasteVO tvo = new TasteVO();
	             tvo.setTasteselectno(rs.getInt("tasteselectno"));
	             selectTastenoList.add(tvo);
	         }// end of while-----------------
	         
	      } finally {
	         close();
	      }
	      
	      return selectTastenoList;
		
	}	// end of public List<TasteVO> selectTastenoList(String selectno) throws SQLException {---

}

