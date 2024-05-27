package help.model.nr;

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
import help.domain.nr.HelpVO;
import product.domain.ProductVO;
import product.domain.TasteVO;
import util.security.hj.AES256;
import util.security.hj.SecretMyKey;

public class HelpDAO_imple implements HelpDAO {

	
	private DataSource ds;	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 생성자
	public HelpDAO_imple() {
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

	
	
	//////////////////////////////////////////////////////////////////
	
	

	// faq q, a 얻어오기
	@Override
	public List<FaqVO> viewfaq(String userid) throws SQLException {
		
		List<FaqVO> faqlist = new ArrayList<FaqVO>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select q_no, q_title, fk_categoryno, q_content, to_char(q_writeday, 'yyyy-mm-dd HH24:mi:ss'), "
					   + "a_content, to_char(a_writeday, 'yyyy-mm-dd HH24:mi:ss') "
					   + "from tbl_faq_q A left join tbl_faq_a B "
					   + "on A.q_no = B.fk_q_no "
					   + "where fk_userid = ? "
					   + "order by q_writeday desc";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FaqVO fvo = new FaqVO();
				fvo.setQ_no(rs.getInt(1));
				fvo.setQ_title(rs.getString(2));
				fvo.setFk_categoryno(rs.getInt(3));
				fvo.setQ_content(rs.getString(4));
				fvo.setQ_writeday(rs.getString(5));
				fvo.setA_content(rs.getString(6));
				fvo.setA_writeday(rs.getString(7));
				
				faqlist.add(fvo);
			}
			
		} finally {
			close();
		}
		
