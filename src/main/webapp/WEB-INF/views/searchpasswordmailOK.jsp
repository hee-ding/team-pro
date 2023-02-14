<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	String temporaryPW = (String)request.getAttribute("temporaryPW");

	if( temporaryPW != null  ) {
		out.println("<script>");
		out.println("alert('임시비밀번호를 메일에서 확인해주세요.')");
		out.println("location.href='/home';");
		out.println("</script>");
	} 
	else {
		out.println("<script>");
		out.println("alert('관리자에게 문의하세요.')");
		out.println( "history.back();" );
		out.println("</script>");
	}
	
%>
</body>
</html>