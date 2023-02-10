<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int flag = (Integer)request.getAttribute( "flag" );

	out.println( "<script type='text/javascript'>" );
	if( flag == 0 ) {
		out.println( "alert( '글쓰기 수정이 성공적으로 완료되었습니다.' );" );
		out.println( "location.href='/';" );
	} else {
		out.println( "alert( '[서버오류] 관리자에게 문의하세요.' );" );
		out.println( "history.back();" );
	}
	out.println( "</script>" );
%>
