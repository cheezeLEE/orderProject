package com.order.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private String userid, userpw, userName, userTel, userEmail, addr1, addr2, addr3;
	private boolean enabled;
	
	private Date regDate, updateDate;
	private List<AuthVO> authList;
}
