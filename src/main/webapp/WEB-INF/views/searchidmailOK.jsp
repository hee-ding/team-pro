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
	String userId = (String)request.getAttribute("userId");

	if( userId != null  ) {
		
		out.println("<script>");
		out.println("alert('id 확인이 완료되었습니다. 이메일을 확인 후 다시 로그인 해주세요.')");
		out.println("location.href='/home';");
		out.println("</script>");
	}  else {
		out.println("<script>");
		out.println("alert('관리자에게 문의하세요.')");
		out.println( "history.back();" );
		out.println("</script>");
	}
	
%>
</body>
</html>