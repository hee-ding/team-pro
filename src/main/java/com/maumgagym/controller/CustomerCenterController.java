package com.maumgagym.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.CommunityDAO;
import com.maumgagym.dao.MemberDAO;
import com.maumgagym.dto.BoardTO;
@Controller
public class CustomerCenterController {
	
	@RequestMapping(value = "/customerCenter"  )
	public ModelAndView customerCenter_viewPage() {
	     
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("customerCenter_viewPage");
		
		return modelAndView;
		
	   }

}
	