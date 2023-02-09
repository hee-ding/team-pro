package com.maumgagym.controller;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.BoardDAO;
import com.maumgagym.dto.BoardTO;
import com.maumgagym.dto.MemberTO;
import com.maumgagym.dto.ReviewTO;


@Controller
public class BoardController {
	
	@Autowired
	private BoardDAO dao;
	
	@RequestMapping(value = "/facility/{seq}", method = RequestMethod.GET)
	public ModelAndView list( HttpServletRequest request, @PathVariable("seq") int seq ) { 
		
		//파라미터를 확인하기 위한 주석
		//System.out.println( "parameter" + seq );
		
		BoardTO bto = new BoardTO();
		bto.setSeq(seq);
		
		Map<String, Object> map = dao.selectFacilityBoard(bto);
		map.put( "membershipList", dao.selectMemberShips(bto) );
		map.put( "noticeList" , dao.selectNotices(bto) );
		map.put( "imageList", dao.selectImages(bto) );
		map.put( "reviewList", dao.selectReviews(bto) );
		
		System.out.println( "=================================" );
		bto = (BoardTO) map.get( "bto" );
		String title = bto.getTitle();
		System.out.println( title );
		
		MemberTO mto = (MemberTO) map.get( "mto" );
		String fullAdress = mto.getFullAddress();
		System.out.println( fullAdress );
		String phone = mto.getPhone();
		System.out.println( phone );
		
		ReviewTO rvto = (ReviewTO) map.get("rvto");
		Float avgStarScore = rvto.getAvg_star_score();
		System.out.println( avgStarScore );
		
		ArrayList<ReviewTO> reviewList = (ArrayList) map.get("reviewList");
		 
		for( ReviewTO rvto2 : reviewList ) {
			
			String nickname = rvto2.getNickname();
			String writeDate = rvto2.getWrite_date();
			String content = rvto2.getContent();
			
			System.out.println( nickname );
			System.out.println( writeDate );
			System.out.println( content );
		}
		System.out.println( "=================================" );
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("map", map );
		modelAndView.setViewName("viewPage");
		
		return modelAndView;
		
	}
}
