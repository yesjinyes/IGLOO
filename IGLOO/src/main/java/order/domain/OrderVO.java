package order.domain;

public class OrderVO {

	// === field === //
	private String ordercode;
	private String fk_userid;
	private int totalprice;
	//////////////////////////////////////////////////////////////
	
	// === select 용 === //
	
	
	//////////////////////////////////////////////////////////////
	
	public String getOrdercode() {
		return ordercode;
	}
	public void setOrdercode(String ordercode) {
		this.ordercode = ordercode;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public int getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}
	public String getOrderdate() {
		return orderdate;
	}
	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}
	private String orderdate;
	
	
	
	
	
	
}
