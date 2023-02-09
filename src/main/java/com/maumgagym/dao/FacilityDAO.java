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

@Repository
public class FacilityDAO {
	
	@Autowired
	private DataSource dataSource = null;
	
	public FacilityDAO() {
		// TODO Auto-generated constructor stub
		try {
			Context init = new InitialContext();
			Context env = (Context)init.lookup( "java:comp/env" );
			
			this.dataSource = (DataSource)env.lookup( "jdbc/mariadb1" );
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			System.out.println( "[에러] : " + e.getMessage() );
		}
	}
	
	public ArrayList facility() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Map<String, Object> map = new HashMap<>();

		ArrayList datas = new ArrayList<>();
		
		try {
			conn = this.dataSource.getConnection();
			
			// 글 게시판의 title을 통한 업체 정보, 멤버 게시판의 address을 통한 주소 정보, 멤버쉽 게시판의 price를 통한 가격 정보, 이미지 게시판의 name을 통한 이미지 파일, 태그 게시판의 tag를 통한 글 태그를 가져옴
			// 카테고리 게시판의 seq는 1~9번(운동시설)으로 가져옴
			StringBuilder sbDatas = new StringBuilder();   			   
			sbDatas.append( " SELECT b.seq, b.title, m.address, ms.price, i.name, t.tag" );
			sbDatas.append( "    FROM board b LEFT OUTER JOIN member m" );
			sbDatas.append( "          ON ( b.write_seq = m.seq ) LEFT OUTER JOIN membership ms" );
			sbDatas.append( "             ON( b.seq = ms.board_seq ) LEFT OUTER JOIN image i" );
			sbDatas.append( "                ON( b.seq = i.board_seq ) LEFT OUTER JOIN tag t" );
			sbDatas.append( "                   ON( b.seq = t.board_seq ) LEFT OUTER JOIN category c" );
			sbDatas.append( "                      ON( b.category_seq = c.seq )" );
			sbDatas.append( "							WHERE c.seq <= 9" );
			sbDatas.append( "								group BY b.seq;" );
			//sbDatas.append( "select t.tag from tag t left outer join board b on( t.board_seq = b.seq );" );
			   
			   
			// 변수에 대입
			String sql = sbDatas.toString(); 
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			int i = 0;
			while( rs.next() ) {
				 i++;
				
				BoardTO bto = new BoardTO();
				bto.setTitle(rs.getString( "b.title" ));
				bto.setTag(rs.getString( "t.tag" ));
			
				MemberTO mto = new MemberTO();
				mto.setAddress(rs.getString("m.address"));
				
				MemberShipTO msto = new MemberShipTO();
				msto.setMembership_price( rs.getInt( "ms.price" ) );
				
//				  System.out.println( bto.getTitle()); 
//				  System.out.println ( mto.getSido());
//				  System.out.println( mto.getGugun()); 
//				  System.out.println( msto.getMembership_price());
				
				map.put("bto" + i, bto);
				map.put("mto" + i, mto);
				map.put("msto" + i, msto);
				datas.add(map);
				}
				//System.out.println( datas.size() );

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println( "[에러] " + e.getMessage() );
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		    
		return datas;
	}
	
//	public BoardTO tag() {
//		
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		try {
//			conn = this.dataSource.getConnection();
//			
//			//글 태그 가져오기
//			String sql = "select t.tag from tag t left outer join board b on( t.board_seq = b.seq );";
//			
//			pstmt = conn.prepareStatement(sql);
//			
//			rs = pstmt.executeQuery();
//			
//			while( rs.next() ) {
//				BoardTO bto = new BoardTO();
//				bto.setTag(rs.getString( "t.tag" ));
//				
//			}
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			System.out.println( "[에러] " + e.getMessage() );
//		} finally {
//			if(rs != null) try {rs.close();} catch(SQLException e) {}
//			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
//			if(conn != null) try {conn.close();} catch(SQLException e) {}
//		}
//		
//		
//		return tag();
//	}
	
//	public BoardTO write() {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		conn = this.dataSource.getConnection();
//		
//		
//		return write();
//	}
	
	
//	public int writeOk() {
//		
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		
//		int flag = 1;	// 0 : 성공 / 1 : 실패
//		
//		conn = this.dataSource.getConnection();
//		
//		String sql  = "insert into board(seq, title, content) values(0, '글제목', '글내용')"
//		
//				
//		
//		return 0;
//	}

}
