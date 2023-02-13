package com.maumgagym.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.maumgagym.dto.ManagerTO;

@Repository
public class ManagerDAO {
	
	@Autowired
	private DataSource dataSource;
	
	public ManagerDAO() {
		
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
			this.dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" ); //항상 이부분 this로 들어가도록 주의
			
			System.out.println("db연결성공");
		} catch (NamingException e) {
			System.out.println( "[에러] " + e.getMessage() ); 
		}
	}
	
	
	 public ManagerTO managerLogin( ManagerTO to  ) { //로그인 메서드
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			
			try {
				 conn = this.dataSource.getConnection();
				 
				 String sql = "select password from admin where id = ? " ;
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, to.getId() );
				 rs = pstmt.executeQuery();
				 
				 if(rs.next()) { 
					 
					 
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

}
