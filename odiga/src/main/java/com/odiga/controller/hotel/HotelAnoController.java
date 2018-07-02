package com.odiga.controller.hotel;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.odiga.controller.index.IndexController;
import com.odiga.dto.hotel.HotelDTO;
import com.odiga.mybatis.hotel.HotelMapper;
import com.odiga.mybatis.member.MemberMapper;

@Controller
public class HotelAnoController {
	@Autowired
	private HotelMapper hotelMapper;
	@Autowired
	private MemberMapper memberMapper;
	

	@RequestMapping(value = "/hotel_list.do")
	public ModelAndView hotelList() {
		List<HotelDTO> hotel_list = hotelMapper.listHotel();
		if(hotel_list.isEmpty()) {
			hotel_list = null;
		}
		
		ModelAndView mav = new ModelAndView("hotel/hotel_list");
		mav.addObject("hotel_list", hotel_list);
		return mav;
	}
	
	@RequestMapping(value = "/hotel_insert.do", method =RequestMethod.GET)
	public String hotelInsertForm(){
		return "hotel/insertForm";
	}
	
	@RequestMapping(value = "/hotel_insert.do", method = RequestMethod.POST)
	public ModelAndView hotelInsertPro(HttpServletRequest req, HotelDTO dto, BindingResult result) throws IOException {
		setImage(req, dto, result);
		hotelMapper.insertHotel(dto);
		ModelAndView mav = new ModelAndView("hotel/hotel_room");
		mav.addObject("hotel_num", dto.getNum()); // insert 한 뒤 num값을 가져와서 보내준다.
		return mav;
	}
	
	protected void setImage(HttpServletRequest req, HotelDTO dto, BindingResult result)throws IOException {
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
		mr.setCharacterEncoding("EUC-KR");
		List<MultipartFile> fileList = mr.getFiles("filename");
		
		if (result.hasErrors() && fileList.isEmpty()) {
			dto.setFilename("");
		}
		
		for (MultipartFile mf : fileList) {
			String originFileName = mf.getOriginalFilename();
			if (originFileName != null && !originFileName.trim().equals("")) {
				HttpSession session = req.getSession();
				String upPath = session.getServletContext().getRealPath("/hotel_img");
				File file = new File(upPath + "//" + originFileName);
				((MultipartFile) mf).transferTo(file);
			}
			dto.setFilename(originFileName);
		}
	} 

	@RequestMapping(value = "/hotel_jusoPopup.do") // 도로명
	public String JusoForm() {
		return "hotel/jusoPopup";
	}
	
	
	@RequestMapping(value = "/hotel_getOne.do")
	public ModelAndView getHotel(HttpServletRequest req, int num, HttpServletResponse resp) {
		ModelAndView mav = new ModelAndView("hotel/hotel_details");
		String start = req.getParameter("start");
		if(start != null) {
			mav.addObject("start", start);
			mav.addObject("end", req.getParameter("end"));
		}
		HotelDTO dto = hotelMapper.getHotel(num);
		
		HttpSession session=req.getSession();
		HashMap<String, String> hm=(HashMap<String, String>) session.getAttribute("user");
		if(hm != null) {
			String id=hm.get("id");
		    int points = memberMapper.getPoint(id);
		   mav.addObject("points", points);
		}
	     
		
		IndexController index = new IndexController();
		String city = index.getCity(req.getCookies());
		index.getWeather(city, mav, resp);
		mav.addObject("hotel", dto);
		return mav;
	}
	
	@RequestMapping(value = "/hotel_map.do")
	public ModelAndView odigaMap(String roadaddrpart1) {
		ModelAndView mav = new ModelAndView("hotel/map");
		mav.addObject("roadaddrpart1", roadaddrpart1);
		return mav;
	}
	
	@RequestMapping(value = "/hotel_content.do")
	   public ModelAndView content(int num, HttpServletRequest req, HttpServletResponse resp) {
	      
	      HotelDTO hotel = hotelMapper.getHotel(num);
	      ModelAndView mav = new ModelAndView("hotel/hotel_details");
	      String[] filenames = hotel.getFilename().split("//@//");
	      
	     IndexController index=new IndexController();
	     String city=index.getCity(req.getCookies());
	     index.getWeather(city, mav, resp); // 날씨정보
	      
	    
	      mav.addObject("filenames", filenames);
	      mav.addObject("hotel", hotel);
	      return mav;
	   }

	  @RequestMapping(value = "/hotel_cate.do") // 타이틀로 찾기
	   public ModelAndView hotelCate(String title, HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException {
	     ModelAndView mav = new ModelAndView("hotel/hotel_cate");
	     IndexController index = new IndexController();
		String city = index.getCity(req.getCookies());
		index.getWeather(city, mav, resp);
	      List<HotelDTO> hotelCate = hotelMapper.cateHotel(title);
	      mav.addObject("hotel_cate", hotelCate);
	      mav.addObject("city", title);
	      mav.addObject("title", title);
	      return mav;
	   }
	  
	  @RequestMapping(value = "/hotel_delete.do")
		public ModelAndView hotelDeletePro(HttpServletRequest req, int num) {
			HotelDTO dto = hotelMapper.getHotel(num);
			if(!dto.getFilename().trim().equals("")) {
				HttpSession session = req.getSession();	// 이미지경로
				String upPath = session.getServletContext().getRealPath("/img");	// 경로 저장하는 곳
				for(String filename : dto.getFilename().split("//@//")) {
					File file = new File(upPath, filename); // 경로/파일이름을 어떻게 하겠다.
					file.delete();
				}
			}
			hotelMapper.deleteHotel(num);
			return new ModelAndView("redirect:index.do");
		}
	  
	  @RequestMapping(value = "/hotel_search.do") 
	  public ModelAndView hotelSearch(HttpServletRequest req, String search, int pageNum, HttpServletResponse resp, String start, String end) throws UnsupportedEncodingException {
		  ModelAndView mav = new ModelAndView("hotel/hotel_search");
		  List<HotelDTO> hotel_Search_list = hotelMapper.getSearch_list(search, pageNum);
		  int count = hotelMapper.getCountSearch(search);
		  int maxPage = count / 9;
		  if(count % 9 > 0) {
			  maxPage++;
		  }
		  
	      IndexController index = new IndexController();
	      String city = index.getCity(req.getCookies());
	      index.getWeather(city, mav, resp);
	      mav.addObject("hotel_search", hotel_Search_list);
	      mav.addObject("maxPage", maxPage);
	      mav.addObject("pageNum", pageNum);
	      mav.addObject("start", start);
	      mav.addObject("end", end);
	      return mav;
	  }
	  
/*
	  @RequestMapping(value = "/hotel_update.do", method = RequestMethod.POST)
		public ModelAndView hotelUpdatePro(HttpServletRequest req, HotelDTO dto, BindingResult result)
		throws IOException {
			setImage(req, dto, result);
			hotelMapper.updateHotel(dto);
			return new ModelAndView("redirect:hotel_list.do");
		}	*/
}