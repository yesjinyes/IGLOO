package product.domain;

public class SelectlistVO {

	// === Field === //
	private int selectno;				// 선택일련번호
	private String fk_userid;				// 회원아이디
	private String fk_productcodeno;		// 제품코드
		
/////////////////////////////////////////////////////////////////////////
		
	// === Select 용 === //
	private	ProductVO product = new ProductVO();
	private TasteVO taste = new TasteVO();
		
/////////////////////////////////////////////////////////////////////////
		
	// === Getter, Setter === //
	public int getSelectno() {
		return selectno;
	}
	public void setSelectno(int selectno) {
		this.selectno = selectno;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getFk_productcodeno() {
		return fk_productcodeno;
	}
	public void setFk_productcodeno(String fk_productcodeno) {
		this.fk_productcodeno = fk_productcodeno;
	}
	public ProductVO getProduct() {
		return product;
	}
	public void setProduct(ProductVO product) {
		this.product = product;
	}
	public TasteVO getTaste() {
		return taste;
	}
	public void setTaste(TasteVO taste) {
		this.taste = taste;
	}
}
