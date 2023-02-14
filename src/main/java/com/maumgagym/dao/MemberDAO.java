package com.maumgagym.dao;

import java.sql.Connection;
import java.sql.Date;
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

import com.maumgagym.dto.MemberTO;

@Repository
public class MemberDAO {
	
	@Autowired
	private DataSource dataSource;
		
		public MemberDAO() {
			
			try {
				Context initCtx = new InitialContext();
				Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
				this.dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" ); //항상 이부분 this로 들어가도록 주의
				
				System.out.println("db연결성공");
			} catch (NamingException e) {
				System.out.println( "[에러] " + e.getMessage() ); 
			}
		}
		
		public Date stringToDate(MemberTO to) // string -> date 변경 메서드
		    {
		        String year = to.getBirthyy();
		        String month = to.getBirthmm();
		        String day = to.getBirthdd();
	        
		        Date birthday = Date.valueOf(year+"-"+month+"-"+day);
		        
		        return birthday;
		        
		    } 
		
		public MemberTO login( MemberTO to  ) { //로그인 메서드
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			
			try {
				 conn = this.dataSource.getConnection();
				 
				 String sql = "select password, type, nickname from member where id = ? " ;
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, to.getId() );
				 rs = pstmt.executeQuery();
				 
				 if(rs.next()) { 
					 
					 to.setType( rs.getString(2) );
					 to.setNickname( rs.getString(3) );
					 
					 if(rs.getString(1).equals( to.getPassword() )) {
						 to.setFlag( 1 );
						 return to;  //로그인 성공
					 }
					 else {
						 to.setFlag( 0 );
						 return to; //비밀번호 불일치
					 }
				 }
				 to.setFlag( -1 );
				 return to;  //아이디가 없음
				 
				 
			} catch (SQLException e){
				System.out.println( "[에러] " +  e.getMessage());
			} finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if(conn != null) try {conn.close();} catch(SQLException e) {}
				if(rs != null) try {rs.close();} catch(SQLException e) {}

			}
			return to; //오류
			 
		}
		
		public int kakaologin(MemberTO to){
					
					Connection conn = null;
					PreparedStatement pstmt = null;
					
					int flag = 1;
					
					try {
						 conn = this.dataSource.getConnection();
						 
						 String sql = "insert into kakao_login values ( 0,?,? )";
						 pstmt = conn.prepareStatement(sql);
						 pstmt.setString(1, to.getNickname());
						 pstmt.setString(2, to.getEmail());
						 
						 if(pstmt.executeUpdate() == 1 ) {
							 flag = 0; //정상
						 }
					} catch (SQLException e){
						System.out.println( "[에러] " +  e.getMessage());
					} finally {
						if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
						if(conn != null) try {conn.close();} catch(SQLException e) {}
					}
					return flag;
					
				}
		
		
		public int join(MemberTO to){ //회원가입 메서드
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			int flag = 1;
			
			try {
				 conn = this.dataSource.getConnection();
				 
				 String sql = "insert into member values (0,?,?,?,?,?,0,?,?,?,?,?,?)";
				 stringToDate(to);
				 
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, to.getNickname());
				 pstmt.setString(2, to.getId());
				 pstmt.setString(3, to.getPassword());
				 pstmt.setString(4, to.getName());
				 pstmt.setDate(5, stringToDate(to));
				 pstmt.setString(6, to.getMail1()+"@"+to.getMail2());
				 pstmt.setString(7, to.getType());
				 pstmt.setString(8, to.getZipcode());
				 pstmt.setString(9, to.getAddress());
				 pstmt.setString(10, to.getFullAddress());
				 pstmt.setString(11, to.getReferAddress());
				 
				 if(pstmt.executeUpdate() == 1){
						flag = 0; //정상
					}
				 
			} catch (SQLException e){
				System.out.println( "[에러] " +  e.getMessage());
			} finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if(conn != null) try {conn.close();} catch(SQLException e) {}
			}
			return flag;
			
		}
		
		
		public int joinPartner(MemberTO to){ //기업 회원가입 메서드
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			int flag = 1;
			
			try {
				 conn = this.dataSource.getConnection();
				 
				 String sql = "insert into member values (0,?,?,?,?,0,0,?,?,?,?,?,?)";
				 
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, to.getNickname()); //상호명
				 pstmt.setString(2, to.getId());
				 pstmt.setString(3, to.getPassword());
				 pstmt.setString(4, to.getName()); // 대표이름
				 pstmt.setString(5, to.getMail1()+"@"+to.getMail2());
				 pstmt.setString(6, to.getType()); //c
				 pstmt.setString(7, to.getZipcode());
				 pstmt.setString(8, to.getAddress());
				 pstmt.setString(9, to.getFullAddress());
				 pstmt.setString(10, to.getReferAddress());
				 
				 if(pstmt.executeUpdate() == 1){
						flag = 0; //정상
					}
				 
			} catch (SQLException e){
				System.out.println( "[에러] " +  e.getMessage());
			} finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if(conn != null) try {conn.close();} catch(SQLException e) {}
			}
			return flag;
			
		}

		
		public MemberTO checkId(MemberTO to){ // 이메일로 아이디 찾기 메서드 (id값 반환)
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				 conn = this.dataSource.getConnection();
				 
				 String sql = "select id, name from member where email=?";
				 
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, to.getEmail());
				 
				 rs = pstmt.executeQuery();
				 
				 while(rs.next()){
					 to.setId(rs.getString("id"));
					 to.setName(rs.getString("name"));
					 
					} //정상
				 
			} catch (SQLException e){
				System.out.println( "[에러] " +  e.getMessage());
			} finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if(conn != null) try {conn.close();} catch(SQLException e) {}
				if(rs != null) try {rs.close();} catch(SQLException e) {}
			}
			return to;
		
		}
	
		public MemberTO getTemporaryPassword(MemberTO to) { // 이메일로 회원을 확인하고, 임시비밀번호 부여 후 임시비밀번호 return
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			 
			try {
				 String str = "";
				 
				 conn = this.dataSource.getConnection();
				 
				 String sql = "select id, name, password from member where email=?";
				 
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, to.getEmail());
				 
				 rs = pstmt.executeQuery();
				 
				 while(rs.next()){
					 to.setId(rs.getString("id"));
					 to.setName(rs.getString("name"));
					 to.setPassword(rs.getString("password"));
					 
					 if(to.getPassword() != null) {
						 char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
								 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
						 str = "";
						 // 문자 배열 길이의 값을 랜덤으로 10개를 뽑아 구문을 작성함
						 int idx = 0;
						 for (int i = 0; i < 10; i++) {
							 idx = (int)(charSet.length * Math.random());
							 str += charSet[idx]; // str 에 랜덤하게 담긴 비빌번호 임시값 들어감.
						 }
					 }
					 to.setTemporaryPW(str);
					 updateTemporaryPassword(to); // 임시비밀번호 저장 메서드 호출
				 }
				 
			} catch (SQLException e){
				System.out.println( "[에러] " +  e.getMessage());
			} finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if(conn != null) try {conn.close();} catch(SQLException e) {}
				if(rs != null) try {rs.close();} catch(SQLException e) {}
			}
			return to;
		}
		
		public void updateTemporaryPassword(MemberTO to) { // 임시비밀번호 저장 메서드
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			try {
				
				 conn = this.dataSource.getConnection();
				 
				 String sql = "update member set password = ? where email = ?";
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1,to.getTemporaryPW());
				 pstmt.setString(2,to.getEmail());
				 pstmt.executeUpdate();
		
			} catch (SQLException e){
				System.out.println( "[에러] " +  e.getMessage());
			} finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if(conn != null) try {conn.close();} catch(SQLException e) {}
			}
		}
		
	public ArrayList<MemberTO> memberList() {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			ArrayList<MemberTO> memberLists = new ArrayList<>();
			try {
				
				conn = this.dataSource.getConnection();
				
				String sql = "select seq, name, id, email, birthday from member order by seq desc  limit 0, 20 ";
				pstmt = conn.prepareStatement( sql );
				
				rs = pstmt.executeQuery();
				
				while( rs.next() ) {
					MemberTO to = new MemberTO();
					to.setSeq(rs.getInt("seq"));
					to.setName (rs.getString( "name" ));
					to.setId(rs.getString("id"));
					to.setEmail (rs.getString( "email" ));
					to.setBirthday(rs.getString("birthday"));
					
					memberLists.add(to);
				}

			} catch( SQLException e ) {
				System.out.println( "[에러] " + e.getMessage() );
			} finally {
				if( rs != null ) try{rs.close();} catch(SQLException e) {}
				if( pstmt != null ) try{pstmt.close();} catch(SQLException e) {}
				if( conn != null ) try{conn.close();} catch(SQLException e) {}
			}
			
			return memberLists;
		}
	 public int memberDelete(int seq) {
		  
		  Connection conn = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null; 
		  int result = 0;
		  
		  try {
			  conn = this.dataSource.getConnection();
			  
			  String  sql = "delete from member where seq = ?";
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

