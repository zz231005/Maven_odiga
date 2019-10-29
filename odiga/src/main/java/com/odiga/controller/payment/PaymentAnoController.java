package com.odiga.controller.payment;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.odiga.mybatis.member.MemberMapper;

import com.odiga.mybatis.payment.PaymentMapper;
import com.odiga.controller.index.IndexController;
import com.odiga.dto.member.MemberDTO;
import com.odiga.dto.payment.PaymentDTO;



@Controller
public class PaymentAnoController {
	@Autowired
	private PaymentMapper paymentMapper;
	@Autowired
	private MemberMapper memberMapper;
	private String[] week = {"일요일", "월요일", "화요일", "수요일", "목요일", "금요일" , "토요일"};

	@RequestMapping(value = "/payment_Form.do")
	public ModelAndView PaymentForm( HttpServletResponse resp,HttpServletRequest req, 
			PaymentDTO dto, String hotel_name, String  score, String roadaddrpart1, String refund) {
		
		
		ModelAndView mav = new ModelAndView("payment/paymentForm");
		String[] start = dto.getStartdate().split("-");
		String[] end = dto.getEnddate().split("-");
		
		HttpSession session=req.getSession();
		HashMap<String, String> hm=(HashMap<String, String>) session.getAttribute("user");
		if(hm != null) {
			String id=hm.get("id");
			MemberDTO memberDTO = memberMapper.getMember(id);
			mav.addObject("mem", memberDTO);
		}
		
		Calendar cal = Calendar.getInstance();
		int days = 0;
		if (Integer.parseInt(start[1]) < Integer.parseInt(end[1])) {
			cal.set(Calendar.MONTH, Integer.parseInt(start[1]));
			int max = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			days = (max - Integer.parseInt(start[2])) + Integer.parseInt(end[2]);
		} else {
			int num_start = Integer.parseInt((start[1] + start[2]));
			int num_end = Integer.parseInt((end[1] + end[2]));
			days = num_end - num_start;
		}
		cal.set(Integer.parseInt(start[0]), Integer.parseInt(start[1])-1, Integer.parseInt(start[2]));
		int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
		mav.addObject("startweek" ,week[dayNum-1] );
		
		cal.set(Integer.parseInt(end[0]), Integer.parseInt(end[1])-1, Integer.parseInt(end[2]));
		dayNum = cal.get(Calendar.DAY_OF_WEEK);
		mav.addObject("endweek" ,week[dayNum-1] );

		
		IndexController index = new IndexController();
		String city = index.getCity(req.getCookies());
		mav = index.getWeather(city, mav, resp);
		
		mav.addObject("days", days);
		mav.addObject("dto", dto);
		mav.addObject("hotel_name", hotel_name);
		mav.addObject("score", score);
		mav.addObject("roadaddrpart1", roadaddrpart1);
		mav.addObject("refund",	refund);
		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "/payment_Pro.do", method = RequestMethod.POST)
	public String PaymentPro(PaymentDTO dto, String value, String name, String card_name, HttpServletRequest req) {
		if(dto.getPay_mode().equals("card"))
	         value = card_name+value;
		
	    dto.setPay_mode(dto.getPay_mode() + "//@//" + name + "//@//" + value);
	    
	    if(!dto.getId().trim().equals("")) {
	    	int point = Integer.parseInt(dto.getPrice()) / 100;
	    	memberMapper.pointEdit(point, dto.getId());
	     }else {
	    	 dto.setId(req.getParameter("email"));
	     }
	    int res = paymentMapper.insertPayment(dto);
	     return String.valueOf(res);
	}

	
	@RequestMapping(value = "getPayment.do")
	public ModelAndView getPayment(String id) {
		List<PaymentDTO> payment = paymentMapper.getPayment(id);
		
		ModelAndView mav = new ModelAndView("payment/payment_list");
		mav.addObject("payment", payment);
		return mav;
	}
	
	

}
