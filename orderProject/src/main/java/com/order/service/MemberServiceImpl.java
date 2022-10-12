package com.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.order.domain.MemberVO;
import com.order.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	@Override
	public void join(MemberVO vo) {
		String encodePw = pwencoder.encode(vo.getUserpw());
		vo.setUserpw(encodePw);
		mapper.join(vo);
		mapper.auth(vo.getUserid());
		log.info("join Service");
	}

	@Override
	public boolean idCheck(String userid) throws Exception {
		if(userid == null || userid.trim() == "") {
			return true;
		}
		int cnt = mapper.idCheck(userid);
		boolean idCheck = true;
		if(cnt > 0) {
			idCheck = true;
		} else if(cnt == 0) {
			idCheck = false;
		}
		return idCheck;
	}

	@Override
	public String searchId(MemberVO vo) throws Exception {
//		String userName = vo.getUserName();
//		String userEmail = vo.getUserEmail();
		String userId = mapper.searchId(vo);
		return userId;
	}

	@Override
	public int searchPw(MemberVO vo) throws Exception {
		int cnt = mapper.searchPw(vo);
		return cnt;
	}

	@Override
	public int changeSearchPw(MemberVO vo) throws Exception {
		
		String encodePw = pwencoder.encode(vo.getUserpw());
		vo.setUserpw(encodePw);
		log.info("userid : " + vo.getUserid());
		log.info("userpw : " + vo.getUserpw());
		int result = mapper.changeSearchPw(vo);
		
		return result;
	}

	@Override
	public boolean checkPw(MemberVO vo) throws Exception {
		log.info("Check password service (not encoding) : " + vo.getUserpw());
		String encodingPw = mapper.checkPw(vo.getUserid());
		boolean check = pwencoder.matches(vo.getUserpw(), encodingPw);
		return check;
	}

	@Override
	public MemberVO userInfo(String userid) throws Exception {
		log.info("Search user infomation in service");
		return mapper.userInfo(userid);
	}

	@Override
	public void updateInfo(MemberVO vo) throws Exception {
		log.info("Update user infomation in service");

		String encodePw = pwencoder.encode(vo.getUserpw());
		vo.setUserpw(encodePw);
		mapper.updateInfo(vo);
	}
}
