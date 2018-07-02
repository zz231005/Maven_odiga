package com.odiga.controller.room;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.odiga.dto.room.RoomDTO;
import com.odiga.mybatis.room.RoomMapper;



@Controller
public class RoomAnoController {
	@Autowired
	private RoomMapper roomMapper;
	
	/* 안녕 */
	@RequestMapping(value = "/insert_Room.do", method = RequestMethod.POST)
	public ModelAndView insertRoom(HttpServletRequest req, int hotel_num, RoomDTO dto,BindingResult result) throws UnsupportedEncodingException {
		if (result.hasErrors()) {
			System.err.println("에러");
		}
		
		//호텔의 방 정보 추가를 5개 까지 할 수 있음 
		for(int i = 1; i <= 5; i++) {
			if(!req.getParameter("room_name_"+i).trim().equals("")) {
				dto = new RoomDTO();
				dto.setRoom_name(req.getParameter("room_name_"+i));
				System.out.println(req.getParameter("room_name_"+i));
				dto.setHotel_num(hotel_num);
				System.out.println(hotel_num);
				dto.setMinp(Integer.parseInt(req.getParameter("minp_"+i)));
				dto.setMaxp(Integer.parseInt(req.getParameter("maxp_"+i)));
				dto.setRoom_size(Integer.parseInt(req.getParameter("room_size_"+i)));
				dto.setWifi(Boolean.valueOf(req.getParameter("wifi_"+i)));
				dto.setBreakfast(Boolean.valueOf(req.getParameter("breakfast_"+i)));
				dto.setSmoking(Boolean.valueOf(req.getParameter("smoking_"+i)));
				dto.setCooking(Boolean.valueOf(req.getParameter("cooking_"+i)));
				dto.setPrice(Integer.parseInt(req.getParameter("price_"+i)));
				dto.setRoom_img(setImg(result,req,"room_img_"+i ));
				roomMapper.insertRoom(dto);
			}
		}
		ModelAndView mav = new ModelAndView("redirect:hotel_getOne.do");
		mav.addObject("num", hotel_num);
		return mav;
	}
	
	protected String setImg( BindingResult result, HttpServletRequest req, String filename) {
		HttpSession session = req.getSession();
		String upPath = session.getServletContext().getRealPath("/room_img");
		try {
			MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
			mr.setCharacterEncoding("EUC-KR");
			MultipartFile mf = mr.getFile(filename);
			
			
			String originFileName = mf.getOriginalFilename();
			File file = new File(upPath, originFileName);
			((MultipartFile) mf).transferTo(file);
			return originFileName;
		}catch(UnsupportedEncodingException e){
			e.printStackTrace();
		}catch(IOException e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	@RequestMapping(value = "/rooms.do")
	public ModelAndView getRooms(int hotel_num) {
		List list = roomMapper.getRooms(hotel_num);
		ModelAndView mav = new ModelAndView("hotel/rooms");
		mav.addObject("room_list", list);
		return mav;
	}
}