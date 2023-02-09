<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="com.dao.member.MemberDAO"%>
<%@page import="com.to.member.MemberTO"%>
<%@page import = "java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");

	String userid = request.getParameter("id");
	String password = request.getParameter("password");
	
	MemberTO to = new MemberTO();
	to.setId(userid);
	to.setPassword(password);

	String id = null;
	
	if( session.getAttribute("id") != null ) {
		id = ( String ) session.getAttribute("id");
	}
	if ( id != null ) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인 되어있습니다.')");
		script.println("location.href='/Maumgagym/homePage.jsp'");
		script.println("</script>");
	}
	
	MemberDAO dao = new MemberDAO();
	to = dao.login( to );
	if( to.getFlag() == 1 ) {
		session.setAttribute("id", to.getId() );
		session.setAttribute("type", to.getType() );
		session.setAttribute("nickname", to.getNickname() );
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='/Maumgagym/homePage.jsp'");
		script.println("</script>");
	} 
	else if ( to.getFlag() == 0 ) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()");
		script.println("</script>");
	} 
	else if ( to.getFlag() == -1 ) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.')");
		script.println("history.back()");
		script.println("</script>");
	} 
	else if ( to.getFlag() == -2 ) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('테이터베이스 오류 발생')");
		script.println("history.back()");
		script.println("</script>");
		}
%>