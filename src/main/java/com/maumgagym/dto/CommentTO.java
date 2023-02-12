package com.maumgagym.dto;

import lombok.Getter;
import lombok.Setter;
@Setter
@Getter
public class CommentTO {

	int gcm;
	int gcms;
	int gcml;
	
	int seq;
	String category;
	String topic;			//토픽
	String title;
	String nickname;
	String content;
	int writer_seq;
	String write_date;
	int status;
	int board_seq;
	
	int flag;
	
}
