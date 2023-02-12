package com.maumgagym.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.maumgagym.dto.MemberTO;
import com.maumgagym.dto.NewsTO;

@Repository
public class NewsDAO {
	
	@Autowired
	private DataSource dataSource;
	
		public NewsDAO() {
			try {
				Context initCtx = new InitialContext();
				Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
				this.dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
			} catch (NamingException e) {
				System.out.println( "[에러] " + e.getMessage() ); 
			}
		}
	
	
	// [알림] id와 type을 통해서 가져오기
	public ArrayList<NewsTO> selectAllNews( MemberTO mto ) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		ArrayList<NewsTO> arrayList = null;
		try {
				
			conn = this.dataSource.getConnection();
			
			StringBuilder sb = new StringBuilder();
			
			sb.append( "SELECT ");
			sb.append( "	b.title AS '글', "); 
			sb.append( "		req_m.nickname '보낸회원이름', ");
			sb.append( "			TIMESTAMPDIFF( SECOND, NOW(), n.req_date ) AS '시간차이', ");
			sb.append( "				case ");
			sb.append( "					when n.type = 1 then '댓글' ");
			sb.append( "					when n.type = 2 then '리뷰' ");
			sb.append( "					when n.type = 3 then '승인요청' ");
			sb.append( "					when n.type = 4 then '승인완료' ");
			sb.append( "				END AS '알림내용', ");
			sb.append( "						n.read_check AS '읽음여부', n.view_check AS '유지여부' ");
			sb.append( "							FROM news n LEFT OUTER JOIN board b ");
			sb.append( "								ON( n.board_seq = b.seq ) ");
			sb.append( "									LEFT OUTER JOIN member req_m ");
			sb.append( "										ON( n.req_member_seq = req_m.seq ) ");
			sb.append( "											LEFT OUTER JOIN member rsp_m ");
			sb.append( "												ON( b.write_seq = rsp_m.seq ) ");
			sb.append( "													WHERE rsp_m.id = ? ");
			sb.append( "															ORDER BY n.req_date desc ");
			
			String sql = sb.toString();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mto.getId() );
			
			rs = pstmt.executeQuery();
			
			arrayList = new ArrayList();
			
			while( rs.next() ) {
				NewsTO nto = new NewsTO();
				nto.setTitle( rs.getString( "글" ) );
				nto.setNickname( rs.getString("보낸회원이름") );
				nto.setTIMESTAMPDIFF( rs.getInt("시간차이") );
				nto.setType( rs.getString("알림내용") );
				nto.setReadCheck( rs.getString("읽음여부") );
				nto.setViewCheck( rs.getString("유지여부") );
				arrayList.add( nto );
			}
			
		} catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		return arrayList;
	
	}
	
	// [알림] id와 type을 통해서 가져오기
	public NewsTO selectUnReadNewsCount( MemberTO mto ) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		NewsTO nto = new NewsTO();
		try {
				
			conn = this.dataSource.getConnection();
			StringBuilder sb = new StringBuilder();
			sb.append( "SELECT ");
			sb.append( "	COUNT( n.view_check ) ");
			sb.append( "		FROM news n LEFT OUTER JOIN board b ");
			sb.append( "			ON( n.board_seq = b.seq ) ");
			sb.append( "				LEFT OUTER JOIN member rsp_m ");
			sb.append( "					ON( b.write_seq = rsp_m.seq ) ");
			sb.append( "						WHERE rsp_m.id = ? AND n.view_check = 'Y' ");
			String sql = sb.toString();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mto.getId() );
			
			rs = pstmt.executeQuery();
			
			if( rs.next() ) {
				nto.setUnViewCount( rs.getInt( "COUNT( n.view_check )" ) );
			}
			
		} catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		return nto;
	
	}
	
}
