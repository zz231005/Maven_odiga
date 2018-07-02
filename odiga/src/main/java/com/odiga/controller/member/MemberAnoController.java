package com.odiga.controller.member;

import java.util.Properties;
// ������� �̸��� import

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.odiga.dto.member.MemberDTO;
import com.odiga.mybatis.member.MemberMapper;

@Controller
public class MemberAnoController {
	
	@Autowired
	private MemberMapper memberMapper;
	
	@RequestMapping(value="/member_input.do", method = RequestMethod.POST)
	public ModelAndView insertMember(@ModelAttribute MemberDTO dto) {
		dto.setEmail(dto.getEmail1(), dto.getEmail2());
		int res=memberMapper.insertMember(dto);
		
		ModelAndView mav=new ModelAndView("member/message");
		String msg, url = "index.do";
		if(res >0) {
			msg = "ȸ������ ó���� �Ϸ�Ǿ����ϴ�.";
		}else {
			msg = "ȸ������ ó���� �Ϸ���� �ʾҽ��ϴ�. �ٽ� Ȯ�� �� �̿��Ź�帳�ϴ�.";
		}
		mav.addObject("msg", msg);
		mav.addObject("url", url);
		return mav;
	}
	
	
	
	@ResponseBody
	@RequestMapping(value="/member_check.do" , method = RequestMethod.POST)
	public String checkMember(String id) {
        int count = memberMapper.idCheck(id);
        return String.valueOf(count);
	}
	
	@ResponseBody
	@RequestMapping(value = "/member_email_check.do", method = RequestMethod.POST)
	public String checkEmailMember(String email) {
		int count = memberMapper.emailCheck(email);
		return String.valueOf(count);
	}
	
	@ResponseBody
	@RequestMapping(value="/member_email.do", method = RequestMethod.POST)
	public String sendEmail(String email1, String email2)throws MessagingException  {
		String email = email1+"@"+email2;
		int count = memberMapper.emailCheck(email);
		if(count > 0) {
			return "1";
		}
		
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
}