package product.model.jy;

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
			 
			 String sql = " select tasteno, tastename, tasteimg "  
			 		    + " from tbl_taste "
			 		   ;
			 		    
			pstmt = conn.prepareStatement(sql);
					
			rs = pstmt.executeQuery();
						
			while(rs.next()) {
				TasteVO tvo = new TasteVO();
				tvo.setTasteno(rs.getInt(1));
				tvo.setTastename(rs.getString(2));
				tvo.setTasteimg(rs.getString(3));
				
				menuList.add(tvo);
			}// end of while(rs.next())----------------------------------
			
		} finally {
			close();
		}	
		
		return menuList;
	}
	
	
	
	
	
	
	
	//더보기 방식으로 상품정보 8개씩 잘라서 조회해오기
	@Override
	public List<TasteVO> selectIceAll(Map<String, String> paraMap) throws Exception {
		
		List<TasteVO> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql =  " SELECT tasteno, tastename, tasteimg " 
						+ " FROM "
						+ " ( "
						+ "   select row_number() over(order by tasteno desc) AS RNO "
						+ " 		, tasteno ,tastename, tasteimg "
						+ "    from tbl_taste "
						+ " ) V "
						+ " WHERE RNO between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("start"));
			pstmt.setString(2, paraMap.get("end"));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				TasteVO tvo = new TasteVO();
				
				tvo.setTasteno(rs.getInt(1));     // 제품번호
				tvo.setTastename(rs.getString(2)); // 제품명
				tvo.setTasteimg(rs.getString(3)); // 제품명
				
								
				productList.add(tvo);
				
			}// end of while(rs.next())-------------------------
			
			
		} finally {
			close();
		}
		
		return productList;		

	}

	
	
	
	
	


}
