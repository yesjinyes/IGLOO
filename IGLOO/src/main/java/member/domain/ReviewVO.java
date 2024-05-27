package member.domain;

import order.domain.OrderVO;
import order.domain.OrderdetailVO;

public class ReviewVO {
	
	
	private int reviewno;
	private String fk_userid;
	private String fk_ordercode;
	private String reviewcontent;
	private String writeday;
	
	
	// ---- select용 -----
	public MemberVO getMvo() {
		return mvo;
	}
	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}
	private MemberVO mvo;
	
	
	
	public OrderVO getOvo() {
		return ovo;
	}
	public void setMvo(OrderVO ovo) {
		this.ovo = ovo;
	}
	private OrderVO ovo;
	
	
	
	public OrderdetailVO getOdvo() {
		return odvo;
	}
	public void setOdvo(OrderdetailVO odvo) {
		this.odvo = odvo;
	}
	private OrderdetailVO odvo;
	
	//매장vo??
	
	
	
	
	
	public int getReviewno() {
		return reviewno;
	}
	public void setReviewno(int reviewno) {
		this.reviewno = reviewno;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getFk_ordercode() {
		return fk_ordercode;
	}
	public void setFk_ordercode(String fk_ordercode) {
		this.fk_ordercode = fk_ordercode;
	}
	public String getReviewcontent() {
		return reviewcontent;
	}
	public void setReviewcontent(String reviewcontent) {
		this.reviewcontent = reviewcontent;
	}
	public String getWriteday() {
		return writeday;
	}
	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	
	
	
	
}
