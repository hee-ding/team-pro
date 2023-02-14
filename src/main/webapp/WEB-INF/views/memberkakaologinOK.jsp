<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="com.maumgagym.dto.MemberTO"%>
    
<%	
	int flag = (Integer)request.getAttribute( "flag" );

	if(flag == 0 ) {
		
		//session.setAttribute("id", to.getNickname()); //메인페이지로 가기전에 session 설정을 해줘야 한다.
		//session.setAttribute("type", "m"); //메인페이지로 가기전에 session 설정을 해줘야 한다.
		
		out.println("<script>");
		out.println("alert('로그인 되었습니다.')");
		out.println("location.href='/home';");
		out.println("</script>");
		
	}else {
		out.println("<script>");
		out.println("alert('[서버오류] 관리자에게 문의하세요.')");
		out.println("location.href='/home';");
		out.println("</script>");
	} 
	
%>