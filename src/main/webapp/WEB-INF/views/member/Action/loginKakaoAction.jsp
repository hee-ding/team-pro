<%@page import="com.to.member.MemberTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.dao.member.loginTestDAO"%>
    
<%
	request.setCharacterEncoding("utf-8");

	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	MemberTO to = new MemberTO();
	to.setNickname(request.getParameter("name")); 
	to.setEmail(request.getParameter("email")); 

	loginTestDAO dao = new loginTestDAO();
	int flag = dao.writeUser(to);
	
	if(flag == 0 ) {
		
		session.setAttribute("id", to.getNickname()); //메인페이지로 가기전에 session 설정을 해줘야 한다.
		session.setAttribute("type", "m"); //메인페이지로 가기전에 session 설정을 해줘야 한다.
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 되었습니다.')");
		script.println("location.href='/Maumgagym/homePage.jsp'");
		script.println("</script>");
		
	} 
%>