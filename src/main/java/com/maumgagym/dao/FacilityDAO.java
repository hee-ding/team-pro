package com.maumgagym.dao;

import java.lang.reflect.Array;
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
	private DataSource dataSource;
	
	private String uploadPath = "C:/eGovFrameDev-4.0.0-64bit/project/SpringBoot_Maumgagym/src/main/webapp/upload";

	
	public ArrayList facility() {
		//System.out.println( "FacilityDAO()호출" );
		
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
			sbDatas.append( " SELECT b.seq, b.title, b.category_seq, m.address, ms.price, i.name, t.tag" );
			sbDatas.append( "    FROM board b LEFT OUTER JOIN member m" );
			sbDatas.append( "          ON ( b.write_seq = m.seq ) LEFT OUTER JOIN membership ms" );
			sbDatas.append( "             ON( b.seq = ms.board_seq ) LEFT OUTER JOIN image i" );
			sbDatas.append( "                ON( b.seq = i.board_seq ) LEFT OUTER JOIN tag t" );
			sbDatas.append( "                   ON( b.seq = t.board_seq ) LEFT OUTER JOIN category c" );
			sbDatas.append( "                      ON( b.category_seq = c.seq )" );
			sbDatas.append( "							WHERE c.seq <= 9 && b.status=1" );
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
				bto.setSeq(rs.getInt( "b.seq" ));
				bto.setTitle(rs.getString( "b.title" ));
				bto.setTag(rs.getString( "t.tag" ));
				bto.setCategory_seq(rs.getInt( "b.category_seq" ));
				bto.setImage_name( rs.getString( "i.name" ) );
			
				MemberTO mto = new MemberTO();
				mto.setAddress(rs.getString("m.address"));
				
				MemberShipTO msto = new MemberShipTO();
				msto.setMembership_price( rs.getInt( "ms.price" ) );
				
//				System.out.println( bto.getTitle()); 
//				System.out.println ( "dao : " + mto.getAddress());
//				System.out.println( msto.getMembership_price());
				
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
	
	public BoardTO selectfacilityBoard( BoardTO to ) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
		conn = dataSource.getConnection();
		
		String sql = "select seq from board "
				+ "		WHERE write_seq = ? "
				+ "			ORDER BY write_date DESC "
				+ "				LIMIT 0,1";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, to.getWrite_seq());
		
		rs = pstmt.executeQuery();
		
		if( rs.next() ) {
			to.setSeq( rs.getInt("seq") );
		}
		
		} catch( SQLException e) {
			System.out.println( "[에러]" + e.getMessage());
		} finally {
			if( pstmt != null) try { pstmt.close(); } catch( SQLException e ) {}
			if( conn != null) try { conn.close(); } catch( SQLException e ) {}
		}
		
		return to;
	}
	
	public int insertfacilityBoard( BoardTO to ) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		int flag = 1;
		
		try {
			
		conn = dataSource.getConnection();
		
		String sql = "insert into board values (0, ?, ?, ?, ?, now(), 1)";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, to.getCategory_seq() );
		pstmt.setString(2, to.getTitle() );
		pstmt.setString(3, to.getContent() );
		pstmt.setInt(4, to.getWrite_seq() );
		
		if( pstmt.executeUpdate() == 1) {
			flag = 0;
		}
		
		} catch( SQLException e) {
			System.out.println( "[에러]" + e.getMessage());
		} finally {
			if( pstmt != null) try { pstmt.close(); } catch( SQLException e ) {}
			if( conn != null) try { conn.close(); } catch( SQLException e ) {}
		}
		
		return flag;
	}
	
	public int insertfacilityImage( BoardTO to ) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		int flag = 1;
		
		try {
			
		conn = dataSource.getConnection();
		
		String sql = "insert into image values (0, ?, ?, ?)";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, to.getImage_name() );
		pstmt.setDouble(2, to.getImage_size() );
		pstmt.setInt(3, to.getSeq() );
		
		if( pstmt.executeUpdate() == 1) {
			flag = 0;
		} else {
			flag = 1;
		}
		
		} catch( SQLException e) {
			System.out.println( "[에러]" + e.getMessage());
		} finally {
			if( pstmt != null) try { pstmt.close(); } catch( SQLException e ) {}
			if( conn != null) try { conn.close(); } catch( SQLException e ) {}
		}
		
		return flag;
	}
	
	public int insertfacilityMembership( BoardTO bto, MemberShipTO msto ) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		int flag = 1;
		
		try {
			
		conn = dataSource.getConnection();
		
		String sql = "insert into membership values (0, ?, ?, ?, ?, ?)";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, bto.getWrite_seq() );
		pstmt.setString(2, msto.getMembership_name()  );
		pstmt.setInt(3, msto.getMembership_price() );
		pstmt.setInt(4, msto.getMembership_period() );
		pstmt.setInt(5, bto.getSeq() );
		
		if( pstmt.executeUpdate() == 1) {
			flag = 0;
		} else {
			flag = 1;
		}
		
		} catch( SQLException e) {
			System.out.println( "[에러]" + e.getMessage());
		} finally {
			if( pstmt != null) try { pstmt.close(); } catch( SQLException e ) {}
			if( conn != null) try { conn.close(); } catch( SQLException e ) {}
		}
		
		return flag;
	}


}

