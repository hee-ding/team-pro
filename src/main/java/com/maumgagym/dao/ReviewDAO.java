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
public class ReviewDAO {
	
	@Autowired
	private DataSource dataSource;
	
	public ReviewDAO() {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
			this.dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
			System.out.println("db연결성공");
		} catch (NamingException e) {
			System.out.println( "[에러] " + e.getMessage() ); 
		}
	}
	
	// [일반 회원, 기업 회원] select 마이 페이지 정보
	public ReviewTO insertReview( ReviewTO rvto ) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		// flag가 0 이면 정상
		// flag가 8 이면 비정상 입력
		// flag가 9 이면 서버 오류
		rvto.setFlag(9);
		try {
			conn = dataSource.getConnection();
			String sql = "insert into review values ( 0, ?, now(), ?, ?, 1, ?, ? ) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rvto.getContent() );
			pstmt.setInt(2, rvto.getWriter_seq() );
			pstmt.setFloat(3, rvto.getStar_score() );
			pstmt.setInt(4, rvto.getBoard_seq() );
			pstmt.setString(5, rvto.getMerchant_uid() );
			if( pstmt.executeUpdate() == 1) { rvto.setFlag(0); } else { rvto.setFlag(8); }
		} catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		return rvto;
	}
	
	// [일반 회원] update 리뷰 작성 후 news 테이블 insert
	// flag 0 정상
	// flag 8 비정상 실행
	// flag 9 서버 오류
	public int InsertNews( MemberTO mto, BoardTO bto ) {
		int flag = 9;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
				
			conn = dataSource.getConnection();
			
			String sql = "insert into news values ( 0, ?, now(), 2, 'N', 'Y', ? ) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mto.getSeq() );
			pstmt.setInt(2, bto.getSeq() );
			
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
