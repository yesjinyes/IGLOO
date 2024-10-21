package myshop.domain;

import java.util.List;

import product.domain.ProductVO;
import product.domain.TasteVO;

public class CartVO {

	// === Field === //
	private int cartno;			// 장바구니번호
	private String fk_userid;		// 회원아이디
	private int count;				// 수량
	private int fk_selectno;		// 선택일련번호
	private List<TasteVO> tastenamelist;	// 맛선택 나열
	
/////////////////////////////////////////////////////////////////////////
	
	// === Select 용 === //
	private	ProductVO product = new ProductVO();
	
/////////////////////////////////////////////////////////////////////////
	
	// === Getter, Setter === //
	public int getCartno() {
		return cartno;
	}
	public void setCartno(int cartno) {
		this.cartno = cartno;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getFk_selectno() {
		return fk_selectno;
	}
	public void setFk_selectno(int fk_selectno) {
		this.fk_selectno = fk_selectno;
	}
	public ProductVO getProduct() {
		return product;
	}
	public void setProduct(ProductVO product) {
		this.product = product;
	}
	public List<TasteVO> getTastenamelist() {
		return tastenamelist;
	}
	public void setTastenamelist(List<TasteVO> tastenamelist) {
		this.tastenamelist = tastenamelist;
	}
}