		return faqlist;
	}

	
	
	
	// 페이징 처리 안 함
	@Override
	public List<HelpVO> faqlist(String category) throws SQLException {

		List<HelpVO> hvoList = new ArrayList<HelpVO>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select faqno, f_category, f_title, f_content "
					   + "from tbl_faqlist ";
			
			if(category != null) {
				sql += "where f_category = ?";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			if(category != null) {
				pstmt.setString(1, category);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				HelpVO hvo = new HelpVO();
				hvo.setFaqno(rs.getInt(1));
				hvo.setF_category(rs.getString(2));
				hvo.setF_title(rs.getString(3));
				hvo.setF_content(rs.getString(4));
				hvoList.add(hvo);
			}
			
		} finally {
			close();
		}
		
		return hvoList;
	}

	
	
	
	// 고객센터 - 자주하는 질문 총 페이지 수
	@Override
	public int getTotalPage(Map<String, String> paramap) throws SQLException {
		
		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " select ceil(count(*)/?) "
						+ " from tbl_faqlist ";
			
			if(paramap.get("category") != null) {
				sql += "where f_category = ? ";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(paramap.get("sizePerPage")));
			
			if(paramap.get("category") != null) {
				pstmt.setString(2, paramap.get("category"));
			}
						
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalPage;		
		
	}

	
	
	
	
	
	// 고객센터 - 자주하는 질문 페이징처리
	@Override
	public List<HelpVO> faqlist_paging(Map<String, String> paramap) throws SQLException {

		List<HelpVO> hvolist = new ArrayList<HelpVO>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select rno, faqno, f_category, f_title, f_content "
					   + "from "
					   + "( "
					   + "select rownum rno, faqno, f_category, f_title, f_content "
					   + "from tbl_faqlist ";
			
			String category = paramap.get("category");
			String searchWord = paramap.get("searchWord");
			
			if(category != null && searchWord == null) {
				sql += "where f_category = ? ";
			}
			
			else if(category == null && searchWord != null) {
				sql += "where f_title like '%'|| ? ||'%' ";
			}
			
			else if(category != null && searchWord != null) {
				sql += "where f_category = ? and f_title like '%'|| ? ||'%' ";
			}
			
						
			sql += ") where rno between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPageNo = Integer.parseInt( paramap.get("currentShowPageNo") ); 
			int sizePerPage = Integer.parseInt( paramap.get("sizePerPage") );
			
			if(category != null && searchWord == null) {
				pstmt.setString(1, category);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			}
			
			else if(category == null && searchWord != null) {
				pstmt.setString(1, searchWord);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			}
			
			else if(category != null && searchWord != null) {
				pstmt.setString(1, category);
				pstmt.setString(2, searchWord);
				pstmt.setInt(3, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(4, (currentShowPageNo * sizePerPage));
				
			}
			
			else {
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1) );
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) );
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				HelpVO hvo = new HelpVO();
				hvo.setFaqno(rs.getInt(2));
				hvo.setF_category(rs.getString(3));
				hvo.setF_title(rs.getString(4));
				hvo.setF_content(rs.getString(5));
				
				hvolist.add(hvo);
			}
		
		} finally {
			close();
		}
		
		return hvolist;
	}

	
	
	
	
	// 고객센터 - 자주하는 질문 총 개수
	@Override
	public int getTotalFaqCount(Map<String, String> paramap) throws SQLException {
		
		int totalFaqCount = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " select count(*) "
						+ " from tbl_faqlist ";
			
			String category = paramap.get("category");
						
			if(category != null) {
			   sql += "where f_category = ? ";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			if(category != null) {
				pstmt.setString(1, category);
			}
						
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalFaqCount = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalFaqCount;
	}

	
	
	
	// 맛 검색
	@Override
	public List<TasteVO> searchTaste(String search) throws SQLException {

		List<TasteVO> tasteList = new ArrayList<TasteVO>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, "
					   + "natrium, allergy, ingredients, eng_name "
					   + "from tbl_taste "
					   + "where tastename like '%'||?||'%' or tasteexplain like '%'||?||'%' ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, search);
			pstmt.setString(2, search);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				TasteVO tvo = new TasteVO();
				tvo.setTasteno(rs.getInt(1));
				tvo.setTastename(rs.getString(2));
				tvo.setTasteimg(rs.getString(3));
				tvo.setTasteexplain(rs.getString(4));
				tvo.setOncesupply(rs.getString(5));
				tvo.setCalory(rs.getString(6));
				tvo.setSugar(rs.getString(7));
				tvo.setProtein(rs.getString(8));
				tvo.setFat(rs.getString(9));
				tvo.setNatrium(rs.getString(10));
				tvo.setAllergy(rs.getString(11));
				tvo.setIngredients(rs.getString(12));
				tvo.setEng_name(rs.getString(13));
				
				tasteList.add(tvo);
				
			}
			
		} finally {
			close();
		}
		
		return tasteList;
	}

	
	// 제품 검색
	@Override
	public List<ProductVO> searchCup(String search) throws SQLException {

		List<ProductVO> productList = new ArrayList<ProductVO>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select productcodeno, productname, productimg, price, productdetail, productimgbelow "
					   + "from tbl_product "
					   + "where productname like '%'||?||'%' or productdetail like '%'||?||'%' ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, search);
			pstmt.setString(2, search);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductVO pvo = new ProductVO();
				
				pvo.setProductcodeno(rs.getString(1));
				pvo.setProductname(rs.getString(2));
				pvo.setProductimg(rs.getString(3));
				pvo.setPrice(rs.getInt(4));
				pvo.setProductdetail(rs.getString(5));
				pvo.setProductimgBelow(rs.getString(6));
				
				productList.add(pvo);
				
			}
			
		} finally {
			close();
		}
		
		return productList;
	}

	
	// 자주하는 질문 검색
	@Override
	public List<HelpVO> searchFaq(String search) throws SQLException {

		List<HelpVO> faqList = new ArrayList<HelpVO>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select faqno, f_category, f_title, f_content "
					   + "from tbl_faqlist "
					   + "where f_title like '%'||?||'%' or f_content like '%'||?||'%' ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, search);
			pstmt.setString(2, search);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				HelpVO hvo = new HelpVO();
				
				hvo.setFaqno(rs.getInt(1));
				hvo.setF_category(rs.getString(2));
				hvo.setF_title(rs.getString(3));
				hvo.setF_content(rs.getString(4));
				
				faqList.add(hvo);				
				
			}
			
		} finally {
			close();
		}
		
		return faqList;
	}

	
	
	

	
	
	

	
	
	
	
	
}
