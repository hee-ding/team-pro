package com.maumgagym.controller;

import java.util.ArrayList;

import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.CommentDAO;
import com.maumgagym.dao.CommunityDAO;
import com.maumgagym.dao.NotificationDAO;
import com.maumgagym.dto.BoardTO;
import com.maumgagym.dto.CommentTO;
import com.maumgagym.dto.LikeDTO;
import com.maumgagym.dto.MemberTO;
import com.maumgagym.dto.NotificationDTO;
import com.maumgagym.dto.PagingDTO;


@Controller
public class NotificationController {
	
	@Autowired
	NotificationDAO dao;
	
	@GetMapping("/notification/list")
    public ModelAndView notificationlist(HttpServletRequest request) { 
		
		  String strpNum = request.getParameter("pageNum"); //주소창에get방식 - ?pageNum=숫자
	        int pNum = 0;
	        if(strpNum == null) { //페이지값이 없을경우 무조건 1페이지로 설정
	            pNum = 1;
	        }else {
	            pNum = Integer.parseInt(strpNum);
	        }
	       
	        ArrayList<NotificationDTO> notificationList = dao.notificationList(pNum);
	        int boardCount = dao.getPageNum();  //총페이지수 구하기 위한 함수 호출
	        
	        PagingDTO pto = new PagingDTO(boardCount, pNum); //페이지네이션 처리를 위한 dto 호출
	       // System.out.println("페이징 처리 정보 : " + pto);
	        
	        ModelAndView modelAndView = new ModelAndView();
	        modelAndView.setViewName("notificationPage");
	        modelAndView.addObject("notificationList", notificationList); //커뮤니티리스트
	        modelAndView.addObject("boardCount", boardCount); //전체글
	        modelAndView.addObject("pto", pto); // 하단 페이지네이션처리
        
	        return modelAndView;
    }
	
	@GetMapping("/notification/listsearch")
    public ModelAndView notificationlistsearch(HttpServletRequest request, String keyword, int category) { 
		
		  int categorysearch = category;
		  String keywordsearch = keyword;
		  String strpNum = request.getParameter("pageNum"); //주소창에get방식 - ?pageNum=숫자
	        int pNum = 0;
	        if(strpNum == null) { //페이지값이 없을경우 무조건 1페이지로 설정
	            pNum = 1;
	        }else {
	            pNum = Integer.parseInt(strpNum);
	        }
	       
	        ArrayList<NotificationDTO> notificationList = dao.notificationsearchList(keywordsearch, pNum, categorysearch);
	        int boardCount = dao.getSearchPageNum(keywordsearch, categorysearch);  //총페이지수 구하기 위한 함수 호출
	        
	        PagingDTO pto = new PagingDTO(boardCount, pNum); //페이지네이션 처리를 위한 dto 호출
	       // System.out.println("페이징 처리 정보 : " + pto);
	        pto.setCategory(categorysearch);
	        pto.setKeyword(keywordsearch);
	        
	        ModelAndView modelAndView = new ModelAndView();
	        modelAndView.setViewName("notificationsearchPage");
	        modelAndView.addObject("notificationList", notificationList); //커뮤니티리스트
	        modelAndView.addObject("boardCount", boardCount); //전체글
	        modelAndView.addObject("pto", pto); // 하단 페이지네이션처리
        
	        return modelAndView;
    }
	
	@GetMapping("/notification/view")
    public ModelAndView notificationview(HttpServletRequest request) { 
	       
			int seq = Integer.parseInt(request.getParameter("seq"));
			
			NotificationDTO notificationDTO = dao.notificationView(seq);
			
	        ModelAndView modelAndView = new ModelAndView();
	        modelAndView.setViewName("notification_viewPage");
	        modelAndView.addObject("notificationDTO", notificationDTO);
        
	        return modelAndView;
        
    }
}