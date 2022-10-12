package com.order.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ProductVO {
	private String productId, productName, productInfo, Category;
	private String image;
	private int price, stock;
	private char deleteYn;
	private Date regDate, updateDate;
}
