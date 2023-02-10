<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	/*
	String id = null;

	if( session.getAttribute("id") != null ) {
		id = ( String ) session.getAttribute("id");
	}
	*/
	
	String id = "id1";
	
%> 
<jsp:include page="./community/community_list.jsp">
	<jsp:param name="id" value="<%= id %>"/>
</jsp:include>