package com.order.mapper;

import com.order.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String userid);
	public void join(MemberVO vo);
	public void auth(String userid);
	public int idCheck(String userid);
	public String searchId(MemberVO vo);
	public int searchPw(MemberVO vo);
	public int changeSearchPw(MemberVO vo);
	public String checkPw(String userId);
	public MemberVO userInfo(String userid);
	public void updateInfo(MemberVO vo);
}
