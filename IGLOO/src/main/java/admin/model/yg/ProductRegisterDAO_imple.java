package admin.model.yg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import product.domain.ProductVO;

public class ProductRegisterDAO_imple implements ProductRegisterDAO {
	
	private DataSource ds;
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자
	public ProductRegisterDAO_imple() {
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
    
    // tbl_product 테이블에 제품정보 insert 하기 
	@Override
	public int productInsert(ProductVO pvo) throws SQLException {
		
		int result = 0;
	      
	      try {
	         conn = ds.getConnection();
	          
	         String sql = " INSERT INTO tbl_product(PRODUCTCODENO, PRODUCTNAME, PRODUCTIMG, PRICE, PRODUCTDETAIL, PRODUCTIMGBELOW) "
	         		    + " values(?,?,?,?,?,?) ";
	         
	         pstmt = conn.prepareStatement(sql);
	           
	         pstmt.setString(1, pvo.getProductcodeno());
	         pstmt.setString(2, pvo.getProductname());
	         pstmt.setString(3, pvo.getProductimg());
	         pstmt.setInt(4, pvo.getPrice());
	         pstmt.setString(5, pvo.getProductdetail());
	         pstmt.setString(6, pvo.getProductimgBelow());

	         result = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return result;
		
	}


}
