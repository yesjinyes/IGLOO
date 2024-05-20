package order.domain;

public class OrderdetailVO {

	// === field === //
	private int orderdetailno;		// 주문상세일련번호
	private String fk_ordercode;	// 주문코드
	private int ordercount;			// 주문량
	private int fk_selectno;		// 선택일련번호
	private int orderprice;			// 주문가격
	private int pickupstatus;		// 픽업상태
	private String pickuptime;		// 픽업완료시간
	//////////////////////////////////////////////////////////////
	
	// === select 용 === //
	private OrderVO order = new OrderVO();
	
	//////////////////////////////////////////////////////////////
	
	// === Getter, Setter === //
	public int getOrderdetailno() {
		return orderdetailno;
	}

	public void setOrderdetailno(int orderdetailno) {
		this.orderdetailno = orderdetailno;
	}

	public String getFk_ordercode() {
		return fk_ordercode;
	}

	public void setFk_ordercode(String fk_ordercode) {
		this.fk_ordercode = fk_ordercode;
	}

	public int getOrdercount() {
		return ordercount;
	}

	public void setOrdercount(int ordercount) {
		this.ordercount = ordercount;
	}

	public int getFk_selectno() {
		return fk_selectno;
	}

	public void setFk_selectno(int fk_selectno) {
		this.fk_selectno = fk_selectno;
	}

	public int getOrderprice() {
		return orderprice;
	}

	public void setOrderprice(int orderprice) {
		this.orderprice = orderprice;
	}

	public int getPickupstatus() {
		return pickupstatus;
	}

	public void setPickupstatus(int pickupstatus) {
		this.pickupstatus = pickupstatus;
	}

	public String getPickuptime() {
		return pickuptime;
	}

	public void setPickuptime(String pickuptime) {
		this.pickuptime = pickuptime;
	}

	public OrderVO getOrder() {
		return order;
	}

	public void setOrder(OrderVO order) {
		this.order = order;
	}
	
}
