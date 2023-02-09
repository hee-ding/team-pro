package com.maumgagym.dto;

import java.util.ArrayList;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class PageTO {
	
	private int cpage;
	private int recordPerPage;
	private int blockPerPage;
	private int totalPage;
	private int totalRecord;
	private int startBlock;
	private int endBlock;
	
	int flag;
	
	private ArrayList<BoardTO> boardLists; 
	
	public PageTO() {
		
		// 기본 페이지 설정 
		this.cpage = 1;
		
		// 페이지 당 글 수
		this.recordPerPage = 10;
		
		// <- 1 2 3 4 5 -> 와 같이 한 페이지당 클릭가능한 페이지 수
		this.blockPerPage = 5;
		
		// 기본 전체 페이지 수
		this.totalPage = 1;
		
		// 기본 전체 글 수
		this.totalRecord = 0;
		
	}
	
}
