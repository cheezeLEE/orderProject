package com.order.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {

	// 권한이 없는 경우 표시할 메시지 지정
	// void의 경우는 Mapping된 value와 동일한 이름을 가진 jsp페이지로 이동함
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("access Denied : " + auth);
		
		model.addAttribute("msg","Access Denied");
	}
	
	// 제작한 customLogin 페이지로 이동하는 메소드 추가
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("error :  " + error);
		log.info("logout : " + logout);
		
		// 에러가 있으면 에러메시지를 model에 저장해 jsp에 전달
		if(error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		
		// 로그아웃 되었으면 해당 메시지를 model에 저장해 jsp에 전달
		if(logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
	}
	
	// 로그아웃을 처리하는 메소드 추가
	// 만일 로그아웃시 추가 작업을 지정하고 싶으면 logoutSuccessHandler를 정의해 처리
	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("custom logout");
	}
}
