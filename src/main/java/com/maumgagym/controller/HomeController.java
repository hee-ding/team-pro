package com.maumgagym.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.HomeDAO;
import com.maumgagym.dao.NewsDAO;
import com.maumgagym.dto.BoardTO;


@Controller
public class HomeController {
	
	@Autowired
	private HomeDAO dao;
	
	@RequestMapping( value = "/home", method = RequestMethod.GET )
	public ModelAndView selectRecommendedList( ) { 
		
		BoardTO bto = new BoardTO();
		bto.setTag( "마음가짐" );
		
		ArrayList<BoardTO> recommendedList = dao.selectRecommendedList( bto );
		ArrayList<BoardTO> FacilityBoardCountList = dao.selectFacilityBoardCountList();
		ArrayList<BoardTO> weeklyBoardList = dao.selectWeeklyBoardList();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("homePage");
		modelAndView.addObject("recommendedList", recommendedList);
		modelAndView.addObject("FacilityBoardCountList", FacilityBoardCountList);
		modelAndView.addObject("weeklyBoardList", weeklyBoardList);
		
		return modelAndView;
	}
	
}
