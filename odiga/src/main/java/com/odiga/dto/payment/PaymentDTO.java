package com.odiga.dto.payment;

import com.odiga.dto.hotel.HotelDTO;

public class PaymentDTO {
	private int num;
	private int hotel_num;
	private String id;
	private String price;
	private String startdate;
	private String enddate;
	private String pay_mode;
	private HotelDTO hotelDTO;
	
	public HotelDTO getHotelDTO() {
		return hotelDTO;
	}
	public void setHotelDTO(HotelDTO hotelDTO) {
		this.hotelDTO = hotelDTO;
	}
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public String getPay_mode() {
		return pay_mode;
	}
	public void setPay_mode(String pay_mode) {
		this.pay_mode = pay_mode;
	}
	public String get_mode(int sel) {
		String[] mode = this.pay_mode.split("//@//");
		return mode[sel]; // card//@//1235-5434-2344 payment//@//1231235-43543-3452
	}
}
