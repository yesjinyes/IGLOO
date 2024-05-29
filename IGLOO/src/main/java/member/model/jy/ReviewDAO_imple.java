package member.model.jy;

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

import member.domain.MemberVO;
import order.domain.OrderVO;
import order.domain.OrderdetailVO;
import product.domain.ProductVO;
import product.domain.SelectlistVO;
import product.domain.TasteVO;
import util.security.hj.AES256;
import util.security.hj.SecretMyKey;

public class ReviewDAO_imple implements ReviewDAO {

	private DataSource ds;	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private ResultSet rs2;
	
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
//	@Override
//	public List<OrderdetailVO> selectOdetailByuserid(String userid) throws SQLException {
//		
//		List<OrderdetailVO> odList = null;
//		
//	      try {
//	          conn = ds.getConnection();
//	          
//	          String sql = " select userid, orderdetailno, orderdate, productname, productimg, tastename, reviewstatus "
//	          		+ "   from tbl_member I "
//	          		+ "   join tbl_order A "
//	          		+ "   on I.userid = A.fk_userid  "
//	          		+ "   join tbl_orderdetail B "
//	          		+ "   on A.ordercode = B.fk_ordercode "
//	          		+ "   join tbl_selectlist C  "
//	          		+ "   on B.fk_selectno = C.selectno "
//	          		+ "   join tbl_tasteselect D "
//	          		+ "   on C.selectno = D.fk_selectno "
//	          		+ "   join tbl_product E "
//	          		+ "   on C.fk_productcodeno = E.productcodeno "
//	          		+ "   join tbl_taste F "
//	          		+ "   on D.fk_tasteno = F.tasteno "
//	          		+ "   where userid = ? "
//	          		+ "   order by orderdetailno ";
//	          
//	          pstmt = conn.prepareStatement(sql);
//	          pstmt.setString(1, userid);
//	          
//	          rs = pstmt.executeQuery();
//	          
//	          
//	          int cnt = 0;
//	          while(rs.next()) {
//	             cnt++;
//	             
//	             if(cnt == 1) {
//	            	 odList = new ArrayList<>();
//	             }
//	             
//	             
//	             OrderdetailVO odvo = new OrderdetailVO();
//	             odvo.setOrderdetailno(rs.getInt("orderdetailno"));
//	             
//	             OrderVO order = new OrderVO();
//	             order.setOrderdate(rs.getString("orderdate"));
//	             order.setFk_userid(rs.getString("userid"));
//	             odvo.setOrder(order);
//	             
//	             ProductVO product = new ProductVO();
//	             product.setProductname(rs.getString("productname"));
//	             product.setProductimg(rs.getString("productimg"));
//	             odvo.setProduct(product);
//	             
//	             TasteVO taste =  new TasteVO();
//	             taste.setTastename(rs.getString("tastename"));
//	             odvo.setTaste(taste);
//	             
//	             
//	             odList.add(odvo);
//	          }// end of while(rs.next())---------------------------
//	  
//	          
//	      } finally {
//	          close();
//	      }
//	       
//		
//		return odList;
//	}

	
	
