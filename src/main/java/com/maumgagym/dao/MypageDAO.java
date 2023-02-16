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
import com.maumgagym.dto.PayTO;
import com.maumgagym.dto.ReviewTO;

@Repository
public class MypageDAO {
	
	@Autowired
	private DataSource dataSource;
	
		public MypageDAO() {
			try {
				Context initCtx = new InitialContext();
				Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
				this.dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
				System.out.println("db연결성공");
			} catch (NamingException e) {
				System.out.println( "[에러] " + e.getMessage() ); 
			}
		}
	
	// [일반 회원, 기업 회원] select 마이 페이지 정보
	public MemberTO selectMember( MemberTO mto ) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		try {
				
			conn = this.dataSource.getConnection();
			String sql = "select m.type, m.seq, m.nickname, m.id, m.name, m.birthday, m.phone, m.email, m.zipcode, m.fulladdress from member m where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mto.getId() );
			rs = pstmt.executeQuery();
			if( rs.next() ) {
				mto.setType( rs.getString("m.type"));
				mto.setSeq( rs.getInt("m.seq"));
				mto.setNickname( rs.getString("m.nickname") );
				mto.setId( rs.getString("m.id") );
				mto.setName( rs.getString("m.name") );
				mto.setBirthday( rs.getString("m.birthday") );
				mto.setPhone( rs.getString("m.phone") );
				mto.setEmail( rs.getString("m.email") );
				mto.setZipcode( rs.getString("m.zipcode") );
				mto.setFullAddress( rs.getString("m.fulladdress") );
			}
		} catch(SQLException e) {
			System.out.println( "[에러] " +  e.getMessage());
		} finally {
			if(conn != null) try {conn.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(rs != null) try {rs.close();} catch(SQLException e) {}
		}
		return mto;
	
	}
	
	// [일반 회원, 기업 회원] update 마이 페이지 정보 수정
	// flag 0 정상
	// flag 1 비밀번호 오류
	// flag 8 비정상 오류
	// flag 9 서버 오류
	public int updateMember( MemberTO mto ) {
		int flag = 9;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
				
			conn = this.dataSource.getConnection();
			
			String sql = "update member SET nickname = ?, birthday = ?, phone = ?, email = ?, fulladdress = ?, password = ? where id = ? and password = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mto.getNickname() );
			pstmt.setString(2, mto.getBirthday() );
			pstmt.setString(3, mto.getPhone() );
			pstmt.setString(4, mto.getEmail() );
			pstmt.setString(5, mto.getFullAddress() );
			pstmt.setString(6, mto.getChangePassword() );
			pstmt.setString(7, mto.getId() );
			pstmt.setString(8, mto.getPassword() );
			
			if( pstmt.executeUpdate() == 1) {
				flag = 0;
			} else {
				flag = 1;
			}
			
			} catch( SQLException e) {
				System.out.println( e.getMessage());
			} finally {
				if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if( conn != null) try {conn.close();} catch(SQLException e) {}
			}
		
