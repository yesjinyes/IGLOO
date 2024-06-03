package order.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

import member.domain.MemberVO;
import myshop.domain.CartVO;

public class OrderVO {

	Date now = new Date();
	SimpleDateFormat sdft = new SimpleDateFormat("yyyy-MM-dd");
	
	// === field === //
	private String ordercode;						// 주문코드
	private String fk_userid;						// 회원아이디
	private int totalprice;							// 주문총액
	private String orderdate = sdft.format(now);	// 주문일자
	private int reviewstatus;						// 리뷰작성상태
	private String storename;
	//////////////////////////////////////////////////////////////
	
	public String getStorename() {
		return storename;
	}
	public void setStorename(String storename) {
		this.storename = storename;
	}
	// === select 용 === //
	private CartVO cart = new CartVO();
	private MemberVO member = new MemberVO();
	
	//////////////////////////////////////////////////////////////
	
	public int getReviewstatus() {
		return reviewstatus;
	}
	public void setReviewstatus(int reviewstatus) {
		this.reviewstatus = reviewstatus;
	}
	public MemberVO getMember() {
		return member;
	}
	public void setMember(MemberVO member) {
		this.member = member;
	}
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