	//로그인한 사용자의 주문한 맛 목록 조회하기
//	@Override
//	public List<OrderdetailVO> selectOtasteByuserid(String userid) throws SQLException {
//		
//		List<OrderdetailVO> otasteList = null;
//
//		try {
//	          conn = ds.getConnection();
//	          
//	          String sql = " select tastename "
//	          		+ "   from tbl_member I "
//	          		+ "   join tbl_order A "
//	          		+ "   on I.userid = A.fk_userid  "
//	          		+ "   join tbl_orderdetail B "
//	          		+ "   on A.ordercode = B.fk_ordercode "
//	          		+ "   join tbl_selectlist C  "
//	          		+ "   on B.fk_selectno = C.selectno "
//	          		+ "   join tbl_tasteselect D "
//	          		+ "   on C.selectno = D.fk_selectno "
//	          		+ "   join tbl_product E "
//	          		+ "   on C.fk_productcodeno = E.productcodeno "
//	          		+ "   join tbl_taste F "
//	          		+ "   on D.fk_tasteno = F.tasteno "
//	          		+ "   where userid = ? "
//	          		+ "   order by orderdetailno ";
//	          
//	          pstmt = conn.prepareStatement(sql);
//	          pstmt.setString(1, userid);
//	          
//	          rs = pstmt.executeQuery();
//	          
//	          while(rs.next()) {
//	        	  
//	        	  otasteList = new ArrayList<>();
//	        	  
//	        	  OrderdetailVO odvo =  new OrderdetailVO();
//		          
//		          TasteVO taste =  new TasteVO();
//	              taste.setTastename(rs.getString("tastename"));
//	              odvo.setTaste(taste);
//	              
//	              otasteList.add(odvo);
//	          }
//	          
//	             
//	      } finally {
//	          close();
//	      }     
//	          
//		return otasteList;
//	}
	
	
	
	
	
	
	
	
	// 전체 주문내역 불러오기(선택 맛 제외)
	@Override
	public List<OrderdetailVO> selectOrderListAll(String userid) throws SQLException {
		
		List<OrderdetailVO> odvoList = new ArrayList<OrderdetailVO>();
	
		try {
			
			conn = ds.getConnection();
			
			String sql = "select A.orderdetailno, B.ordercode, A.ordercount, C.selectno, A.orderprice, A.pickupstatus, A.pickuptime, "
					   + "       B.fk_userid, B.totalprice, to_char(B.orderdate, 'yyyy-mm-dd hh24:mi:ss'), "
					   + "       D.productcodeno, D.productname, D.productimg, D.price, "
					   + "       E.name, E.email, E.mobile, E.postcode, E.address, E.detailAddress, E.extraaddress, E.gender, E.birthday "
					   + "from tbl_orderdetail A join tbl_order B "
					   + "on A.fk_ordercode = B.ordercode "
					   + "join tbl_selectlist C "
					   + "on A.fk_selectno = C.selectno "
					   + "join tbl_product D "
					   + "on C.fk_productcodeno = D.productcodeno "
					   + "join tbl_member E "
					   + "on B.fk_userid = E.userid "
					   + " where userid = ? "
					   + "order by 1 desc ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			

			
			while(rs.next()) {

				OrderdetailVO odvo = new OrderdetailVO();
				
				int orderdetailno = rs.getInt(1);
				odvo.setOrderdetailno(orderdetailno);
				
				OrderVO ovo = new OrderVO();
				ovo.setOrdercode(rs.getString(2));
				
				odvo.setOrdercount(rs.getInt(3));
				
				SelectlistVO slvo = new SelectlistVO();
				slvo.setSelectno(rs.getInt(4));
				
				odvo.setOrderprice(rs.getInt(5));
				odvo.setPickupstatus(rs.getInt(6));
				odvo.setPickuptime(rs.getString(7));
				
				ovo.setFk_userid(rs.getString(8));
				ovo.setTotalprice(rs.getInt(9));
				ovo.setOrderdate(rs.getString(10));
				
				ProductVO pvo = new ProductVO();
				pvo.setProductcodeno(rs.getString(11));
				pvo.setProductname(rs.getString(12));
				pvo.setProductimg(rs.getString(13));
				pvo.setPrice(rs.getInt(14));

				MemberVO mvo = new MemberVO();
				mvo.setName(rs.getString(15));
				mvo.setEmail(aes.decrypt(rs.getString(16)));
				mvo.setMobile(aes.decrypt(rs.getString(17)));
				mvo.setPostcode(rs.getString(18));
				mvo.setAddress(rs.getString(19));
				mvo.setDetailaddress(rs.getString(20));
				mvo.setExtraaddress(rs.getString(21));
				mvo.setGender(rs.getString(22));
				mvo.setBirthday(rs.getString(23));
				
				ovo.setMember(mvo);
				odvo.setOrder(ovo);
				odvo.setSelectlist(slvo);
				odvo.setProduct(pvo);
				
					
				sql = "select A.orderdetailno, B.ordercode, E.tasteselectno, F.tastename "
					+ "from tbl_orderdetail A join tbl_order B "
					+ "on A.fk_ordercode = B.ordercode "
					+ "join tbl_selectlist C "
					+ "on A.fk_selectno = C.selectno "
					+ "join tbl_product D "
					+ "on C.fk_productcodeno = D.productcodeno "
					+ "join tbl_tasteselect E "
					+ "on E.fk_selectno = C.selectno "
					+ "join tbl_taste F "
					+ "on E.fk_tasteno = F.tasteno "
					+ "where orderdetailno = ?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, orderdetailno);
				
				rs2 = pstmt.executeQuery();
				
				List<TasteVO> tasteList = new ArrayList<TasteVO>();
				
				while(rs2.next()) {
					TasteVO tvo = new TasteVO();
					tvo.setTastename(rs2.getString(4));
					tasteList.add(tvo);
				}
				
				odvo.setTastenamelist(tasteList);
				
				odvoList.add(odvo);

			}
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e ) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return odvoList;
	}


	
	
	
	
	
}
