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
		
		String sql = "select b.seq\n"
				+ "     , c.category\n"
				+ "     , c.topic\n"
				+ "     , b.title\n"
				+ "     , m.nickname\n"
				+ "     , b.write_date\n"
				+ "  from board b \n"
				+ "  inner join category c on b.category_seq = c.seq\n"
				+ "  inner join `member` m on b.write_seq = m.seq\n"
				+ " where c.seq BETWEEN 10 and 14"
				+ " limit 0, 20";
		
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
				
				String sql = "select b.seq\n"
						+ "     , c.category\n"
						+ "     , c.topic\n"
						+ "     , b.title\n"
						+ "     , m.name\n"
						+ "     , b.write_date\n"
						+ "  from board b \n"
						+ "  inner join category c on b.category_seq = c.seq\n"
						+ "  inner join `member` m on b.write_seq = m.seq\n"
						+ " where c.seq BETWEEN 1 and 9"
						+ " limit 0, 20";
				
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
	
	
	  public int boardDelete(int seq) {

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null; 
			int result = 0;
			//ArrayList<BoardTO> boardDeletes = new ArrayList<>();
			
		    try {
				conn = this.dataSource.getConnection();
				
			  String  sql = "delete from board where seq = ?";
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
	  
	  public int facilityBoardDelete(int seq) {
		  
		  Connection conn = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null; 
		  int result = 0;
		  
		  try {
			  conn = this.dataSource.getConnection();
			  
			  String  sql = "delete from board where seq = ?";
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

	  
	  
	public Map<String, Object> selectFacilityBoard( BoardTO to ) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		Map<String, Object> map = null;
		
		try {
			
			conn = this.dataSource.getConnection();
			
			StringBuilder sb = new StringBuilder();
			sb.append( " select b.title, b.content, " );
			sb.append( " 	m.fulladdress, m.phone, avg( rv.star_score )" );
			sb.append( " 			from board b  " );
			sb.append( " 				left outer join member m on ( b.write_seq = m.seq ) " );
			sb.append( " 					right outer join review rv " );
			sb.append( " 						on( b.seq = rv.board_seq) " );
			sb.append( " 							where b.seq = ? " );
			
			String sql = sb.toString();
			
			pstmt = conn.prepareStatement( sql );
			pstmt.setInt(1, to.getSeq() );
			
			rs = pstmt.executeQuery();
			
			map = new HashMap<>();
			if( rs.next()) {
				// 글
				BoardTO bto = new BoardTO();
				bto.setTitle( rs.getString("b.title") );
				bto.setContent( rs.getString("b.content") );
				map.put( "bto", bto );
				//System.out.println( "bto" + bto.getTitle() );
				
				// 작성자(회원)
				MemberTO mto = new MemberTO();
				mto.setFullAddress( rs.getString("m.fulladdress") );
				mto.setPhone( rs.getString("m.phone") );
				map.put( "mto", mto );
				//System.out.println( "mto" + mto.getFullAddress() );
				
				// 리뷰
				ReviewTO rvto = new ReviewTO();
				rvto.setAvg_star_score( rs.getFloat("avg( rv.star_score )") );
				map.put( "rvto", rvto );
			}
		}catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		return map;
	}
	
	public ArrayList<MemberShipTO> selectMemberShips( BoardTO to ) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		ArrayList<MemberShipTO> arryList = null;
		
		try {
			
			conn = this.dataSource.getConnection();
			
			StringBuilder sbMemberShip = new StringBuilder();
			
			sbMemberShip.append( " select ms.seq, ms.name, ms.price, ms.period " );
			sbMemberShip.append( " 		from board b left outer join membership ms " );
			sbMemberShip.append( " 			on( b.seq = ms.board_seq) " );
			sbMemberShip.append( " 					where b.seq = ? " );
			
	 		String sql = sbMemberShip.toString(); 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, to.getSeq() );
			
			rs = pstmt.executeQuery();
			
			arryList = new ArrayList<>();
			
			while( rs.next()) {
				MemberShipTO msto = new MemberShipTO();
				msto.setMembership_seq( rs.getInt("ms.seq") );
				msto.setMembership_name( rs.getString("ms.name") );
				msto.setMembership_price( rs.getInt("ms.price") );
				msto.setMembership_period( rs.getInt("ms.period") );
				arryList.add(msto);
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
	
	public ArrayList<BoardTO> selectNotices( BoardTO to ) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		ArrayList<BoardTO> arryList = null;
		try {
			conn = this.dataSource.getConnection();
			StringBuilder sb = new StringBuilder();
			sb.append( " select b2.title, b2.seq" );
			sb.append( " 		from board b1 left outer join board b2 " );
			sb.append( " 			on( b1.write_seq = b2.write_seq ) " );
			sb.append( " 					where b2.category_seq = 13 or b2.category_seq = 14 and b1.seq = ? " );
			sb.append( " 						order by b1.seq desc " );
			sb.append( " 						limit 0, 4 " );
	 		String sql = sb.toString(); 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, to.getSeq() );
			rs = pstmt.executeQuery();
			arryList = new ArrayList<>();
			while( rs.next()) {
				BoardTO bto = new BoardTO();
				bto.setSeq( rs.getInt("b2.seq") );
				bto.setTitle( rs.getString("b2.title") );
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
	
	public ArrayList<BoardTO> selectImages( BoardTO to ) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		ArrayList<BoardTO> arryList = null;
		try {
			conn = this.dataSource.getConnection();
			StringBuilder sb = new StringBuilder();
			sb.append( " select img.name " );
			sb.append( " 		from board b left outer join image img " );
			sb.append( " 			on (b.seq = img.board_seq ) " );
			sb.append( " 					where b.seq = ? " );
	 		String sql = sb.toString(); 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, to.getSeq() );
			rs = pstmt.executeQuery();
			arryList = new ArrayList<>();
			while( rs.next()) {
				BoardTO bto = new BoardTO();
				bto.setImage_name( rs.getString("img.name") );
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
	
	public ArrayList<ReviewTO> selectReviews( BoardTO to ) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		ArrayList<ReviewTO> arryList = null;
		try {
			conn = this.dataSource.getConnection();
			StringBuilder sb = new StringBuilder();
			
			
			sb.append( " SELECT rv.content, date_format( rv.write_date, '%Y-%m-%d' ) AS 'rv.write_date', rv.star_score, m.nickname " );
			sb.append( " 		FROM review rv " );
			sb.append( " 			LEFT OUTER JOIN board b " );
			sb.append( " 					ON ( rv.board_seq = b.seq ) left outer join member m" );
			sb.append( " 					ON ( rv.writer_seq = m.seq )" );
			sb.append( " 						where rv.board_seq = ? AND rv.status = 1" );
			sb.append( " 							order by rv.write_date desc" );
	 		String sql = sb.toString(); 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, to.getSeq() );
			rs = pstmt.executeQuery();
			arryList = new ArrayList<>();
			
			while( rs.next()) {
				ReviewTO rvto = new ReviewTO();
				rvto.setNickname( rs.getString("m.nickname") );
				rvto.setContent( rs.getString("rv.content") );
				rvto.setWrite_date( rs.getString("rv.write_date") );
				rvto.setStar_score( rs.getFloat( "rv.star_score"));
				arryList.add(rvto);
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
