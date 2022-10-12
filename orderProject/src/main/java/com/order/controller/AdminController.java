package com.order.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class AdminController {

	@RequestMapping(value ="/admin", method = RequestMethod.GET)
	public String admin() {
		return "/admin";
	}
}
