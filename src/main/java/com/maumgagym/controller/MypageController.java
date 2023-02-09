package com.maumgagym.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.MypageDAO;
import com.maumgagym.dto.MemberTO;


@Controller
public class MypageController {
	
	@Autowired
	private MypageDAO dao;
	
	@RequestMapping(value = "/mypage/{id}", method = RequestMethod.GET)
	public ModelAndView showMypage( HttpServletRequest request, @PathVariable("id") String id  ) { 
		
		MemberTO mto = new MemberTO();
		mto.setId( id );
		
		mto = dao.selectMember(mto);
		ModelAndView modelAndView = new ModelAndView();
		
		if( mto.getType().equals("M") ) {
			ArrayList< Map<String, Object> > arryList = dao.selectAllPurchasedMemberships(mto);
			
			modelAndView.setViewName("userPage");
			modelAndView.addObject("mto", mto );
			modelAndView.addObject("arryList", arryList );
			
		} else if ( mto.getType().equals("C") ) {
			ArrayList< Map<String, Object> > arryList = dao.selectAllPurchasedMembers(mto);
			
			modelAndView.setViewName("facilityUserPage");
			modelAndView.addObject("mto", mto );
			modelAndView.addObject("arryList", arryList );
		}
		
		return modelAndView;
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/member/nicknameCheck", method = RequestMethod.POST)
	public HashMap<String, Integer> nicknameDuplicateCheck( HttpServletRequest request ) { 
		
		MemberTO mto = new MemberTO();
		mto.setNickname( request.getParameter( "nickname" ) );
		
		int flag = dao.nicknameDuplicateCheck(mto);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("flag", flag);
		
		return map;
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/mypage", method = RequestMethod.PUT)
	public HashMap<String, Integer> updateMypage( HttpServletRequest request ) { 
		
		MemberTO mto = new MemberTO();
		mto.setName( request.getParameter( "name" ) );
		mto.setId( request.getParameter( "id" ) );
		mto.setNickname( request.getParameter( "nickname" ) );
		mto.setBirthday( request.getParameter( "birthday" ) );
		mto.setPhone( request.getParameter( "phone" ) );
		mto.setEmail( request.getParameter( "email" ) );
		mto.setFullAddress( request.getParameter( "full_address" ) );
		mto.setPassword( request.getParameter( "password" ) );
		mto.setChangePassword( request.getParameter( "change_password" ) );
		
		int flag = dao.updateMember(mto);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("flag", flag);
		
		return map;
		
	}
}

