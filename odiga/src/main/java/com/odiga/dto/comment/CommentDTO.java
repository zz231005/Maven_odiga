package com.odiga.dto.comment;

public class CommentDTO {
	private int num;
	private int hotel_num;
	private String id;
	private String title;
	private String comments;
	private String passwd;
	private String logtime;
	private double star_rate ;

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getHotel_num() {
		return hotel_num;
	}

	public void setHotel_num(int hotel_num) {
		this.hotel_num = hotel_num;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getLogtime() {
		return logtime;
	}

	public void setLogtime(String logtime) {
		this.logtime = logtime;
	}

	public double getStar_rate() {
		return star_rate ;
	}

	public void setStar_rate (double star_rate ) {
		this.star_rate  = star_rate ;
	}
	
}
