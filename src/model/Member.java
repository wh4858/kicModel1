package model;

public class Member {
	private String id;
	private String pass;
	private String name;
	private int gender;
	private String tel;
	private String email;
	private String picture;

	public Member(String id, String pass, String name, int gender, String tel, String email, String picture) {
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.gender = gender;
		this.tel = tel;
		this.email = email;
		this.picture = picture;
	}
	public String getId() {
		return id;
	}
	public String getPass() {
		return pass;
	}
	public String getName() {
		return name;
	}
	public int getGender() {
		return gender;
	}
	public String getTel() {
		return tel;
	}
	public String getEmail() {
		return email;
	}
	public String getPicture() {
		return picture;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	@Override
	public String toString() {
		return "Member [id=" + id + ", pass=" + pass + ", name=" + name + ", gender=" + gender + ", tel=" + tel
				+ ", email=" + email + ", picture=" + picture + "]";
	}
	
	
}
