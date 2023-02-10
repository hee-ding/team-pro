package com.maumgagym.controller;

import java.util.ArrayList;

import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.CommunityDAO;
import com.maumgagym.dto.BoardTO;
import com.maumgagym.dto.MemberTO;


@Controller
public class CommunityController {
	
	@Autowired
	private CommunityDAO dao;
	
	@RequestMapping("/community/list")
	public ModelAndView communitylist( ) { 
		
		ArrayList<BoardTO> communityList = dao.communityList();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("communityPage");
		modelAndView.addObject("communityList", communityList);
		
		return modelAndView;
		
	}
	
	@RequestMapping("/community/write")
	public ModelAndView communitywrite(HttpServletRequest request) { 
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("community_write");
		
		return modelAndView;
		
	}
	
	@PostMapping("/community/writeok")
	public String communitywriteok(@ModelAttribute MemberTO to1, BoardTO to, HttpServletRequest request, Model model, HttpSession session ) throws NamingException { 
		
		to.setTitle(request.getParameter("subject"));
		to.setContent(request.getParameter("contents"));
		
		int category_seq = Integer.parseInt(request.getParameter("category_seq"));
		to.setCategory_seq(category_seq);
		
		to1.setNickname(request.getParameter("writer"));
		
		int flag = dao.boardWriteOK(to1, to);
		model.addAttribute("flag", flag);
		
		return "community_writeok";
		
	}
	
	@GetMapping(value = "/community/view")
	public String communityview(HttpServletRequest request,int seq, Model model) {
		System.out.println(seq);
		BoardTO to = new BoardTO();
		to.setSeq(seq);
		
		to = dao.boardView(to);
		
		model.addAttribute("to" , to); 
		return "community_viewPage";
	}
}
