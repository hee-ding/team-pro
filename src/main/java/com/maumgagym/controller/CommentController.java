package com.maumgagym.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.CommentDAO;
import com.maumgagym.dto.BoardTO;
import com.maumgagym.dto.CommentTO;
import com.maumgagym.dto.MemberTO;


@Controller
public class CommentController {
	
	@Autowired
	private CommentDAO dao;

	@ResponseBody
	@RequestMapping( value = "/comment/write", method = RequestMethod.POST )
	public HashMap<String, Object> insertCmt( HttpServletRequest req ) { 
		
		CommentTO cto = new CommentTO();
		MemberTO mto = new MemberTO();
		BoardTO bto = new BoardTO();
		
		cto.setContent( req.getParameter( "content" ));
		cto.setWriter_seq( mto.getSeq());
		cto.setBoard_seq(bto.getSeq());
		
		
		int flag = dao.commentInsert(cto);
		
		if( cto.getFlag() == 0 ) {
			mto.setSeq( cto.getWriter_seq() );
			bto.setSeq( cto.getBoard_seq() );
			flag = dao.commentInsert(cto);
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put( "flag", flag );
		
		return map;
	}
}