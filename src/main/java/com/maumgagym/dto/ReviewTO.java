package com.maumgagym.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ReviewTO {
	
	int seq;
	String nickname;
	String content;
	String write_date;
	int writer_seq;
	float star_score;
	float avg_star_score;
	String status;
	int board_seq;
	
	int flag;
	String merchant_uid;
	

}
