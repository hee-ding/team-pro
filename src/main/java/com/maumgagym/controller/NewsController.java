package com.maumgagym.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.maumgagym.dao.NewsDAO;
import com.maumgagym.dto.MemberTO;
import com.maumgagym.dto.NewsTO;


@Controller
public class NewsController {
	
	@Autowired
	private NewsDAO dao;
	
	@ResponseBody
	//@RequestMapping(value = "/news", method = RequestMethod.POST)
	@RequestMapping(value = "/news" )
	public String selectAllNews( HttpSession session ) { 
		
		MemberTO mto = new MemberTO();
		mto.setId( (String) session.getAttribute("id") );
		ArrayList<NewsTO> newsList = dao.selectAllNews( mto );
		NewsTO to = dao.selectUnReadNewsCount(mto);
		
        JsonObject obj = new JsonObject();
        obj.addProperty("unread_news", to.getUnViewCount() );
        
        JsonArray jsonArray = new JsonArray();
        
        for (NewsTO nto : newsList) {
        	
            JsonObject jsonObject = new JsonObject();
            
            jsonObject.addProperty( "news_seq", nto.getSeq() );
            jsonObject.addProperty( "board_seq", nto.getBoardSeq() );
            jsonObject.addProperty( "title", nto.getTitle() );
            jsonObject.addProperty( "req_member_name", nto.getNickname() );
            jsonObject.addProperty( "time_stamp_diff", nto.getTIMESTAMPDIFF() );
            jsonObject.addProperty( "type", nto.getType() );
            jsonObject.addProperty( "read_check", nto.getReadCheck() );
            jsonObject.addProperty( "view_check", nto.getViewCheck() );
            
            jsonArray.add(jsonObject);
        }
        
        obj.add("data", jsonArray);
        
        return obj.toString();
	}
	
	@RequestMapping(value = "/news/{seq}", method = RequestMethod.GET)
	public String showMypage( HttpSession session, HttpServletRequest request, @PathVariable("seq") int seq  ) { 
		
		NewsTO nto = new NewsTO();
		nto.setSeq( seq );
		
		int flag = dao.updateReadNews( nto );
		ModelAndView modelAndView = new ModelAndView();
		if( flag == 0 ) {
			return "redirect:/mypage/" + session.getAttribute("id")+"";
		} else {
			return "redirect:/500error";
		}
	}
}
