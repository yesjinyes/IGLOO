package product.model.nr;

import java.io.UnsupportedEncodingException;
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
import util.security.hj.AES256;
import util.security.hj.SecretMyKey;

public class ProductDAO_imple implements ProductDAO {

	private DataSource ds;	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 생성자
	public ProductDAO_imple() {
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

	
	
	
	
	
	
	// 아이스크림 맛 상세정보 가져오기
	@Override
	public TasteVO getMenuDetail(String tasteno) throws SQLException {
		
		TasteVO tvo = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy, ingredients, eng_name "
					   + "from tbl_taste "
					   + "where tasteno = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tasteno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				tvo = new TasteVO();
				
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
				
			}
			
		} finally {
			close();
		}
		
		return tvo;
	}

	@Override
	public List<ProductVO> getMainProduct() throws SQLException {

		List<ProductVO> productList = new ArrayList<ProductVO>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select productname, productimg, productdetail, productcodeno "
					   + "from tbl_product";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductVO pvo = new ProductVO();
				
				pvo.setProductname(rs.getString(1));
				pvo.setProductimg(rs.getString(2));
				pvo.setProductdetail(rs.getString(3));
				pvo.setProductcodeno(rs.getString(4));
				
				productList.add(pvo);
				
			}
			
		} finally {
			close();
		}
		
		
		return productList;
	}

	
	
	
	
	
	
	// 메인페이지 맛 정보 가져오기
	@Override
	public List<TasteVO> getMainTaste() throws SQLException {

		List<TasteVO> tasteList = new ArrayList<TasteVO>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select tasteno, tastename, tasteimg "
					   + "from tbl_taste";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				TasteVO tvo = new TasteVO();
				
				tvo.setTasteno(rs.getInt(1));
				tvo.setTastename(rs.getString(2));
				tvo.setTasteimg(rs.getString(3));
				
				tasteList.add(tvo);
				
			}
			
		} finally {
			close();
		}
		
		
		return tasteList;
	}

	
	
	
	
	// 메인페이지 메인이미지 가져오기
	@Override
	public List<Map<String, String>> getMainImg() throws SQLException {
		
		List<Map<String, String>> mainImgList = new ArrayList<Map<String,String>>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select imgno, imgfilename "
						+ "from tbl_main_image ";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Map<String, String> imgMap = new HashMap<String, String>();
				
				imgMap.put("imgno", rs.getString(1));
				imgMap.put("imgfilename", rs.getString(2));
				
				mainImgList.add(imgMap);
			}
			
		} finally {
			close();
		}
		
		return mainImgList;
	}


	
	
	
}
