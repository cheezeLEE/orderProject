package com.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.domain.ProductVO;
import com.order.mapper.OrderMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class TestServiceImpl implements TestService {
	@Autowired
	private OrderMapper mapper;
	
	@Override
	public void createProduct(ProductVO vo) {
		log.info("Create product service");
		mapper.createProduct(vo);
	}
}
