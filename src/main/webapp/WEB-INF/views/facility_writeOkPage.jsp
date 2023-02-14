<%@page import="com.maumgagym.dto.MemberShipTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.maumgagym.dto.MemberTO"%>
<%@page import="com.maumgagym.dao.FacilityDAO"%>
<%@page import="com.maumgagym.dto.BoardTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (Integer)request.getAttribute( "flag" );
		//System.out.println( flag );
	BoardTO bto = new BoardTO();
	FacilityDAO dao = new FacilityDAO();
	MemberShipTO msto = new MemberShipTO();
	ArrayList<BoardTO> arry = new ArrayList<>();
	dao.insertfacilityBoard(bto);
	dao.insertfacilityImage(bto);
	dao.insertfacilityMembership(bto, msto);
	int seq = bto.getSeq();
	System.out.println( "writeOk seq : " + seq );
	out.println( "<script type='text/javascript'>" );
	if( flag == 0 ) {
		out.println( "alert('글쓰기에 성공했습니다.');");
		out.println( "location.href='/facility/" + seq + "';" );
	} else {
		out.println( "alert('글쓰기에 실패했습니다.');" );
		out.println( "history.back();" );
	}
	out.println( "</script>" );

%>
