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
	to = dao.getTemporaryPassword(to);
	String temporaryPW = to.getTemporaryPW();
	
	if ( temporaryPW != null){
		String toEmail = to.getEmail();
		String toName = to.getName();
		String subject =  "[마음가짐] 임시비밀번호 안내 이메일 입니다.";
		String content =  "<html><head><meta charset='utf-8'></head><body>";
			   content += "<img src='http://localhost:8080/Maumgagym/resources/asset/images/logo_1.jpg'/>" ;
			   content += "<br/><h2> 임시비밀번호는" + temporaryPW + "입니다.마이페이지에서 비밀번호 수정을 진행해주세요. </h2></body></html>";
		
		MailSender mailSender = new MailSender();
		mailSender.sendManil(toEmail, toName, subject, content);
		
		System.out.println("메일이 전송되었습니다.");
		
		script.println("<script>");
		script.println("alert('임시비밀번호를 메일에서 확인해주세요.')");
		script.println("location.href='/Maumgagym/homePage.jsp'");
		script.println("</script>");
		
	} else { //오류
		script.println("<script>");
		script.println("alert('관리자에게 문의하세요.')");
		script.println("</script>");
	}
	
%>

</body>
</html>
