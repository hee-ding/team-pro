package com.maumgagym.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.BoardDAO;
import com.maumgagym.dao.MemberDAO;
import com.maumgagym.dto.MemberTO;

import jdk.jfr.MemoryAddress;


@Controller
public class LoginController {
	@Autowired
	private MemberDAO dao;
	
	@RequestMapping(value = "/member/login" )
	public ModelAndView loginPage() {
	      
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("loginPage");
		
		return modelAndView;
	   }
	
	@PostMapping("/member/loginAction")
	public String loginAction(@ModelAttribute MemberTO to, HttpServletRequest request, Model model, HttpSession session) {
		//센션값 주고 전달
		
		String id = request.getParameter("id");
		String type = request.getParameter("type");
		
		session.setAttribute("id", id);          
		session.setAttribute("type", type);         
		
		to.setId(id);
		MemberTO result = dao.login(to);
		String nickname = result.getNickname();
		session.setAttribute("nickname", nickname);
		model.addAttribute("result" , result);
		return "memberloginOK";
	}
	
	@RequestMapping(value = "/member/kakaologin" )
	public String kakaologin(@ModelAttribute MemberTO to, HttpServletRequest request, Model model, HttpSession session) {
	    
		//센션값 주고 전달
		String id = request.getParameter("nickname"); //카카오는 닉네임을 id값으로 가져가도록
		String type = request.getParameter("type");
		session.setAttribute("id", id);          
		session.setAttribute("type", type);         
		
		to.setNickname(request.getParameter("nickname")); 
		to.setEmail(request.getParameter("email")); 
		
		int flag = dao.kakaologin(to);
		model.addAttribute("flag", flag);
		return "memberkakaologinOK";
	   }
	
	@RequestMapping(value = "/member/logout" )
	public ModelAndView logoutPage() {
	      
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("logoutPage");
		
		return modelAndView;
	   }
}
