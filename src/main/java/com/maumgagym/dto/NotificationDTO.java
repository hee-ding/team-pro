package com.maumgagym.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class NotificationDTO {
	
	int seq;
	int category_seq;
	String topic;
	String subject;
	int writer_admin;
	String date;
	int hit;
	String content;

	String writer;
	String category;
	
}
