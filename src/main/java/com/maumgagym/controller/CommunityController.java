package com.maumgagym.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.CommunityDAO;
import com.maumgagym.dto.BoardTO;


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
}
