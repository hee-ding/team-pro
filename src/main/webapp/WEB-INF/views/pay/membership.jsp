<%@page import="com.to.pay.PayTO"%>
<%@page import="java.util.UUID"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.to.board.MemberShipTO"%>
<%@page import="com.to.member.MemberTO"%>
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
    
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>



<%

	request.setCharacterEncoding( "utf-8" );

	String buyerNickname = request.getParameter("buyer_nickname");
	String membershipSeq = request.getParameter("membership_seq");
	
	//System.out.println( buyerNickname );
	//System.out.println( membershipSeq );
	
 	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	
	// flag가 0 이면 정상
	// flag가 1 이면 서버 오류
	// flag가 2 이면 아이디 또는 세션 오류
	// flag가 3 이면 회원권 오류
	int flag = 1;
	
	MemberTO mto = null;
	MemberShipTO msto = null;
	PayTO payto = null;
	
	
	
 	try {
		
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
		DataSource dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
		
		conn = dataSource.getConnection();
		
		// 주문서에 작성할 사용자 정보 쿼리
		String sql = "SELECT m.seq, m.email, m.NAME, m.phone, m.fulladdress, m.zipcode FROM member m WHERE nickname = ?";
				
				
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, buyerNickname );
		
		rs = pstmt.executeQuery();
		
		mto = new MemberTO();
		
		if( rs.next()) {
			
			// 정상 
			flag = 0;
			
			mto.setSeq( rs.getInt("m.seq") );
			mto.setEmail( rs.getString("m.email") );
			mto.setName( rs.getString("m.NAME") );
			mto.setPhone( rs.getString("m.phone") );
			mto.setFullAddress( rs.getString("m.fulladdress") );
			mto.setZipcode( rs.getString("m.zipcode") );
			
		} else {
			// DB에 매칭되는 정보가 없다는 의미 => 세션 또는 아이디 오류
			flag = 2;
		}
		
		
		// 구매하고자 하는 회원권 정보 가져오기
		
		sql = "SELECT ms.NAME, ms.price FROM membership ms " +
				"WHERE seq = ?";
		
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, membershipSeq );

		rs = pstmt.executeQuery();
		
		msto = new MemberShipTO();
		
		if( rs.next()) {
			
			// 정상 
			flag = 0;
			msto.setMembership_name( rs.getString("ms.name") );
			msto.setMembership_price( rs.getInt("ms.price") );
			
			
		} else {
			
			// DB에 매칭되는 정보가 없다는 의미 => 회원권 번호 오류
			flag = 3;
			
		}
		
		
		// 주문번호 생성 후 set 
		payto = new PayTO();
		payto.setMerchant_uid( "merchant_" + UUID.randomUUID().toString() );
		
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
		
		obj.put( "merchant_uid", payto.getMerchant_uid() );
		
		obj.put( "name", msto.getMembership_name() );
		
		obj.put( "amount", msto.getMembership_price() );
		
		obj.put( "buyer_seq", mto.getSeq() );
		
		obj.put( "buyer_email", mto.getEmail() );
		
		obj.put( "buyer_name", mto.getName() );
		
		obj.put( "buyer_phone", mto.getPhone());
		
		obj.put( "buyer_addr", mto.getFullAddress() );
		
		obj.put( "buyer_postcode", mto.getZipcode());
		
		out.println( obj );
%> 
