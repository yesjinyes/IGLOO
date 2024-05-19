package cart.model.hj;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
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

import myshop.domain.CartVO;
import product.domain.ProductVO;
import product.domain.TasteVO;

public class CartDAO_imple implements CartDAO {

	private DataSource ds;	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private CartVO cdto;
	private ProductVO pdto;
	private TasteVO tdto;
	private List<TasteVO> talstenamelist;
	
	// 생성자
	public CartDAO_imple() {
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

///////////////////////////////////////////////////////////////////////////////////
	
	
	// === 해당 사용자의 장바구니 리스트 읽기 === //
	@Override
	public List<CartVO> getCartlist(String userid) throws SQLException {

		List<CartVO> cartList = new ArrayList<>();
		
		try {
	         conn = ds.getConnection();
	         
	         String sql = " SELECT cartno, O.fk_userid as userid, count, productname, price, productimg, tastename "
	         		+ " FROM "
	         		+ " ( "
	         		+ "    SELECT fk_userid, selectno, productname, tastename, price, productimg "
	         		+ "    FROM "
	         		+ "    ( "
	         		+ "        SELECT tasteselectno, fk_selectno, tastename "
	         		+ "        FROM "
	         		+ "        ( "
	         		+ "            SELECT tasteselectno, fk_selectno, fk_tasteno "
	         		+ "            FROM tbl_tasteselect "
	         		+ "        ) "
	         		+ "        JOIN "
	         		+ "        ( "
	         		+ "            SELECT tasteno, tastename "
	         		+ "            FROM tbl_taste "
	         		+ "        ) "
	         		+ "        ON fk_tasteno = tasteno "
	         		+ "    ) T "
	         		+ "    JOIN "
	         		+ "    ( "
	         		+ "        SELECT selectno, fk_productcodeno, productname, price, fk_userid, productimg "
	         		+ "        FROM "
	         		+ "        ( "
	         		+ "            SELECT selectno, fk_productcodeno, productname, price, fk_userid, productimg "
	         		+ "            FROM "
	         		+ "            ( "
	         		+ "                SELECT productcodeno, productname, price, productimg "
	         		+ "                FROM tbl_product "
	         		+ "            ) "
	         		+ "            JOIN "
	         		+ "            ( "
	         		+ "                SELECT selectno, fk_productcodeno, fk_userid "
	         		+ "                FROM tbl_selectlist "
	         		+ "            ) "
	         		+ "            ON productcodeno = fk_productcodeno "
	         		+ "        ) "
	         		+ "        JOIN "
	         		+ "        ( "
	         		+ "            SELECT userid "
	         		+ "            FROM tbl_member "
	         		+ "        ) "
	         		+ "        ON fk_userid = userid "
	         		+ "    ) "
	         		+ "    ON fk_selectno = selectno "
	         		+ " ) O "
	         		+ "    JOIN "
	         		+ " ( "
	         		+ "    SELECT fk_userid, cartno, COUNT, fk_selectno "
	         		+ "    FROM tbl_cart "
	         		+ " ) "
	         		+ " ON fk_selectno = selectno "
	         		+ " WHERE O.fk_userid = ? ";
	         		

	         pstmt = conn.prepareStatement(sql); 
	         
	         pstmt.setString(1, userid);
	         
	         rs = pstmt.executeQuery();
	         
	         boolean start_flag = true;
	         int cnt = 0;
	         
	         while(rs.next()) {
	        	 
	        	 String productname = rs.getString("productname");
	        	 
	        	 switch (productname) {
	        	 case "파인트":
					
	        		tdto = null;
	        		 
					if(start_flag) {
						start_flag = false;
						cnt = 3;
					
						cdto = new CartVO();
						cdto.setCartno(rs.getString("cartno"));
						cdto.setFk_userid(rs.getString("userid"));
						cdto.setCount(rs.getInt("count"));
						
						pdto = new ProductVO();
						pdto.setProductname(rs.getString("productname"));
						pdto.setPrice(rs.getInt("price"));
						pdto.setProductimg(rs.getString("productimg"));
						
						tdto = new TasteVO();
						tdto.setTastename(rs.getString("tastename"));
						
						talstenamelist = new ArrayList<>();
						talstenamelist.add(tdto);
						
						cnt--;
					}
					else {
						if(cnt > 1) {
							tdto = new TasteVO();
							tdto.setTastename(rs.getString("tastename"));
							talstenamelist.add(tdto);
							cnt--;
						}
						else {	// cnt = 1 (마지막)
							tdto = new TasteVO();
							tdto.setTastename(rs.getString("tastename"));
							talstenamelist.add(tdto);
							
							cdto.setProduct(pdto);
							cdto.setTalstenamelist(talstenamelist);
							
							cartList.add(cdto);
							
							cnt = 0;
							start_flag = true;
							tdto = null;
							pdto = null;
							cdto = null;
							
						}
					}
					break;
				case "쿼터":
					tdto = null;
					
					if(start_flag) {
						start_flag = false;
						cnt = 4;
					
						cdto = new CartVO();
						cdto.setCartno(rs.getString("cartno"));
						cdto.setFk_userid(rs.getString("userid"));
						cdto.setCount(rs.getInt("count"));
						
						pdto = new ProductVO();
						pdto.setProductname(rs.getString("productname"));
						pdto.setPrice(rs.getInt("price"));
						pdto.setProductimg(rs.getString("productimg"));
						
						tdto = new TasteVO();
						tdto.setTastename(rs.getString("tastename"));
						
						talstenamelist = new ArrayList<>();
						talstenamelist.add(tdto);
						
						cnt--;
					}
					else {
						if(cnt > 1) {
							tdto = new TasteVO();
							tdto.setTastename(rs.getString("tastename"));
							talstenamelist.add(tdto);
							cnt--;
						}
						else {	// cnt = 1 (마지막)
							tdto = new TasteVO();
							tdto.setTastename(rs.getString("tastename"));
							talstenamelist.add(tdto);
							
							cdto.setProduct(pdto);
							cdto.setTalstenamelist(talstenamelist);
							
							cartList.add(cdto);
							
							cnt = 0;
							start_flag = true;
							
							tdto = null;
							pdto = null;
							cdto = null;
						}
					}
					break;
				case "패밀리":
					tdto = null;
					
					if(start_flag) {
						start_flag = false;
						cnt = 5;
					
						cdto = new CartVO();
						cdto.setCartno(rs.getString("cartno"));
						cdto.setFk_userid(rs.getString("userid"));
						cdto.setCount(rs.getInt("count"));
						
						pdto = new ProductVO();
						pdto.setProductname(rs.getString("productname"));
						pdto.setPrice(rs.getInt("price"));
						pdto.setProductimg(rs.getString("productimg"));
						
						tdto = new TasteVO();
						tdto.setTastename(rs.getString("tastename"));
						
						talstenamelist = new ArrayList<>();
						talstenamelist.add(tdto);
						
						cnt--;
					}
					else {
						if(cnt > 1) {
							tdto = new TasteVO();
							tdto.setTastename(rs.getString("tastename"));
							talstenamelist.add(tdto);
							cnt--;
						}
						else {	// cnt = 1 (마지막)
							tdto = new TasteVO();
							tdto.setTastename(rs.getString("tastename"));
							talstenamelist.add(tdto);
							
							cdto.setProduct(pdto);
							cdto.setTalstenamelist(talstenamelist);
							
							cartList.add(cdto);
							
							cnt = 0;
							start_flag = true;
							
							tdto = null;
							pdto = null;
							cdto = null;
						}
					}				
					break;
				case "하프갤런":
					tdto = null;
					
					if(start_flag) {
						start_flag = false;
						cnt = 6;
					
						cdto = new CartVO();
						cdto.setCartno(rs.getString("cartno"));
						cdto.setFk_userid(rs.getString("userid"));
						cdto.setCount(rs.getInt("count"));
						
						pdto = new ProductVO();
						pdto.setProductname(rs.getString("productname"));
						pdto.setPrice(rs.getInt("price"));
						pdto.setProductimg(rs.getString("productimg"));
						
						tdto = new TasteVO();
						tdto.setTastename(rs.getString("tastename"));
						
						talstenamelist = new ArrayList<>();
						talstenamelist.add(tdto);
						
						cnt--;
					}
					else {
						if(cnt > 1) {
							tdto = new TasteVO();
							tdto.setTastename(rs.getString("tastename"));
							talstenamelist.add(tdto);
							cnt--;
						}
						else {	// cnt = 1 (마지막)
							tdto = new TasteVO();
							tdto.setTastename(rs.getString("tastename"));
							talstenamelist.add(tdto);
							
							cdto.setProduct(pdto);
							cdto.setTalstenamelist(talstenamelist);
							
							cartList.add(cdto);
							
							cnt = 0;
							start_flag = true;
							
							tdto = null;
							pdto = null;
							cdto = null;
						}
					}
					break;
	        	 }
	         }
	         
	      } finally {
	    	  close();
	      }
		return cartList;
		
	}	// end of public List<CartVO> getCartlist(MemberVO loginuser) throws SQLException------

}
