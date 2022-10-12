<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   	<meta name="_csrf" content="${_csrf.token}"/>
    <title>productList</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
    <style>
        body{
            width: 800px;
            height: 600px;
        }
        label{
            margin-right: 10px;
        }
        table{
            background-color: lightgray;
        }
        table td{
            padding: 5px;
        }
        ul{
            margin-top: 10px;
        }
        ul,
        li {
            list-style: none;
            margin-left: 0px;
            padding: 0px;
        }
        li ul{
            width: 100px;
            margin-left: 0px;
            float: right;
        }
        .pagination li{
            margin-left: 0px;
        }
        img{
            margin-bottom: 20px;
        }
        .cell_1:hover{
            border: 1px solid black;
        }
    </style>
</head>
<body>
    <div class="productList" style="margin: 10px 0px 0px 10px;">
	    <sec:authorize access="isAuthenticated()">
		  <a href="#" onclick="document.getElementById('logout').submit();"style="margin-left:10px; float: right;">로그아웃</a>
		</sec:authorize>
        <a href="/modCheck" style="margin-left:10px; float: right;">회원정보수정</a>
        <a href="/orderList" style="margin-left:10px; float: right;">주문정보</a>
        <a href="/admin" style="float: right;">관리자페이지</a>
        <h1>상품목록</h1>
        <div class="search">
            <form id="searchForm" action="/productList" method="get">
                <table width="100%">
                    <tr>
                        <td><span style="margin-right:10px;">카테고리</span>
                            <select name="searchCat" id="category">
                                <option value="" <c:if test="${searchCategory eq ''}">selected</c:if>>선택</option>
                                <option value="소주" <c:if test="${searchCategory eq '소주'}">selected</c:if>>소주</option>
                                <option value="맥주" <c:if test="${searchCategory eq '맥주'}">selected</c:if>>맥주</option>
                                <option value="양주" <c:if test="${searchCategory eq '양주'}">selected</c:if>>양주</option>
                            </select>
                        </td>
                        <td>
                            <span class="searchPrdt" style="margin-left: 30px;">
                                <label for="searchPrdtNm">상품이름</label>
                                <input type="text" name="searchPrdtNm" id="searchPrdtNm" value="${searchProductName}">   
                            </span>
	                        <input type="hidden" name="nowPage" id="nowPage" value="1" />
	                        <input type="hidden" name="cntPerPage" id="cntPerPage" value="${paging.cntPerPage}" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <span class="searchPrice">
                                <label for="strtPrice">가격</label>
                                <input type="number" name="strtPrice" id="strtPrice" value="${searchStartPrice}">
                                <span style="margin: 0px 10px 0px 10px;">~</span>
                                <input type="number" name="endPrice" id="endPrice" value="${searchEndPrice}">
                            </span>        
                            <span class="search" style="float: right;">
                                <input type="submit" id="searchBtn" class="btn btn-primary" value="검색">
                            </span>    
                        </td>
                    </tr>
                </table>
            </form>    
        </div>
        <div class="adminBtn" style="margin-top: 10px; text-align: end;">
            <button class="btn btn-primary" id="updateBtn">수정</button>
            <button class="btn btn-primary" id="createBtn">등록</button>
            <button class="btn btn-danger" id="delBtn">삭제</button>
        </div>
        <div class="product">
            <div class="list con">
                <ul class="row">
	            	<c:forEach items="${productList}" var="list">
	                    <li><input type="checkbox" name="checkList" style="margin-left: 10px;" value="${list.productId}"></li>
	                    <li class="cell_1" onclick="location.href='/productDetail?productId=${list.productId}'">
	                        <span class="img-box"><img src="${list.image}" alt="사진1" width="145px" height="100px" style="margin-right : 4px;"></span>
	                        <ul>
	                            <li>${list.category}</li>
	                            <li>${list.productName}</li>
	                            <li>${list.price}원</li>
	                        </ul>
	                    </li>
	            	</c:forEach>
                </ul>           
            </div>
        </div>
        <nav aria-label="..." style="float: right;">
            <ul class="pagination">
                <li class="page-item">
	            	<c:if test="${paging.startPage != 1 }">
						<a class="page-link" href="/productList?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
					</c:if>
                </li>
				<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
					<c:choose>
						<c:when test="${p == paging.nowPage }">
			                <li class="page-item active">
			                    <a class="page-link" href="#">${p }</a>
			                </li>
						</c:when>
						<c:when test="${p != paging.nowPage }">
							<li class="page-item">
								<a class="page-link" href="/productList?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
							</li>
						</c:when>
					</c:choose>
				</c:forEach>
                <li class="page-item">
					<c:if test="${paging.endPage != paging.lastPage}">
						<a class="page-link" href="/productList?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
					</c:if>
				</li>
            </ul>
        </nav>
    </div>
   		<input type="hidden" name="startPage" id="hiddenStartPage" value="${paging.startPage}" />
   		<input type="hidden" name="endPage" id="hiddenEndPage" value="${paging.endPage}" />    
    <form id="actionForm" action="/productList" method="get">
   		<input type="hidden" name="nowPage" id="hiddenNowPage" value="${paging.nowPage}" />
    	<input type="hidden" name="cntPerPage" value="${paging.cntPerPage}" />
    	<input type="hidden" name="searchCat" value="${searchCategory}" />
    	<input type="hidden" name="searchPrdtNm" value="${searchProductName}" />
    	<input type="hidden" name="strtPrice" value="${searchStartPrice}" />
    	<input type="hidden" name="endPrice" value="${searchEndPrice}" />
    </form>
    
    <form id="logout" action="/logout" method="POST">
	   <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
	</form>

    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
	    let chk_val, csrfToken;
	    let startPrice, endPrice;
	    let result;
    
	    $("#delBtn").on("click", function(){
            result = confirm("삭제하시겠습니까?");
            chk_val = [];
            if(result){
            	$("input[name='checkList']").each(function(i, iVal){
            		if($(this).is(":checked") == true){
            			chk_val.push($(this).val());
            		}
            	});
            	if(chk_val.length == 0){
            		alert("삭제할 상품을 클릭해주세요.");
            		return;
            	}
            	$.ajax({
            		url: "/deleteProduct",
            		type: "post",
            		traditional: true,
            		data: {"arrStr" : chk_val},
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
            }
        });
	    
	    $("#createBtn").on("click", function(e){
	    	e.preventDefault();
	    	location.href='/createProduct';
	    });
	    
	    $("#updateBtn").on("click", function(e){
	    	e.preventDefault();
            chk_val = [];

	    	$("input[name='checkList']").each(function(i, iVal){
        		if($(this).is(":checked") == true){
        			chk_val.push($(this).val());
        		}
        	});
        	
	    	if(chk_val.length == 0){
        		alert("수정할 상품을 클릭해주세요.");
        		return;
        	}

	    	if(chk_val.length > 1){
        		alert("하나의 상품만 선택해주세요.");
        		return;
        	}
	    		    	
	    	location.href='/updateProduct?productId='+chk_val[0];
	    });
	    
	    $(".page-link").on("click", function(e){
	    	e.preventDefault();
 	    	if($(this).text() == '>'){
		    	$("#hiddenNowPage").val(Number($("#hiddenEndPage").val()) + 1);
	    	}else if($(this).text() == '<'){
		    	$("#hiddenNowPage").val(Number($("#hiddenStartPage").val()) - 1);
	    	}else{
		    	$("#hiddenNowPage").val($(this).text());
	    	}
	    	$("#actionForm").submit();
	    })
	    
	    $("#searchBtn").on("click", function(e){
	    	e.preventDefault();
	    	if($("#strtPrice").val() != '' && $("#endPrice").val() != ''){
	    		startPrice = Number($("#strtPrice").val());
	    		endPrice = Number($("#endPrice").val());
	    		if(startPrice < 0 ){
	    			alert("시작가격은 0원 이상이어야 합니다.");
	    			return;
	    		} else if(endPrice <= 0){
	    			alert("종료가격은 0원 초과여야 합니다.");
	    			return;
	    		} else if(startPrice > endPrice){
	    			alert("시작가격은 종료가격보다 클 수 없습니다.");
	    			return;
	    		}
	    	}else if($("#strtPrice").val() != '' || $("#endPrice").val() != ''){
	    		alert("가격은 시작과 끝이 모두 입력되어야 합니다.");
    			return;
	    	}
	    	$("#searchForm").submit();
	    });
    </script>
</body>
</html>