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
import com.maumgagym.dto.BoardTO;
import com.maumgagym.dto.CommentTO;
import com.maumgagym.dto.LikeDTO;
import com.maumgagym.dto.MemberTO;
import com.maumgagym.dto.PagingDTO;


@Controller
public class Notification {
	
	@GetMapping("/notification/list")
    public ModelAndView notificationlist(HttpServletRequest request) { 
        
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("notificationPage");
        
        return modelAndView;
        
    }
}