package com.maumgagym.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.SearchDAO;

@Controller
public class SearchController {
	
	@Autowired
	private SearchDAO dao;
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public ModelAndView searchList( HttpServletRequest req) {
		//System.out.println( "컨트롤러 /search/list" );
		
		String data = null;
		ArrayList searchLists = dao.searchresult();
		//System.out.println("컨트롤러 검색어 : " + req.getParameter( "search" ));
		data = req.getParameter( "search" );
		//System.out.println( "data : " + data );
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName( "searchPage" );
		mav.addObject( "searchLists", searchLists  );
		mav.addObject( "data", data );
		
		return mav;
	}
}
