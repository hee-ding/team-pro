package com.maumgagym.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.maumgagym.dto.BoardTO;
import com.maumgagym.dto.MemberShipTO;
import com.maumgagym.dto.MemberTO;
import com.maumgagym.dto.PayTO;
import com.maumgagym.dto.ReviewTO;

@Repository
public class PayDAO {
	
	@Autowired
	private DataSource dataSource;
	
	public PayDAO() {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
			this.dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
		} catch (NamingException e) {
			System.out.println( "[에러] " + e.getMessage() ); 
		}
	}
	
	public MemberTO selectMember( MemberTO mto ) {
		mto.setFlag(9);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		try {
		conn = this.dataSource.getConnection();
		String sql = "SELECT m.seq, m.email, m.NAME, m.phone, m.fulladdress, m.zipcode FROM member m WHERE nickname = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mto.getNickname() );
		rs = pstmt.executeQuery();
		if( rs.next()) {
			mto.setFlag(0);
			mto.setSeq( rs.getInt("m.seq") );
			mto.setEmail( rs.getString("m.email") );
			mto.setName( rs.getString("m.NAME") );
			mto.setPhone( rs.getString("m.phone") );
			mto.setFullAddress( rs.getString("m.fulladdress") );
			mto.setZipcode( rs.getString("m.zipcode") );
		} else { mto.setFlag(8); }
		}catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		return mto;
	}
	
	public MemberShipTO selectPurchaseMembership( MemberShipTO msto ) {
		msto.setFlag(9);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		try {
		conn = this.dataSource.getConnection();
		String sql = "SELECT ms.NAME, ms.price FROM membership ms WHERE seq = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,msto.getMembership_seq() );
		rs = pstmt.executeQuery();
		if( rs.next()) {
			msto.setFlag(0);
			msto.setMembership_name( rs.getString("ms.name") );
			msto.setMembership_price( rs.getInt("ms.price") );
		} else { msto.setFlag(8); }
		}catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		return msto;
	}
	
	// [일반 회원] insert 결제성공 후 데이터 입력
	// flag 0 정상
	// flag 8 비정상 오류
	// flag 9 서버 오류
	public int insertPurchasedMembership( MemberTO mto, PayTO pto ) {
		int flag = 9;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = this.dataSource.getConnection();
			String sql = "insert into pay values ( ?, ?, ?, ?, 1, now(), ? )";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pto.getMerchant_uid() );
			pstmt.setInt(2, pto.getMembership_seq() );
			pstmt.setString(3, pto.getType() );
			pstmt.setString(4, pto.getImp_uid() );
			pstmt.setInt(5, mto.getSeq() );
			if( pstmt.executeUpdate() == 1) { flag = 0; } else { flag = 8; }
			} catch( SQLException e) {
				System.out.println( e.getMessage());
			} finally {
				if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if( conn != null) try {conn.close();} catch(SQLException e) {}
			}
		return flag;
	}
}
