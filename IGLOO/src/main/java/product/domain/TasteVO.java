package product.domain;

public class TasteVO {

	// === Field === //
	private int tasteno;				// 맛종류번호
	private String tastename;			// 맛이름
	private String tasteimg;			// 이미지명
	private String ingredients;			// 재료
	private int cnt;					// 맛별 주문 수
/////////////////////////////////////////////////////////////////////////
	
	// === Select 용 === //
	
	
/////////////////////////////////////////////////////////////////////////
	
	// === Getter, Setter === //
	
	public int getTasteno() {
		return tasteno;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public void setTasteno(int tasteno) {
		this.tasteno = tasteno;
	}
	public String getIngredients() {
		return ingredients;
	}
	public void setIngredients(String ingredients) {
		this.ingredients = ingredients;
	}
	public String getTastename() {
		return tastename;
	}
	public void setTastename(String tastename) {
		this.tastename = tastename;
	}
	public String getTasteimg() {
		return tasteimg;
	}
	public void setTasteimg(String tasteimg) {
		this.tasteimg = tasteimg;
	}
}
