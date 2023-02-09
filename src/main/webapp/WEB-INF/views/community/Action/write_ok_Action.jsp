<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.to.member.MemberTO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
    
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="com.to.board.CommunityDAO"%>
<%@page import="com.to.board.BoardTO"%>
    
<%

	request.setCharacterEncoding("utf-8");
	
	BoardTO to = new BoardTO();
	
	//String title =(String)request.getParameter("subject");
	System.out.println((String)request.getParameter("subject")); //출력성공
	
	to.setTitle(request.getParameter("subject"));
	to.setContent(request.getParameter("contents"));
	
	int category_seq = Integer.parseInt(request.getParameter("category_seq"));
	to.setCategory_seq(category_seq); //가져오기 성공
	
	MemberTO to1 = new MemberTO();
	to1.setNickname(request.getParameter("writer"));
	
	CommunityDAO dao = new CommunityDAO();
	int flag = dao.boardWriteOK(to1,to);
	
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
		script.println("alert('글쓰기가 성공적으로 완료되었습니다.')");
		script.println("location.href='/Maumgagym/communityPage.jsp'");
		script.println("</script>");
	}else {
		script.println("<script>");
		script.println("alert('서버 오류')");
		script.println("history.back()");
		script.println("</script>");
	}
%>

		

</body>
</html>