		return flag;
	
	}
	
	// [일반 회원] select 내가 결제한 전체 멤버쉽( 환불 포함 ) 
	public ArrayList< Map<String, Object> > selectAllPurchasedMemberships( MemberTO mto ) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		Map<String, Object> map = null;
		ArrayList< Map<String, Object> > arrayList = null;
		try {
				
			conn = this.dataSource.getConnection();
			
			StringBuilder sb = new StringBuilder();
			
			
			sb.append( "select date_format( p.pay_date, '%Y-%m-%d' ) AS '결제 날짜', p.type AS '결제 방식', IF( p.status = 1, '정상', '환불' ) AS '결제 상태', p.merchant_uid AS '결제 번호'," );
			sb.append( "	ms.name AS '회원권 이름', ms.price AS '회원권 가격', ms.period AS '회원권 기간',");
			sb.append( "		b.seq AS '게시글 번호' , b.title AS '게시글 타이틀',");
			sb.append( "			i.name AS '대표 이미지', ");
			sb.append( "				wm.fulladdress AS '업체 주소',  wm.phone AS '업체 번호', ");
			sb.append( "					IFNULL( msr.status, 0 ) AS '회원권 상태', ");
			sb.append( "						IFNULL(rv.status, 0 ) AS '리뷰 상태' ");
			sb.append( "							from pay p LEFT OUTER JOIN member m");
			sb.append( "								ON( p.member_seq = m.seq ) LEFT OUTER JOIN membership ms");
			sb.append( "									ON( p.membership_seq = ms.seq ) LEFT OUTER JOIN board b");
			sb.append( "										ON( ms.board_seq = b.seq ) LEFT OUTER JOIN image i");
			sb.append( "											ON( b.seq = i.board_seq) LEFT OUTER JOIN member wm");
			sb.append( "												ON( b.write_seq = wm.seq ) LEFT OUTER JOIN membership_register msr ");
			sb.append( "													ON ( p.merchant_uid = msr.merchant_uid )  LEFT OUTER JOIN review rv ");
			sb.append( "														ON ( p.merchant_uid = rv.merchant_uid)" );
			sb.append( "															WHERE m.id = ?");
			sb.append( "																group BY p.merchant_uid");
			sb.append( "																	ORDER BY p.pay_date desc");
			
			String sql = sb.toString();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mto.getId() );
			
			rs = pstmt.executeQuery();
			
			arrayList = new ArrayList();
			
			while( rs.next() ) {
				
				map = new HashMap<String, Object>();
				
				PayTO pto = new PayTO();
				pto.setPay_date( rs.getString("결제 날짜") );
				pto.setType( rs.getString("결제 방식") );
				pto.setPay_status( rs.getString("결제 상태") );
				pto.setMerchant_uid( rs.getString("결제 번호") );
				pto.setMembership_register_status( rs.getString("회원권 상태") );
				map.put( "pto", pto );
				
				MemberShipTO msto = new MemberShipTO();
				msto.setMembership_name( rs.getString("회원권 이름") );
				msto.setMembership_price( rs.getInt("회원권 가격") );
				msto.setMembership_period( rs.getInt("회원권 기간") );
				map.put( "msto", msto );
				
				BoardTO bto = new BoardTO();
				bto.setSeq( rs.getInt("게시글 번호"));
				bto.setTitle( rs.getString("게시글 타이틀") );
				bto.setImage_name(  rs.getString("대표 이미지") );
				map.put( "bto", bto );
				
				MemberTO wmto = new MemberTO();
				wmto.setFullAddress( rs.getString("업체 주소") );
				wmto.setPhone( rs.getString("업체 번호") );
				map.put( "wmto", wmto );
				
				ReviewTO rvto = new ReviewTO();
				rvto.setStatus( rs.getString("리뷰 상태") );
				map.put( "rvto", rvto );
				
				arrayList.add( map );
				
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
	
	// [업체 회원] select 회원권을 결제한 전체 회원 정보( 환불 포함 ) 
	public ArrayList< Map<String, Object> > selectAllPurchasedMembers( MemberTO mto ) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		Map<String, Object> map = null;
		ArrayList< Map<String, Object> > arrayList = null;
		try {
				
			conn = this.dataSource.getConnection();
			
			StringBuilder sb = new StringBuilder();
			
			sb.append( "SELECT b.seq '글번호', CONCAT( c.topic ) '카테고리' ," );
			sb.append( "	CONCAT ( '[', ms.seq, '] ', ms.name ) '회원권 정보',");
			sb.append( "		m.name '회원 이름', m.phone '회원 연락처',");
			sb.append( "			IFNULL ( DATE_FORMAT( msr.register_date, '%Y-%m-%d'), '-' ) '회원권 등록일', IFNULL( DATE_FORMAT( msr.expiry_date ,'%Y-%m-%d'), '-' ) '회원권 만료일', ");
			sb.append( "				case ");
			sb.append( "					when msr.status IS NULL then '결제 완료' ");
			sb.append( "					when msr.status = 1 then '승인 대기' ");
			sb.append( "					when msr.status = 2 then '승인 완료' ");
			sb.append( "					when msr.status = 3 then '사용 중지' ");
			sb.append( "					when msr.status = 4 then '기간 만료' ");
			sb.append( "					when msr.status = 5 then '환불' ");
			sb.append( "				END AS '회원권  상태', ");
			sb.append( "					msr.merchant_uid AS '주문 번호', ");
			sb.append( "						IF( p.status = 1, '정상', '환불' ) AS '결제 상태', DATE_FORMAT(p.pay_date, '%Y-%m-%d') '결제일' ");
			sb.append( "							FROM member LEFT OUTER JOIN board b ");
			sb.append( "								ON (member.seq = b.write_seq ) ");
			sb.append( "									LEFT OUTER JOIN category c ");
			sb.append( "										ON ( b.category_seq = c.seq ) ");
			sb.append( "											LEFT OUTER JOIN membership ms ");
			sb.append( "												ON ( b.seq = ms.board_seq ) ");
			sb.append( "													INNER JOIN pay p ");
			sb.append( "														ON ( ms.seq = p.membership_seq ) ");
			sb.append( "															LEFT OUTER JOIN member m ");
			sb.append( "																ON ( p.member_seq = m.seq ) ");
			sb.append( "																	LEFT OUTER JOIN membership_register msr ");
			sb.append( "																		ON( p.merchant_uid = msr.merchant_uid ) ");
			sb.append( "																			WHERE member.id = ? AND  c.seq < 9 ");
			sb.append( "																				order by p.pay_date");
			
			String sql = sb.toString();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mto.getId() );
			
			rs = pstmt.executeQuery();
			
			arrayList = new ArrayList();
			
			while( rs.next() ) {
				
				map = new HashMap();
				
				BoardTO bto = new BoardTO();
				bto.setSeq( rs.getInt("글번호") );
				bto.setFullCategoryString( rs.getString("카테고리") );
				map.put( "bto", bto );
				
				MemberShipTO msto = new MemberShipTO();
				msto.setFull_membership_name( rs.getString("회원권 정보") );
				map.put( "msto", msto );
				
				MemberTO pmto = new MemberTO();
				pmto.setName( rs.getString("회원 이름") );
				pmto.setPhone( rs.getString("회원 연락처") );
				map.put( "pmto", pmto );
				
				PayTO pto = new PayTO();
				pto.setMembership_register_date( rs.getString("회원권 등록일") );
				pto.setMembership_expiry_date( (  rs.getString("회원권 만료일") )  );
				pto.setMembership_register_status( ( rs.getString("회원권  상태") ) );
				pto.setPay_status( ( rs.getString("결제 상태") ) );
				pto.setPay_date( ( rs.getString("결제일") ) );
				pto.setMerchant_uid( ( rs.getString("주문 번호") ) );
				map.put( "pto", pto );
				
				arrayList.add( map );
				
				
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
	
	// [기업 회원] 이전 정지 사용 여부 확인
	// flag 0 정상
	// flag 1 정지 1회 초과
	// flag 9 서버 오류
	public int pauseDuplicateCheck( PayTO pto ) {
		int flag = 9;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
				
			conn = dataSource.getConnection();
			
	 		String sql = "SELECT msh.register_seq FROM membership_hold msh INNER JOIN membership_register msr ON( msh.register_seq = msr.seq ) WHERE msr.merchant_uid = ? ";
	 		
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pto.getMerchant_uid() );
			
			rs = pstmt.executeQuery();
		
			if( rs.next() ) { flag = 1; } else { flag = 0; }
			
			} catch( SQLException e) {
				System.out.println( e.getMessage());
			} finally {
				if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if( conn != null) try {conn.close();} catch(SQLException e) {}
				if(rs != null) try {rs.close();} catch(SQLException e) {}
			}
		return flag;
	}
	
	// [기업 회원] 결제 번호로 register table의 seq, expiry_date 조회
	// flag 0 정상
	// flag 8 비정상 조회
	// flag 9 서버 오류
	public PayTO selectRegisterMembership( PayTO pto ) {
		int flag = 9;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dataSource.getConnection();
			String sql = "select * from membership_register where merchant_uid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pto.getMerchant_uid() );
			rs = pstmt.executeQuery();
			if( rs.next() ) {
				flag = 0;
				pto.setMembership_register_seq( rs.getInt("seq") );
				pto.setMembership_expiry_date( rs.getString("expiry_date") );
			} else { flag = 8; }
			
			} catch( SQLException e) {
				System.out.println( e.getMessage());
			} finally {
				if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if( conn != null) try {conn.close();} catch(SQLException e) {}
				if(rs != null) try {rs.close();} catch(SQLException e) {}
			}
		return pto;
	}
	
	// [기업 회원] 해당 멤버쉽 정지를 위한 멤버쉽 hold 테이블 insert
	// flag 0 정상
	// flag 8 비정상 실행
	// flag 9 서버 오류
	public int insertPauseMembership( PayTO pto ) {
		int flag = 9;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dataSource.getConnection();
			String sql = "insert into membership_hold ( seq, hold_date, register_seq ) value ( 0, now(), ?) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pto.getMembership_register_seq() );
			
			if( pstmt.executeUpdate() == 1) { flag = 0; } else { flag = 8; }
			
			} catch( SQLException e) {
				System.out.println( e.getMessage());
			} finally {
				if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if( conn != null) try {conn.close();} catch(SQLException e) {}
				if(rs != null) try {rs.close();} catch(SQLException e) {}
			}
		return flag;
	}
	
	// [기업 회원] 멤버쉽 정지에 따른 등록 테이블 status 변경
	// flag 0 정상
	// flag 8 비정상 실행
	// flag 9 서버 오류
	public int updatePauseMembership( PayTO pto ) {
		int flag = 9;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dataSource.getConnection();
			String sql = "update membership_register SET status = 3 where merchant_uid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pto.getMerchant_uid() );
			
			if( pstmt.executeUpdate() == 1) { flag = 0; } else { flag = 8; }
			
			} catch( SQLException e) {
				System.out.println( e.getMessage());
			} finally {
				if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if( conn != null) try {conn.close();} catch(SQLException e) {}
				if(rs != null) try {rs.close();} catch(SQLException e) {}
			}
		return flag;
	}
	
	// [일반 회원] update 멤버쉽 승인 요청
	// flag 0 정상
	// flag 8 비정상 실행
	// flag 9 서버 오류
	public int InsertRequestMembership( PayTO pto ) {
		int flag = 9;
		Connection conn = null;
		PreparedStatement pstmt = null;
		MemberTO mto = new MemberTO();
		try {
				
			conn = dataSource.getConnection();
			
			String sql = "insert into membership_register (seq, status, merchant_uid ) values ( 0, 1, ? ) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pto.getMerchant_uid() );
			
			if( pstmt.executeUpdate() == 1) {
				flag = 0;
			} else { flag = 8; }
			
			} catch( SQLException e) {
				System.out.println( e.getMessage());
			} finally {
				if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if( conn != null) try {conn.close();} catch(SQLException e) {}
			}
		
		return flag;
	
	}
	
	// [일반 회원] update 멤버쉽 승인 요청 후 news 테이블 insert
	// flag 0 정상
	// flag 8 비정상 실행
	// flag 9 서버 오류
	public int InsertNews( MemberTO mto, BoardTO bto ) {
		int flag = 9;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
				
			conn = dataSource.getConnection();
			
			String sql = "insert into news values ( 0, ?, now(), 3, 'N', 'Y', ? ) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mto.getSeq() );
			pstmt.setInt(2, bto.getSeq() );
			
			if( pstmt.executeUpdate() == 1) { flag = 0; } else { flag = 8; }
			
			} catch( SQLException e) {
				System.out.println( e.getMessage());
			} finally {
				if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if( conn != null) try {conn.close();} catch(SQLException e) {}
			}
		
		return flag;
	
	}
	
	// [기업 회원] update 멤버쉽 환불 
	// flag가 0 이면 정상
	// flag가 1 이면 pay 테이블 update 오류
	// flag 8 비정상 실행
	// flag 9 서버 오류
	public int updateRefundMembershipOfPay( PayTO pto ) {
		int flag = 9;
		Connection conn = null;
		PreparedStatement pstmt = null;
		MemberTO mto = new MemberTO();
		try {
				
			conn = dataSource.getConnection();
			
			String sql = "update pay SET status = 2 where merchant_uid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pto.getMerchant_uid() );
			
			if( pstmt.executeUpdate() == 1) { flag = 0; } else { flag = 8; }
			
			} catch( SQLException e) {
				System.out.println( e.getMessage());
			} finally {
				if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if( conn != null) try {conn.close();} catch(SQLException e) {}
			}
		
		return flag;
	
	}
	
	// [기업 회원] update 멤버쉽 환불 
	// flag가 0 이면 정상
	// flag가 1 이면 register 테이블 update 오류
	// flag 8 비정상 실행
	// flag 9 서버 오류
	public int updateRefundMembershipOfRegister( PayTO pto ) {
		int flag = 9;
		Connection conn = null;
		PreparedStatement pstmt = null;
		MemberTO mto = new MemberTO();
		try {
				
			conn = dataSource.getConnection();
			
			String sql = "update membership_register SET status = 5 where merchant_uid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pto.getMerchant_uid() );
			
			if( pstmt.executeUpdate() == 1) { flag = 0; } else { flag = 8; }
			
			} catch( SQLException e) {
				System.out.println( e.getMessage());
			} finally {
				if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if( conn != null) try {conn.close();} catch(SQLException e) {}
			}
		
		return flag;
	
	}
	
	// [기업 회원] select 멤버쉽 승인을 위한 회원권 개월수 확인
	// flag 0 정상
	// flag 9 서버 오류
	public MemberShipTO selectMembershipPeriod( PayTO pto ) { 
		int flag = 9;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberShipTO msto = null;
		try {
			conn = dataSource.getConnection();
	 		String sql = "SELECT ms.period FROM pay p LEFT OUTER JOIN membership ms ON( p.membership_seq = ms.seq ) WHERE p.merchant_uid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pto.getMerchant_uid() );
			rs = pstmt.executeQuery();
			msto = new MemberShipTO();
			if( rs.next() ) {
				msto.setMembership_period( rs.getInt("ms.period") );
			}
			
			} catch( SQLException e) {
				System.out.println( e.getMessage());
			} finally {
				if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if( conn != null) try {conn.close();} catch(SQLException e) {}
				if(rs != null) try {rs.close();} catch(SQLException e) {}
			}
		return msto;
	}
	
	// [기업 회원] select 멤버쉽 재개를 위한 정보 가져오기 가져오기
	// flag 0 정상
	// flag 8 비정상 입력
	// flag 9 서버 오류
	public PayTO selectPauseMembershipInfo( PayTO pto ) { 
		int flag = 9;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dataSource.getConnection();
			String sql = "select * from membership_hold where register_seq = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pto.getMembership_register_seq() );
			
			rs = pstmt.executeQuery();
			
			if( rs.next() ) {
				flag = 0;
				pto.setHold_date( rs.getString( "hold_date") );
				pto.setHold_sum_date( rs.getString( "hold_sum_date") );
			} else { flag = 8; }
			
			} catch( SQLException e) {
				System.out.println( e.getMessage());
			} finally {
				if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if( conn != null) try {conn.close();} catch(SQLException e) {}
				if(rs != null) try {rs.close();} catch(SQLException e) {}
			}
		return pto;
	}
	
	// [기업 회원] update 멤버쉽 재개를 위한 변경
	// flag 0 정상
	// flag 1 멤버쉽 재개를 위한 변경 오류
	// flag 8 비정상 입력
	// flag 9 서버 오류
	public int updateRestartMembership( PayTO pto ) { 
		int flag = 9;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
				
			conn = dataSource.getConnection();
			
			String sql = "update membership_hold SET hold_end_date = NOW(), hold_sum_date = TIMESTAMPDIFF(DAY, ?, now() ) where register_seq = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pto.getHold_date() );
			pstmt.setInt(2, pto.getMembership_register_seq() );
			
			if( pstmt.executeUpdate() == 1) { flag = 0; } else { flag = 1; }
			
			} catch( SQLException e) {
				System.out.println( e.getMessage());
			} finally {
				if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if( conn != null) try {conn.close();} catch(SQLException e) {}
			}
		
		return flag;
	}
	
	// [기업 회원] update 재개내용 반영
	// flag 0 정상
	// flag 2 멤버쉽 재개를 위한 membership_register 테이블 변경 오류
	// flag 9 서버 오류
	public int updateRestartMembershipInfo( PayTO pto ) {
		
		System.out.println( pto.getMembership_expiry_date() );
		System.out.println( pto.getHold_sum_date() );
		System.out.println( pto.getMerchant_uid() );
		int flag = 9;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
				
			conn = dataSource.getConnection();
			
			String sql = "update membership_register SET expiry_date = date_add( ?, INTERVAL ? DAY ), status = 2 where merchant_uid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pto.getMembership_expiry_date() );
			pstmt.setString(2, pto.getHold_sum_date() );
			pstmt.setString(3, pto.getMerchant_uid() );
			
			if( pstmt.executeUpdate() == 1) { flag = 0; } else { flag = 2; }
			
			} catch( SQLException e) {
				System.out.println( e.getMessage());
			} finally {
				if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if( conn != null) try {conn.close();} catch(SQLException e) {}
			}
		System.out.println( flag );
		return flag;
	}
	
	
	// [기업 회원] update 멤버쉽 승인
	// flag 0 정상
	// flag 8 비정상 입력
	// flag 9 서버 오류
	public int updateApprovalMembership( MemberShipTO msto, PayTO pto ) { 
		int flag = 9;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
				
			conn = dataSource.getConnection();
			
			String sql = "update membership_register SET register_date = NOW(), expiry_date = date_add( now(), INTERVAL ? MONTH ), status = 2 where merchant_uid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, msto.getMembership_period() );
			pstmt.setString(2, pto.getMerchant_uid() );
			
			if( pstmt.executeUpdate() == 1) { flag = 0; } else { flag = 8; }
			
			} catch( SQLException e) {
				System.out.println( e.getMessage());
			} finally {
				if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if( conn != null) try {conn.close();} catch(SQLException e) {}
			}
		
		return flag;
	}
	
	// [일반 회원, 기업 회원] update 정보 수정 전 닉네임 중복 검사
	// flag가 0 이면 정상
	// flag가 1 이면 중복
	// flag가 9 이면 서버 오류
	public int nicknameDuplicateCheck( MemberTO to ) {
		int flag = 9;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
				
			conn = dataSource.getConnection();
			
			String sql = "select nickname from member where nickname = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getNickname() );
			
			rs = pstmt.executeQuery();
			
			if( rs.next() ) { flag = 1; } else { flag = 0; }
			
			} catch( SQLException e) {
				System.out.println( e.getMessage());
			} finally {
				if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if( conn != null) try {conn.close();} catch(SQLException e) {}
				if(rs != null) try {rs.close();} catch(SQLException e) {}
			}
		
		return flag;
	
	}
}
