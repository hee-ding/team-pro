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

@Repository
public class BoardDAO {
	
	@Autowired
	private DataSource dataSource;
	
	// upload 경로 수정 필요
	// private String uploadPath = "C://eGovFrameDev-4.0.0-64bit//workspace//AlbumBootSpringMVCEx01//src//main//webapp//upload";
	public BoardDAO() {
		
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
			this.dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" ); //항상 이부분 this로 들어가도록 주의
			
			System.out.println("db연결성공");
		} catch (NamingException e) {
			System.out.println( "[에러] " + e.getMessage() ); 
		}
	}
	
	

	public ArrayList<BoardTO> boardList(){
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		ArrayList<BoardTO> boardLists = new ArrayList<>();
		
		try {
			
		conn = this.dataSource.getConnection();
		
		//String sql =  "select b.seq, c.seq, b.title, b.content, m.seq , b.write_date, r.like_count from board b left join category c on( b.category_seq = c.seq) left join member m on( m.seq = b.write_seq ) left join reaction r on( b.seq = r.board_seq) where 9  < c.seq and c.seq < 13 order by r.like_count desc";
		String sql = "select b.seq\n"
				+ "     , c.category\n"
				+ "     , c.topic\n"
				+ "     , b.title\n"
				+ "     , m.nickname\n"
				+ "     , b.write_date\n"
				+ "  from board b \n"
				+ "  inner join category c on b.category_seq = c.seq\n"
				+ "  inner join `member` m on b.write_seq = m.seq\n"
				+ " where c.seq BETWEEN 10 and 14";
		
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
				BoardTO to = new BoardTO();
				to.setSeq(rs.getInt("b.seq"));
				to.setCategory(rs.getString("c.category"));
				to.setTopic(rs.getString("c.topic"));
				to.setTitle(rs.getString("b.title"));
				to.setNickname(rs.getString("m.nickname"));
				to.setWrite_date(rs.getString("b.write_date"));
				boardLists.add(to);
			}
		}catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		return boardLists;
	
	}
public ArrayList<BoardTO> facilityBoardList(){
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null; 
			
			ArrayList<BoardTO> facilityBoardLists = new ArrayList<>();
			
			try {
				
				conn = this.dataSource.getConnection();
				
				//String sql =  "select b.seq, c.seq, b.title, b.content, m.seq , b.write_date, r.like_count from board b left join category c on( b.category_seq = c.seq) left join member m on( m.seq = b.write_seq ) left join reaction r on( b.seq = r.board_seq) where 9  < c.seq and c.seq < 13 order by r.like_count desc";
				String sql = "select b.seq\n"
						+ "     , c.category\n"
						+ "     , c.topic\n"
						+ "     , b.title\n"
						+ "     , m.name\n"
						+ "     , b.write_date\n"
						+ "  from board b \n"
						+ "  inner join category c on b.category_seq = c.seq\n"
						+ "  inner join `member` m on b.write_seq = m.seq\n"
						+ " where c.seq BETWEEN 1 and 9";
				
				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					BoardTO to = new BoardTO();
					to.setSeq(rs.getInt("b.seq"));
					to.setCategory(rs.getString("c.category"));
					to.setTopic(rs.getString("c.topic"));
					to.setTitle(rs.getString("b.title"));
					to.setName(rs.getString("m.name"));
					to.setWrite_date(rs.getString("b.write_date"));
					facilityBoardLists.add(to);
				}
			}catch(SQLException e) {
				System.out.println( "[에러] " +  e.getMessage());
			} finally {
				if(conn != null) try {conn.close();} catch(SQLException e) {}
				if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if(rs != null) try {rs.close();} catch(SQLException e) {}
			}
			return facilityBoardLists;
			
		}

	
}
