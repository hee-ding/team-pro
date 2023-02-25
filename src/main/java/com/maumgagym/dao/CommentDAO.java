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
import com.maumgagym.dto.CommentTO;
import com.maumgagym.dto.MemberTO;

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

	public ArrayList<CommentTO> commentList(BoardTO to){
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		ArrayList<CommentTO> commentLists = new ArrayList<>();
		
		try {
			
		conn = this.dataSource.getConnection();
		
		StringBuilder sbDatas = new StringBuilder();   	
		sbDatas.append( "SELECT c.seq, c.content, c.write_date, b.seq, m.nickname" );
		sbDatas.append( "	FROM comment c LEFT JOIN board b ON b.seq = c.board_seq" );
		sbDatas.append( "		LEFT JOIN member m ON m.seq = c.writer_seq" );
		sbDatas.append( "			WHERE b.seq = ?" );
		
		String sql = sbDatas.toString(); 
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, to.getSeq() );
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			CommentTO cto = new CommentTO();
			cto.setSeq(rs.getInt("c.seq"));
			cto.setContent(rs.getString("c.content"));
			cto.setWrite_date( rs.getString("c.write_date") );
			cto.setNickname( rs.getString("m.nickname") );
			commentLists.add(cto);
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
	
	public int commentInsert(CommentTO cmtto, MemberTO mto) {
		  Connection conn = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;

		  int flag = 0;
		  
		  try {
			conn = this.dataSource.getConnection();
			
			  String sql = "select seq from member where nickname = ?";
			  pstmt = conn.prepareStatement(sql);
			  pstmt.setString(1, mto.getNickname());
			  rs = pstmt.executeQuery();
			  if(rs.next()) {
				  cmtto.setWriter_seq(rs.getInt("seq"));
			  }
			  
			  sql = "insert into comment values(0, ?, ?, now(), 1, ?)";
			  pstmt = conn.prepareStatement(sql);
			  
			  pstmt.setString(1, cmtto.getContent());
			  pstmt.setInt(2, cmtto.getWriter_seq() );
			  pstmt.setInt(3, cmtto.getBoard_seq());
			  
			  if( pstmt.executeUpdate() == 1 ) {
				  flag = 1;
			  }
			  
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println( "[에러] : " +  e.getMessage());		
		} finally {
			if( pstmt != null) try { pstmt.close(); } catch( SQLException e ) {}
			if( conn != null) try { conn.close(); } catch( SQLException e ) {}
			if( rs != null) try { rs.close(); } catch( SQLException e ) {}
		}
		  return flag;
	}
	
	 public int commentDelete(int seq) {
		  
		  Connection conn = null;
		  PreparedStatement pstmt = null;
		  
		  int flag = 0;
		  
		  try {
			  conn = this.dataSource.getConnection();
			  
			  String  sql = "delete from comment where seq = ?";
			  pstmt = conn.prepareStatement(sql);
			  pstmt.setInt(1, seq);
			  
			  if(pstmt.executeUpdate() == 1) {
				  flag = 1;
			  }
			  
		  }catch(SQLException e) {
			  System.out.println( "[에러] " +  e.getMessage());
		  } finally {
			  if(conn != null) try {conn.close();} catch(SQLException e) {}
			  if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
		  }
		  return flag;
	  }
}