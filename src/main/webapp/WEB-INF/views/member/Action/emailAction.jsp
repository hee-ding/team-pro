<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="com.send.mail.MailSender"%>
<%@page import="com.dao.member.MemberDAO"%>
<%@page import="com.to.member.MemberTO"%>
<%@page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("utf-8");
	
	MemberTO to = new MemberTO();
	to.setEmail(request.getParameter("email")); 
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<% 
	PrintWriter script = response.getWriter();
	MemberDAO dao = new MemberDAO();
	to = dao.checkId(to);
	String userId = to.getId();
	String temporaryPW = to.getTemporaryPW();
	
	if( userId != null  ) {
		String toEmail = to.getEmail();
		String toName = to.getName();
		String subject  = "[마음가짐] ID 안내 이메일 입니다.";
		String content  = "<html><head><meta charset='utf-8'></head><body>";
		       content += "<img src='http://localhost:8080/Maumgagym/resources/asset/images/logo_1.jpg'/>" ;
		       content += "<br/><h2> 회원님의 ID는 " + userId + "입니다. 다시 로그인을 진행해주세요. </h2></body></html>";
		   
		MailSender mailSender = new MailSender();
		mailSender.sendManil(toEmail, toName, subject, content);
		
		System.out.println("메일이 전송되었습니다.");
		
		script.println("<script>");
		script.println("alert('id 확인이 완료되었습니다. 이메일을 확인 후 다시 로그인 해주세요.')");
		script.println("location.href='/Maumgagym/homePage.jsp'");
		script.println("</script>");
		
	} 
	
	
	else if ( temporaryPW != null){
		String toEmail = to.getEmail();
		String toName = to.getName();
		String subject = "[마음가짐] 임시비밀번호 안내 이메일 입니다.";
		String content = "<html><head><meta charset='utf-8'></head><body><img src='http://localhost:8080/Maumgagym/resources/asset/images/logo_1.jpg'/><br/><h2> 임시비밀번호는 : <input type='text', value='temporaryPW'/> 입니다. 마이페이지에서 비밀번호 수정을 진행해주세요. </h2> </body></html>";
		
		MailSender mailSender = new MailSender();
		mailSender.sendManil(toEmail, toName, subject, content);
		
		System.out.println("메일이 전송되었습니다.");
		
		script.println("<script>");
		script.println("alert('임시비밀번호를 메일에서 확인해주세요.')");
		script.println("location.href='/Maumgagym/homePage.jsp'");
		script.println("</script>");
		
	} else {
		script.println("<script>");
		script.println("alert('관리자에게 문의하세요.')");
		script.println("</script>");
	}
	
%>

</body>
</html>
