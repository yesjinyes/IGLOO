package product.model.jy;
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

import product.domain.TasteVO;
public class MenuDAO_imple implements MenuDAO {
	
	private DataSource ds;  // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	// 생성자
	public MenuDAO_imple() {
		
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		    
		    
		    
		} catch(NamingException e) {
			e.printStackTrace();
		}
		
	}
	
	private void close() {
		try {
			if(rs != null)    {rs.close();    rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null)  {conn.close();  conn=null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	//아이스크림 맛의 전체개수를 알아오기
	@Override
	public int totalCount() throws Exception {
		
		int totalCount = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*) "
					   + " from tbl_taste " ;
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalCount = rs.getInt(1);
			
			
		} finally {
			close();
		}
		
		return totalCount;
		
	}// end of public int totalPspecCount(String string) throws SQLException------
	
	
	
	
	
	
	
	//정렬
//	@Override
//	public List<TasteVO> selectIceAll(Map<String, String> paraMap) throws Exception {
//		
//		List<TasteVO> productList = new ArrayList<>();
//		
//		
//		
//		try {
//			conn = ds.getConnection();
//			
//			String sql = " select rno, tastename, review_cnt "
//					+ "    from "
//					+ "    ( "
//					+ "        select rownum rno, tastename, review_cnt "
//					+ "        from "
//					+ "        ( "
//					+ "         SELECT TASTENAME, CNT AS REVIEW_CNT "
//					+ "         FROM "
//					+ "         ( "
//					+ "             SELECT V.TASTENAME, COUNT(*) AS CNT "
//					+ "             FROM "
//					+ "             ( "
//					+ "                 SELECT A.ORDERDETAILNO, D.TASTENAME "
//					+ "                 FROM TBL_ORDERDETAIL A "
//					+ "                 JOIN TBL_SELECTLIST B "
//					+ "                 ON A.FK_SELECTNO = B.SELECTNO "
//					+ "                 JOIN TBL_TASTESELECT C"
//					+ "                 ON B.SELECTNO = C.FK_SELECTNO "
//					+ "                 JOIN TBL_TASTE D "
//					+ "                 ON C.FK_TASTENO = D.TASTENO "
//					+ "             ) V "
//					+ "             GROUP BY V.TASTENAME "
//					+ "            ) T ";
//					
//			
//			
//			
//			String colname = paraMap.get("menuAlign");
//			
//			
//			if("name".equals(colname) ) { //메뉴정렬이 가나다순 인 경우 
//				sql += " order by TASTENAME asc";
//			}
//			
//			else if("order".equals(colname) ) { //메뉴정렬이 인기순 인 경우 
//				sql += " order by REVIEW_CNT DESC";
//			}
//			
//			sql += "         ) "
//				+ "     )"
//				+ "     WHERE rno between ? and ? ";
//			
//			
//			pstmt = conn.prepareStatement(sql);
//	
//			
//			pstmt.setString(1, paraMap.get("start"));
//			pstmt.setString(2, paraMap.get("end"));
//			
//			rs = pstmt.executeQuery();
//			
//			rs.next();
//				
//			while(rs.next()) {
//				
//				TasteVO tvo = new  TasteVO();
//				
//				tvo.setRno(rs.getInt(1));
//				tvo.setTastename(rs.getString(2));
//				tvo.setCnt(rs.getInt(3));
//				
//				productList.add(tvo);
//				
//			}
//			
//		} finally {
//			close();
//		}
//		
//		return productList;		
//	}

	
	
	
	
	
	/*
	//정보
	@Override
	public List<TasteVO> icejsonList(Map<String, String> paraMap)  throws Exception{
		
		List<TasteVO> icejsonList = new ArrayList<>(); 
		
		try {
			 conn = ds.getConnection();
		
			 String sql =  "  SELECT tasteno, tastename, tasteimg, ingredients "
			 		+ " FROM "
			 		+ " ( ";
			
				String colname = paraMap.get("menuAlign");
				
				
				if("name".equals(colname) ) { //메뉴정렬이 가나다순 인 경우 
					sql += "    SELECT ROW_NUMBER() OVER(ORDER BY tastename ) AS rno, NVL(REVIEW_CNT, 0) AS REVIEW_CNT, tastename, tasteno, tasteimg, ingredients ";
				}
				
				else if("order".equals(colname) ) { //메뉴정렬이 인기순 인 경우 
					sql += "    SELECT ROW_NUMBER() OVER(ORDER BY NVL(REVIEW_CNT, 0) DESC) AS rno, NVL(REVIEW_CNT, 0) AS REVIEW_CNT, tastename, tasteno, tasteimg, ingredients ";
				}
				
				sql +=    "    FROM  "
				 		+ "    ( "
				 		+ "        SELECT D.TASTENO, D.TASTENAME, D.TASTEIMG, D.INGREDIENTS, R.CNT AS REVIEW_CNT "
				 		+ "        FROM TBL_TASTE D "
				 		+ "        LEFT JOIN "
				 		+ "        ( "
				 		+ "            SELECT V.TASTENO, COUNT(*) AS CNT "
				 		+ "            FROM "
				 		+ "            ( "
				 		+ "                SELECT A.ORDERDETAILNO, D.TASTENO "
				 		+ "                FROM TBL_ORDERDETAIL A "
				 		+ "                JOIN TBL_SELECTLIST B ON A.FK_SELECTNO = B.SELECTNO "
				 		+ "                JOIN TBL_TASTESELECT C ON B.SELECTNO = C.FK_SELECTNO "
				 		+ "                JOIN TBL_TASTE D ON C.FK_TASTENO = D.TASTENO "
				 		+ "            ) V "
				 		+ "            GROUP BY V.TASTENO "
				 		+ "        ) R ON D.TASTENO = R.TASTENO "
				 		+ "        ORDER BY tastename "
				 		+ "    ) T  "
				 		+ " ) "
				 		+ " WHERE rno BETWEEN ? AND ? ";
				
				
				pstmt = conn.prepareStatement(sql);
		
				
				pstmt.setString(1, paraMap.get("start"));
				pstmt.setString(2, paraMap.get("end"));
				
				rs = pstmt.executeQuery();

			 
			 
			 
			 
						
			while(rs.next()) {
				TasteVO tvo = new TasteVO();
				tvo.setTasteno(rs.getInt(1));
				tvo.setTastename(rs.getString(2));
				tvo.setTasteimg(rs.getString(3));
				tvo.setIngredients(rs.getString(4));	

				icejsonList.add(tvo);
			}// end of while(rs.next())----------------------------------
			
		} finally {
			close();
		}	
		
		return icejsonList;
	

	}

	
	*/
	
	
	
	
	
	
	@Override
	public List<TasteVO> select_Member_paging(Map<String, String> paraMap) throws SQLException {
		
		
		List<TasteVO> memberList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql =  " SELECT rno, tasteno, tastename, tasteimg, ingredients "
					+ " FROM "
					+ " ( "
					+ "     select row_number() OVER (ORDER BY tastename DESC) AS rno "
					+ "				, tasteno , tastename, tasteimg, ingredients "
					+ "     from  tbl_taste ";
			
			String searchWord = paraMap.get("searchWord");
			
			if( searchWord != null && !searchWord.trim().isEmpty())  {
				   sql += " WHERE tastename LIKE '%' || ? || '%' ";
				   // 컬럼명과 테이블명은 위치홀더(?)로 사용하면 꽝!!! 이다.
				   // 위치홀더(?)로 들어오는 것은 컬럼명과 테이블명이 아닌 오로지 데이터값만 들어온다.!!!!
				}
			
			sql += 	"     ) V "
				 +  " WHERE rno BETWEEN ? AND ? ";
			
			pstmt = conn.prepareStatement(sql);
			
		 /*
		    === 페이징처리의 공식 ===
		    where RNO between (조회하고자하는페이지번호 * 한페이지당보여줄행의개수) - (한페이지당보여줄행의개수 - 1) and (조회하고자하는페이지번호 * 한페이지당보여줄행의개수); 
		 */
			int currentShowPageNo = Integer.parseInt( paraMap.get("currentShowPageNo") ); 
			int sizePerPage = Integer.parseInt( paraMap.get("sizePerPage") );
			
			if( searchWord != null && !searchWord.trim().isEmpty())  {
				// 검색이 있는 경우
				pstmt.setString(1, searchWord);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1) ); // 공식 
				pstmt.setInt(3, (currentShowPageNo * sizePerPage) ); // 공식
			}
			else {
				// 검색이 없는 경우
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1) ); // 공식
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) ); // 공식
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				TasteVO tvo = new TasteVO();
				tvo.setTasteno(rs.getInt(1));
				tvo.setTastename(rs.getString(2));
				tvo.setTasteimg(rs.getString(3));
				tvo.setIngredients(rs.getString(4));	
				
				memberList.add(tvo);
			}// end of while(rs.next())---------------------
			
		}finally {
			close();
		}
		
		return memberList;
	}

	
	
	
	
	
	
	@Override
	public int getTotalMemberCount(Map<String, String> paraMap) throws SQLException {
		
		int totalMemberCount = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " select count(*) "
						+ " from tbl_taste ";
			
			String searchWord = paraMap.get("searchWord");
			
			
			if((searchWord != null && !searchWord.trim().isEmpty()) ) {
			   sql += " and tastename like '%'|| ? ||'%' ";
			   // 컬럼명과 테이블명은 위치홀더(?)로 사용하면 꽝!!! 이다.
			   // 위치홀더(?)로 들어오는 것은 컬럼명과 테이블명이 아닌 오로지 데이터값만 들어온다.!!!!
			}
			
			pstmt = conn.prepareStatement(sql);
			
			if( (searchWord != null && !searchWord.trim().isEmpty()) ) {
				// 검색이 있는 경우
				pstmt.setString(1, searchWord);
			}
						
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalMemberCount = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalMemberCount;		

	}

	
	
	
	
	
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " select ceil(count(*)/?) "
						+ " from tbl_taste ";
			
			String searchWord = paraMap.get("searchWord");
			
			
			
			if( (searchWord != null && !searchWord.trim().isEmpty()) ) {
			   sql += " and tastename like '%'|| ? ||'%' ";
			   // 컬럼명과 테이블명은 위치홀더(?)로 사용하면 꽝!!! 이다.
			   // 위치홀더(?)로 들어오는 것은 컬럼명과 테이블명이 아닌 오로지 데이터값만 들어온다.!!!!
			}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(paraMap.get("sizePerPage")));
			
			if( (searchWord != null && !searchWord.trim().isEmpty()) ) {
				// 검색이 있는 경우
				pstmt.setString(2, searchWord);
			}
						
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
			
		}  finally {
			close();
		}
		
		return totalPage;		
	}

	
	
	
	
	// 가나다순 메뉴
	@Override
	public List<TasteVO> getMenuByName(Map<String, String> paraMap) throws SQLException {

		List<TasteVO> tasteList = new ArrayList<TasteVO>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select rn, tasteno, tastename, tasteimg, ingredients "
					+ "from "
					+ "(select rownum rn, tasteno, tastename, tasteimg, ingredients "
					+ "from "
					+ "(select tasteno, tastename, tasteimg, ingredients "
					+ " from tbl_taste "
					+ " order by 3)) "
					+ " where rn between ? and ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("start"));
			pstmt.setString(2, paraMap.get("end"));
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				TasteVO tvo = new TasteVO();
				
				tvo.setTasteno(rs.getInt(2));
				tvo.setTastename(rs.getString(3));
				tvo.setTasteimg(rs.getString(4));
				tvo.setIngredients(rs.getString(5));

				tasteList.add(tvo);
			}
			
			
		} finally {
			close();
		}
		
		return tasteList;
	}

	
	
	// 인기순 메뉴
	@Override
	public List<TasteVO> getMenuByOrder(Map<String, String> paraMap) throws SQLException {

		List<TasteVO> tasteList = new ArrayList<TasteVO>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select rn, tasteno, tastename, tasteimg, ingredients, cnt "
					   + "from "
					   + "( "
					   + "select rownum rn, tasteno, tastename, tasteimg, ingredients, cnt "
					   + "from "
					   + "( "
					   + "select V.tasteno, T.tastename, V.tasteimg, V.ingredients, T.cnt "
					   + "from "
					   + "( "
					   + "select tastename, cnt "
					   + "from "
					   + "(select D.tastename, count(tastename) cnt "
					   + "from tbl_orderdetail A join tbl_selectlist B "
					   + "on A.fk_selectno = B.selectno "
					   + "join tbl_tasteselect C "
					   + "on C.fk_selectno = B.selectno "
					   + "right join tbl_taste D "
					   + "on C.fk_tasteno = D.tasteno "
					   + "group by D.tastename)) T "
					   + "left join tbl_taste V "
					   + "on T.tastename = V.tastename "
					   + "order by cnt desc)) "
					   + "where rn between ? and ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("start"));
			pstmt.setString(2, paraMap.get("end"));
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				TasteVO tvo = new TasteVO();
				
				tvo.setTasteno(rs.getInt(2));
				tvo.setTastename(rs.getString(3));
				tvo.setTasteimg(rs.getString(4));
				tvo.setIngredients(rs.getString(5));

				tasteList.add(tvo);
			}
			
			
		} finally {
			close();
		}
		
		return tasteList;
		
	}
	
	
	
	
	
}