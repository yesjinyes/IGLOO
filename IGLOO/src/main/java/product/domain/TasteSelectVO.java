package product.domain;

public class TasteSelectVO {

	private int tasteselectno;  // 맛선택 일련번호
	private int fk_selectno;	// 선택 일련번호
	private int fk_tasteno;		// 맛종류번호
	
	
	public int getTasteselectno() {
		return tasteselectno;
	}
	public void setTasteselectno(int tasteselectno) {
		this.tasteselectno = tasteselectno;
	}
	public int getFk_selectno() {
		return fk_selectno;
	}
	public void setFk_selectno(int fk_selectno) {
		this.fk_selectno = fk_selectno;
	}
	public int getFk_tasteno() {
		return fk_tasteno;
	}
	public void setFk_tasteno(int fk_tasteno) {
		this.fk_tasteno = fk_tasteno;
	}
	
}
