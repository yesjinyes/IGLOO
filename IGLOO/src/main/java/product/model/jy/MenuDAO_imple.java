package product.model.jy;

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


import product.domain.TasteVO;



public class MenuDAO_imple implements MenuDAO {
	
	private DataSource ds;  // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	// 생성자
	public MenuDAO_imple() {
		
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		    
		    
		    
		} catch(NamingException e) {
			e.printStackTrace();
		}
		
	}
	
	private void close() {
		try {
			if(rs != null)    {rs.close();    rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null)  {conn.close();  conn=null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

	
	
	
	
	//아이스크림 맛의 전체개수를 알아오기
	@Override
	public int totalCount() throws Exception {
		
		int totalCount = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*) "
					   + " from tbl_taste "
					    ;
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalCount = rs.getInt(1);
			
			
		} finally {
			close();
		}
		
		return totalCount;
		
	}// end of public int totalPspecCount(String string) throws SQLException------

	
	
	
	//아이스크림 정보 조회
	@Override
	public List<TasteVO> getMenuList() throws Exception {
		
		List<TasteVO> menuList = new ArrayList<>(); 
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select cnum, code, cname "  
			 		    + " from tbl_taste "
			 		   ;
			 		    
			pstmt = conn.prepareStatement(sql);
					
			rs = pstmt.executeQuery();
						
//			while(rs.next()) {
//				TasteVO tvo = new TasteVO();
//				tvo.setCnum(rs.getString(1));
//				tvo.setCode(rs.getString(2));
//				tvo.setCname(rs.getString(3));
//				
//				categoryList.add(cvo);
//			}// end of while(rs.next())----------------------------------
//			
		} finally {
			close();
		}	
		
		return menuList;
	}

	
	
	
	
	


}
