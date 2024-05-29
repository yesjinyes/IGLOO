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
import myshop.domain.CartVO;
import order.domain.OrderVO;
import order.domain.OrderdetailVO;
import product.domain.ProductVO;
import product.domain.TasteVO;
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

	
	
	
	
	//로그인한 사용자의 주문상세목록 조회해기 
	@Override
	public List<OrderdetailVO> selectOdetailByuserid(String userid) throws SQLException {
		
		List<OrderdetailVO> odList = null;
		
	      try {
	          conn = ds.getConnection();
	          
	          String sql = " select userid, orderdetailno, orderdate, productname, productimg, tastename, reviewstatus "
	          		+ "   from tbl_member I "
	          		+ "   join tbl_order A "
	          		+ "   on I.userid = A.fk_userid  "
	          		+ "   join tbl_orderdetail B "
	          		+ "   on A.ordercode = B.fk_ordercode "
	          		+ "   join tbl_selectlist C  "
	          		+ "   on B.fk_selectno = C.selectno "
	          		+ "   join tbl_tasteselect D "
	          		+ "   on C.selectno = D.fk_selectno "
	          		+ "   join tbl_product E "
	          		+ "   on C.fk_productcodeno = E.productcodeno "
	          		+ "   join tbl_taste F "
	          		+ "   on D.fk_tasteno = F.tasteno "
	          		+ "   where userid = ? "
	          		+ "   order by orderdetailno ";
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, userid);
	          
	          rs = pstmt.executeQuery();
	          
	          
	          int cnt = 0;
	          while(rs.next()) {
	             cnt++;
	             
	             if(cnt == 1) {
	            	 odList = new ArrayList<>();
	             }
	             
	             
	             OrderdetailVO odvo = new OrderdetailVO();
	             odvo.setOrderdetailno(rs.getInt("orderdetailno"));
	             
	             OrderVO order = new OrderVO();
	             order.setOrderdate(rs.getString("orderdate"));
	             order.setFk_userid(rs.getString("userid"));
	             odvo.setOrder(order);
	             
	             ProductVO product = new ProductVO();
	             product.setProductname(rs.getString("productname"));
	             product.setProductimg(rs.getString("productimg"));
	             odvo.setProduct(product);
	             
	             TasteVO taste =  new TasteVO();
	             taste.setTastename(rs.getString("tastename"));
	             odvo.setTaste(taste);
	             
	             
	             odList.add(odvo);
	          }// end of while(rs.next())---------------------------
	  
	          
	      } finally {
	          close();
	      }
	       
		
		return odList;
	}

	
	
	//로그인한 사용자의 주문한 맛 목록 조회하기
	@Override
	public List<OrderdetailVO> selectOtasteByuserid(String userid) throws SQLException {
		
		List<OrderdetailVO> otasteList = null;

		try {
	          conn = ds.getConnection();
	          
	          String sql = " select tastename "
	          		+ "   from tbl_member I "
	          		+ "   join tbl_order A "
	          		+ "   on I.userid = A.fk_userid  "
	          		+ "   join tbl_orderdetail B "
	          		+ "   on A.ordercode = B.fk_ordercode "
	          		+ "   join tbl_selectlist C  "
	          		+ "   on B.fk_selectno = C.selectno "
	          		+ "   join tbl_tasteselect D "
	          		+ "   on C.selectno = D.fk_selectno "
	          		+ "   join tbl_product E "
	          		+ "   on C.fk_productcodeno = E.productcodeno "
	          		+ "   join tbl_taste F "
	          		+ "   on D.fk_tasteno = F.tasteno "
	          		+ "   where userid = ? "
	          		+ "   order by orderdetailno ";
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, userid);
	          
	          rs = pstmt.executeQuery();
	          
	          while(rs.next()) {
	        	  
	        	  otasteList = new ArrayList<>();
	        	  
	        	  OrderdetailVO odvo =  new OrderdetailVO();
		          
		          TasteVO taste =  new TasteVO();
	              taste.setTastename(rs.getString("tastename"));
	              odvo.setTaste(taste);
	              
	              otasteList.add(odvo);
	          }
	          
	             
	      } finally {
	          close();
	      }     
	          
		return otasteList;
	}
	
	

	
	
	
	
	
}
