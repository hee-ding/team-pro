<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.io.PrintWriter"%>
<%@page import="com.dao.member.MemberDAO"%>
<%@page import="com.to.member.MemberTO"%>

<%
	request.setCharacterEncoding("utf-8");
	
	MemberTO to = new MemberTO();
	to.setNickname(request.getParameter("nickName")); 
	to.setId(request.getParameter("id")); 
	to.setPassword(request.getParameter("password")); 
	to.setName(request.getParameter("name")); 
	to.setMail1(request.getParameter("mail1")); 
	to.setMail2(request.getParameter("mail2"));
	to.setType(request.getParameter("type"));
	to.setBirthyy(request.getParameter("year"));
	to.setBirthmm(request.getParameter("month"));
	to.setBirthdd(request.getParameter("day"));
	to.setZipcode(request.getParameter("zipcode"));
	to.setAddress(request.getParameter("address"));
	to.setReferAddress(request.getParameter("referAddress"));
	to.setFullAddress(request.getParameter("fullAddress"));
	
	MemberDAO dao = new MemberDAO();
	int flag = dao.join(to);

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

	if( flag == 0 ) {
		script.println("<script>");
		script.println("alert('회원가입이 완료되었습니다. 다시 로그인 해주세요! ')");
		script.println("location.href='/Maumgagym/homePage.jsp'");
		script.println("</script>");
	}
%>

		

</body>
</html>
