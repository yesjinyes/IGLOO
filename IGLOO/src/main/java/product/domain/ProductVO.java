package product.domain;

public class ProductVO {
	
	// === Field === //
	private String productcodeno;		// 제품코드
	private String productname;			// 제품명
	private String productimgTop;		// 제품상단이미지
	private String productimgBelow;		// 제품상단이미지
	private int price;					// 가격
	private String productdetail;		// 제품설명
	
/////////////////////////////////////////////////////////////////////////
	
	// === Select 용 === //
	
	
/////////////////////////////////////////////////////////////////////////
	
	// === Getter, Setter === //
	public String getProductcodeno() {
		return productcodeno;
	}
	public void setProductcodeno(String productcodeno) {
		this.productcodeno = productcodeno;
	}
	public String getProductimgTop() {
		return productimgTop;
	}
	public void setProductimgTop(String productimgTop) {
		this.productimgTop = productimgTop;
	}
	public String getProductimgBelow() {
		return productimgBelow;
	}
	public void setProductimgBelow(String productimgBelow) {
		this.productimgBelow = productimgBelow;
	}
	public String getProductname() {
		return productname;
	}
	public void setProductname(String productname) {
		this.productname = productname;
	}
	
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getProductdetail() {
		return productdetail;
	}
	public void setProductdetail(String productdetail) {
		this.productdetail = productdetail;
	}
}
