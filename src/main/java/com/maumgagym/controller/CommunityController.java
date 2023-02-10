package com.maumgagym.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class CommunityController {
	
	@RequestMapping("/community/list")
	public ModelAndView communitylist( ) { 
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("communityPage");
		
		return modelAndView;
		
	}
}
