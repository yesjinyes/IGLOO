package myshop.model.hj;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.hj.AES256;
import util.security.hj.SecretMyKey;

public class StoreDAO_imple implements StoreDAO {


	
	private DataSource ds;	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 생성자
	public StoreDAO_imple() {
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
	
	
	
	// 점포 정보 불러오기
	@Override
	public List<Map<String, String>> viewStoreList() throws SQLException {

		List<Map<String, String>> storeList = new ArrayList<Map<String,String>>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select storeno, storename, storepage, storeimg, storeaddress, storetel, latitude, longitude "
					   + "from tbl_store";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Map<String, String> storemap = new HashMap<String, String>();
				
				storemap.put("storeno", rs.getString(1));
				storemap.put("storename", rs.getString(2));
				storemap.put("storepage", rs.getString(3));
				storemap.put("storeimg", rs.getString(4));
				storemap.put("storeaddress", rs.getString(5));
				storemap.put("storetel", rs.getString(6));
				storemap.put("latitude", rs.getString(7));
				storemap.put("longitude", rs.getString(8));
				
				storeList.add(storemap);
				
			}
			
		} finally {
			close();
		}

		return storeList;
	}

	@Override
	public List<Map<String, String>> getSearchStore(String searchInput) throws SQLException {

		List<Map<String, String>> storeList = new ArrayList<Map<String,String>>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select storeno, storename, storepage, storeimg, storeaddress, storetel, latitude, longitude "
					   + "from tbl_store "
					   + "where storename like '%'|| ? ||'%' or storeaddress like '%'|| ? ||'%' ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchInput);
			pstmt.setString(2, searchInput);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				Map<String, String> storemap = new HashMap<String, String>();
				
				storemap.put("storeno", rs.getString(1));
				storemap.put("storename", rs.getString(2));
				storemap.put("storepage", rs.getString(3));
				storemap.put("storeimg", rs.getString(4));
				storemap.put("storeaddress", rs.getString(5));
				storemap.put("storetel", rs.getString(6));
				storemap.put("latitude", rs.getString(7));
				storemap.put("longitude", rs.getString(8));
				
				storeList.add(storemap);
				
			}
			
			
		}finally {
			close();
		}
		
		return storeList;
	}
	
	
	
}
