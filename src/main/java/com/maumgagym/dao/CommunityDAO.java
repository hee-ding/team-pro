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
import com.maumgagym.dto.ReactionDTO;

@Repository
public class CommunityDAO {
	
	@Autowired
	private DataSource dataSource;
		
		public CommunityDAO() {
			
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
	
	public int boardWriteOK(MemberTO to1, BoardTO to) throws NamingException {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int flag = 1; //비정상

		try {
			
			System.out.println("db연결성공");
		
			conn = this.dataSource.getConnection();
			
			String sql = "select seq from member where nickname = ?"; //닉네임에 따른 seq 값 받아온다.
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to1.getNickname());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				to.setWrite_seq(rs.getInt("seq")); //BoardTO 안에 setWrite_seq 로 넣어준다.
			}
			
			 sql = "insert into board values(0, ?, ?, ?, ?, now(), 1) "; // 1 : 정상 //prepared문을 만들어서 board테이블에 insert 한다.
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setInt(1, to.getCategory_seq());
				 pstmt.setString(2, to.getTitle());
				 pstmt.setString(3, to.getContent());
				 pstmt.setInt(4, to.getWrite_seq());
				 
				 if(pstmt.executeUpdate() == 1 ) {
					 flag = 0; //정상
				 }			 
				 
			} catch (SQLException e){
				System.out.println( "[에러] " +  e.getMessage());
			} finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if(conn != null) try {conn.close();} catch(SQLException e) {}
				if(rs != null) try {rs.close();} catch(SQLException e) {}
			}
		return flag;
	}
	
	
	public ArrayList<BoardTO> communityList(int pageNum){
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		final int board_count = 10;
		
		ArrayList<BoardTO> communityList = new ArrayList<>();
		
		try {
			
		conn = this.dataSource.getConnection();
		
		int limitNum = ((pageNum-1)*board_count); 
		//String sql =  "select b.seq, c.topic, b.title, b.content, m.name , b.write_date, r.like_count, b.status from board b left join category c on( b.category_seq = c.seq) left join member m on( m.seq = b.write_seq ) left join reaction r on( b.seq = r.board_seq) where 9  < c.seq and c.seq < 13 order by r.like_count desc";
		String sql =  "select b.seq, c.topic, b.title, b.content, m.name , b.write_date, (select count(*) from likeaction l where l.board_seq = b.seq) as like_check, b.status from board b left join category c on( b.category_seq = c.seq) left join member m on( m.seq = b.write_seq )  where 9  < c.seq and c.seq < 13 order by b.seq desc limit ?,?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, limitNum);
		pstmt.setInt(2, board_count);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
				BoardTO to = new BoardTO();
				to.setSeq(rs.getInt("b.seq"));
				to.setTopic(rs.getString("c.topic"));
				to.setTitle(rs.getString("b.title"));
				to.setContent(rs.getString("b.content"));
				to.setNickname(rs.getString("m.name"));
				to.setWrite_date(rs.getString("b.write_date"));
				to.setLike_check(rs.getInt("like_check"));
				to.setStatus(rs.getString("b.status"));
				
				communityList.add(to);
			}
		}catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		return communityList;
	
	}
	
	public ArrayList<BoardTO> communitysearchList(String keyword, int pageNum , int category){
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		final int board_count = 10;
		
		ArrayList<BoardTO> communityList = new ArrayList<>();
		
		try {
			
		conn = this.dataSource.getConnection();
		
		int limitNum = ((pageNum-1)*board_count); 
		//String sql =  "select b.seq, c.topic, b.title, b.content, m.name , b.write_date, r.like_count, b.status from board b left join category c on( b.category_seq = c.seq) left join member m on( m.seq = b.write_seq ) left join reaction r on( b.seq = r.board_seq) where 9  < c.seq and c.seq < 13 order by r.like_count desc";
		String sql =  "select b.seq, c.topic, b.title, b.content, m.name , b.write_date, (select count(*) from likeaction l where l.board_seq = b.seq) as like_check, b.status from board b left join category c on( b.category_seq = c.seq) left join member m on( m.seq = b.write_seq )  where 9  < c.seq and c.seq < 13 and b.title like '%"+keyword+"%' and c.seq like '%"+category+"%' order by b.seq desc limit ?,?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, limitNum);
		pstmt.setInt(2, board_count);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
				BoardTO to = new BoardTO();
				to.setSeq(rs.getInt("b.seq"));
				to.setTopic(rs.getString("c.topic"));
				to.setTitle(rs.getString("b.title"));
				to.setContent(rs.getString("b.content"));
				to.setNickname(rs.getString("m.name"));
				to.setWrite_date(rs.getString("b.write_date"));
				to.setLike_check(rs.getInt("like_check"));
				to.setStatus(rs.getString("b.status"));
				
				communityList.add(to);
			}
		}catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		System.out.println("반환성공");
		return communityList;
	
	}
	
	public int getPageNum() { //전체페이지 갯구 구하는 함수
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		int pageNum = 0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from board b left join category c on( b.category_seq = c.seq) left join member m on( m.seq = b.write_seq ) left join reaction r on( b.seq = r.board_seq) where 9  < c.seq and c.seq < 13";
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
			
			String sql = "select count(*) from board b left join category c on( b.category_seq = c.seq) left join member m on( m.seq = b.write_seq ) left join reaction r on( b.seq = r.board_seq) where 9  < c.seq and c.seq < 13 and b.title like '%"+keyword+"%' and c.seq like '%"+category+"%' ";
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
	
	public BoardTO boardView(BoardTO to, MemberTO mto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		String id = null;
		
		try{
			conn = this.dataSource.getConnection();
			
			String sql = "select m.id from board b left join member m on (b.write_seq = m.seq) where b.seq = ? ";
			pstmt = conn.prepareStatement( sql );
			pstmt.setInt( 1, to.getSeq() );
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString("m.id");
			}
			
			sql = "select m.id, b.title, b.write_date, m.name, b.content from board b left join member m on (b.write_seq = m.seq) where b.seq = ? ";
			pstmt = conn.prepareStatement( sql );
			pstmt.setInt( 1, to.getSeq() );
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				to.setId(id);
				to.setTitle(rs.getString("b.title"));
				to.setWrite_date(rs.getString("b.write_date"));
				to.setWriter(rs.getString("m.name"));
				to.setContent(rs.getString("b.content"));
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
	
	public BoardTO boardModify(BoardTO to) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = this.dataSource.getConnection();
			
			 String sql = "select b.title, b.write_date, m.name, b.content from board b left join member m on (b.write_seq = m.seq) where b.seq = ? ";
		     pstmt = conn.prepareStatement(sql);
		     pstmt.setInt(1, to.getSeq());
		      
		     rs = pstmt.executeQuery();
		      
		      if( rs.next() ){
		    	  to.setTitle(rs.getString("b.title"));
				  to.setWrite_date(rs.getString("b.write_date"));
				  to.setWriter(rs.getString("m.name"));
				  to.setContent(rs.getString("b.content"));
		       }
		       
		    } catch( SQLException e ){
		       System.out.println( "[에러]" +e.getMessage() );
		    } finally {
		       if( rs != null ) try {rs.close();} catch(SQLException e) {}
		       if( pstmt != null ) try {pstmt.close();} catch(SQLException e) {}
		       if( conn != null ) try {conn.close();} catch(SQLException e) {}
		    }
			
			return to;
		}
	
	public int boardModifyOK(MemberTO to1, BoardTO to) {
		
			 Connection conn = null;
			 PreparedStatement pstmt = null;
			 
			 int flag = 2;
			 
			   try{
			      conn = this.dataSource.getConnection();
			      
			      String sql = "insert into board_modify values (0 , now() , ?) ";
			      pstmt = conn.prepareStatement(sql);
			      pstmt.setInt(1, to.getSeq());
			      pstmt.executeUpdate();
			      
			      // 수정할 경우 status = 2 로 고정 값 ( 2 = 수정 )
			      sql = "update board b left join member m on (b.write_seq = m.seq) set b.title = ? , b.content=?, b.status = 2 where b.seq =? and m.password =? ";
			      pstmt = conn.prepareStatement(sql);
			      pstmt.setString( 1, to.getTitle() );
			      pstmt.setString( 2, to.getContent() );
			      pstmt.setInt( 3, to.getSeq() );
			      pstmt.setString( 4, to1.getPassword() );
			      
			      int result = pstmt.executeUpdate(); //수정된애들을 result 에 던진다.
			      if( result ==0 ) {
			         flag = 1;
			      } else if( result ==1 ) {
			         // 정상 동작
			         flag = 0;
			      }
			      
			   } catch( SQLException e ){
			      System.out.println( "[에러]" +e.getMessage() );
			   } finally {
				   if(pstmt != null) try{pstmt.close();} catch(SQLException e) {}
				   if(conn != null) try{conn.close();} catch(SQLException e) {}
			      
			   }
			return flag;
	}
	
	public BoardTO boardDelete(BoardTO to) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select m.name , b.title, m.password from board b left join member m on  (b.write_seq = m.seq) where b.seq = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, to.getSeq());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				to.setWriter(rs.getString("m.name"));
				to.setTitle(rs.getString("b.title"));
			}
		} catch (SQLException e){
			System.out.println( "[에러] " +  e.getMessage());
			
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		return to;
		
	}
	
	public int boardDeleteOK(MemberTO to1, BoardTO to) {
		
		 Connection conn = null;
		 PreparedStatement pstmt = null;
		 
		 int flag = 2;
		 
		   try{
		      conn = this.dataSource.getConnection();
		      
		      String sql = "insert into board_delete values (0 , now() , ?) ";
		      pstmt = conn.prepareStatement(sql);
		      pstmt.setInt(1, to.getSeq());
		      pstmt.executeUpdate();
		      
		      //삭제시 board 테이블에 기존데이터 그대로 두고 status만 3으로 변경 ( 3 = 삭제 )
		      sql = "update board b left join member m on (b.write_seq = m.seq) set b.status = 3 where b.seq =? and m.password =? ";
		      pstmt = conn.prepareStatement(sql);
		      pstmt.setInt( 1, to.getSeq() );
		      pstmt.setString( 2, to1.getPassword() );
		      
		      int result = pstmt.executeUpdate(); //수정된애들을 result 에 던진다.
		      if( result ==0 ) {
		         flag = 1;
		      } else if( result ==1 ) {
		         // 정상 동작
		         flag = 0;
		      }
		      
		   } catch( SQLException e ){
		      System.out.println( "[에러]" +e.getMessage() );
		   } finally {
			   if(pstmt != null) try{pstmt.close();} catch(SQLException e) {}
			   if(conn != null) try{conn.close();} catch(SQLException e) {}
		      
		   }
		return flag;
	}
	
	public int communityLike(LikeDTO to) {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			int flag = 0 ; //비정상
			try {
				
				System.out.println("db연결성공");
				
				conn = this.dataSource.getConnection();
				
				//insert 
				String sql = "insert into likeaction values(0, 1, ?, ?  )";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, to.getUser());
				pstmt.setInt(2, to.getBoard_seq());
				
				if(pstmt.executeUpdate() == 1) {
					flag = 1; //정상
					
				}
				
				} catch (SQLException e){
					System.out.println( "[에러] " +  e.getMessage());
				} finally {
					if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
					if(conn != null) try {conn.close();} catch(SQLException e) {}
				}
			
			return flag;
		}
	
	public int communitydisLike(LikeDTO to) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		int flag = 0 ; //비정상
		try {
			
			System.out.println("db연결성공");
			
			conn = this.dataSource.getConnection();
			
			//insert 
			String sql = "delete from likeaction where user = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getUser());
			
			if(pstmt.executeUpdate() == 1) {
				flag = 1; //정상
				
			}
			
			} catch (SQLException e){
				System.out.println( "[에러] " +  e.getMessage());
			} finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if(conn != null) try {conn.close();} catch(SQLException e) {}
			}
		
		return flag;
	}
	
	public int communityalreadylike(LikeDTO to) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		int flag = 0 ; //비정상
		try {
			
			System.out.println("db연결성공");
			
			conn = this.dataSource.getConnection();
			
			//insert 
			String sql = "select * from likeaction where user = ? and board_seq = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getUser());
			pstmt.setInt(2, to.getBoard_seq());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				flag = 1;
			}
		
			
			} catch (SQLException e){
				System.out.println( "[에러] " +  e.getMessage());
			} finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if(conn != null) try {conn.close();} catch(SQLException e) {}
			}
		System.out.println("반환성공");
		
		return flag;
	}
	
}