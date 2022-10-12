package com.order.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {
	private String orderId, productId, userId, orderName, orderTel, orderAddr1, orderAddr2, orderAddr3, deliverStatus;
	private Date orderDate;
	private int count;
}
