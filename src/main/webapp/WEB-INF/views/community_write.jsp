<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String id = null;

	if( session.getAttribute("id") != null ) {
		id = ( String ) session.getAttribute("id");
	}
	
	String nickname = null;

	if( session.getAttribute("nickname") != null ) {
		nickname = ( String ) session.getAttribute("nickname");
	}
	
	
%> 

<jsp:include page="./community/community_write.jsp">
	<jsp:param name="nickname" value="<%= nickname %>"/>
</jsp:include>