package product.domain;

public class TasteVO {

	// === Field === //
	private String tasteno;				// 맛종류번호
	private String tastename;			// 맛이름
	private String tasteimg;			// 이미지명
	
/////////////////////////////////////////////////////////////////////////
	
	// === Select 용 === //
	
	
/////////////////////////////////////////////////////////////////////////
	
	// === Getter, Setter === //
	public String getTasteno() {
		return tasteno;
	}
	public void setTasteno(String tasteno) {
		this.tasteno = tasteno;
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
