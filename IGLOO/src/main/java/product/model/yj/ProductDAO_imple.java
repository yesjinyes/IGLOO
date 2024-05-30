package product.model.yj;

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
	public ProductVO getproductEach(String pcode) throws SQLException {
		
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
	      
	}// end of public ProductVO getproductEach(String pcode) throws SQLException-------------

	///////////////////////////////////////////////////////////////
	
	// == tbl_selectList 에 insert == //
	@Override
	public Map<String, Integer> insertSelectList(Map<String, Object> paraMap) throws SQLException {
		
		Map<String, Integer> map = new HashMap<>();
		
		int selectListResult = 0;
		
		try {
			conn = ds.getConnection();
/*
	-- 선택내역 테이블 : TBL_SELECTLIST
	-- 맛선택 테이블 : TBL_TASTESELECT
 */
			String sqlInsert =  " insert into tbl_selectlist(selectno, fk_productcodeno, fk_userid) "
							  + " values(seq_selectno.nextval, ?, ?) ";
			
			pstmt = conn.prepareStatement(sqlInsert);
			pstmt.setString(1, (String)paraMap.get("pcode"));
			pstmt.setString(2, (String)paraMap.get("userid"));
			
			selectListResult = pstmt.executeUpdate();
			
			String sqlSelect = " select max(selectno) "
							  + " from tbl_selectList ";
			
			pstmt = conn.prepareStatement(sqlSelect);
			
			rs = pstmt.executeQuery();
			
			int selectno = 0;
			if(rs.next()) {
				selectno = rs.getInt(1);
			}
			// System.out.println("selectno : " + selectno); // selectno : 12
			
			map.put("selectListResult", selectListResult);
			map.put("selectno", selectno);
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return map;
		
	}// end of public Map<String, Integer> insertSelectList(Map<String, Object> paraMap) throws SQLException--------------

	///////////////////////////////////////////////////////////////
	
	// == tbl_tasteSelect에 insert == //
	@Override
	public int insertTasteList(Map<String, Object> paraMap) throws SQLException {
		
		int tasteListResult = 0;
		
		try {
			conn = ds.getConnection();

			String sqlInsert =  " insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) "
					    	  + " values(seq_tasteselectno.nextval, ?, ?)";
			
			String[] tasteno_arr = (String[])paraMap.get("tasteno_arr");
			
			for(String tasteno : tasteno_arr) {
				pstmt = conn.prepareStatement(sqlInsert);
				pstmt.setInt(1, (Integer)paraMap.get("selectno"));
				pstmt.setInt(2, Integer.parseInt(tasteno));
				
				tasteListResult += pstmt.executeUpdate();
			}// end of for --------
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return tasteListResult;
		
	}// end of public int insertTasteList(Map<String, Object> paraMap) throws SQLException----------
	
	///////////////////////////////////////////////////////////////

	// == TBL_CART 에 insert 하는 메소드 생성 == //
	@Override
	public int insertCartList(Map<String, Object> paraMap) throws SQLException {
		
		int cartListResult = 0;
		
		try {
			conn = ds.getConnection();

			String sqlInsert =  " insert into tbl_cart(cartno, fk_userid, fk_selectno) "
							  + " values(seq_cartno.nextval, ?, ?) ";
			
			pstmt = conn.prepareStatement(sqlInsert);
			pstmt.setString(1, (String)paraMap.get("userid"));
			//pstmt.setInt(2, ); // 수량(count)이 들어올 자리... 어떻게 넘길까
			pstmt.setInt(2, (Integer)paraMap.get("selectno"));
				
			cartListResult = pstmt.executeUpdate();
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return cartListResult;
		
	}// public int insertCartList(Map<String, Object> paraMap) throws SQLException-----------------




}

