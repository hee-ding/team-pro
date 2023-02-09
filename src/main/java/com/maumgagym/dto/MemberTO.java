package com.maumgagym.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MemberTO {
	
	int seq;
	String nickname;
	String id;
	String password;
	String temporaryPW;
	String changePassword;
	String name;
	String birthday;
	String Birthyy;
	String Birthmm;
	String Birthdd;
	String phone;
	String email;
	String mail1;
	String mail2;
	
	String type;
	
	String zipcode;
	String address;
	String fullAddress;
	String referAddress;
	
	
	int flag;
	
	
	public MemberTO() {
		
		// 초기값 설정 ==> 데이터베이스 오류를 의미
		this.flag = 2;
	}
}
