package com.maumgagym.service;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSender {
	
	private String fromEmail;
	private String fromPassword;

	public MailSender() {
		this.fromEmail = "01058190222a@gmail.com";
		this.fromPassword = "qansmbjjfhptuado";
	}

	public static void main(String[] args) {
		// 받을 사람 이메일
		String toEmail = "이메일";
		// 받을 사람 이름
		String toName = "테스터";
		// 보낼 제목
		String subject = "테스트 제목";
		// 보낼 내용
		String content = "<html><head><meta charset='utf-8'><style type = 'text/css'>body {color : red;}</style></head><body style='color:blue'>내용 테스트</body></html>";
		
		MailSender mailSender = new MailSender();
		mailSender.sendManil(toEmail, toName, subject, content);
		
		System.out.println("메일이 전송되었습니다.");
		
	}
	
	public void sendManil(String toEmail, String toName, String subject, String content) {
		try {
			//HashMap 과 유사한 맵계열 collection
			// 연결환경 설정
			Properties props = new Properties();
			
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");
			props.put("mail.smtp.auth", "true");
			
			props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
			props.put("mail.smtp.ssl.protocols", "TLSv1.2");
			
			MailAuthenticator authenticator = new MailAuthenticator(fromEmail, fromPassword);
			// 세션 = 연결정보
			Session session = Session.getInstance(props, authenticator);
			
			// 메시지 내용설정
			MimeMessage msg = new MimeMessage(session);
			// 메시지 헤더 : 문서형태
			msg.setHeader("Content-Type", "text/html; charset=utf-8");
			// 받는 사람 정보
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail, toName, "utf-8"));
			// 제목글
			msg.setSubject(subject);
			msg.setContent(content,"text/html; charset=utf-8");
			
			msg.setSentDate(new java.util.Date()); 
			
			Transport.send(msg);
		} catch (UnsupportedEncodingException e) {
			System.out.println("[에러]" + e.getMessage());
		} catch (MessagingException e) {
			System.out.println("[에러]" + e.getMessage());
		}
	}
}