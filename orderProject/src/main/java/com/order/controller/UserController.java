package com.order.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.order.domain.MemberVO;
import com.order.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class UserController {

	@Autowired
	private MemberService service;
	
    @Autowired
    private JavaMailSender mailSender;
			
	@RequestMapping(value ="/login", method = RequestMethod.GET)
	public String getLogin() {
		return "/login";
	}
	
	@RequestMapping(value ="/join", method = RequestMethod.GET)
	public String join() {
		return "/join";
	}

	@RequestMapping(value="/join", method = RequestMethod.POST)
	public String joinPost(MemberVO vo, RedirectAttributes rttr) {
		try {
			service.join(vo);
			log.info("join service");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/login";
	}
	
	// id 중복확인
	@RequestMapping(value="/idCheck", method = RequestMethod.POST)
	@ResponseBody
	public boolean idCheck(@RequestParam("userid") String userid) throws Exception {
		
		log.info("id check");
		log.info("userid : " + userid);
		
		boolean idCheck = service.idCheck(userid);
		
		return idCheck;
	}
	
	// email 인중
	@RequestMapping(value="/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String  mailCheckGET(String email) throws Exception{
		log.info("이메일 데이터 전송확인");
		log.info("인증번호 : " + email);
		
        /* 인증번호(난수) 생성 */
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
        log.info("인증번호 " + checkNum);
        
        /* 이메일 보내기 */
        String setFrom = "zndn121@gmail.com";
        String toMail = email;
        String title = "회원가입 인증 이메일 입니다.";
        String content = 
                "홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        
        String num = Integer.toString(checkNum);
        
        return num;
	}
	
	@RequestMapping(value="/searchId", method = RequestMethod.POST)
	@ResponseBody
	public String idSearch(MemberVO vo) throws Exception {
				
		String userId = service.searchId(vo);		
		log.info("userId : " + userId);
		if(userId == null || userId.trim() == "") {
			return "fail";
		} else {
			return userId;			
		}
	}
	
	@RequestMapping(value ="/searchId", method = RequestMethod.GET)
	public String searchId() {
		return "/searchId";
	}
	
//	@RequestMapping(value="/searchId", method = RequestMethod.POST)
//	public String searchIdPost(@RequestParam("userName") String userName, @RequestParam("userEmail") String userEmail, Model model) throws Exception {
//		log.info("search id");
//		log.info("user information - userName : " + userName + ", userEmail : " + userEmail);
//		
//		MemberVO vo = new MemberVO();
//		vo.setUserName(userName);
//		vo.setUserEmail(userEmail);
//		
//		String userId = service.searchId(vo);
//		
//		model.addAttribute("userId", userId);
//		
//		return "resultId";
//	}
	
	@RequestMapping(value ="/searchPw", method = RequestMethod.GET)
	public String searchPw() {
		return "/searchPw";
	}

	@RequestMapping(value ="/searchPw", method = RequestMethod.POST)
	@ResponseBody
	public String searchPwPost(MemberVO vo, Model model) throws Exception {
		log.info("search password");
				
		int userCheck = service.searchPw(vo);
		if(userCheck == 1) {
			log.info(vo.getUserid());
			return vo.getUserid();
		} else {
			return "fail";
		}
	}
	
	
	@RequestMapping(value ="/modjoin", method = RequestMethod.GET)
	public String modjoin(@RequestParam("userid") String userId, Model model) throws Exception {
		MemberVO vo = service.userInfo(userId);
		model.addAttribute("Member", vo);
		return "/modjoin";
	}
	
	@RequestMapping(value = "/modjoin", method = RequestMethod.POST)
	public String modjoinPost(MemberVO vo, Model model) throws Exception{
		log.info(vo);
		service.updateInfo(vo);
		
		return "redirect:/productList";
	}
		
	@RequestMapping(value ="/modCheck", method = RequestMethod.GET)
	public String modCheck(Authentication authentication, Model model) throws Exception {
		String userId = authentication.getName();
		model.addAttribute("userId", userId);
		return "/modCheck";
	}

	@RequestMapping(value ="/modCheck", method = RequestMethod.POST)
	@ResponseBody
	public boolean modCheckPost(MemberVO vo) throws Exception {
		boolean result = service.checkPw(vo);
		return result;
	}

	@RequestMapping(value ="/resultId", method = RequestMethod.GET)
	public String resultId(@RequestParam("userid") String userId, Model model) {
		model.addAttribute("userId", userId);		
		return "/resultId";
	}
	
	@RequestMapping(value ="/resultPw", method = RequestMethod.GET)
	public String resultPw(MemberVO vo, Model model) {
		model.addAttribute("userId", vo.getUserid());
		return "/resultPw";
	}

	@RequestMapping(value ="/resultPw", method = RequestMethod.POST)
	@ResponseBody
	public int resultPwPost(MemberVO vo, Model model) throws Exception {
		
		log.info("test1 : " + vo.getUserid() + ", " + vo.getUserpw());
		
		int result = service.changeSearchPw(vo);
		log.info("test2 : " + result);
		return result;			
	}
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public void logout() {
		log.info("custom logout");
	}
	
}
