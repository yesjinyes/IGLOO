package product.model.hj;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import myshop.domain.CartVO;
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

/////////////////////////////////////////////////////////////////

	// === 선택한 맛 리스트 뽑기 === //
	@Override
	public List<TasteVO> selectTasteList(String selectno) throws SQLException {
		
		List<TasteVO> tasteList = new ArrayList<>();

	      try {
	         conn = ds.getConnection();
	         
	         String sql = " SELECT tastename, tasteno "
	         		+ " FROM "
	         		+ " ( "
	         		+ "    select tasteno, tastename "
	         		+ "    from tbl_taste "
	         		+ " ) "
	         		+ " JOIN "
	         		+ " ( "
	         		+ "    select fk_tasteno "
	         		+ "    from tbl_tasteselect "
	         		+ "    where fk_selectno = ? "
	         		+ " ) "
	         		+ " ON tasteno = fk_tasteno";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, selectno);
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()) {
	        	 TasteVO tvo = new TasteVO();
	             tvo.setTastename(rs.getString("tastename"));
	             tvo.setTasteno(rs.getInt("tasteno"));
	             tasteList.add(tvo);
	         }// end of while-----------------
	         
	      } finally {
	         close();
	      }
	      
	      return tasteList;
		
	}	// end of public List<TasteVO> selectTasteList() throws SQLException {----
	
////////////////////////////////////////////////////////////////////	
	
	// == 맛 목록을 조회해오기(선택한 맛 제외) == //
	@Override
	public List<TasteVO> tasteList() throws SQLException {

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
	             tvo.setTasteno(rs.getInt("tasteno"));
	             tvo.setTastename(rs.getString("tastename"));
	             tasteList.add(tvo);
	         }// end of while-----------------
	         
	      } finally {
	         close();
	      }
	      
	      return tasteList;

	}// end of public List<TasteVO> selectTasteList() throws SQLException

