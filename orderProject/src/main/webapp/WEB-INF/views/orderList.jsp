<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="_csrf" content="${_csrf.token}"/>
    <title>orderList</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
    <style>
        body{
            width: 800px;
            height: 600px;
        }
        .cancel{
            text-align: center;
            vertical-align: middle;
        }
        .orderBtn{
            margin-top: 10px;
            float: right;
        }
        table{
            text-align: center;
        }
        a:link { 
            color: black; text-decoration: none;
        }
        a:visited { 
            color: black; text-decoration: none;
        }
        a:hover { 
            color: black; text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="orderList" style="margin: 10px 0px 0px 10px;">
        <h1>주문목록</h1>
        <table id="orderTable" border="1" style="width:100%">
            <colgroup>
                <col width="7%">
                <col width="22%">
                <col width="12%">
                <col width="7%">
                <col width="12%">
                <col width="20%">
                <col width="13%">
                <col width="7%">
            </colgroup>
            <thead>
                <tr>
                    <th>순번</th>
                    <th>상품명</th>
                    <th>가격</th>
                    <th>수량</th>
                    <th>총가격</th>
                    <th>주문날짜</th>
                    <th>상태</th>
                    <th>취소</th>      
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${orderList}" var="list" varStatus="status">
                <tr>
                	
                    <td>${status.count}</td>
                    <td>${list.productName}</td>
                    <td>${list.price }원</td>
                    <td>${list.count }개</td>
                    <td>${list.totalPrice }원</td>
                    <td><fmt:formatDate value="${list.orderDate}" pattern="yyyy-MM-dd"/></td>
                    <td>${list.deliverStatus}</td>
                    <td class="cancel">
	                    <input type="hidden" id="orderId" value="${list.orderId}">
	                    <c:if test="${list.deliverStatus eq '결제완료'}">
	                    	<button type="button">X</button>
	                    </c:if>
	                </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="orderBtn">
            <input type="button" class="btn btn-primary" value="목록" onclick="location.href='productList.html'">
        </div>
        <input type="hidden" id="orderCount" value="${orderCount}" />
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
   		let orderCount = $("#orderCount").val();
		let orderId;
    	
    	$(".cancel button").on("click", function(){
    		orderId = $(this).siblings("input").val();
    		$.ajax({
    			url: "/deleteOrder",
    			type: "post",
    			data: {'orderId': orderId},
        		beforeSend : function(jqXHR, setting){
        			csrfToken = $("meta[name='_csrf']").attr("content");
        			jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
        		},
    			success: function(data){
    				if(data == 1){
    					alert("삭제성공");
    					window.location.href = "/orderList";
    				}else{
    					console.log(data);
    				}
    			},
        		error : function(request,status,error){
        			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        		}
    		});
    	});
    </script>
</body>
</html>