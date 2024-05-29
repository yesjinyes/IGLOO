package product.model.yj;

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
	///////////////////////////////////////////////////////////////////////////////////
	
	// == 상품에 대한 정보 알아오는 메소드 == //
	@Override
	public List<ProductVO> getproductList() throws SQLException {
		
		  List<ProductVO> productList = new ArrayList<>();
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select productcodeno, productimg, productimgBelow, productname, productdetail, price "
		         		+ " from tbl_product ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()) {
	        	 ProductVO pvo = new ProductVO();
	        	 pvo.setProductcodeno(rs.getString(1));
	        	 pvo.setProductimg(rs.getString(2));
	        	 pvo.setProductimgBelow(rs.getString(3));
	        	 pvo.setProductname(rs.getString(4));
	        	 pvo.setProductdetail(rs.getString(5));
	        	 pvo.setPrice(rs.getInt(6));
	        	 
	        	 productList.add(pvo);
	        	 
	         }// end of while-----------------
	         
	      } finally {
	         close();
	      }
	      
	      //System.out.println("확인용 이미지 : "+ productList);
	      
	      return productList;

	}// end of public List<ProductVO> getproductList() throws SQLException

	///////////////////////////////////////////////////////////////

	// == 맛 목록 조회해오기 == //
	@Override
	public List<TasteVO> selectTasteList() throws SQLException {

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
	             tvo.setTasteno(rs.getInt(1));
	             tvo.setTastename(rs.getString(2));
	             tasteList.add(tvo);
	         }// end of while-----------------
	         
	      } finally {
	         close();
	      }
	      
	      return tasteList;

	}// end of public List<TasteVO> selectTasteList() throws SQLException

	///////////////////////////////////////////////////////////////
	
	// == 제품 한 개만 불러오기 == //
	@Override
	public ProductVO getproductList_2(String pcode) throws SQLException {
		
		ProductVO pvo = new ProductVO();
		
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select productcodeno, productimg, productimgBelow, productname, productdetail, price "
		         		+ " from tbl_product "
		         		+ " where productcodeno = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, pcode);
	         
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()) {
	        	 pvo.setProductcodeno(rs.getString(1));
	        	 pvo.setProductimg(rs.getString(2));
	        	 pvo.setProductimgBelow(rs.getString(3));
	        	 pvo.setProductname(rs.getString(4));
	        	 pvo.setProductdetail(rs.getString(5));
	        	 pvo.setPrice(rs.getInt(6));
	        	 
	         }// end of  if(rs.next())-----------------
	         
	      } finally {
	         close();
	      }
	      
	      return pvo;
	      
	}// end of public ProductVO getproductList_2(String pcode) throws SQLException-------------

	///////////////////////////////////////////////////////////////
	
	// == 결제창 이동 시 맛번호 넘기기 == //
	@Override
	public int insertTaste(Map<String, Object> paraMap) throws SQLException {
		
		int isInsert = 0;
		int n1=0, n2=0;
		
		
		try {
			conn = ds.getConnection();
			
			conn.setAutoCommit(false); // 수동커밋으로 전환

			
			String[] tasteno_arr = (String[])paraMap.get("tasteno_arr"); // 맛번호
			
			int cnt = 0;
			for(int i=0; i<tasteno_arr.length; i++) {
				
				String sql =  " insert into tbl_selectlist(tasteno, fk_productcodeno, fk_userid) "
							+ " values(?, ?, ?); ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, tasteno_arr[i]);
				pstmt.setString(2, (String)paraMap.get("pcode"));
				pstmt.setString(3, (String)paraMap.get("userid"));
				
				pstmt.executeUpdate();
				cnt++;
			}// end of for--------------------
			
			if(cnt == tasteno_arr.length) {
				n1 = 1; 
			}
			System.out.println("확인용 n1 : " + n1);
			
		
		} catch(SQLException e) {
			conn.rollback();
			conn.setAutoCommit(true); // 자동커밋으로 전환
			isInsert = 0;
		} finally {
			close();
		}
		
		return isInsert;
		
	}// end of public int insertTaste(Map<String, Object> paraMap) throws SQLException--------------




}

