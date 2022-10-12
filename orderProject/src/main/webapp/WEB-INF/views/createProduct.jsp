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
    <title>createProduct</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
    <style>
        body{
            width: 800px;
            height: 600px;
        }
        select{
            margin: 10px 0px 10px 0px;
        }
        .btn-group {
            float: right;
        }
    </style>
</head>
<body>
	<div class="container-fluid product">
	    <c:if test="${type eq 'create'}">
	        <h1>상품 등록</h1>    
	    </c:if>
	    <c:if test="${type eq 'update'}">
	        <h1>상품 수정</h1>
	    </c:if>
	    
        <form id="createForm" method="post">
			<div class="row">
				<c:if test="${type eq 'update'}">
					<label class="col-2">상품번호</label>
					<input type="text" name="productId" id="productId" value="${prdtVO.productId}" class="col-6" readonly>
				</c:if>
			</div>
		    <div class="row">
		        <label for="category" class="col-2" style='display: flex; align-items: center;'>카테고리</label>
		        <select name="category" id="category" class="col-2">
		            <option value="" <c:if test="${prdtVO.category eq ''}">selected</c:if>>선택</option>
		            <option value="소주" <c:if test="${prdtVO.category eq '소주'}">selected</c:if>>소주</option>
		            <option value="맥주" <c:if test="${prdtVO.category eq '맥주'}">selected</c:if>>맥주</option>
		            <option value="양주" <c:if test="${prdtVO.category eq '양주'}">selected</c:if>>양주</option>
		        </select>
			</div>
		    <div class="row form-group">
		        <label for="productName" class="col-2">상품명</label>
				<input type="text" name="productName" id="productName" value="${prdtVO.productName}" class="col-6">
			</div>
		    <div class="row form-group">
		        <label for="price" class="col-2">가격</label>
				<input type="text" name="price" id="price" value="${prdtVO.price}" class="col-4">&nbsp;&nbsp;원
			</div>
		    <div class="row form-group">
		        <label for="stock" class="col-2">재고</label>
				<input type="text" name="stock" id="stock" value="${prdtVO.stock}" class="col-4">&nbsp;&nbsp;개
			</div>
		    <div class="row form-group">
		        <label for="productInfo" class="col-2">상품설명</label>
				<textarea name="productInfo" id="productInfo" class="col-6" cols="30" rows="10">${prdtVO.productInfo}</textarea>
			</div>
			<div class="row form-group">
				<label for="image2" class="col-2">이미지</label>
				<input type="file" name="image2" id="image2" onchange="loadFile(this)" class="col-6">
				<input type="hidden" id="imageHidden" name="image" value="${prdtVO.image}" />
			</div>
		    <div class="row" id="imgTag">
		    	<c:if test="${type eq 'update'}">
		    		<img src='${prdtVO.image}' style='max-height:100px; max-width:150px;'/>
		    	</c:if>
		        <span class="col-2"></span>
		    </div>
			
			<div class="row btn-group">
				<c:if test="${type eq 'create'}">
					<input id="createBtn" type="submit" class="btn btn-primary" value="등록" style="margin-right: 5px;">
				</c:if>
				<c:if test="${type eq 'update'}">
					<input id="updateBtn" type="submit" class="btn btn-primary" value="수정" style="margin-right: 5px;" onclick="alert('수정이 완료되었습니다.')">
				</c:if>
		        <input type="button" id="goList" class="btn btn-info" value="목록" onclick="location.href='/productList'">
		 		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</div>
		</form>
	</div>
	<form id="redirectForm" method="post"></form>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
let csrfToken;

function loadFile(input) {
    $('#imgTag').html("");
    
    var file = input.files[0];
    $('#imgTag').append("<img src='"+URL.createObjectURL(file)+"' style='max-height:100px; max-width:150px;'/> ");
}
	$(document).ready(function(){
		$("#createBtn").on("click", function(e){
			e.preventDefault();
			var formData = new FormData();
			var inputFile = $("input[name='image2']");
			var files = inputFile[0].files;
			
			if(files.length === 0){
				alert("이미지를 선택해주세요.")
				return;
			}
						
			// add fileData to formData
			for(var i = 0; i < files.length; i++){
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url : '/uploadImage',
				processData : false,
				contentType : false,
				data : formData,
				type : "POST",
        		beforeSend : function(jqXHR, setting){
        			csrfToken = $("meta[name='_csrf']").attr("content");
        			jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
        		},
				success : function(result) {
					console.log(result);
					$("#imageHidden").val(result);
					$.ajax({
						url : '/createProduct',
						type : 'post',
						data : $("#createForm").serialize(),
						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        		beforeSend : function(jqXHR, setting){
		        			csrfToken = $("meta[name='_csrf']").attr("content");
		        			jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
		        		},
		        		success : function(result) {
		        			location.href="/productList"
		        		}
					})
				}
			});
		});
		
		$("#updateBtn").on("click", function(e){
			e.preventDefault();
			var formData = new FormData();
			if($("image2").val() != '' || $("image2").val() != null){
				var inputFile = $("input[name='image2']");
				var files = inputFile[0].files;
								
				// add fileData to formData
				for(var i = 0; i < files.length; i++){
					formData.append("uploadFile", files[i]);
					console.log(formData);
				}
				
				$.ajax({
					url : '/uploadImage',
					processData : false,
					contentType : false,
					data : formData,
					type : "POST",
	        		beforeSend : function(jqXHR, setting){
	        			csrfToken = $("meta[name='_csrf']").attr("content");
	        			jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
	        		},
					success : function(result) {
						$("#imageHidden").val(result);
						$.ajax({
							url : '/updateProduct',
							type : 'post',
							data : $("#createForm").serialize(),
							contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			        		beforeSend : function(jqXHR, setting){
			        			csrfToken = $("meta[name='_csrf']").attr("content");
			        			jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
			        		},
			        		success : function(result) {
			        			location.href="/productList"
			        		}
						})
					}
				});				
			}
			if(!$("image2").val()){
				$.ajax({
					url : '/updateProduct',
					type : 'post',
					data : $("#createForm").serialize(),
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        		beforeSend : function(jqXHR, setting){
	        			csrfToken = $("meta[name='_csrf']").attr("content");
	        			jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
	        		},
	        		success : function(result) {
	        			location.href="/productList"
	        		}
				});
			}
		});
		$('input[type="file"]').change(function () {
		    var ext = this.value.match(/\.(.+)$/)[1].toLowerCase();
		    switch (ext) {
		        case 'jpg':
		        case 'jpeg':
		        case 'png':
		            break;
		        default:
		            alert('지원하지 않는 형식입니다');
		            this.value = '';
		            $("#imgTag").html("");
		    }
		});
	});
</script>
</body>
</html>