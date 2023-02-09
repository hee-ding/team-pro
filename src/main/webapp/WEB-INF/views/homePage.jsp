<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%
	String id = null;
	String type = null;

	if( session.getAttribute("id") != null ) {
		id = ( String ) session.getAttribute("id");
	}
	
%>    
<jsp:include page="./main/main.jsp">
	<jsp:param name="id" value="<%= id %>"/>
</jsp:include>