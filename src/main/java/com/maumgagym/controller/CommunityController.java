package com.maumgagym.controller;

import java.util.ArrayList;

import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
public class CommunityController {
	
	@Autowired
	private CommunityDAO dao;
	
	@Autowired
	private CommentDAO cmtdao;
	
	@GetMapping("/community/list")
	public ModelAndView communitylist(HttpServletRequest request) { 
		
		String strpNum = request.getParameter("pageNum"); //주소창에get방식 - ?pageNum=숫자
		int pNum = 0;
		if(strpNum == null) { //페이지값이 없을경우 무조건 1페이지로 설정
			pNum = 1;
		}else {
			pNum = Integer.parseInt(strpNum);
		}
		ArrayList<BoardTO> communityList = dao.communityList(pNum);
		int boardCount = dao.getPageNum(); 
		
		PagingDTO pto = new PagingDTO(boardCount, pNum);
		System.out.println("페이징 처리 정보 : " + pto);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("communityPage");
		modelAndView.addObject("communityList", communityList); //커뮤니티리스트
		modelAndView.addObject("boardCount", boardCount); //전체글
		modelAndView.addObject("pto", pto); // 하단 페이지네이션처리
		
		return modelAndView;
		
	}
	
	@RequestMapping("/community/write")
	public ModelAndView communitywrite(HttpServletRequest request) { 
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("community_write");
		
		return modelAndView;
		
	}
	
	@PostMapping("/community/writeok")
	public String communitywriteok( MemberTO to1, BoardTO to, HttpServletRequest request, Model model) throws NamingException { 
		
		to.setTitle(request.getParameter("subject"));
		to.setContent(request.getParameter("contents"));
		
		int category_seq = Integer.parseInt(request.getParameter("category_seq"));
		to.setCategory_seq(category_seq);
		
		to1.setNickname(request.getParameter("writer"));
		
		int flag = dao.boardWriteOK(to1, to);
		model.addAttribute("flag", flag);
		
		return "community_writeok";
		
	}
	
	@GetMapping("/community/view")
	public ModelAndView communityview( Model model, HttpServletRequest req) {
		
		ModelAndView mv = new ModelAndView();
		BoardTO bto = new BoardTO();
		MemberTO mto = new MemberTO();
		
		//1. 원글 가져온다.
		int b_seq = Integer.parseInt( req.getParameter( "seq" ) );
		bto.setSeq(b_seq);
		bto = dao.boardView(bto, mto);
		
		// 2. 리뷰를 가져온다.
		ArrayList<CommentTO> commentList = cmtdao.commentList(bto);
		
		for( CommentTO to : commentList ) {
			System.out.println( to.getContent() );
		}
		
		
		
		// 3. 원글과 리뷰를 addObject 한다.
		mv.addObject( "bto", bto );
		mv.addObject( "commentList", commentList );
		mv.setViewName("community_viewPage");
		return mv;
	}
	
	@GetMapping("/community/modify")
	public String communitymodify(int seq, Model model){ 
		BoardTO to = new BoardTO();
		to.setSeq(seq);
		
		to = dao.boardModify(to);
		model.addAttribute("to" , to); 
		
		return "community_modifyPage";
	}
	
	@PostMapping("/community/modifyok")
	public String communitymodifyok(HttpServletRequest request,BoardTO to, MemberTO to1, Model model){ 
		to.setSeq(Integer.parseInt(request.getParameter("seq"))); //board
		to.setWrite_date(request.getParameter("date")); // board
		to.setContent(request.getParameter("contents")); // board
		to.setTitle(request.getParameter("subject")); // board
		to1.setPassword(request.getParameter("password")); // member
		to1.setName(request.getParameter("subject")); // member
		
		int flag = dao.boardModifyOK(to1, to);
		model.addAttribute("flag" , flag); 
		
		return "community_modifyok";
	}

	@GetMapping("/community/delete")
	public String communitydelete(int seq, Model model){ 
		BoardTO to = new BoardTO();
		to.setSeq(seq);
		
		to = dao.boardDelete(to);
		model.addAttribute("to" , to); 
		
		return "community_deletePage";
	}
	
	@PostMapping("/community/deleteok")
	public String communitydeleteok(HttpServletRequest request,BoardTO to, MemberTO to1, Model model){ 
		to1.setPassword(request.getParameter("password")); // member
		to.setSeq(Integer.parseInt(request.getParameter("seq"))); //board
		
		int flag = dao.boardDeleteOK(to1, to);
		model.addAttribute("flag" , flag); 
		
		return "community_deleteok";
	}
	
//	//좋아요 기능을 클릭하면 해당 dao가 돌아간다.
//	@GetMapping("/community/like")
//	@ResponseBody
//	public Object communitylike(HttpServletRequest request, int seq) { 
//		
//		LikeDTO to = new LikeDTO();
//		to.setBoard_seq(seq);
//		
//		int flag = dao.communityLike(to);
//		
//		return flag;
//	}
}
