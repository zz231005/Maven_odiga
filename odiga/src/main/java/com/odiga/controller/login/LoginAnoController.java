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
				user.put("admin","������");
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
		
		String from="gudwls072@naver.com"; // �̸��� ������ �ּ�
		String subject="Odiga IDã�� �����Դϴ�."; // ����
		String content="������ ID:"+ id;
		
		Properties p = new Properties(); // ������ ���� ��ü
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
	    MimeMessage msg = new MimeMessage(ses); // ������ ������ ���� ��ü
	    msg.setSubject(subject); //  ����
	    StringBuffer buffer = new StringBuffer();
	    buffer.append(content);
	    Address fromAddr = new InternetAddress(from);
	    msg.setFrom(fromAddr); 
	    Address toAddr = new InternetAddress(email);
	    msg.addRecipient(Message.RecipientType.TO, toAddr); // �޴� ���
	    msg.setContent(buffer.toString(), "text/html;charset=UTF-8"); // ����   
	    Transport.send(msg); // ����  

		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value="/login_findpwdCheck.do")
	public String findpwd(String id, String email)throws MessagingException {
		int count = loginMapper.findPwd(id, email);
		if(count == 0)
			return "0";
		String from="gudwls072@naver.com"; // �̸��� ������ �ּ�
		String subject="Odiga �������� �����Դϴ�."; // ����
		int num=(int)(Math.random()*99999)+10000;
		String content="������ȣ:"+num;
		
		Properties p = new Properties(); // ������ ���� ��ü
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
	    MimeMessage msg = new MimeMessage(ses); // ������ ������ ���� ��ü 
	 
	    msg.setSubject(subject); //  ����
	 
	    StringBuffer buffer = new StringBuffer();
	    buffer.append(content);
	    Address fromAddr = new InternetAddress(from);
	    msg.setFrom(fromAddr); 
	 
	    Address toAddr = new InternetAddress(email);
	    msg.addRecipient(Message.RecipientType.TO, toAddr); // �޴� ���
	     
	    msg.setContent(buffer.toString(), "text/html;charset=UTF-8"); // ����
	    Transport.send(msg); // ����
		return String.valueOf(num);
	}
	
	
	@RequestMapping(value = "/login_updatePwdOk.do")
	public ModelAndView updatePwdOk(String update_id, String passwd1) {
		loginMapper.updatePwd(update_id, passwd1);
		return new ModelAndView("redirect:index.do");
	}
}