package com.odiga.dto.hotel;



public class HotelDTO {

	private int num;
	private String name;
	private String roadaddrpart1;
	private String addrdetail;
	private String zipno;
	private double score;
	private int price;
	private String filename;
	private boolean parking;
	private boolean refund;
	private String checkin;
	private String checkout;
	private String content;
	private int population; //ÀÎ±¸¼ö
	
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getPopulation() {
		return population;
	}
	public void setPopulation(int population) {
		this.population = population;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRoadaddrpart1() {
		return roadaddrpart1;
	}
	public void setRoadaddrpart1(String roadaddrpart1) {
		this.roadaddrpart1 = roadaddrpart1;
	}
	public String getAddrdetail() {
		return addrdetail;
	}
	public void setAddrdetail(String addrdetail) {
		this.addrdetail = addrdetail;
	}
	public String getZipno() {
		return zipno;
	}
	public void setZipno(String zipno) {
		this.zipno = zipno;
	}
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
	      if (this.filename == null) {
	         this.filename = filename;
	      } else {
	         this.filename += "//@//" + filename;
	      }
	}
	public boolean isParking() {
		return parking;
	}
	public void setParking(boolean parking) {
		this.parking = parking;
	}
	public boolean isRefund() {
		return refund;
	}
	public void setRefund(boolean refund) {
		this.refund = refund;
	}	
	public void one_setFilename(String filename) {
	      this.filename = filename;
	  }
	public String getCheckin() {
		return checkin;
	}
	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}
	public String getCheckout() {
		return checkout;
	}
	public void setCheckout(String checkout) {
		this.checkout = checkout;
	}
	public String getOneFilename() {
		String[] filename = this.filename.split("//@//");
		return filename[0];
	}
	public String getAdd_Easy() {
		String[] hotel_addvalue = this.roadaddrpart1.split(" ");
		return hotel_addvalue[0] + ", "  +hotel_addvalue[1];
	}
	public String[] getFilename_list() {
		String[] filename = this.filename.split("//@//");
		return filename;
	}
}
