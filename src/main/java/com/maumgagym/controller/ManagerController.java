package com.maumgagym.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.BoardDAO;
import com.maumgagym.dao.MemberDAO;
import com.maumgagym.dto.BoardTO;
import com.maumgagym.dto.MemberTO;


@Controller
public class ManagerController {
	
	@Autowired
	private BoardDAO bdao;
	private MemberDAO mdao;
	
	@RequestMapping("/manager/board")
	public ModelAndView boardlist( ) { 
		
		ArrayList<BoardTO> boardLists = bdao.boardList();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("managerBoardPage");
		modelAndView.addObject("boardList", boardLists);
		
		return modelAndView;
		
	}
	@RequestMapping("/manager/facilityboard")
	public ModelAndView facilityBoardList( ) { 
		ArrayList<BoardTO> facilityBoardLists = bdao.facilityBoardList();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("managerFacilityBoardPage");
		modelAndView.addObject("facilityBoardList", facilityBoardLists);
		
		return modelAndView;
		
	}
	@RequestMapping("/manager/main")
	public ModelAndView mainList( ) { 
		ArrayList<BoardTO> facilityBoardLists = bdao.facilityBoardList();
		ArrayList<BoardTO> boardLists = bdao.boardList();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("managerMainPage");
		modelAndView.addObject("facilityBoardList", facilityBoardLists);
		modelAndView.addObject("boardList", boardLists);
		
		return modelAndView;
		
	}
//	@RequestMapping("/manager/comment")
//	public ModelAndView commentList( ) { 
//		ArrayList<BoardTO> facilityBoardLists = dao.facilityBoardList();
//		
//		ModelAndView modelAndView = new ModelAndView();
//		modelAndView.setViewName("managerCommentPage");
//		modelAndView.addObject("facilityBoardList", facilityBoardLists);
//		
//		return modelAndView;
//		
//	}
	
	@RequestMapping("/manager/member")
	public ModelAndView memberList( ) { 
		ArrayList<MemberTO> memberLists = mdao.memberList();		
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("managerMemberPage");
		modelAndView.addObject("memberList", memberLists);
		
		return modelAndView;
		
	}
	
}
