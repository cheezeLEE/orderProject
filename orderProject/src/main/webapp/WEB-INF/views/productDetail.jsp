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
    <title>productDetail</title>
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
        <h1>상품상세</h1>
        <div class="row">
            <ul>
                <li class="cell">
                    <span class="img-box"><img src="${prdtVO.image}" alt="사진1" width="150px" height="100px" style="margin-left: 25px;"></span>
                    <ul>
                        <li>
                            <label for="prdtNm" class="col-2">상품명</label>
                            <span>${prdtVO.productName}</span>
                        </li>
                        <li>
                            <label for="price" class="col-2">가격</label>
                            <span>${prdtVO.price}</span>&nbsp;원
                        </li>
                        <li>
                            <label for="prdtDetail" class="col-2" style="vertical-align: top;">상품설명</label>
                            <textarea name="prdtDetail" id="prdtDetail" cols="60" rows="10" readonly>${prdtVO.productInfo}</textarea>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
        <div class="row btn-group">
            <input type="button" id="updateBtn" class="btn btn-primary" value="수정" style="margin-right: 5px;">
            <input type="button" id="orderBtn" class="btn btn-primary" value="주문" style="margin-right: 5px;">
            <input type="button" id="deleteBtn" class="btn btn-danger" value="삭제" style="margin-right: 5px;">
            <input type="button" id="listBtn" class="btn btn-info" value="목록">
        </div>
    </div>

	<form id="actionForm">
		<input type="hidden" id="productId" name="productId" value="${prdtVO.productId}">
	</form>

    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    	let prdtId, csrfToken;
    
    	$("#updateBtn").on("click", function(e){
    		e.preventDefault();
    		$("#actionForm").attr("action", "/updateProduct");
    		$("#actionForm").attr("method", "get");
    		$("#actionForm").submit();
    	});
    	
    	$("#orderBtn").on("click", function(e){
    		e.preventDefault();
    		$("#actionForm").attr("action", "/productOrder");
    		$("#actionForm").attr("method", "get");
    		$("#actionForm").submit();
    	});
    	
    	$("#listBtn").on("click", function(e){
    		e.preventDefault();
    		location.href = "productList";
    	});
    	
    	$("#deleteBtn").on("click", function(e){
    		prdtId = $("#productId").val();
    		e.preventDefault();
    		$.ajax({
        		url: "/deleteProduct",
        		type: "post",
        		traditional: true,
        		data: {"arrStr" : prdtId},
        		beforeSend : function(jqXHR, setting){
        			csrfToken = $("meta[name='_csrf']").attr("content");
        			jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
        		},
        		success: function(data){
                    alert("상품이 삭제되었습니다.");
                    location.href='/productList';
        		},
        		error:function(request,status,error){
        			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        		}
        	});    		
    	});
    </script>
</body>
</html>