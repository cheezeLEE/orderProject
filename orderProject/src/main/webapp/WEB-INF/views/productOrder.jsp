<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}"/>
    <title>productOrder</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
    <style>
        body{
            width: 800px;
            height: 600px;
        }
        ul,
        li{
            list-style: none;
            margin-left: 0px;
            padding: 0px;
        }
        li ul{
            margin-left: 0px;
            float: right;
            width: 600px;
        }
        .btn-group {
            float: right;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <h1>주문 페이지</h1>
        <div class="row">
            <ul>
                <li class="cell">
                    <span class="img-box"><img src="${product.image}" alt="사진1" width="150px" height="100px" style="margin-left: 25px;"></span>
                    <ul>
                        <li>
                            <label for="prdtNm" class="col-2">상품명</label>
                            <span id="prdtNm">${product.productName}</span>
                        </li>
                        <li>
                            <label for="price" class="col-2">가격</label>
                            <span id="price">${product.price}</span>&nbsp;원
                        </li>
                        <li>
                            <label for="count" class="col-2">수량</label>
                            <input type="number" name="count" id="count" class="col-1" min="1" value="1" style="padding-right:0px">&nbsp;개
                        </li>
                        <li>
                            <label for="totalAmount" class="col-2">결제금액</label>
                            <span id="totalPrice"></span>&nbsp;원
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
        <div class="row form-group">
            <label for="orderNm" class="col-2">주문자 이름</label>
            <input type="text" name="orderNm" id="orderNm" class="col-6" value="${order.orderName}">
        </div>
        <div class="row form-group">
            <label for="orderTel" class="col-2">연락처</label>
            <input type="text" name="orderTel" id="orderTel" class="col-6" value="${order.orderTel}">
        </div>
        <div class="row form-group">
            <label for="addr1" class="col-2">우편번호</label>
            <input type="text" name="addr1" id="addr1" class="col-6" readonly>
            <input type="button" id="searchAddr" value="찾기" class="btn btn-sm btn-primary" style="margin-left: 5px;" value="${order.orderAddr1}">
        </div>
        <div class="row form-group">
            <label for="addr2" class="col-2">기본주소</label>
            <input type="text" name="addr2" id="addr2" class="col-6" value="${order.orderAddr2}" readonly>
        </div>
        <div class="row form-group">
            <label for="addr3" class="col-2">상세주소</label>
            <input type="text" name="addr3" id="addr3" class="col-6" value="${order.orderAddr3}">
        </div>
        <div class="row btn-group">
            <input type="button" class="btn btn-primary" id="orderBtn" value="주문" style="margin-right: 5px;">
            <input type="button" class="btn btn-danger" id="delBtn" value="취소">
        </div>
    </div>
    
    <form id="orderForm">
    	<input type="hidden" name="productId" id="hiddenProductId" value="${product.productId}"/>
    	<input type="hidden" name="userId" id="hiddenUserId" value="${userId}"/>
    	<input type="hidden" name="orderName" id="hiddenOrderName"/>
    	<input type="hidden" name="orderTel" id="hiddenOrderTel"/>
    	<input type="hidden" name="orderAddr1" id="hiddenOrderAddr1"/>
    	<input type="hidden" name="orderAddr2" id="hiddenOrderAddr2"/>
    	<input type="hidden" name="orderAddr3" id="hiddenOrderAddr3"/>
    	<input type="hidden" name="count" id="hiddenCount"/>
    	<input type="hidden" id="hiddenStock" value="${product.stock}"/>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />   
    </form>

	<script src="/resources/js/common.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
	    let orderNm, orderTel, orderAddr1, orderAddr2, orderAddr3;
	    let price, count;

	    $(function(){
    		price = $("#price").text();
    		count = $("#count").val();    		
    		$("#totalPrice").text(price * count);
    	});
    	
    	$("#count").on("change", function(){
    		price = $("#price").text();
    		count = $("#count").val();    		
    		$("#totalPrice").text(price * count);
    	});
    	
        $("#searchAddr").on("click", function(){
        	// 주소 api (daum)
            searchAddr();
        });
        
        $("#orderBtn").on("click", function(e){
        	e.preventDefault();
           
            if($("#orderNm").val() == null || $("#orderNm").val() == ''){
            	alert("주문자 이름을 입력하세요.");
            	return;
            }else if($("#orderTel").val() == null || $("#orderTel").val() == ''){
            	alert("주문자 전화번호를 입력하세요");
            	return;
            }else if($("#addr1").val() == null || $("#addr1").val() == ''){
            	alert("주소를 입력하세요");
            	return;
            }else if($("#addr2").val() == null || $("#addr2").val() == ''){
            	alert("주소를 입력하세요");
            	return;
            }else if($("#addr3").val() == null || $("#addr3").val() == ''){
            	alert("주소를 입력하세요");
            	return;
            }
            
            orderNm = $("#orderNm").val();
            orderTel = $("#orderTel").val();
            orderAddr1 = $("#addr1").val();
            orderAddr2 = $("#addr2").val();
            orderAddr3 = $("#addr3").val();
            count = $("#count").val();
            stock = $("#hiddenStock").val();

            if(parseInt(count) > parseInt(stock)){
            	alert("재고가 부족합니다.");
            	return;
            }

            $("#hiddenOrderName").val(orderNm);
            $("#hiddenOrderTel").val(orderTel);
            $("#hiddenOrderAddr1").val(orderAddr1);
            $("#hiddenOrderAddr2").val(orderAddr2);
            $("#hiddenOrderAddr3").val(orderAddr3);
            $("#hiddenCount").val(count);
            
            $("#orderForm").attr("method", "post");
            $("#orderForm").attr("action", "/productOrder");
            $("#orderForm").submit();
            
            alert("주문이 완료되었습니다.");
        });
        
        $("#delBtn").on("click", function(e){
        	e.preventDefault();
        	alert("주문이 취소되었습니다.");
        	location.href="/productList";
        });
    </script>
</body>
</html>