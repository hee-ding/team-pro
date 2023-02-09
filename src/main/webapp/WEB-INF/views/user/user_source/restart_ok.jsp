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
	int registerSeq = 0;
	String holdDate = null;
	String holdSumDate = null;
	String expiryDate = null;
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// flag 0 정상
	// flag 1 register select 오류
	// flag 2 holdDate select 오류
	// flag 3 membershipHold update 오류
	// flag 4 holdSum select 오류
	// flag 5 재개 정보 update 오류
	// flag 6 서버 오류
	int flag = 6;
	
	try {
		
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
		DataSource dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
		
		conn = dataSource.getConnection();
		
		// 1. register의 seq(번호) 가져오기
		String sql = "select seq, expiry_date from membership_register where merchant_uid = ?";
			
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, merchantUid );
		
		rs = pstmt.executeQuery();
		
		PayTO pto = new PayTO();
		
		if( rs.next() ) {
			
			flag = 0;
			
			pto.setMembership_register_seq( rs.getInt("seq") );
			registerSeq = pto.getMembership_register_seq();
			
			pto.setMembership_expiry_date( rs.getString("expiry_date") );
			expiryDate = pto.getMembership_expiry_date();
			
				// 2. 홀드한 날짜 가져오기
				sql = "select hold_date from membership_hold where register_seq = ?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, registerSeq );
				
				rs = pstmt.executeQuery();
				
				if( rs.next() ) {
					
					flag = 0;
					
					pto.setHold_date( rs.getString( "hold_date") );
					holdDate = pto.getHold_date();
					
						// 3. membership_hold 테이블 변경하기
						sql = "update membership_hold SET hold_end_date = NOW(), hold_sum_date = TIMESTAMPDIFF(DAY, ?, now() ) where register_seq = ? ";
						
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, holdDate );
						pstmt.setInt(2, registerSeq );
						
						if( pstmt.executeUpdate() == 1) {
							flag = 0;
							
							// 4. membership_hold 테이블에서 정보 가져오기	
					 		sql = "SELECT hold_sum_date FROM membership_hold WHERE register_seq = ? ";
					 		
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, registerSeq );
							
							rs = pstmt.executeQuery();
							
							if( rs.next() ) {
								
								flag = 0;
								pto.setHold_sum_date( rs.getString( "hold_sum_date" ) );
								holdSumDate = pto.getHold_sum_date();
								
									// 5. membership_register 테이블에 재개내용 반영하기
									sql = "update membership_register SET expiry_date = date_add( ?, INTERVAL ? DAY ), status = 2 where merchant_uid = ? ";
									
									pstmt = conn.prepareStatement(sql);
									pstmt.setString(1, expiryDate );
									pstmt.setString(2, holdSumDate );
									pstmt.setString(3, merchantUid );
									
									if( pstmt.executeUpdate() == 1) {
										flag = 0;
										
									} else {
										
										flag = 5;
									}
								
								
							} else {
								
								flag = 4;
							}
							
							
						} else {
							flag = 1;
						}
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