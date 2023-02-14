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

import com.maumgagym.dto.CommentTO;

@Repository
public class CommentDAO {
	
	@Autowired
	private DataSource dataSource;
	
	// upload 경로 수정 필요
	// private String uploadPath = "C://eGovFrameDev-4.0.0-64bit//workspace//AlbumBootSpringMVCEx01//src//main//webapp//upload";
	public CommentDAO() {
		
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
			this.dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" ); //항상 이부분 this로 들어가도록 주의
			
			System.out.println("db연결성공");
		} catch (NamingException e) {
			System.out.println( "[에러] " + e.getMessage() ); 
		}
	}
	
	

	public ArrayList<CommentTO> commentList(){
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		ArrayList<CommentTO> commentLists = new ArrayList<>();
		
		try {
			
		conn = this.dataSource.getConnection();
		
		String sql = "select c1.seq\n"
				+ "	 , c2.category\n"
				+ "	 , c2.topic\n"
				+ "	 , b.title\n"
				+ "	 , c1.content\n"
				+ "	 , m.nickname\n"
				+ "	 , c1.write_date\n"
				+ "from comment c1 \n"
				+ "inner join board b on c1.board_seq = b.seq \n"
				+ "inner join category c2 on c2.seq = c1.seq \n"
				+ "inner join `member` m ON b.write_seq = m.seq \n"
				+ "limit 0, 20";
		
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
				CommentTO to = new CommentTO();
				to.setSeq(rs.getInt("c1.seq"));
				to.setCategory(rs.getString("c2.category"));
				to.setTopic(rs.getString("c2.topic"));
				to.setTitle(rs.getString("b.title"));
				to.setContent(rs.getString("c1.content"));
				to.setNickname(rs.getString("m.nickname"));
				to.setWrite_date(rs.getString("c1.write_date"));
				commentLists.add(to);
			}
		}catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		return commentLists;
	}
	 public int commentDelete(int seq) {
		  
		  Connection conn = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null; 
		  int result = 0;
		  
		  try {
			  conn = this.dataSource.getConnection();
			  
			  String  sql = "delete from comment where seq = ?";
			  pstmt = conn.prepareStatement(sql);
			  pstmt.setInt(1, seq);
			  result = pstmt.executeUpdate();
			  
		  }catch(SQLException e) {
			  System.out.println( "[에러] " +  e.getMessage());
		  } finally {
			  if(conn != null) try {conn.close();} catch(SQLException e) {}
			  if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			  if(rs != null) try {rs.close();} catch(SQLException e) {}
		  }
		  return result;
	  }
}