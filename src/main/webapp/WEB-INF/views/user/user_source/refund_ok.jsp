<%@page import="com.to.board.MemberShipTO"%>
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

	String merchantUid	= request.getParameter( "merchant_uid" );
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// flag가 0 이면 정상
	// flag가 1 이면 pay 테이블 update 오류
	// flag가 2 이면 register 테이블 update 오류
	// flag가 3 이면 서버 오류
	int flag = 3;
	
	try {
		
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
		DataSource dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
		
		conn = dataSource.getConnection();
		
		// pay 테이블에서 환불로 변경
		String sql = "update pay SET status = 2 where merchant_uid = ? ";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, merchantUid );
		
		if( pstmt.executeUpdate() == 1) {
			flag = 0;
			
				sql = "update membership_register SET status = 5 where merchant_uid = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, merchantUid );
				
				if( pstmt.executeUpdate() == 1) {
					flag = 0;
				} else {
					flag = 2;
				}
			
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
			if( rs != null) try {rs.close();} catch(SQLException e) {}
		}
	 	
	 	JSONObject obj = new JSONObject();
	 	
	 	obj.put( "flag", flag);
	 	
	 	out.println( obj );

%>