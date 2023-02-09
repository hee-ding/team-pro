package com.maumgagym.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
@Controller
public class CustomerCenterController {
	
	@RequestMapping(value = "/center/customerCenter_viewPage"  )
	public ModelAndView customerCenter_viewPage() {
	     
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("customerCenter_viewPage");
		
		return modelAndView;
		
	   }

}
