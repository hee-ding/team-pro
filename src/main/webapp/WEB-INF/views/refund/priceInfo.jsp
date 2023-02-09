<%@page import="com.to.board.MemberShipTO"%>
<%@page import="com.to.pay.PayTO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.SQLException"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding( "utf-8" );	

	// post로 온 요청을 받기
	String merchantUid = request.getParameter( "merchant_uid" );
	int price = 0;
	
 	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// flag가 0 이면 정상
	// flag가 1 이면 서버 오류
	int flag = 1;
	
 	try {
		
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
		DataSource dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
		
		conn = dataSource.getConnection();
		
		String sql = "SELECT ms.price FROM pay p LEFT OUTER JOIN membership ms ON ( p.membership_seq = ms.seq ) WHERE p.merchant_uid = ? ";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, merchantUid );
		
		rs = pstmt.executeQuery();
		
		MemberShipTO msto = new MemberShipTO();
		
		if( rs.next() ) {
			
			flag = 0;
			msto.setMembership_price( rs.getInt( "ms.price" ));
			price = msto.getMembership_price();
			
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
 	
 	obj.put( "flag", flag );
 	obj.put( "price", price );
 	
 	out.println( obj );
			
	
	
%>