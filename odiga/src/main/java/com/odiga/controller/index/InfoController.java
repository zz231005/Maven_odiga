package com.odiga.controller.index;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.odiga.controller.member.SMTPAuthenticatior;
import com.odiga.dto.cart.CartDTO;
import com.odiga.dto.hotel.HotelDTO;
import com.odiga.dto.member.MemberDTO;
import com.odiga.dto.payment.PaymentDTO;
import com.odiga.mybatis.hotel.HotelMapper;
import com.odiga.mybatis.member.MemberMapper;
import com.odiga.mybatis.payment.PaymentMapper;

@Controller
public class InfoController {
	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private PaymentMapper paymentMapper;
	@Autowired
	private HotelMapper hotelMapper;
	
	
	@RequestMapping(value="/info_member.do")
	public ModelAndView memberInfo(HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException {
		ModelAndView mav=new ModelAndView("info/info_member");
		
		
		HttpSession session=req.getSession();
		HashMap<String, String> hm=(HashMap<String, String>) session.getAttribute("user");
		if(hm == null) {
			new ModelAndView("index.do");
		}
		String id=hm.get("id");
		MemberDTO info = memberMapper.getMember(id);
		
		
		IndexController index=new IndexController();
		String city=index.getCity(req.getCookies());
		index.getWeather(city, mav, resp);
		mav.addObject("points", info.getPoints());
		mav.addObject("info",info);
		mav.addObject("id", id);
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/info_update.do", method = RequestMethod.POST)
	public String updateInfo(@ModelAttribute MemberDTO dto, HttpServletRequest req) {
		HttpSession session=req.getSession();
		HashMap<String, String> hs=(HashMap<String, String>) session.getAttribute("user");
		
		hs.put("user_name", dto.getName());
		hs.put("id",dto.getId());
		HashMap<String,String> hm=new HashMap<>();
		hm.put("name", dto.getName());
		hm.put("email",dto.getEmail());
		hm.put("hp1",dto.getHp1());
		hm.put("hp2",dto.getHp2());
		hm.put("hp3",dto.getHp3());
		hm.put("passwd",dto.getPasswd());
		hm.put("id",dto.getId());
		
		int res=memberMapper.updateMember(hm);
		return String.valueOf(res);
	}
	
	@ResponseBody
	@RequestMapping(value="/info_email.do", method = RequestMethod.POST)
	public String emailUpdate(@RequestParam String email, @ModelAttribute MemberDTO dto, HttpServletRequest req) throws MessagingException{
		HttpSession session=req.getSession();
		HashMap<String, String> hs=(HashMap<String, String>) session.getAttribute("user");
		hs.put("id",dto.getId());
		
		int count = memberMapper.emailCheck(email);
		if(count > 0) {
			return "1";
		}
		
		String from="gudwls072@naver.com"; // 이메일 보내는 주소
		String subject="Odiga 메일인증 서비스입니다."; // 제목
		int num=(int)(Math.random()*90000)+10000;
		String content="인증번호:"+num;
		
		
		Properties p = new Properties(); // 정보를 담을 객체
		p.put("mail.smtp.host","smtp.naver.com");
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		
	    Authenticator auth = new SMTPAuthenticatior();
	    Session ses = Session.getInstance(p, auth);
	      
	    ses.setDebug(true);
	    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체 
	 
	    msg.setSubject(subject); //  제목
	 
	    StringBuffer buffer = new StringBuffer();
	    buffer.append(content);
	    Address fromAddr = new InternetAddress(from);
	    msg.setFrom(fromAddr); 
	 
	    Address toAddr = new InternetAddress(email);
	    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
	    msg.setContent(buffer.toString(), "text/html;charset=UTF-8"); // 내용
	    Transport.send(msg); // 전송
	    
    	HashMap<String,String> hm=new HashMap<>();
		hm.put("email",email);
		hm.put("id",dto.getId());
		int res=memberMapper.updateMember(hm);
		
		return String.valueOf(num);
	}
	
	
	@RequestMapping(value="/info_cart.do")
	public ModelAndView infoCart(HttpServletRequest req, HttpServletResponse resp){
		 ModelAndView mav=new ModelAndView("info/info_cart");
			
		 IndexController index=new IndexController();
		 String city=index.getCity(req.getCookies());
		 index.getWeather(city, mav, resp); // 날씨정보
			
			HttpSession session=req.getSession();
			HashMap<String, String> hm=(HashMap<String, String>) session.getAttribute("user");
			if(hm == null) {
				return new ModelAndView("index.do");
			}
	      String id=hm.get("id");
	      int points = memberMapper.getPoint(id);
	     mav.addObject("points", points);
	     return mav;
	}
	

	
	@RequestMapping(value="/info_schedule.do")
	public ModelAndView infoSchedule(HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException{
		ModelAndView mav=new ModelAndView("info/info_schedule");
		
		IndexController index=new IndexController();
		String city=index.getCity(req.getCookies());
		index.getWeather(city, mav, resp);
		
		HttpSession session=req.getSession();
		HashMap<String, String> hm=(HashMap<String, String>) session.getAttribute("user");
		
		if(hm == null) {
			return new ModelAndView("index.do");
		}
		String id=hm.get("id");
		 int points = memberMapper.getPoint(id);
	     mav.addObject("points", points);
		
		
		
		return mav;
	}
	
	@RequestMapping(value="/info_bcheck.do") //여기하는중 ㅇㅇ
	public ModelAndView infoScheduleb(HttpServletRequest req, int pageNum, HttpServletResponse resp) throws UnsupportedEncodingException {
		ModelAndView mav=new ModelAndView("info/info_bcheck");
		IndexController index=new IndexController();
		String city=index.getCity(req.getCookies());
		index.getWeather(city, mav, resp);
		
		HttpSession session=req.getSession();
		HashMap<String, String> hm=(HashMap<String, String>) session.getAttribute("user");
		
		if(hm == null) {
			return new ModelAndView("index.do");
		}
		String id=hm.get("id");
		int points = memberMapper.getPoint(id);
		mav.addObject("points", points);
		mav.addObject("pageNum", pageNum);
		List<PaymentDTO> b_list = paymentMapper.before(id, pageNum);
		for(PaymentDTO save : b_list) {
			HotelDTO dto = hotelMapper.getHotel(save.getHotel_num());
			save.setHotelDTO(dto);
		}
		mav.addObject("b_list", b_list);


		int count = paymentMapper.before_count(id); //
		int maxPage = count / 6;
		if(count%6 > 0) {
			maxPage++;
		}
		mav.addObject("maxPage",maxPage);
		
		return mav;
	}
	
	@RequestMapping(value="/info_ccheck.do") //여기하는중 ㅇㅇ
	public ModelAndView infoSchedulec(HttpServletRequest req, int pageNum, HttpServletResponse resp) throws UnsupportedEncodingException {
		ModelAndView mav=new ModelAndView("info/info_ccheck");
		IndexController index=new IndexController();
		String city=index.getCity(req.getCookies());
		index.getWeather(city, mav, resp);
		
		HttpSession session=req.getSession();
		HashMap<String, String> hm=(HashMap<String, String>) session.getAttribute("user");
		if(hm == null) {
			return new ModelAndView("index.do");
		}
		
		String id=hm.get("id");
		int points = memberMapper.getPoint(id);
		mav.addObject("points", points);
		mav.addObject("pageNum", pageNum);
		List<PaymentDTO> c_list = paymentMapper.schedule(id, pageNum);
		for(PaymentDTO save : c_list) {
			HotelDTO dto = hotelMapper.getHotel(save.getHotel_num());
			save.setHotelDTO(dto);
		}
		mav.addObject("c_list", c_list);
		
		int count = paymentMapper.schedule_count(id);
		int maxPage = count / 6;
		if(count%6 > 0) {
			maxPage++;
		}
		mav.addObject("maxPage",maxPage);
		
		return mav;
	}
	
	
	
	
	@RequestMapping(value="/info_cartlist.do")//여기
	public ModelAndView CartList(HttpServletRequest req, int pageNum) {
		HttpSession session=req.getSession();
		HashMap<String, String> hm=(HashMap<String, String>) session.getAttribute("user");
		if(hm == null) {
			return new ModelAndView("index.do");
		}
		
		String id=hm.get("id");
	
		ModelAndView mav=new ModelAndView("info/info_cartlist");
		
		mav.addObject("pageNum", pageNum);
		
		List<CartDTO> cart = hotelMapper.viewCart(id, pageNum);
		for(CartDTO save : cart) {
			HotelDTO dto = hotelMapper.getHotel(save.getHotel_num());
			save.setHotelDTO(dto);
		}
		mav.addObject("cart", cart);
		
		int count = hotelMapper.countCart(id);
		int maxPage = count / 6;
		if(count%6 > 0) {
			maxPage++;
		}
		mav.addObject("maxPage",maxPage);
		
		return mav;
	}
	
	
	@RequestMapping(value = "deleteSchedule.do") // 예약 삭제
	public ModelAndView deleteSchedule(HttpServletRequest req, int num) {
		System.out.println("도착");
		HttpSession session=req.getSession();
		HashMap<String, String> hm=(HashMap<String, String>) session.getAttribute("user");
		String id = "";
		if(hm == null) {
			id = req.getParameter("id");
			System.out.println(id);
			if(id.trim().equals("")) {
				return new ModelAndView("redirect:index.do");
			}
			paymentMapper.deletePay(num, id);
			return new ModelAndView("redirect:info_nonMember.do");
		}else {
			id=hm.get("id");
		}
		paymentMapper.deletePay(num, id);
		return new ModelAndView("redirect:info_schedule.do");
	}
	
	@RequestMapping(value = "/info_deletecart.do")
	public ModelAndView info_deletecart(HttpServletRequest req, int num) {
		
		HttpSession session=req.getSession();
		HashMap<String, String> hm=(HashMap<String, String>) session.getAttribute("user");
		if(hm == null) {
			return new ModelAndView("redirect:index.do");
		}
		String id=hm.get("id");
		int res = hotelMapper.deleteCart(num, id);
		
		return new ModelAndView("redirect:info_cart.do");
	}
	
	@RequestMapping(value = "/info_nonMember.do")
	public ModelAndView info_nonMember(HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView("info/info_nonMember");
		IndexController index=new IndexController();
		String city=index.getCity(req.getCookies());
		index.getWeather(city, mav, resp);
		String name = req.getParameter("name");
		if(name != null) {
			name = URLDecoder.decode(name, "UTF-8");
			String pay_mode = req.getParameter("pay_mode");
			String email = req.getParameter("email");
			int pageNum = Integer.parseInt(req.getParameter("pageNum"));
			List<PaymentDTO> non_list = paymentMapper.nonmem_getPay(name, email, pay_mode, pageNum);
			for(PaymentDTO save : non_list) {
				HotelDTO dto = hotelMapper.getHotel(save.getHotel_num());
				save.setHotelDTO(dto);
			}
			
			int count = paymentMapper.nonmem_count(name, email, pay_mode);
			int maxPage = count / 6;
			if(count%6 > 0) {
				maxPage++;
			}
			mav.addObject("name", name);
			mav.addObject("pay_mode", pay_mode);
			mav.addObject("email", email);
			mav.addObject("pageNum", pageNum);
			mav.addObject("maxPage",maxPage);
			mav.addObject("non_list", non_list);
		}
		return mav;
	}
	
	@RequestMapping(value="info_delete.do")
	public ModelAndView infoDelete(HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException{
		ModelAndView mav=new ModelAndView("info/info_delete");
		IndexController index=new IndexController();
		String city=index.getCity(req.getCookies());
		index.getWeather(city, mav, resp);
		HttpSession session=req.getSession();
		HashMap<String, String> hm=(HashMap<String, String>) session.getAttribute("user");
		if(hm == null) {
			new ModelAndView("index.do");
		}
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="info_deleteOk.do", method = RequestMethod.POST)
	public String infoDeleteOk(HttpServletRequest req, String passwd) {
		HttpSession session=req.getSession();
		HashMap<String, String> hm=(HashMap<String, String>) session.getAttribute("user");
		String id=hm.get("id");
		String check=memberMapper.isPasswd(id, passwd);
		if(check==null) {
			return "0";
		}
		int result=paymentMapper.deletePayment(check);
		int res=memberMapper.deleteMember(check);
		int respect=result+res;
		session.removeValue("user");
		return String.valueOf(respect);
	}
	
	@ResponseBody
	@RequestMapping(value="/info_inputcart.do")
	public String inputCart(int num,  String id){
		System.out.println(num + " : " +  id);
		int  check = hotelMapper.checkNum(id, String.valueOf(num));
		int res = 0;
		if(check == 0) {
			res = hotelMapper.inputCart(id, num);
		}
		return String.valueOf(res);
   }
}