<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.dao.member.MemberDAO"%>
<%@ page import="com.to.member.MemberTO"%>
<%@ page import ="java.io.PrintWriter" %>

<jsp:useBean id="member" class="com.to.member.MemberTO" scope="page"/>

<jsp:setProperty name="member" property="nickname"/>
<jsp:setProperty name="member" property="id"/>
<jsp:setProperty name="member" property="password"/>
<jsp:setProperty name="member" property="name"/>
<jsp:setProperty name="member" property="email"/>
<jsp:setProperty name="member" property="birthday"/>

<%
	request.setCharacterEncoding("UTF-8");

	if(member.getNickname() == null || member.getId() == null || member.getPassword() == null ) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else {
			MemberDAO dao = new MemberDAO();
			int result = dao.join(member);
			
			if(result == -1 ) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 아이디 입니다.')");
		script.println("history.back()");
		script.println("</script>");
			} //db에 정보가 저장된 후 바로 로그인페이지로 이동
			else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='/Maumgagym/homePage.jsp'");
		script.println("</script>");
			} 
		}
%>