package com.odiga.controller.login;

import java.util.HashMap;
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
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.odiga.controller.member.SMTPAuthenticatior;
import com.odiga.mybatis.login.LoginMapper;


@Controller
public class LoginAnoController {
	@Autowired
	private LoginMapper loginMapper;
	
	@ResponseBody
	@RequestMapping(value="/login_ok.do")
	public String memberCheck(String id, String passwd, HttpServletRequest req) {
		String name = loginMapper.loginCheck(id, passwd);
		if(name !=null) {
			HttpSession session =  req.getSession();
			HashMap<String, String> user = new HashMap<>();
			user.put("user_name", name);
			user.put("id", id);
			session.setAttribute("user", user);
			if(id.equals("admin")) {
				user.put("admin","관리자");
			}
			return "1";
		}else {
			return "0";
		}
	}
	
	@RequestMapping(value = "/logout.do")
	public ModelAndView logout(HttpServletRequest req) {
		HttpSession session = req.getSession();
		session.removeAttribute("user");
		return new ModelAndView("redirect:index.do");
	}
	
	
	@ResponseBody
	@RequestMapping(value="/login_findIdCheck.do")
	public String findIdOk(String name, String email) throws MessagingException{
		
		String id = loginMapper.findId(name, email);

		if(id == null)
			return "0";
		
		String from="gudwls072@naver.com"; // 이메일 보내는 주소
		String subject="Odiga ID찾기 서비스입니다."; // 제목
		String content="가입한 ID:"+ id;
		
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

		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value="/login_findpwdCheck.do")
	public String findpwd(String id, String email)throws MessagingException {
		int count = loginMapper.findPwd(id, email);
		if(count == 0)
			return "0";
		String from="gudwls072@naver.com"; // 이메일 보내는 주소
		String subject="Odiga 메일인증 서비스입니다."; // 제목
		int num=(int)(Math.random()*99999)+10000;
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
		return String.valueOf(num);
	}
	
	
	@RequestMapping(value = "/login_updatePwdOk.do")
	public ModelAndView updatePwdOk(String update_id, String passwd1) {
		loginMapper.updatePwd(update_id, passwd1);
		return new ModelAndView("redirect:index.do");
	}
}