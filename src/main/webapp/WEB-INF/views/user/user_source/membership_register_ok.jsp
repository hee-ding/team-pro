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

	String merchantUid	= request.getParameter( "merchant_uid" );
	
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	// flag가 0 이면 정상
	// flag가 1 이면 서버 오류
	int flag = 1;
	
	try {
		
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
		DataSource dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
		
		conn = dataSource.getConnection();
		
		String sql = "insert into membership_register (seq, status, merchant_uid ) values ( 0, 1, ? ) ";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, merchantUid );
		
		if( pstmt.executeUpdate() == 1) {
			flag = 0;
		} else {
			flag = 1;
		}
		
		} catch( NamingException e) {
			System.out.println( e.getMessage());
		} catch( SQLException e) {
			System.out.println( e.getMessage());
		} finally {
			if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if( conn != null) try {conn.close();} catch(SQLException e) {}
		}
	 	
	 	JSONObject obj = new JSONObject();
	 	
	 	obj.put( "flag", flag);
	 	
	 	out.println( obj );

%>