/////////////////////////////////////////////////////////////////////////////
	
	// === 맛 수정 === //
	@Override
	public boolean updateTasteno(Map<String, String> paraMap) throws SQLException {
		
		boolean result = false;

		try {
			int n = 0;
			conn = ds.getConnection();
			
			String sql = " update tbl_tasteselect set fk_tasteno = ? "
					+ " where fk_selectno = ? and tasteselectno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("tasteno"));
			pstmt.setString(2, paraMap.get("selectno"));
			pstmt.setString(3, paraMap.get("tasteselectno"));
			
			/*
			 * System.out.println(paraMap.get("tasteno"));
			 * System.out.println(paraMap.get("selectno"));
			 * System.out.println(paraMap.get("basetasteno"));
			 */

			n = pstmt.executeUpdate();
			if(n==1) {
				result = true;
			}
			
		}finally {
			close();
		}
		
		return result;
		
	} // end of public boolean updateTasteno(Map<String, String> paraMap) throws SQLException {----

	//////////////////////////////////////////////////////////////////
	
	// === 기존 맛에 대한 선택내역번호 가져오기 === //
	@Override
	public List<TasteVO> selectTastenoList(String selectno) throws SQLException {

		List<TasteVO> selectTastenoList = new ArrayList<>();

	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select tasteselectno "
	         		    + " from tbl_tasteselect "
	         		    + " where fk_selectno = ? "
	         		    + " order by tasteselectno ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, selectno);
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()) {
	        	 TasteVO tvo = new TasteVO();
	             tvo.setTasteselectno(rs.getInt("tasteselectno"));
	             selectTastenoList.add(tvo);
	         }// end of while-----------------
	         
	      } finally {
	         close();
	      }
	      
	      return selectTastenoList;
		
	}	// end of public List<TasteVO> selectTastenoList(String selectno) throws SQLException {---

	
	// order 와 orderdetail 테이블에 insert 해주는 메소드
	@Override
	public int productOrder(Map<String, Object> paraMap) throws SQLException {
		int isSuccess = 0;
		
		int n1=0, n2=0, n3=0;
		
		try {
			conn = ds.getConnection();
			
			conn.setAutoCommit(false); // 수동커밋으로 전환
			
			// 2. 주문 테이블에 insert 하기(수동커밋처리)
			String sql = " insert into tbl_order(ordercode, fk_userid, totalprice) values(?, ?, ?) ";

			// System.out.println((String)paraMap.get("odrcode")); // P-20240530-15
			// System.out.println((String)paraMap.get("userid"));  // jjoung
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, (String)paraMap.get("odrcode"));
			pstmt.setString(2, (String)paraMap.get("userid"));
			pstmt.setInt(3, Integer.parseInt((String)paraMap.get("totalprice")));
			
			n1 = pstmt.executeUpdate();
			// System.out.println(" n1 확인용 ===>   " + n1); // n1 확인용 ===>   1
            
			// 3. 주문상세 테이블에 insert 하기(수동커밋처리)
			if(n1 == 1) {
				
				// 주문코드(명세서번호) --> (String)paraMap.get("odrcode")
				String[] selectno_arr = (String[]) paraMap.get("selectno_arr");
				String[] cartno_arr = (String[]) paraMap.get("cartno_arr"); 
				
				List<CartVO> cvoList = new ArrayList<CartVO>();
				List<ProductVO> pvoList = new ArrayList<ProductVO>();
				if(paraMap.get("cartno_arr") != null) {
					
					for(int i=0; i<selectno_arr.length; i++) { // count(주문량) 를 구해오기 위한 반복문
						
						sql = " select count, price "
						    + " from tbl_cart C join tbl_selectlist S"
						    + " on c.fk_selectno = s.selectno"
						    + " join tbl_product P on s.fk_productcodeno = productcodeno "
						    + " where cartno = ? ";
						
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, cartno_arr[i]);
						
						rs = pstmt.executeQuery();
						
						rs.next();
						
						CartVO cvo = new CartVO();
						cvo.setCount(rs.getInt(1));
						
						ProductVO pvo = new ProductVO();
						pvo.setPrice(rs.getInt(2));
						
						cvoList.add(cvo);
						pvoList.add(pvo);
						// System.out.println("cvoList.get(i)  ===>> "+cvoList.get(i).getCount()); // cvoList.get(i)  ===>> 3
					} // end of for -------------------------------------------------------
				}
				
				int cnt = 0;
				for(int i=0; i<selectno_arr.length; i++) {
					sql =  " insert into tbl_orderdetail(orderdetailno, fk_ordercode, ordercount, fk_selectno, orderprice) "
						 + " values(SEQ_ORDERDETAILNO.nextval, ?, ?, ?, ?) ";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, (String)paraMap.get("odrcode"));
					
					if(paraMap.get("cartno_arr") == null) {
					 // request.getParameter("");
					}
					else {
						pstmt.setInt(2, cvoList.get(i).getCount());
					}
					
					pstmt.setString(3, selectno_arr[i]);
					pstmt.setInt(4, pvoList.get(i).getPrice());
					
					pstmt.executeUpdate();
					cnt++;
					
				}// end of for---------------------------
				
				if(cnt == selectno_arr.length) { // 위에 과정이 완료 되었으면 n2 cnt == selectno_arr.length 일 것.
					n2 = 1;
				}
			}// end of if(n1 == 1)------------------------------------------------------------------------------------------------
			
			// 4. 장바구니 테이블에서 str_cartno_join 값에 해당하는 행들을 삭제(delete)하기(수동커밋처리)
			// >> 장바구니에서 주문을 한 것이 아니라 특정제품을 바로주문하기를 한 경우에는 장바구니 테이블에서 행들을 삭제할 작업은 없다. << 
			if(n2==1 && paraMap.get("cartno_arr") != null) {
			/*
		    	sql = " delete from tbl_cart "
		    		+ " where cartno in (?) ";
		    */
		    // !!! 중요 in 절은 위와 같이 위치홀더 ? 를 사용하면 안됨. !!! //
				String[] cartno_arr = (String[]) paraMap.get("cartno_arr"); // 장바구니번호
				// cartno_arr 은 ["7","6","4"]
				
				String cartno_join = String.join("','", cartno_arr); // "7','6','4" 
				
				cartno_join = "'"+cartno_join+"'"; //  "'7','6','4'"
				
				sql = " delete from tbl_cart "
			    	+ " where cartno in ("+cartno_join+") ";
				// !!! 중요 in 절은 위와 같이 직접 변수로 처리해야 함. !!!
		    	// String.join(",", cartno_arr) 은 "7,6,4" 이러한 것이다.
				// 조심할 것은 in 에 사용되어지는 cartno 컬럼의 타입이 number 타입이라면 괜찮은데
				// 만약에 cartno 컬럼의 타입이 varchar2 타입이라면 "7,6,4" 와 같이 되어지면 오류가 발생한다. 
				// 그래서 cartno 컬럼의 타입이 varchar2 타입이라면 "7,6,4" 을 "'7','6','4'" 와 같이 변경해주어야 한다.  
				
				pstmt = conn.prepareStatement(sql); 
		    	n3 = pstmt.executeUpdate();
		    	
		    	if(n3 == cartno_arr.length) {
		    	   n3 = 1;
		    	}
			} // end of if(n2==1 && paraMap.get("cartno_arr") != null)------------------
			
			if(n2==1 && paraMap.get("cartno_arr") == null) {
				// "제품 상세 정보" 페이지에서 "바로주문하기" 를 한 경우
		    	// 장바구니 번호인 paraMap.get("cartno_arr") 이 없는 것이다.
				n3 = 1;
			} // end of if(n3==1 && paraMap.get("cartno_arr") == null)---------
			
			// 5. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
			if(n1*n2*n3 == 1) {
				
				conn.commit();
				
				conn.setAutoCommit(true); // 자동커밋으로 전환
				
				isSuccess = 1;
			}
			
		} catch(SQLException e) {
			
			// 6. **** SQL 장애 발생시 rollback 하기(rollback) ****
			conn.rollback();
			
			conn.setAutoCommit(true); // 자동커밋으로 전환
			
			isSuccess = 0;
			
		} finally {
			close();
		}
		
		return isSuccess;
	}

	// === 제품명 가져오는 메소드 생성하기 === //
	@Override
	public List<String> get_productname_tbl_product(String[] cartno_arr) throws SQLException {
		
		String sql = "";
		List<String> cartno_list = new ArrayList<>();
		try {
	         conn = ds.getConnection();
	         for(int i=0; i<cartno_arr.length; i++) {
	        	 sql = " select P.productname "
	        		 + " from tbl_cart C JOIN tbl_selectlist S "
	        		 + " ON C.fk_selectno = S.selectno "
	        		 + " JOIN tbl_product P ON S.fk_productcodeno = P.productcodeno "
	        		 + " where C.cartno = ? ";
	        	 
	        	 pstmt = conn.prepareStatement(sql);
	        	 pstmt.setString(1, cartno_arr[i]);
	        	 
	        	 rs = pstmt.executeQuery();
	        	 
	        	 rs.next();
	        	 
	        	 cartno_list.add(rs.getString(1));
	         }
	      } finally {
	         close();
	      }
	      return cartno_list;
	} // end of public List<String> get_productname_tbl_product(String[] cartno_arr) throws SQLException {}-----------------------------------

	// === 주문코드를 위한 제품코드 select 해오기 === //
	@Override
	public String getProductcodeno(String userid) throws SQLException {
		
		String productcodeno = "";
		try {
	         conn = ds.getConnection();
	         
	         String sql = " select productcodeno "
	                    + " from tbl_cart C join tbl_selectlist S "
	                    + " on C.fk_selectno = S.selectno "
	                    + " join tbl_product P "
	                    + " on S.fk_productcodeno = P.productcodeno "
	                    + " where c.fk_userid = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()) {
	        	 productcodeno = rs.getString(1);
	         };
	         
	      } finally {
	         close();
	      }
	      return productcodeno;
	} // end of public String getProductcodeno(String userid) throws SQLException {}---------------------------------------

	@Override
	public String getOrdcode(String productcode) throws SQLException {
		// 날짜 생성
		Date now = new Date();
		SimpleDateFormat smdatefm = new SimpleDateFormat("yyyyMMdd"); 
		String today = smdatefm.format(now);
		
		// 주문코드를 위한 시퀀스 번호 select 해오기
		int seq = 0;
		try {
	         conn = ds.getConnection();
	         
	         String sql = " select lpad(seq_ordercode.nextval,6,'0') as seq "
	         	        + " from dual ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         rs = pstmt.executeQuery();
	         
	         rs.next();
	         
	         seq = rs.getInt(1);
	         
	      } finally {
	         close();
	      }
		return productcode +"-" +  today + "-" +  seq;
	} // end of public String getOrdcode(String productcode) throws SQLException {}--------------------------------------------------------------

	// === 지점명을 가져오는 메소드 생성하기 === //	
	@Override
	public List<String> get_storename() throws SQLException {
		
		List<String> storename = new ArrayList<>();
	      
	    try {
	    	conn = ds.getConnection();
	         
	        String sql = " select storename "
	        		   + " from tbl_store ";
	         
	        pstmt = conn.prepareStatement(sql);
	         
	        rs = pstmt.executeQuery();
	         
	        while(rs.next()) {
	        	storename.add(rs.getString(1)); 
	        }
	         
	    } finally {
	        close();
	    }
	      
	    return storename;   
	}
	
	// === 지점명에 따른 주소를 가져오는 메소드 === //
	@Override
	public Map<String, String> getStaddress(String stname) throws SQLException {
		
		Map<String, String> stnamecheck = new HashMap<>();
		
		try {
	    	conn = ds.getConnection();
	         
	        String sql = " select storeaddress "
	        		   + " from tbl_store "
	        		   + " where storeno = ? ";
	        // System.out.println(stname);
	         
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, stname);
	        rs = pstmt.executeQuery();
	        
	        rs.next();
	         
	        stnamecheck.put("storeaddress", rs.getString(1));
	         
	    } finally {
	        close();
	    }
	      
	    return stnamecheck;  
	} // end of public Map<String, String> getStaddress(String stname) throws SQLException {}------------------------

	
