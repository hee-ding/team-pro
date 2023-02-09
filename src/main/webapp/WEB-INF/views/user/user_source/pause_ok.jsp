<%@page import="com.to.pay.PayTO"%>
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
	
	//System.out.println( merchantUid );
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// flag가 0 이면 정상
	// flag가 1 이면 홀딩 1회 초과
	// flag가 2 이면 서버 오류
	int flag = 2;
	
	try {
		
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
		DataSource dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
		
		conn = dataSource.getConnection();
		
		// 이전에 홀딩을 사용 했는지 확인
 		String sql = "SELECT msh.register_seq FROM membership_hold msh INNER JOIN membership_register msr ON( msh.register_seq = msr.seq ) WHERE msr.merchant_uid = ? ";
 		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, merchantUid );
		
		rs = pstmt.executeQuery();
		
		PayTO pto = new PayTO();
		
		// 결과가 나온다면 이전에 홀딩을 사용.
		if( rs.next() ) {
			
			flag = 1;
			
			
		} else { 
			
			flag = 0;
			
			sql = "select seq from membership_register where merchant_uid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, merchantUid );
			
			rs = pstmt.executeQuery();
			
			if( rs.next() ) {
				
				flag = 0;
				
				pto.setMembership_register_seq( rs.getInt("seq") );
				
				sql = "insert into membership_hold ( seq, hold_date, register_seq ) value ( 0, now(), ?) ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pto.getMembership_register_seq() );
				
				if( pstmt.executeUpdate() == 1) {
					
					flag = 0;
					
					sql = "update membership_register SET status = 3 where merchant_uid = ? ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, merchantUid );
					
					if( pstmt.executeUpdate() == 1) {
						flag = 0;
					} else {
						flag = 1;
					}
					
				}
			}
		
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