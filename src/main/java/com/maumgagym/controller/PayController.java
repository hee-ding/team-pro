package com.maumgagym.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.BoardDAO;
import com.maumgagym.dao.PayDAO;
import com.maumgagym.dto.MemberShipTO;
import com.maumgagym.dto.MemberTO;
import com.maumgagym.dto.PayTO;


@Controller
public class PayController {
	
	@Autowired
	private PayDAO dao;
	
	@ResponseBody
	@RequestMapping(value = "/pay/information", method = RequestMethod.GET)
	public HashMap<String, Object> selectRegisterMembership( HttpServletRequest request ) {
		int flag = 9;
		MemberTO mto = new MemberTO();
		mto.setNickname( request.getParameter("buyer_nickname") );
		MemberShipTO msto = new MemberShipTO();
		msto.setMembership_seq( Integer.valueOf( request.getParameter("membership_seq") ) );
		PayTO pto = new PayTO();
		
		mto = dao.selectMember( mto );
		msto = dao.selectPurchaseMembership( msto );
		if( mto.getFlag() == msto.getFlag() ) { flag = 0; }
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("merchant_uid", pto.getMerchant_uid() );
		map.put("name", msto.getMembership_name() );
		map.put("amount", msto.getMembership_price() );
		map.put("buyer_email", mto.getEmail() );
		map.put("buyer_name", mto.getName() );
		map.put("buyer_tel", mto.getPhone() );
		map.put("buyer_addr", mto.getFullAddress() );
		map.put("buyer_postcode", mto.getZipcode() );
		map.put("buyer_seq", mto.getSeq() );
		map.put("flag", flag );
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/pay", method = RequestMethod.POST)
	public HashMap<String, Object> insertPurchasedMembership( HttpServletRequest request ) {
		
		MemberTO mto = new MemberTO();
		mto.setSeq( Integer.valueOf( request.getParameter("buyer_seq") ) );
		
		PayTO pto = new PayTO();
		pto.setImp_uid( request.getParameter("imp_uid") );
		pto.setMerchant_uid( request.getParameter("merchant_uid") );
		pto.setType( request.getParameter("pay_method") );
		pto.setMembership_seq( Integer.valueOf( request.getParameter("membership_seq") ) );
		
		int flag = dao.insertPurchasedMembership( mto, pto );
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("flag", flag );
		return map;
	}
	
	@RequestMapping(value = "/pay/success", method = RequestMethod.GET)
	public ModelAndView showPaySuccessPage( ) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pay/success");
		return modelAndView;
	}
	
	@RequestMapping(value = "/pay/fail", method = RequestMethod.GET)
	public ModelAndView showPayFailPage( ) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pay/fail");
		return modelAndView;
	}
}
