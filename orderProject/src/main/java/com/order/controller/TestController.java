package com.order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.order.domain.ProductVO;
import com.order.service.TestService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class TestController {

	@Autowired
	private TestService service;
	
	@RequestMapping(value="/test", method=RequestMethod.GET)
	public String test(Model model) {
		model.addAttribute("type", "create");
		log.info("테스트 페이지 진입");
		return "test";
	}

	@RequestMapping(value="/testSession", method=RequestMethod.GET)
	public String testSession(Model model, HttpServletRequest request) {
		log.info("테스트 세션 페이지 진입");
		
		HttpSession session = request.getSession();
		
		return "testSession";
	}
	
/*	@RequestMapping(value="/testUpload", method = RequestMethod.POST)
	public String testUpload(@RequestParam("image") MultipartFile file, ProductVO vo) {
		
		log.info("Create product controller with file upload");
		
		// 업로드 폴더 지정
		String uploadFolder = "C:\\Users\\LEEJH\\Downloads\\orderProject\\src\\main\\webapp\\resources\\image";
		
		String uploadFileName = file.getOriginalFilename();
		
		// 파일명이 겹치는것을 방지하기 위해 UUID 지정
		UUID uuid = UUID.randomUUID();
//		File saveFile = new File(uploadFolder+"\\" + uuid + uploadFileName);
		File saveFile = new File(uploadFolder, uploadFileName);
		log.info(saveFile.getName());
		
		try {
			file.transferTo(saveFile); // 실제 파일 저장메서드(filewriter 작업을 손쉽게 한방에 처리해준다.)
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "test";
	}*/
	
	@RequestMapping(value="/testCreate", method= {RequestMethod.POST, RequestMethod.GET})
	public String testCreate(ProductVO vo) {
		
		log.info("vo : " + vo);
		
		service.createProduct(vo);
		return "test";
	}

//	@RequestMapping(value="/uploadImage", method = RequestMethod.POST)
//	@ResponseBody
//	public String testUpload(MultipartFile[] uploadFile) {
//		log.info("Create product controller with file upload");
//		
//		// 업로드 폴더 지정
//		String uploadFolder = "C:\\Users\\LEEJH\\Downloads\\orderProject\\src\\main\\webapp\\resources\\image";
//
//		for(MultipartFile multipartFile : uploadFile) {
//			log.info("---------------------------------");
//			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
//			log.info("Upload File Size : " + multipartFile.getSize());
//			
//			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
//			
//			try {
//				multipartFile.transferTo(saveFile);
//			} catch (Exception e) {
//				log.error(e.getMessage());
//			}
//		}
//		return uploadFolder + uploadFile[0].getOriginalFilename();
//	}
}