/////////////////////////////////////////////////////////////////////////
	
	// === tbl_map(위,경도) 테이블에 있는 정보를 가져오기(select) === //
	@Override
	public List<Map<String, String>> selectStoreMap() throws SQLException {
		
		List<Map<String, String>> storeMapList = new ArrayList<>();
	      
	    try {
	    	conn = ds.getConnection();
	         
	        String sql = " select storeno, storename, storepage, storeimg "
	        		+ " , storeaddress, storetel, latitude, longitude, zindex "
	        		+ " from tbl_store "
	        		+ " order by zindex asc ";
	         
	        pstmt = conn.prepareStatement(sql);
	         
	        rs = pstmt.executeQuery();
	         
	        while(rs.next()) {
	        	Map<String, String> map = new HashMap<>();
	            map.put("STORENO", rs.getString("storeno"));
	            map.put("STORENAME", rs.getString("storename"));
	            map.put("STOREPAGE", rs.getString("storepage"));
	            map.put("STOREIMG", rs.getString("storeimg"));
	            map.put("STOREADDRESS", rs.getString("storeaddress"));
	            map.put("STORETEL", rs.getString("storetel"));
	            map.put("LAT", rs.getString("latitude"));
	            map.put("LNG", rs.getString("longitude"));
	            map.put("ZINDEX", rs.getString("zindex"));
	                        
	            storeMapList.add(map); 
	        }
	         
	    } finally {
	        close();
	    }
	      
	    return storeMapList;   
		
	}	// end of public List<Map<String, String>> selectStoreMap() throws SQLException---


	
}

