package com.order.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderProductVO {
	private String productName, deliverStatus;
	private int price, count, totalPrice;
	private Date orderDate;
	private String orderId;
}
