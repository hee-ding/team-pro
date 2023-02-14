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
import com.maumgagym.dto.ReviewTO;

@Repository
public class HomeDAO {
	
	@Autowired
	private DataSource dataSource;
	
	public HomeDAO() {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
			this.dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
		} catch (NamingException e) {
			System.out.println( "[에러] " + e.getMessage() ); 
		}
	}
	
	public ArrayList<BoardTO> selectRecommendedList( BoardTO to ) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		ArrayList<BoardTO> arryList = null;
		try {
			conn = this.dataSource.getConnection();
			StringBuilder sb = new StringBuilder();
			sb.append( " SELECT b.seq, b.title, t.tag, i.name " );
			sb.append( " 		FROM board b LEFT OUTER JOIN tag t " );
			sb.append( " 			ON ( b.seq = t.board_seq ) LEFT OUTER JOIN image i " );
			sb.append( " 				ON( b.seq = i.board_seq ) LEFT OUTER JOIN category c " );
			sb.append( " 					ON ( b.category_seq = c.seq ) " );
			sb.append( " 						WHERE c.seq < 13 AND tag LIKE ? " );
			sb.append( " 							group BY b.seq " );
			sb.append( " 								ORDER by b.seq desc " );
			sb.append( " 									limit 0, 6  " );
	 		String sql = sb.toString();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString( 1, "%" + to.getTag() + "%" );
			rs = pstmt.executeQuery();
			arryList = new ArrayList<>();
			while( rs.next()) {
				BoardTO bto = new BoardTO();
				bto.setSeq( rs.getInt("b.seq") );
				bto.setTitle( rs.getString( "b.title" ) );
				bto.setTag( rs.getString("t.tag") );
				bto.setImage_name( rs.getString("i.name") );
				arryList.add( bto );
			}
		}catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		return arryList;
	}
	
	public ArrayList<BoardTO> selectFacilityBoardCountList( ) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		ArrayList<BoardTO> arryList = null;
		try {
			conn = this.dataSource.getConnection();
			StringBuilder sb = new StringBuilder();
			sb.append( " SELECT c.topic, count( b.seq ) ");
			sb.append( " 	from board b right OUTER JOIN category c ");
			sb.append( " 		ON ( b.category_seq = c.seq ) ");
			sb.append( " 			WHERE c.seq between 1 AND 9  ");
			sb.append( " 				group BY c.seq ");
	 		String sql = sb.toString();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			arryList = new ArrayList<>();
			while( rs.next()) {
				BoardTO bto = new BoardTO();
				bto.setTopic( rs.getString("c.topic") );
				bto.setCategoryBoardCount( rs.getInt("count( b.seq )") );
				arryList.add( bto );
			}
		}catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		return arryList;
	}
	
	public ArrayList<BoardTO> selectWeeklyBoardList( ) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		ArrayList<BoardTO> arryList = null;
		try {
			conn = this.dataSource.getConnection();
			StringBuilder sb = new StringBuilder();
			sb.append( "	SELECT b.seq, b.title, c.topic, m.nickname, ra.view_count, ra.like_count, COUNT( cm.seq ), i.name ");
			sb.append( " 		FROM board b LEFT OUTER JOIN category c ");
			sb.append( " 			ON( b.category_seq = c.seq ) LEFT OUTER JOIN member m ");
			sb.append( " 				ON( b.write_seq = m.seq ) LEFT OUTER JOIN reaction ra ");
			sb.append( " 			    	ON( b.seq = ra.board_seq ) LEFT OUTER JOIN comment cm ");
			sb.append( " 			        	ON( b.seq = cm.board_seq ) LEFT OUTER JOIN image i ");
			sb.append( " 			            	ON( b.seq = i.board_seq ) "); 
			sb.append( " 			                	WHERE (b.status = 1 or b.status = 2) and c.seq BETWEEN 10 AND 12 ");
			sb.append( " 			                    	group BY b.seq ");
			sb.append( " 			                       		LIMIT 0, 6; ");
	 		String sql = sb.toString();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			arryList = new ArrayList<>();
			while( rs.next()) {
				BoardTO bto = new BoardTO();
				bto.setSeq( rs.getInt( "b.seq") );
				bto.setTitle( rs.getString( "b.title") );
				bto.setTopic( rs.getString( "c.topic") );
				bto.setNickname( rs.getString( "m.nickname") );
				bto.setView_count( rs.getInt( "ra.view_count" ) );
				bto.setLike_count( rs.getInt( "ra.like_count" ) );
				bto.setComment_count( rs.getInt( "COUNT( cm.seq )" ) );
				bto.setImage_name( rs.getString( "i.name") );
				arryList.add( bto );
			}
		}catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		return arryList;
	}
	
}
