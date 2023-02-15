<%@page import="com.maumgagym.dto.MemberShipTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.maumgagym.dto.MemberTO"%>
<%@page import="com.maumgagym.dao.FacilityDAO"%>
<%@page import="com.maumgagym.dto.BoardTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (Integer)request.getAttribute( "flag" );
	int board_seq = (Integer)request.getAttribute( "board_seq" );

	System.out.println( "writeOk flag : " + flag );
	System.out.println( "writeOk board_seq : " + board_seq );
	
	
	
	out.println( "<script type='text/javascript'>" );
	
	if( flag == 0 ) {
		out.println( "alert('글쓰기에 성공했습니다.');");
		out.println( "location.href='/facility/" + board_seq + "';" );
	} else {
		out.println( "alert('글쓰기에 실패했습니다.');" );
		out.println( "history.back();" );
	}
	out.println( "</script>" );

%>
