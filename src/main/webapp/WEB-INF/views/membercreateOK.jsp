<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int flag = (Integer)request.getAttribute( "flag" );

	out.println( "<script type='text/javascript'>" );
	if( flag == 0 ) {
		System.out.println("여기까지옴");
		out.println( "alert( '회원가입에 성공하셨습니다. 메인으로 돌아가서 다시 로그인 해주세요.' );" );
		out.println( "location.href='/';" );
	} else {
		out.println( "alert( '[서버오류] 관리자에게 문의하세요.' );" );
		out.println( "history.back();" );
	}
	out.println( "</script>" );
%>