package com.maumgagym.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class NewsTO {
	
	int seq;				// 고유 식별자
	String title;			// 제목
	String nickname;  		// 보낸사람 이름
	int TIMESTAMPDIFF;  	// 시간차이
	String type;			// 요청 종류
	String readCheck;		// 읽음 여부
	String viewCheck;		// 유지 여부
	int boardSeq;		// 글번호
	int unViewCount;
	

}
