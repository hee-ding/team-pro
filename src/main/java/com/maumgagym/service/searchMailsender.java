package com.maumgagym.service;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.MemberDAO;
import com.maumgagym.dto.MemberTO;

@Controller
public class searchMailsender {
	
	@Autowired
	private MemberDAO dao;
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	@RequestMapping(value = "/member/searchid"  )
	public ModelAndView searchid() {
	     
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("searchIDPage");
		
		return modelAndView;
		
	   }
	
	@PostMapping("/idsearch/mailsender")
	public ModelAndView idsearchmailok(@ModelAttribute MemberTO to,HttpServletRequest request, Model model) {
	     
		to.setEmail(request.getParameter("email"));
		to = dao.checkId(to);
		String userId = to.getId();
		
	     String toEmail= to.getEmail();
	     String toName= to.getName();
	     String subject="[마음가짐] ID 안내 이메일 입니다.";
	     String content  = "<html><head><meta charset='utf-8'></head><body>";
	       		content += "<img src='http://localhost:8080/resources/asset/images/logo_1.jpg'/>" ;
	       		content += "<br/><h2> 회원님의 ID는 [" + userId + "] 입니다. 다시 로그인을 진행해주세요. </h2></body></html>";
	        
	     mailSender(toEmail, toName, subject, content);
	     
	     model.addAttribute("userId" , userId);
	     return new ModelAndView("searchidmailOK");
		
		}
	
		public void mailSender(String toEmail, String toName, String subject, String content) { 
        
        MimeMessage mimeMessage = javaMailSender.createMimeMessage();
        
        try {
            mimeMessage.addRecipient(RecipientType.TO, new InternetAddress(toEmail, toName, "utf-8"));
            mimeMessage.setSubject(subject, "utf-8");
            mimeMessage.setText(content,"utf-8", "html");
            
            mimeMessage.setSentDate(new java.util.Date());
            
            javaMailSender.send(mimeMessage);
            
        } catch (MailException e) {
            System.out.println("[에러] : " + e.getMessage());
        } catch (UnsupportedEncodingException e) {
            System.out.println("[에러] : " + e.getMessage());
        } catch (MessagingException e) {
            System.out.println("[에러] : " + e.getMessage());
        }
		}
		
		
		@RequestMapping(value = "/member/searchpassword"  )
		public ModelAndView searchpassword() {
		     
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.setViewName("searchPasswordPage");
			
			return modelAndView;
			
		   }
		
		
		@PostMapping("/passwordsearch/mailsender")
		public ModelAndView passwordsearchmailok(@ModelAttribute MemberTO to,HttpServletRequest request, Model model) {
		     
			to.setEmail(request.getParameter("email"));
			to = dao.getTemporaryPassword(to);
			String temporaryPW = to.getTemporaryPW();
			
		     String toEmail= to.getEmail();
		     String toName= to.getName();
		     String subject="[마음가짐] 임시비밀번호 안내 이메일 입니다.";
		     String content  = "<html><head><meta charset='utf-8'></head><body>";
		       		content += "<img src='http://localhost:8080/resources/asset/images/logo_1.jpg'/><br/>" ;
		       		content += "<h2> 임시비밀번호는 : [" + temporaryPW + "] 입니다. 입니다. \"";
		       		content += "마이페이지에서 비밀번호 수정을 진행해주세요. </h2> </body></html>";
		        
		     mailSenderPW(toEmail, toName, subject, content);
		     
		     model.addAttribute("temporaryPW" , temporaryPW);
		     return new ModelAndView("searchpasswordmailOK");
			
			}
		
			public void mailSenderPW(String toEmail, String toName, String subject, String content) { 
	        
	        MimeMessage mimeMessage = javaMailSender.createMimeMessage();
	        
	        try {
	            mimeMessage.addRecipient(RecipientType.TO, new InternetAddress(toEmail, toName, "utf-8"));
	            mimeMessage.setSubject(subject, "utf-8");
	            mimeMessage.setText(content,"utf-8", "html");
	            
	            mimeMessage.setSentDate(new java.util.Date());
	            
	            javaMailSender.send(mimeMessage);
	            
	            System.out.println("전송이 완료되었습니다.");
	        } catch (MailException e) {
	            System.out.println("[에러] : " + e.getMessage());
	        } catch (UnsupportedEncodingException e) {
	            System.out.println("[에러] : " + e.getMessage());
	        } catch (MessagingException e) {
	            System.out.println("[에러] : " + e.getMessage());
	        }
			}
	
	}
