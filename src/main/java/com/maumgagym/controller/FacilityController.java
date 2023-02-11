package com.maumgagym.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.FacilityDAO;
import com.maumgagym.dto.MemberTO;

@Controller
public class FacilityController {
	
	@Autowired
	private FacilityDAO dao;
	
	// 지도
	@RequestMapping(value = "/facility/loc", method = RequestMethod.GET)
	public ModelAndView facilityLoc( HttpServletRequest req ) {
		//System.out.println( "컨트롤러 /facility/loc" );
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName( "facilityMapPage" );
		
		return mav;
	}
	
	// 리스트
	@RequestMapping(value = "/facility/list", method = RequestMethod.GET)
	public ModelAndView facilityLocList( HttpServletRequest req) {
		//System.out.println( "컨트롤러 /facility/list" );
		
		String data = null;
		ArrayList facilityLists = dao.facility();
		//System.out.println("컨트롤러 주소 : " + req.getParameter( "q" ));
		data = req.getParameter( "q" );
		//System.out.println( "data : " + data );
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName( "facilityPage" );
		mav.addObject( "facilityLists", facilityLists );
		mav.addObject( "data", data );
		
		return mav;
	}
}
