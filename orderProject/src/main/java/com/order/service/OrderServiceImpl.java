package com.order.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.domain.OrderProductVO;
import com.order.domain.OrderVO;
import com.order.domain.ProductVO;
import com.order.mapper.OrderMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class OrderServiceImpl implements OrderService{

	@Autowired
	private OrderMapper mapper;
	
	@Override
	public void createProduct(ProductVO vo) {
		log.info("Create product service");
		mapper.createProduct(vo);
	}

//	@Override
//	public List<ProductVO> productList() {
//		log.info("select product list service");
//		return mapper.productList();
//	}

//	@Override
//	public List<ProductVO> productList(PageDTO dto) {
//		log.info("select product list service with paging");
//		return mapper.productList(dto);
//	}

	@Override
	public List<ProductVO> productList(HashMap<String, Object> productList) {
		log.info("select product list service with paging");
		return mapper.productList(productList);
	}

	@Override
	public ProductVO productDetail(String productId) {
		log.info("Detail product service.");
		return mapper.productDetail(productId);
	}

	@Override
	public void updateProduct(ProductVO vo) {
		log.info("Update product service");
		mapper.updateProduct(vo);
	}

	@Override
	public void deleteProduct(String productId) {
		log.info("Delete product service");
		mapper.deleteProduct(productId);
	}

	@Override
	public int countProduct(HashMap<String, Object> productList) {
		log.info("Count Products");
		return mapper.countProduct(productList);
	}

	@Override
	public void orderProduct(OrderVO vo) {
		log.info("Order Product");
		mapper.orderProduct(vo);
	}

	/** 주문시 주문량만큼 재고를 줄이는 메소드 */
	@Override
	public void changeStock(OrderVO vo) {
		mapper.changeStock(vo);
	}

	@Override
	public List<OrderProductVO> orderList(String userid) {
		log.info("OrderList ServiceImpl");
		return mapper.orderList(userid);
	}

	@Override
	public int orderCount(String userid) {
		log.info("OrderCount ServiceImpl");
		return mapper.orderCount(userid);
	}

	@Override
	public int deleteOrder(String orderId) {
		log.info("deleteOrder ServiceImpl");
		return mapper.deleteOrder(orderId);
	}
}
