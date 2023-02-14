package com.maumgagym.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

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
import com.maumgagym.dto.BoardTO;
import com.maumgagym.dto.MemberTO;

@Controller
public class FacilityController {
	
	@Autowired
	private FacilityDAO dao;
	
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
		System.out.println( "쓰기 페이지" );
		ModelAndView mav = new ModelAndView();
		mav.setViewName( "facilityWritePage" );
		
		return mav;
	}
	
	@RequestMapping(value="/facility/writeOK", method=RequestMethod.POST)
	public String facilityWriteOk(HttpServletRequest req, Model model, MultipartFile upload) {

		BoardTO bto = new BoardTO();
		bto.setTitle( req.getParameter( "subject" ));
		bto.setContent( req.getParameter( "content" ));
		bto.setCategory_seq(Integer.parseInt(req.getParameter( "category" )) );
		
		MemberTO mto = new MemberTO();
		mto.setNickname( req.getParameter( "nickname" ));
		
		System.out.println( "title : " + req.getParameter( "subject" ));
		System.out.println( "content : " + req.getParameter( "content" ));
		System.out.println( "category : " + req.getParameter( "category" ));
		System.out.println( "seq : " + bto.getSeq());
		
		String saveFileName = UUID.randomUUID().toString() + upload.getOriginalFilename().substring( upload.getOriginalFilename().indexOf(".") );
		System.out.println( "파일 이름 : " + upload.getOriginalFilename() );
		try {
		if( !upload.isEmpty() ) {
			bto.setImage_name( saveFileName );
			bto.setImage_size( upload.getSize() );
		}
		upload.transferTo(  new File( saveFileName ) );
		
		System.out.println( "이미지 : " + saveFileName );
	} catch (IllegalStateException e) {
		// TODO Auto-generated catch block
		System.out.println( "[에러] : " + e.getMessage() );
	} catch (IOException e) {
		// TODO Auto-generated catch block
		System.out.println( "[에러] : " + e.getMessage() );
	}
		
		int flag = dao.writeOk(bto, mto);
		model.addAttribute("flag", flag);
		
		return "facility_writeOkPage";
	}

//	@RequestMapping(value="/facility/uploadOk", produces = "application/json; charset=utf8", method = RequestMethod.POST)
//	@ResponseBody
//	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request ) throws Exception {
//		JsonObject jsonObject = new JsonObject();
//		
//        /*
//		 * String fileRoot = "C:\\summernote_image\\"; // 외부경로로 저장을 희망할때.
//		 */
//		
//		// 내부경로로 저장
//		String contextRoot = new HttpServletRequestWrapper(request).getServletContext().getRealPath("/");
//		String fileRoot = contextRoot+"/upload/";
//		System.out.println( "*******" + contextRoot );
//		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
//		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
//		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
//		
//		BoardTO bto = new BoardTO();
//		bto.setImage_name(savedFileName);
//		bto.setImage_size(multipartFile.getSize());
//		
//		
//		File targetFile = new File(fileRoot + savedFileName);	
//		try {
//			InputStream fileStream = multipartFile.getInputStream();
//			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
//			jsonObject.addProperty("url", "/upload"+savedFileName); // contextroot + resources + 저장할 내부 폴더명
//			jsonObject.addProperty("responseCode", "success");
//				
//		} catch (IOException e) {
//			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
//			jsonObject.addProperty("responseCode", "error");
//			e.printStackTrace();
//		}
//		String a = jsonObject.toString();
//		//int flag = dao.uploadOk(bto);
//		
//		return a;
//	}
	
	
//	@RequestMapping(value="/facility/writeOK", method=RequestMethod.POST)
//	public String facilityWriteOk(HttpServletRequest req, Model model) {
//
//		BoardTO bto = new BoardTO();
//		bto.setTitle( req.getParameter( "subject" ));
//		bto.setContent( req.getParameter( "content" ));
//		bto.setCategory_seq(Integer.parseInt(req.getParameter( "category" )) );
//		
//		MemberTO mto = new MemberTO();
//		mto.setNickname( req.getParameter( "nickname" ));
//		
//		System.out.println( "title : " + req.getParameter( "subject" ));
//		System.out.println( "content : " + req.getParameter( "content" ));
//		System.out.println( "category : " + req.getParameter( "category" ));
//		//System.out.println( "nickname : " + req.getParameter( "nickname" ));
//		
//		int flag = dao.writeOk(bto, mto);
//		model.addAttribute("flag", flag);
//		
//		return "facility_writeOkPage";
//	}
	
	
//	@RequestMapping( value="/facility/uploadOK", method=RequestMethod.POST)
//	public ModelAndView facilityUploadOk( HttpServletRequest request, MultipartFile upload ) {
//		
//		BoardTO bto = new BoardTO();
//		
//		try {
//			if( !upload.isEmpty() ) {
//				bto.setImage_name( upload.getOriginalFilename() );
//				bto.setImage_size( upload.getSize() );
//			}
//			upload.transferTo( new File(upload.getOriginalFilename() ) );
//			
//			System.out.println( "이미지 : " + upload.getOriginalFilename());
//		} catch (IllegalStateException e) {
//			// TODO Auto-generated catch block
//			System.out.println( "[에러] : " + e.getMessage() );
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			System.out.println( "[에러] : " + e.getMessage() );
//		}
//
//		int flag = dao.uploadOk(bto);
//		
//		ModelAndView modelAndView = new ModelAndView();
//		modelAndView.setViewName( "facility_writeOkPage" );
//		modelAndView.addObject( "write", flag );
//		
//		return modelAndView;
//	}

}