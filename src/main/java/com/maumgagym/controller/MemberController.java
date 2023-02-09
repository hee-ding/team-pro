package com.maumgagym.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.BoardDAO;


@Controller
public class MemberController {
	
	@Autowired
	private BoardDAO dao;
	
	// 아래는 샘플 코드입니다. 삭제 후 사용해주세요.
	// '/board/list/' 요청에 대해서 응답
	// {pageNumber}은 변수처리
	// URL에는 동사가 아닌 명사를 사용
	// 파라미터가 많아질 경우 @RequestParam HashMap<String,String> paramMap) 으로 받기
	/* 예)
		게시판 목록		/board
		게시글 작성화면		/board/write	method => get
		게시글 작성		/board/write	method => post
		게시글 상세화면		/board/글번호		method => get
		게시글 수정		/board/글번호		method => put
		게시글 삭제		/board/글번호		method => delete
	*/
	public ModelAndView list( HttpServletRequest request, @PathVariable("pageNumber") int pageNumber ) { 
		
		// 파라미터를 확인하기 위한 주석
		// System.out.println( pageNumber ); 
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("homePage");
		
		return modelAndView;
		
	}
}
