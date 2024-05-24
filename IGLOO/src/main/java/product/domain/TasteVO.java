package product.domain;

import order.domain.OrderdetailVO;

public class TasteVO {

	// === Field === //
	private int tasteno;				// 맛종류번호
	private String tastename;			// 맛이름
	private String tasteimg;			// 이미지명 
	private String ingredients;			// 재료
/////////////////////////////////////////////////////////////////////////
	
	// === Select 용 === //
	private OrderdetailVO odvo; // 주문상세VO 
	
	private int rno;
	private int cnt;
	
/////////////////////////////////////////////////////////////////////////
	
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	// === Getter, Setter === //
	public OrderdetailVO getOdvo() {
		return odvo;
	}
	public void setOdvo(OrderdetailVO odvo) {
		this.odvo = odvo;
	}
	public int getTasteno() {
		return tasteno;
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
