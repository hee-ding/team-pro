package com.maumgagym.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.MypageDAO;
import com.maumgagym.dto.BoardTO;
import com.maumgagym.dto.MemberShipTO;
import com.maumgagym.dto.MemberTO;
import com.maumgagym.dto.PayTO;


@Controller
public class MypageController {
	
	@Autowired
	private MypageDAO dao;
	
	@RequestMapping(value = "/mypage/{id}", method = RequestMethod.GET)
	public ModelAndView showMypage(  HttpSession session, HttpServletRequest request, @PathVariable("id") String id  ) { 
		
		System.out.println( session.getAttribute("id") );
		
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
	
	@ResponseBody
	@RequestMapping( value = "/membership/request", method = RequestMethod.POST )
	public HashMap<String, Integer> insertRequestMembership( HttpServletRequest request ) {
		
		MemberTO mto = new MemberTO();
		mto.setSeq( Integer.valueOf( request.getParameter( "req_member_seq" ) ) );
		
		BoardTO bto = new BoardTO();
		bto.setSeq( Integer.valueOf( request.getParameter( "board_seq" ) ) );
		
		PayTO pto = new PayTO();
		pto.setMerchant_uid( request.getParameter( "merchant_uid" ) );
		
		int flag = dao.InsertRequestMembership(pto);
		
		if( flag == 0 ) {
			flag = dao.InsertNews( mto, bto );
		}
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("flag", flag);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping( value = "/membership/approve", method = RequestMethod.PUT )
	public HashMap<String, Integer> updateApprovalMembership( HttpServletRequest request ) { 
		
		PayTO pto = new PayTO();
		pto.setMerchant_uid( request.getParameter( "merchant_uid" ) );

		MemberShipTO msto = dao.selectMembershipPeriod(pto);
		int flag = dao.updateApprovalMembership( msto, pto );
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("flag", flag);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping( value = "/membership/pause", method = RequestMethod.PUT )
	public HashMap<String, Integer> pauseDuplicateCheck( HttpServletRequest request ) { 
		// flag 0 정상
		// flag 1 정지 1회 초과
		// flag 8 비정상 조회
		// flag 9 서버 오류
		PayTO pto = new PayTO();
		pto.setMerchant_uid( request.getParameter( "merchant_uid" ) );
		
		int flag = dao.pauseDuplicateCheck(pto);
		if( flag == 0 ) {
			pto = dao.selectRegisterMembership(pto);
			flag = dao.insertPauseMembership(pto);
			if( flag == 0 ) {
				flag = dao.updatePauseMembership(pto);
			}
		}
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("flag", flag);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/membership/restart", method = RequestMethod.PUT)
	public HashMap<String, Integer> updateRestartMembership( HttpServletRequest request ) { 
		// flag 0 정상
		// flag 1 멤버쉽 재개를 위한 membership_hold 테이블 변경 오류
		// flag 2 멤버쉽 재개를 위한 membership_register 테이블 변경 오류
		// flag 8 비정상 조회
		// flag 9 서버 오류
		PayTO pto = new PayTO();
		pto.setMerchant_uid( request.getParameter( "merchant_uid" ) );
		
		pto = dao.selectRegisterMembership(pto);
		pto = dao.selectPauseMembershipInfo(pto);
		int flag = dao.updateRestartMembership(pto);
		if( flag == 0 ) {
			pto = dao.selectPauseMembershipInfo(pto);
			flag = dao.updateRestartMembershipInfo(pto);
		}
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put( "flag", flag );
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/membership/refund", method = RequestMethod.PUT)
	public HashMap<String, Integer> updateRefundMembership( HttpServletRequest request ) { 
		// flag 0 정상
		// flag 1 pay 테이블 update 오류
		// flag 2 register 테이블 update 오류
		// flag 8 비정상 조회
		// flag 9 서버 오류
		PayTO pto = new PayTO();
		pto.setMerchant_uid( request.getParameter("merchant_uid") );
		
		int flag = dao.updateRefundMembershipOfPay(pto);
		if( flag == 0 ) {
			flag = dao.updateRefundMembershipOfRegister(pto);
		}
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("flag", flag );
		
		return map;
	}
	
	
	/*
	
	@ResponseBody
	@RequestMapping(value = "/membership/register", method = RequestMethod.GET)
	public HashMap<String, Object> selectRegisterMembership( HttpServletRequest request ) { 
		
		PayTO pto = new PayTO();
		pto.setMerchant_uid( request.getParameter("merchant_uid") );
		
		pto = dao.selectRegisterMembership(pto);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("register_seq", pto.getMembership_register_seq() );
		map.put("expiry_date", pto.getMembership_expiry_date() );
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/membership/pause", method = RequestMethod.POST)
	public HashMap<String, Object> insertPauseMembership( HttpServletRequest request ) { 
		
		PayTO pto = new PayTO();
		pto.setMembership_register_seq( Integer.valueOf( request.getParameter("register_seq") ) );
		
		int flag = dao.insertPauseMembership(pto);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("register_seq", pto.getMembership_register_seq() );
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/membership/pause", method = RequestMethod.PUT)
	public HashMap<String, Integer> updatePauseMembership( HttpServletRequest request ) { 
		
		PayTO pto = new PayTO();
		pto.setMembership_register_seq( Integer.valueOf( request.getParameter("register_seq") ) );
		
		int flag = dao.updatePauseMembership(pto);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("flag", flag );
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/membership/pay/refund", method = RequestMethod.PUT)
	public HashMap<String, Integer> updateRefundMembershipOfPay( HttpServletRequest request ) { 
		
		PayTO pto = new PayTO();
		pto.setMerchant_uid( request.getParameter("merchant_uid") );
		
		int flag = dao.updateRefundMembershipOfPay(pto);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("flag", flag );
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/membership/register/refund", method = RequestMethod.PUT)
	public HashMap<String, Integer> updateRefundMembershipOfRegister( HttpServletRequest request ) { 
		
		PayTO pto = new PayTO();
		pto.setMerchant_uid( request.getParameter("merchant_uid") );
		
		int flag = dao.updateRefundMembershipOfRegister(pto);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("flag", flag );
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/membership/period/{merchant_uid}", method = RequestMethod.GET)
	public HashMap<String, Object> updateRefundMembershipOfRegister( HttpServletRequest request, @PathVariable("merchant_uid") String merchantUid ) { 
		
		PayTO pto = new PayTO();
		pto.setMerchant_uid( merchantUid );
		
		MemberShipTO msto = dao.selectMembershipPeriod(pto);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put( "membership_period", msto.getMembership_period() );
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/membership/pause/{register_seq}", method = RequestMethod.GET)
	public HashMap<String, Object> selectPauseMembershipInfo( HttpServletRequest request, @PathVariable("register_seq") int seq ) { 
		
		PayTO pto = new PayTO();
		pto.setMembership_register_seq( seq );
		
		pto = dao.selectPauseMembershipInfo(pto);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put( "hold_date", pto.getHold_date() );
		map.put( "hold_sum_date", pto.getHold_sum_date() );
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/membership/pause/restart", method = RequestMethod.PUT)
	public int updateRestartMembership( HttpServletRequest request ) { 
		
		PayTO pto = new PayTO();
		pto.setHold_date( request.getParameter("hold_date") );
		pto.setMembership_register_seq( Integer.valueOf( request.getParameter("register_seq") ) );
		
		int flag = dao.updateRestartMembership(pto);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put( "flag", flag );
		
		return flag;
	}
	
	@ResponseBody
	@RequestMapping(value = "/membership/register/restart", method = RequestMethod.PUT)
	public HashMap<String, Integer> updateRestartMembershipInfo( HttpServletRequest request ) { 
		
		PayTO pto = new PayTO();
		pto.setMembership_expiry_date( request.getParameter("expiry_date") );
		pto.setHold_sum_date( request.getParameter("hold_sum_date") );
		pto.setMerchant_uid( request.getParameter("merchant_uid"));
		
		int flag = dao.updateRestartMembershipInfo(pto);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put( "flag", flag );
		
		return map;
	}
	*/
}

