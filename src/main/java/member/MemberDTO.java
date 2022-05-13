package member;

import java.sql.Timestamp;

public class MemberDTO {
	// 멤버변수 정의
	private String id;
	private String pass;
	private String name;
	private String email;
	private String address;
	private String phone;
	private String mobile;
	private int point_cur;
	private int point_max;
	private Timestamp date;
	private Timestamp date_cur;
	private int rating;
	private String rating_name;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public int getPoint_cur() {
		return point_cur;
	}
	public void setPoint_cur(int point_cur) {
		this.point_cur = point_cur;
	}
	public int getPoint_max() {
		return point_max;
	}
	public void setPoint_max(int point_max) {
		this.point_max = point_max;
	}
	public Timestamp getDate_cur() {
		return date_cur;
	}
	public void setDate_cur(Timestamp date_cur) {
		this.date_cur = date_cur;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getRating_name() {
		return rating_name;
	}
	public void setRating_name(String rating_name) {
		this.rating_name = rating_name;
	}
	
	
	
//	String gender;
//	String email;
//	String phone;
//	String address;
	// 멤버함수 메서드 정의
}
