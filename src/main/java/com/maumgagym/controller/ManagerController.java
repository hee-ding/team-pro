package com.maumgagym.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.Manager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.BoardDAO;
import com.maumgagym.dao.CommentDAO;
import com.maumgagym.dao.ManagerDAO;
import com.maumgagym.dao.MemberDAO;
import com.maumgagym.dto.BoardTO;
import com.maumgagym.dto.CommentTO;
import com.maumgagym.dto.MemberShipTO;
import com.maumgagym.dto.MemberTO;
import com.maumgagym.dto.ManagerTO;
import com.maumgagym.dto.PayTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ManagerController {
	
	@Autowired
	private BoardDAO bdao;
	@Autowired
	private MemberDAO mdao;
	@Autowired
	private CommentDAO cdao;
	@Autowired
	private ManagerDAO mmdao;
	
	@RequestMapping("/manager/board")
	public ModelAndView boardlist( ) { 
		
		ArrayList<BoardTO> boardLists = bdao.boardList();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("managerBoardPage");
		modelAndView.addObject("boardList", boardLists);
		
		return modelAndView;
		
	}
	@RequestMapping("/manager/facilityboard")
	public ModelAndView facilityBoardList( ) { 
		ArrayList<BoardTO> facilityBoardLists = bdao.facilityBoardList();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("managerFacilityBoardPage");
		modelAndView.addObject("facilityBoardList", facilityBoardLists);
		
		return modelAndView;
		
	}
	@RequestMapping("/manager/main")
	public ModelAndView mainList( ) { 
		ArrayList<BoardTO> facilityBoardLists = bdao.facilityBoardList();
		ArrayList<BoardTO> boardLists = bdao.boardList();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("managerMainPage");
		modelAndView.addObject("facilityBoardList", facilityBoardLists);
		modelAndView.addObject("boardList", boardLists);
		
		return modelAndView;
		
	}
	@RequestMapping("/manager/comment")
	public ModelAndView commentList( ) { 
		
		BoardTO bto = new BoardTO();
		ArrayList<CommentTO> commentLists = cdao.commentList(bto);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("managerCommentPage");
		modelAndView.addObject("commentList", commentLists);
		
		return modelAndView;

	}
	
	@RequestMapping("/manager/member")
	public ModelAndView member(){ 
		ArrayList<MemberTO> memberLists = mdao.memberList();		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("managerMemberPage");
		modelAndView.addObject("memberList", memberLists);
		
		return modelAndView;
		
	}
	
	@ResponseBody
	@RequestMapping("/manager/boardDelete")
	public Map<String, Object> boardDelete( HttpServletRequest request, @RequestParam int seq) {
		int result = bdao.boardDelete(seq);
		log.debug("boardDelete");
		Map<String, Object> param = new HashMap<>();
		
		if(result > 0) {
			param.put("msg", "success");
		}else {
			param.put("msg", "fail...");
		}
		return param;
	}
	
	@ResponseBody
	@RequestMapping("/manager/facilityBoardDelete")
	public Map<String, Object> facilityBoardDelete( HttpServletRequest request, @RequestParam int seq) {
		int result = bdao.facilityBoardDelete(seq);
		log.debug("facilityBoardDelete");
		Map<String, Object> param = new HashMap<>();
		
		if(result > 0) {
			param.put("msg", "success");
		}else {
			param.put("msg", "fail...");
		}
		return param;
	}
	
	@ResponseBody
	@RequestMapping("/manager/commentDelete")
	public Map<String, Object> commentDelete( HttpServletRequest request, @RequestParam int seq) {
		int result = cdao.commentDelete(seq);
		log.debug("commentDelete");
		Map<String, Object> param = new HashMap<>();
		
		if(result > 0) {
			param.put("msg", "success");
		}else {
			param.put("msg", "fail...");
		}
		return param;
	}
	
	@ResponseBody
	@RequestMapping("/manager/memberDelete")
	public Map<String, Object> memberDelete( HttpServletRequest request, @RequestParam int seq) {
		int result = mdao.memberDelete(seq);
		log.debug("memberDelete");
		Map<String, Object> param = new HashMap<>();
		
		if(result > 0) {
			param.put("msg", "success");
		}else {
			param.put("msg", "fail...");
		}
		return param;
	}
	
		
	@RequestMapping("/manager/login" )
	public ModelAndView manageLoginPage() {
	      
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("managerLoginPage");
		
		return modelAndView;
	   }
	
	@PostMapping("/manager/loginAction")
	public String loginAction(@ModelAttribute ManagerTO to, HttpServletRequest request, Model model, HttpSession session) {
		//센션값 주고 전달
		
		String id = request.getParameter("id");
		
		session.setAttribute("id", id);          
		
		to.setId(id);
		ManagerTO result = mmdao.managerLogin(to);
		model.addAttribute("result" , result);
		return "managerLoginOK";
	}
	
	
}
