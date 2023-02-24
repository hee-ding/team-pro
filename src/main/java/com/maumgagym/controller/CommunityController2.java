/*
 * package com.maumgagym.controller;
 * 
 * import java.util.ArrayList;
 * 
 * import javax.naming.NamingException; import
 * javax.servlet.http.HttpServletRequest; import javax.servlet.http.HttpSession;
 * 
 * import org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.ui.Model; import
 * org.springframework.web.bind.annotation.GetMapping; import
 * org.springframework.web.bind.annotation.ModelAttribute; import
 * org.springframework.web.bind.annotation.PathVariable; import
 * org.springframework.web.bind.annotation.PostMapping; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestMethod; import
 * org.springframework.web.bind.annotation.RequestParam; import
 * org.springframework.web.bind.annotation.ResponseBody; import
 * org.springframework.web.servlet.ModelAndView;
 * 
 * import com.maumgagym.dao.CommunityDAO; import com.maumgagym.dto.BoardTO;
 * import com.maumgagym.dto.LikeDTO; import com.maumgagym.dto.MemberTO;
 * 
 * 
 * @Controller public class CommunityController2 {
 * 
 * @Autowired private CommunityDAO dao;
 * 
 * @RequestMapping("/community/list") public ModelAndView communitylist( ) {
 * 
 * ArrayList<BoardTO> communityList = dao.communityList();
 * 
 * ModelAndView modelAndView = new ModelAndView();
 * modelAndView.setViewName("communityPage");
 * modelAndView.addObject("communityList", communityList);
 * 
 * return modelAndView;
 * 
 * }
 * 
 * @RequestMapping("/community/write") public ModelAndView
 * communitywrite(HttpServletRequest request) {
 * 
 * ModelAndView modelAndView = new ModelAndView();
 * modelAndView.setViewName("community_write");
 * 
 * return modelAndView;
 * 
 * }
 * 
 * @PostMapping("/community/writeok") public String communitywriteok( MemberTO
 * to1, BoardTO to, HttpServletRequest request, Model model) throws
 * NamingException {
 * 
 * to.setTitle(request.getParameter("subject"));
 * to.setContent(request.getParameter("contents"));
 * 
 * int category_seq = Integer.parseInt(request.getParameter("category_seq"));
 * to.setCategory_seq(category_seq);
 * 
 * to1.setNickname(request.getParameter("writer"));
 * 
 * int flag = dao.boardWriteOK(to1, to); model.addAttribute("flag", flag);
 * 
 * return "community_writeok";
 * 
 * }
 * 
 * @GetMapping("/community/view") public String communityview(int seq, Model
 * model) { BoardTO to = new BoardTO(); to.setSeq(seq);
 * 
 * to = dao.boardView(to);
 * 
 * model.addAttribute("to" , to); return "community_viewPage"; }
 * 
 * @GetMapping("/community/modify") public String communitymodify(int seq, Model
 * model){ BoardTO to = new BoardTO(); to.setSeq(seq);
 * 
 * to = dao.boardModify(to); model.addAttribute("to" , to);
 * 
 * return "community_modifyPage"; }
 * 
 * @PostMapping("/community/modifyok") public String
 * communitymodifyok(HttpServletRequest request,BoardTO to, MemberTO to1, Model
 * model){ to.setSeq(Integer.parseInt(request.getParameter("seq"))); //board
 * to.setWrite_date(request.getParameter("date")); // board
 * to.setContent(request.getParameter("contents")); // board
 * to.setTitle(request.getParameter("subject")); // board
 * 
 * to1.setPassword(request.getParameter("password")); // member
 * to1.setName(request.getParameter("subject")); // member
 * 
 * int flag = dao.boardModifyOK(to1, to); model.addAttribute("flag" , flag);
 * 
 * return "community_modifyok"; }
 * 
 * @GetMapping("/community/delete") public String communitydelete(int seq, Model
 * model){ BoardTO to = new BoardTO(); to.setSeq(seq);
 * 
 * to = dao.boardDelete(to); model.addAttribute("to" , to);
 * 
 * return "community_deletePage"; }
 * 
 * @PostMapping("/community/deleteok") public String
 * communitydeleteok(HttpServletRequest request,BoardTO to, MemberTO to1, Model
 * model){ to1.setPassword(request.getParameter("password")); // member
 * to.setSeq(Integer.parseInt(request.getParameter("seq"))); //board
 * 
 * int flag = dao.boardDeleteOK(to1, to); model.addAttribute("flag" , flag);
 * 
 * return "community_deleteok"; }
 * 
 * //좋아요 기능을 클릭하면 해당 dao가 돌아간다.
 * 
 * @GetMapping("/community/like")
 * 
 * @ResponseBody public Object communitylike(HttpServletRequest request, int
 * seq) {
 * 
 * LikeDTO to = new LikeDTO(); to.setBoard_seq(seq);
 * 
 * int flag = dao.communityLike(to);
 * 
 * return flag; } }
 */