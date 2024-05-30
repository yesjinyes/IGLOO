package member.model.jy;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
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

	
	
	// 전체 주문내역 불러오기(선택 맛 제외)
	@Override
	public List<OrderdetailVO> selectOrderListAll(String userid) throws SQLException {
		
		List<OrderdetailVO> odvoList = new ArrayList<OrderdetailVO>();
	
		try {
			
			conn = ds.getConnection();
			
			String sql = "select A.orderdetailno, B.ordercode, A.ordercount, C.selectno, A.orderprice, A.pickupstatus, A.pickuptime, "
					   + "       B.fk_userid, B.totalprice, to_char(B.orderdate, 'yyyy-mm-dd'), "
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
				
					
				sql = "select A.orderdetailno, B.ordercode, E.tasteselectno, F.tastename, F.tasteimg "
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
				List<TasteVO> tasteimgList = new ArrayList<TasteVO>();
				
				while(rs2.next()) {
					TasteVO tvo = new TasteVO();
					tvo.setTastename(rs2.getString(4));
					tasteList.add(tvo);
					
					tvo.setTasteimg(rs2.getString(5));
					tasteimgList.add(tvo);
				}
				
				odvo.setTastenamelist(tasteList);
				odvo.setTasteimglist(tasteimgList);
				
				odvoList.add(odvo);

			}
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e ) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return odvoList;
	}//end of-----------------------------------------------------

	
	
	
	
	// 리뷰 insert
	@Override
	public int insertReviewOne(Map<String, String> paraMap) throws SQLException {

		int n = 0;
		
		
		try {
			conn = ds.getConnection();
			
			conn.setAutoCommit(false); // 수동커밋으로 전환
			
			// 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리) 
			String sql = "  insert into tbl_review(reviewno, fk_userid, fk_ordercode, reviewcontent, writeday) "
						+"					values(seq_tbl_review.nextval, ? , ?, ? , sysdate) "; 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid") );
			pstmt.setString(2, paraMap.get("ordercode") );
			pstmt.setString(3, paraMap.get("reviewcontent") );
			
			n = pstmt.executeUpdate();
         //	System.out.println("~~~~~ 확인용 n1 : " + n);
		 //  ~~~~~ 확인용 n1 : 1	
		
         	
		} finally {
			close();
		}
		return n;
	}

	
	
	
	
	
	// 해당주문내역(1개)에 대한 상세(리스트) 메소드
	@Override
	public OrderdetailVO odvoOne(String ordercode) throws SQLException {
		
		OrderdetailVO odvoOne = new OrderdetailVO();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select A.orderdetailno, B.ordercode, A.ordercount, C.selectno, A.orderprice, A.pickupstatus, A.pickuptime, "
					   + "       B.fk_userid, B.totalprice, to_char(B.orderdate, 'yyyy-mm-dd') orderdate, "
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
					   + " where ordercode = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, ordercode);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				
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
				
					
				sql = "select A.orderdetailno, B.ordercode, E.tasteselectno, F.tastename, F.tasteimg "
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
				List<TasteVO> tasteimgList = new ArrayList<TasteVO>();
				
				while(rs2.next()) {
					TasteVO tvo = new TasteVO();
					tvo.setTastename(rs2.getString(4));
					tasteList.add(tvo);
					
					tvo.setTasteimg(rs2.getString(5));
					tasteimgList.add(tvo);
				}

				odvoOne.setTastenamelist(tasteList);
				odvoOne.setTasteimglist(tasteimgList);
			}
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e ) {
			e.printStackTrace();
		}finally {
			close();
		}
		
		
		return odvoOne;
	}//end of-----------------------------------------------------

	
	
	

	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	// 리뷰쓰기를 위해 주문목록에서 해당 주문상세 불러오기
//	@Override
//	public List<OrderdetailVO> selectOrderDetailOne(String userid) throws SQLException {
//		
//		List<OrderdetailVO> odvoOne = new ArrayList<OrderdetailVO>();
//		
//		try {
//			
//			conn = ds.getConnection();
//			
//			String sql = " select userid, orderdetailno, tasteimg, tastename, reviewstatus "
//					+ "   from tbl_member I "
//					+ "   join tbl_order A "
//					+ "   on I.userid = A.fk_userid "
//					+ "   join tbl_orderdetail B "
//					+ "   on A.ordercode = B.fk_ordercode "
//					+ "   join tbl_selectlist C "
//					+ "   on B.fk_selectno = C.selectno "
//					+ "   join tbl_tasteselect D "
//					+ "   on C.selectno = D.fk_selectno "
//					+ "   join tbl_product E "
//					+ "   on C.fk_productcodeno = E.productcodeno "
//					+ "   join tbl_taste F "
//					+ "   on D.fk_tasteno = F.tasteno "
//					+ "   where userid = ? and orderdetailno = ? "
//					+ "   order by orderdetailno ";
//		
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, userid);
//			//pstmt.setInt(2, orderdetailno);
//			
//			while(rs.next()) {
//				
//				OrderVO ovo = new OrderVO();
//				ovo.setFk_userid(rs.getString(1));
//				
//				OrderdetailVO odvo = new OrderdetailVO();
//				int orderdetailno = rs.getInt(2);
//				odvo.setOrderdetailno(orderdetailno);
//				
//				TasteVO tvo = new TasteVO();
//				tvo.setTasteimg(rs.getString(3));
//				tvo.setTastename(rs.getString(4));
//				
//				
//				odvo.setOrder(ovo);
//				odvo.setTaste(tvo);
//				odvoOne.add(odvo);
//				
//				
//			}
//			
//			
//		} finally {
//			close();
//		}	
//			
//			
//		return odvoOne;
//	}

	
	


	
	
	
	
	
}
