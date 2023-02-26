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

import com.maumgagym.dto.BoardTO;
import com.maumgagym.dto.LikeDTO;
import com.maumgagym.dto.MemberTO;
import com.maumgagym.dto.NotificationDTO;
import com.maumgagym.dto.ReactionDTO;

@Repository
public class NotificationDAO {
	
	@Autowired
	private DataSource dataSource;
		
		public NotificationDAO() {
			
			try {
				Context initCtx = new InitialContext();
				Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
				this.dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" ); //항상 이부분 this로 들어가도록 주의
				
				System.out.println("db연결성공");
			} catch (NamingException e) {
				System.out.println( "[에러] " + e.getMessage() ); 
			}
		}
//	
	
	public ArrayList<NotificationDTO> notificationList(int pageNum){
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		final int board_count = 10;
		
		ArrayList<NotificationDTO> notificationList = new ArrayList<>();
		
		try {
			
		conn = this.dataSource.getConnection();
		
		int limitNum = ((pageNum-1)*board_count); 
		String sql =  "select n.seq, c.topic, n.subject, a.nickname, n.date, n.hit from notification n left join category c on(n.category_seq = c.seq) left join admin a on (a.seq = n.writer_admin)order by n.seq desc limit ?,?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, limitNum);
		pstmt.setInt(2, board_count);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
				NotificationDTO to = new NotificationDTO();
				to.setSeq(rs.getInt("n.seq"));
				to.setCategory(rs.getString("c.topic"));
				to.setSubject(rs.getString("n.subject"));
				to.setWriter(rs.getString("a.nickname"));
				to.setDate(rs.getString("n.date"));
				to.setHit(rs.getInt("n.hit"));
				
				notificationList.add(to);
			}
		}catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		return notificationList;
	
	}
	
	public ArrayList<NotificationDTO> notificationsearchList(String keyword, int pageNum , int category){
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		final int board_count = 10;
		
		ArrayList<NotificationDTO> notificationList = new ArrayList<>();
		
		try {
			
		conn = this.dataSource.getConnection();
		
		int limitNum = ((pageNum-1)*board_count); 
		String sql =  "select n.seq, c.topic, n.subject, a.nickname, n.date, n.hit from notification n  left join category c on(n.category_seq = c.seq) left join admin a on (a.seq = n.writer_admin) where n.subject like '%"+keyword+"%' and c.seq like '%"+category+"%' order by n.seq desc limit ?,?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, limitNum);
		pstmt.setInt(2, board_count);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
				NotificationDTO to = new NotificationDTO();
				to.setSeq(rs.getInt("n.seq"));
				to.setCategory(rs.getString("c.topic"));
				to.setSubject(rs.getString("n.subject"));
				to.setWriter(rs.getString("a.nickname"));
				to.setDate(rs.getString("n.date"));
				to.setHit(rs.getInt("n.hit"));
				
				notificationList.add(to);
			}
		}catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		System.out.println("반환성공");
		return notificationList;
	
	}
	
	public int getPageNum() { //전체페이지 갯구 구하는 함수
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		int pageNum = 0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from notification n left join category c on( n.category_seq = c.seq) ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pageNum = rs.getInt(1);
			}
		}catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		return pageNum;
	}
	
	public int getSearchPageNum(String keyword, int category ) { //전체페이지 갯구 구하는 함수
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		int getSearchPageNum = 0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from notification n left join category c on( n.category_seq = c.seq) left join admin a on( a.seq = n.writer_admin ) where n.subject like '%"+keyword+"%' and c.seq like '%"+category+"%' ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				getSearchPageNum = rs.getInt(1);
			}
		}catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		return getSearchPageNum;
	}
	
	public NotificationDTO notificationView(int seq) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		NotificationDTO to = new NotificationDTO();
		try{
			conn = this.dataSource.getConnection();
			
			String sql = "update notification set hit=hit+1 where seq =?";
			pstmt = conn.prepareStatement( sql );
			pstmt.setInt( 1, seq );
			
			pstmt.executeUpdate();
			
			sql = "select n.subject, n.date, a.nickname, n.hit, n.content from notification n left join admin a on (a.seq = n.writer_admin) where n.seq = ?";
			pstmt = conn.prepareStatement( sql );
			pstmt.setInt( 1, seq );
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				to.setSubject(rs.getString("n.subject"));
				to.setDate(rs.getString("n.date"));
				to.setWriter(rs.getString("a.nickname"));
				to.setHit(rs.getInt("n.hit"));
				to.setContent(rs.getString("n.content"));
			}
			
		} catch (SQLException e){
			System.out.println( "[에러] " +  e.getMessage());
			
		} finally {
			if(rs != null) try{rs.close();} catch(SQLException e) {}
			if(pstmt != null) try{pstmt.close();} catch(SQLException e) {}
			if(conn != null) try{conn.close();} catch(SQLException e) {}
		}
		return to;
	}
	
}