package help.domain.nr;

import member.domain.MemberVO;

public class FaqVO {
	
	private int q_no;
	private String fk_userid;
	private String q_title;
	private int fk_categoryno;
	private String q_content;
	private String q_writeday;
	private int a_no;
	private int fk_q_no;
	private String a_content;
	private String a_writeday;
	private int answerstatus;
	private String faq_img;
	
	public String getFaq_img() {
		return faq_img;
	}
	public void setFaq_img(String faq_img) {
		this.faq_img = faq_img;
	}
	public MemberVO getMvo() {
		return mvo;
	}
	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}
	private MemberVO mvo;
	
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public int getAnswerstatus() {
		return answerstatus;
	}
	public void setAnswerstatus(int answerstatus) {
		this.answerstatus = answerstatus;
	}
	public int getQ_no() {
		return q_no;
	}
	public void setQ_no(int q_no) {
		this.q_no = q_no;
	}
	public String getQ_title() {
		return q_title;
	}
	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}
	public int getFk_categoryno() {
		return fk_categoryno;
	}
	public void setFk_categoryno(int fk_categoryno) {
		this.fk_categoryno = fk_categoryno;
	}
	public String getQ_content() {
		return q_content;
	}
	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}
	public String getQ_writeday() {
		return q_writeday;
	}
	public void setQ_writeday(String q_writeday) {
		this.q_writeday = q_writeday;
	}
	public int getA_no() {
		return a_no;
	}
	public void setA_no(int a_no) {
		this.a_no = a_no;
	}
	public int getFk_q_no() {
		return fk_q_no;
	}
	public void setFk_q_no(int fk_q_no) {
		this.fk_q_no = fk_q_no;
	}
	public String getA_content() {
		return a_content;
	}
	public void setA_content(String a_content) {
		this.a_content = a_content;
	}
	public String getA_writeday() {
		return a_writeday;
	}
	public void setA_writeday(String a_writeday) {
		this.a_writeday = a_writeday;
	}
	
}
