package com.odiga.dto.cart;

import com.odiga.dto.hotel.HotelDTO;

public class CartDTO {
	private int num;
	private int hotel_num;
	private String id;
	private HotelDTO hotelDTO;
	
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
	public HotelDTO getHotelDTO() {
		return hotelDTO;
	}
	public void setHotelDTO(HotelDTO hotelDTO) {
		this.hotelDTO = hotelDTO;
	}
	
	public String toString() {
		return 
			"num : " + this.num + "\n" +
			"hotel_num : " + this.hotel_num + "\n" +
			"id : " + this.id + "\n";
	}
}
