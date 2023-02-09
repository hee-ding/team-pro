package com.maumgagym.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.maumgagym.dto.MemberTO;

@Repository
public class loginTestDAO {
	
	@Autowired
	private DataSource dataSource = null;
		
		public loginTestDAO() {
			
			try {
				Context initCtx = new InitialContext();
				Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
				this.dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" ); //항상 이부분 this로 들어가도록 주의
				
				System.out.println("db연결성공");
			} catch (NamingException e) {
				System.out.println( "[에러] " + e.getMessage() ); 
			}
		}
		
		public int writeUser(MemberTO to){
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			int flag = 1;
			
			try {
				 conn = this.dataSource.getConnection();
				 
				 String sql = "insert into kakao_login values ( 0,0,?,? )";
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

}
