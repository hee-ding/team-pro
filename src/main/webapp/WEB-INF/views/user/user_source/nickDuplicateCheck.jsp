<%@page import="java.sql.ResultSet"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.SQLException"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
		
	request.setCharacterEncoding( "utf-8" );

	String nickname	= request.getParameter( "nickname" );
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// flag가 0 이면 정상
	// flag가 1 이면 중복
	// flag가 2 이면 서버 오류
	int flag = 2;
	
	try {
		
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
		DataSource dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
		
		conn = dataSource.getConnection();
		
		String sql = "select nickname from member where nickname = ?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, nickname );
		
		rs = pstmt.executeQuery();
		
		if( rs.next() ) {
			
			flag = 1;
			
		} else {
			
			flag = 0;
			
		}
		
		} catch( NamingException e) {
			System.out.println( e.getMessage());
		} catch( SQLException e) {
			System.out.println( e.getMessage());
		} finally {
			if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if( conn != null) try {conn.close();} catch(SQLException e) {}
			if( rs != null) try {rs.close();} catch(SQLException e) {}
		}
	 	
	 	JSONObject obj = new JSONObject();
	 	
	 	obj.put( "flag", flag);
	 	
	 	out.println( obj );

%>