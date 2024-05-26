package product.domain;

import order.domain.OrderdetailVO;

public class TasteVO {

	// === Field === //
	private int tasteno;				// 맛종류번호
	private String tastename;			// 맛이름
	private String tasteimg;			// 이미지명 
	private String ingredients;			// 재료
	private String tasteexplain;
	private String oncesupply;
	private String calory;
	private String sugar;
	private String protein;
	private String fat;
	private String natrium;
	private String allergy;
	private String eng_name;
/////////////////////////////////////////////////////////////////////////
	
	// === Select 용 === //
	private OrderdetailVO odvo; // 주문상세VO 
	
	private int rno;
	private int cnt;
	
/////////////////////////////////////////////////////////////////////////
	
	public String getTasteexplain() {
		return tasteexplain;
	}
	public void setTasteexplain(String tasteexplain) {
		this.tasteexplain = tasteexplain;
	}
	public String getOncesupply() {
		return oncesupply;
	}
	public void setOncesupply(String oncesupply) {
		this.oncesupply = oncesupply;
	}
	public String getCalory() {
		return calory;
	}
	public void setCalory(String calory) {
		this.calory = calory;
	}
	public String getSugar() {
		return sugar;
	}
	public void setSugar(String sugar) {
		this.sugar = sugar;
	}
	public String getProtein() {
		return protein;
	}
	public void setProtein(String protein) {
		this.protein = protein;
	}
	public String getFat() {
		return fat;
	}
	public void setFat(String fat) {
		this.fat = fat;
	}
	public String getNatrium() {
		return natrium;
	}
	public void setNatrium(String natrium) {
		this.natrium = natrium;
	}
	public String getAllergy() {
		return allergy;
	}
	public void setAllergy(String allergy) {
		this.allergy = allergy;
	}
	public String getEng_name() {
		return eng_name;
	}
	public void setEng_name(String eng_name) {
		this.eng_name = eng_name;
	}
	
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
