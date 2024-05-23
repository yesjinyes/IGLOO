package admin.model.nr;

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

import help.domain.nr.FaqVO;
import member.domain.MemberVO;
import order.domain.OrderVO;
import order.domain.OrderdetailVO;
import product.domain.ProductVO;
import product.domain.SelectlistVO;
import product.domain.TasteVO;
import util.security.hj.AES256;
import util.security.hj.SecretMyKey;

public class AdminDAO_imple implements AdminDAO {

	private DataSource ds;	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private ResultSet rs2;
	
	private AES256 aes;
	
	// 생성자
	public AdminDAO_imple() {
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

	@Override
	public int getTotalPage(Map<String, String> paramap) throws SQLException {

		int totalPage = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select ceil(count(*)/?) "
					   + "from tbl_faq_q ";
					   
			int sizePerPage = Integer.parseInt(paramap.get("sizePerPage"));
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sizePerPage);
		
			rs = pstmt.executeQuery();
		
			rs.next();
			totalPage = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalPage;
	}

	
	
	
	
	
	// 관리자 - 1:1 질문 목록 페이징처리 불러오기
	@Override
	public List<FaqVO> select_faq_paging(Map<String, String> paramap) throws SQLException {
		
		List<FaqVO> faqList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select rn, q_no, fk_userid, fk_categoryno, q_title, q_content, q_writeday, answerstatus, name "
					   + "from "
					   + "(select rownum rn, q_no, fk_userid, fk_categoryno, q_title, q_content, q_writeday, answerstatus, name "
					   + "from tbl_faq_q A join tbl_member B "
					   + "on A.fk_userid = B.userid "
					   + "order by answerstatus asc, q_writeday desc) "
					   + "where rn between ? and ? ";
					   
			int currentShowPageNo = Integer.parseInt(paramap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paramap.get("sizePerPage"));
			
			pstmt = conn.prepareStatement(sql);
			
			/*
				페이징 처리 공식
				where RNO between (조회하고자하는페이지번호 * 한페이지당보여줄행의개수) - (한페이지당보여줄행의개수 - 1) and (조회하고자하는페이지번호 * 한페이지당보여줄행의개수);
			*/
			
			pstmt.setInt(1, currentShowPageNo*sizePerPage-(sizePerPage-1));
			pstmt.setInt(2, currentShowPageNo*sizePerPage);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FaqVO fvo = new FaqVO();
				fvo.setQ_no(rs.getInt(2));
				fvo.setFk_userid(rs.getString(3));
				fvo.setFk_categoryno(rs.getInt(4));
				fvo.setQ_title(rs.getString(5));
				fvo.setQ_content(rs.getString(6));
				fvo.setQ_writeday(rs.getString(7));
				fvo.setAnswerstatus(rs.getInt(8));
				
				MemberVO mvo = new MemberVO();
				mvo.setName(rs.getString(9));
				
				fvo.setMvo(mvo);
				
				faqList.add(fvo);
			}
			
		} finally {
			close();
		}
		
		return faqList;
	}

	
	
	
	
	
	// 관리자 - 1:1 질문 총 개수 알아오기
	@Override
	public int getTotalFaqCount(Map<String, String> paramap) throws SQLException {
		
		int totalFaqCount = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select count(*) "
					   + "from tbl_faq_q ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
		
			rs.next();
			totalFaqCount = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalFaqCount;
	}

	
	
	
	
	// 관리자 - 1:1 질문 상세보기
	@Override
	public FaqVO getFaq(String fk_q_no) throws SQLException {
		
		FaqVO fvo = new FaqVO();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select q_no, fk_userid, fk_categoryno, q_title, q_content, to_char(q_writeday, 'yyyy-mm-dd hh24:mi:ss'), name, answerstatus, a_no, fk_q_no, a_content, to_char(a_writeday, 'yyyy-mm-dd hh24:mi:ss') "
					   + "from tbl_faq_q A join tbl_member B "
					   + "on A.fk_userid = B.userid "
					   + "left join tbl_faq_a C "
					   + "on A.q_no = C.fk_q_no "
					   + "where q_no = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_q_no);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			fvo.setQ_no(rs.getInt(1));
			fvo.setFk_userid(rs.getString(2));
			fvo.setFk_categoryno(rs.getInt(3));
			fvo.setQ_title(rs.getString(4));
			fvo.setQ_content(rs.getString(5));
			fvo.setQ_writeday(rs.getString(6));
			fvo.setAnswerstatus(rs.getInt(8));
			fvo.setA_no(rs.getInt(9));
			fvo.setFk_q_no(rs.getInt(10));
			fvo.setA_content(rs.getString(11));
			fvo.setA_writeday(rs.getString(12));
			
			MemberVO mvo = new MemberVO();
			mvo.setName(rs.getString(7));
			fvo.setMvo(mvo);
			
		} finally {
			close();
		}
		
		
		return fvo;
		
	}

	
	
	
	// 관리자 - 1:1 답변 등록
	@Override
	public int insertAnswer(Map<String, String> paramap) throws SQLException {
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "insert into tbl_faq_a(a_no, fk_q_no, a_content) values(seq_tbl_faq_a.nextval, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paramap.get("q_no"));
			pstmt.setString(2, paramap.get("input"));
			
			n = pstmt.executeUpdate();
			
			if(n==1) {
				sql = "update tbl_faq_q set answerstatus = 1 "
					+ "where q_no = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paramap.get("q_no"));
				n = pstmt.executeUpdate();
			}
			
		} finally {
			close();
		}
		
		return n;
	}

	
	
	
	
	
	
	
	
	// 전체 주문내역 불러오기(선택 맛 제외)
	@Override
	public List<OrderdetailVO> selectOrderListAll() throws SQLException {
		
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
					   + "on B.fk_userid = E.userid ";
			
			pstmt = conn.prepareStatement(sql);
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
