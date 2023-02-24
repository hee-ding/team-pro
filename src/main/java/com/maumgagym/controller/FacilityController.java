package com.maumgagym.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.maumgagym.dao.FacilityDAO;
import com.maumgagym.dao.MypageDAO;
import com.maumgagym.dto.BoardTO;
import com.maumgagym.dto.MemberShipTO;
import com.maumgagym.dto.MemberTO;

@Controller
public class FacilityController {
	
	@Autowired
	private FacilityDAO dao;
	
	@Autowired
	private MypageDAO mydao;
	
	private String uploadPath = "C:\\java2\\teamproject-workspace\\SpringBoot_Maumgagym\\src\\main\\webapp\\upload";
	
	// 지도
	@RequestMapping(value="/facility/loc", method=RequestMethod.GET)
	public ModelAndView facilityLoc( HttpServletRequest req ) {
		//System.out.println( "컨트롤러 /facility/loc" );
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName( "facilityMapPage" );
		
		return mav;
	}
	
	// 리스트
	@RequestMapping(value="/facility", method=RequestMethod.GET)
	public ModelAndView facilityLocList( HttpServletRequest req) {
		//System.out.println( "컨트롤러 /facility/list" );
		
		String data = null;
		ArrayList facilityLists = dao.facility();
		//System.out.println("컨트롤러 주소 : " + req.getParameter( "address" ));
		data = req.getParameter( "address" );
		//System.out.println( "data : " + data );
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName( "facilityPage" );
		mav.addObject( "facilityLists", facilityLists );
		mav.addObject( "data", data );
		
		return mav;
	}
	
	//쓰기
	@RequestMapping(value="/facility/write", method=RequestMethod.GET)
	public ModelAndView facilityWrite( HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName( "facilityWritePage" );
		
		return mav;
	}
	
	@RequestMapping(value="/facility/writeOK", method=RequestMethod.POST)
	public ModelAndView facilityWriteOk(HttpServletRequest req, Model model, MultipartFile upload, HttpSession session ) {
		
		ModelAndView mav = new ModelAndView();
		
		// 1. 사진을 저장합니다.
		String saveFileName = UUID.randomUUID().toString() + upload.getOriginalFilename().substring( upload.getOriginalFilename().indexOf(".") );
		try { upload.transferTo( new File( saveFileName ) ); } catch (IOException e) { System.out.println( "[에러] :" + e.getMessage()); }	
		
		
		// 2. 세션을 통해 얻은 아이디로 member_seq을 가져옵니다. MypageDAO 사용
		MemberTO mto = new MemberTO();
		mto.setId( (String) session.getAttribute("id") );
		mto = mydao.selectMember(mto);
		
		
		// 3. 게시글을 작성합니다.
		BoardTO bto = new BoardTO();
		bto.setCategory_seq( Integer.parseInt( req.getParameter("category") ) );
		bto.setTitle( req.getParameter("title") );
		bto.setContent( req.getParameter("content") );
		bto.setWrite_seq( mto.getSeq() );
		int flag = dao.insertfacilityBoard(bto);
		
		
		//4. 저장된 게시글의 seq를 가져옵니다.
		bto = dao.selectfacilityBoard(bto);
		
		int boardSeq = bto.getSeq();
		
		// 5. 게시글이 정상적으로 작성이 되었다면, 사진의 정보를 DB에 insert 합니다.
		// 그게 아니라면 500eroor 페이지로 이동시킵니다.
		if( flag == 0) {
			bto.setImage_name(saveFileName);
			bto.setImage_size(upload.getSize());
			flag = dao.insertfacilityImage(bto);
		}  else {
			mav.setViewName( "error/500error" );
			return mav;
		}
		
		
		// 6. 사진의 정보를 DB에 정상적으로 insert 했다면, 회원권을 등록합니다.
		// 그게 아니라면 500eroor 페이지로 이동시킵니다.
		if( flag == 0) {
		
			if ( !req.getParameter("membership1").equals("") ) {
				
				MemberShipTO msto = new MemberShipTO();
				msto.setMembership_name("1개월권");
				msto.setMembership_price( Integer.parseInt( req.getParameter("membership1") ) );
				msto.setMembership_period(1);
				
				flag = dao.insertfacilityMembership(bto, msto);
			}
			
			if ( !req.getParameter("membership3").equals("") ) {
				
				MemberShipTO msto = new MemberShipTO();
				msto.setMembership_name("3개월권");
				msto.setMembership_price( Integer.parseInt( req.getParameter("membership3") ) );
				msto.setMembership_period(3);
				
				flag = dao.insertfacilityMembership(bto, msto);
				
			}
			
			if ( !req.getParameter("membership6").equals("") ) {
				
				MemberShipTO msto = new MemberShipTO();
				msto.setMembership_name("6개월권");
				msto.setMembership_price( Integer.parseInt( req.getParameter("membership6") ) );
				msto.setMembership_period(6);
				
				flag = dao.insertfacilityMembership(bto, msto);
			}
			
			if (  !req.getParameter("membership12").equals("") ) {
				
				MemberShipTO msto = new MemberShipTO();
				msto.setMembership_name("12개월권");
				msto.setMembership_price( Integer.parseInt( req.getParameter("membership12") ) );
				msto.setMembership_period(12);
				
				flag = dao.insertfacilityMembership(bto, msto);
				
			}
		
		}  else {
			mav.setViewName( "error/500error" );
			return mav;
		}
		
		mav.addObject( "flag", flag );
		mav.addObject( "board_seq",  bto.getSeq() );
		mav.setViewName( "facility_writeOkPage" );
		return mav;
	}

}