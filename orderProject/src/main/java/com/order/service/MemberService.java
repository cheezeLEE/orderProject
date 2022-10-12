package com.order.service;

import com.order.domain.MemberVO;

public interface MemberService {
	public void join(MemberVO vo) throws Exception;
	public boolean idCheck(String userid) throws Exception;
	public String searchId(MemberVO vo) throws Exception;
	public int searchPw(MemberVO vo) throws Exception;
	public int changeSearchPw(MemberVO vo) throws Exception;
	public boolean checkPw(MemberVO vo) throws Exception;
	public MemberVO userInfo(String userid) throws Exception;
	public void updateInfo(MemberVO vo) throws Exception;
}
