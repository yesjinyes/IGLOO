package order.domain;

import myshop.domain.CartVO;

public class OrderVO {

	// === field === //
	private String ordercode;
	private String fk_userid;
	private int totalprice;
	private String orderdate;
	//////////////////////////////////////////////////////////////
	
	// === select 용 === //
	private CartVO cart = new CartVO();
	
	//////////////////////////////////////////////////////////////
	
	// === Getter,Setter === //
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
	
///////////////////////////////////////
	
	public CartVO getCart() {
		return cart;
	}
	public void setCart(CartVO cart) {
		this.cart = cart;
	}
	
	
	
	
	
}
