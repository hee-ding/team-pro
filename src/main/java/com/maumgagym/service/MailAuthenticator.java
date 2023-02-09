package com.maumgagym.service;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MailAuthenticator extends Authenticator {

	
	private String fromEmail;
	private String fromPassword;
	
	//매개변수가 있는 생성자 만들기
	public MailAuthenticator(String fromEmail, String fromPassword) {
		this.fromEmail = fromEmail;
		this.fromPassword = fromPassword;
	}
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication(fromEmail, fromPassword);
	}
}
