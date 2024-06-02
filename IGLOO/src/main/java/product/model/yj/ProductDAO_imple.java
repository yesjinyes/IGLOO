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
	
	// == TBL_SELECTLIST 에 insert == //
	@Override
	public List<Map<String, Integer>> insertSelectList(int tasteListSize, String userid, String pcode) throws SQLException {
		
		List<Map<String, Integer>> resultList = new ArrayList<Map<String,Integer>>();
		
		int selectListResult = 0;
		
		try {
			conn = ds.getConnection();
		
			// == 맛선택 개수만큼 반복 == //
			for(int i=0; i<tasteListSize; i++) {
			
				String sqlInsert =  " insert into tbl_selectlist(selectno, fk_productcodeno, fk_userid) "
								  + " values(seq_selectno.nextval, ?, ?) ";
				
				pstmt = conn.prepareStatement(sqlInsert);
				pstmt.setString(1, pcode);
				pstmt.setString(2, userid);
				
				selectListResult = pstmt.executeUpdate();
				
				String sqlSelect = " select max(selectno) "
								  + " from tbl_selectList ";
				
				pstmt = conn.prepareStatement(sqlSelect);
				
				rs = pstmt.executeQuery();
				
				int selectno = 0;
				if(rs.next()) {
					selectno = rs.getInt(1);
				}
				//System.out.println("selectno : " + selectno); // selectno : 12
				
				Map<String, Integer> map = new HashMap<>();
				map.put("selectListResult", selectListResult); // TBL_SELECTLIST 에 insert 되었는지 확인하는 int 값
				map.put("str_selectno", selectno); // insert 되는 str_selectno 값
				
				resultList.add(map); // resultList 에 selectListResult, str_selectno 담아줌
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return resultList;
		
	}// end of public Map<String, Integer> insertSelectList(Map<String, Object> paraMap) throws SQLException--------------
	
	///////////////////////////////////////////////////////////////
	
	// == TBL_TASTESELECT에 insert 하는 method 생성 == //
	@Override
	public int insertTasteList(List<Map<String, Integer>> resultList, List<Map<String, Integer>> tasteinfoList) throws SQLException {
		
		int tasteListResult = 1; //insert 전체 성공여부
		
		try {
			conn = ds.getConnection();

			List<Integer> insertTasteListResult = new ArrayList<>();

			// 이중 for 문..
			for(int i = 0; i < resultList.size(); i++) {
				
				int selectno = resultList.get(i).get("str_selectno");
				
				System.out.println("i : "+ i);
				System.out.println("selectno : "+ selectno);
				
				for(int j = 0; j < tasteinfoList.get(i).size() - 1; j++) { // map에 담긴 1234, 중에 맨 마지막인 수량은 필요가 없으니까 -1 을 해주었음
					int tasteno = tasteinfoList.get(i).get("taste" + (j+1)); // tasteinfoList 의 첫번째 map 에서 taste1인 값을 가져온것
					
					String sqlInsert =  " insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) "
					    	  		  + " values(seq_tasteselectno.nextval, ?, ?)";

					pstmt = conn.prepareStatement(sqlInsert);
					pstmt.setInt(1, selectno);
					pstmt.setInt(2, tasteno);
					
					int result = pstmt.executeUpdate();
					
					insertTasteListResult.add(result);
				}
			}
			
			//insert 성공여부
			for(int n : insertTasteListResult) {
				if(n != 1) {
					tasteListResult = 0;
				}
			}
			
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
	public int insertCartList(String userid, List<Map<String, Integer>> tasteinfoList, List<Map<String, Integer>> resultList) throws SQLException {
		
		int cartListResult = 0;
		
		try {
			conn = ds.getConnection();
			String sqlInsert =  " insert into tbl_cart(cartno, fk_userid, count, fk_selectno) "
							  + " values(seq_cartno.nextval, ?, ?, ?) ";
			
			
			for(int i=0; i<resultList.size(); i++) {
				
				int count =  tasteinfoList.get(i).get("count");
				int selectno = resultList.get(i).get("str_selectno");
				
				// System.out.println("count 확인 : " + count);
				// System.out.println("selectno 확인 : " + selectno); 
				
				pstmt = conn.prepareStatement(sqlInsert);
				pstmt.setString(1, userid);
				pstmt.setInt(2, count);
				pstmt.setInt(3, selectno);
				
				cartListResult = pstmt.executeUpdate();
				
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return cartListResult;
		
	}// public int insertCartList(Map<String, Object> paraMap) throws SQLException-----------------
}


