package com.order.service;

import java.util.HashMap;
import java.util.List;

import com.order.domain.OrderProductVO;
import com.order.domain.OrderVO;
import com.order.domain.ProductVO;

public interface OrderService {
	public void createProduct(ProductVO vo);
//	public List<ProductVO> productList();
//	public List<ProductVO> productList(PageDTO dto);
	public List<ProductVO> productList(HashMap<String, Object> productList);
	public ProductVO productDetail(String productId);
	public void updateProduct(ProductVO vo);
	public void deleteProduct(String productId);
	public int countProduct(HashMap<String, Object> productList);
	public void orderProduct(OrderVO vo);
	public void changeStock(OrderVO vo);
	public List<OrderProductVO> orderList(String userid);
	public int orderCount(String userid);
	public int deleteOrder(String orderId);
}
