package com.maumgagym.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class ErrorController {
	
	@RequestMapping( value = "/500error" )
	public ModelAndView selectRecommendedList( ) { 
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("error/500error");
		return modelAndView;
	}
	
}
