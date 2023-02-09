<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userID = null;
	if( session.getAttribute("userID") != null ) {
		userID = ( String ) session.getAttribute("userID");
	} else {
		userID = "tester1";
	}
%>    
<jsp:include page="./manager/managerMember.jsp">
	<jsp:param name="userID" value="<%= userID %>"/>
</jsp:include>