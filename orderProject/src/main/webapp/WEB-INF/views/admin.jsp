<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
    <title>회원가입</title>    
    <style>
        body{
            width: 800px;
            height: 600px;
        }
        h3{
            margin: 10px 0px 0px 10px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <h3><b>관리자 페이지</b></h3>
        </div>
        <div style="float: right;">
            <button id="search" class="btn btn-info btn-sm" style="margin-bottom: 5px;">검색</button>
        </div>
        <table class="table table-bordered">
            <colgroup>
                <col width="15%">
                <col width="35%">
                <col width="15%">
                <col width="35%">
            </colgroup>
            <tr>
                <td class="">상품번호</td>
                <td><input type="text" id="productId" name="productId" placeholder="내용을 입력해주세요."></td>
                <td>상품이름</td>
                <td><input type="text" id="productName" name="productName" placeholder="내용을 입력해주세요."></td>
            </tr>
            <tr>
                <td>이름</td>
                <td><input type="text" id="orderName" name="orderName" placeholder="내용을 입력해주세요."></td>
                <td>아이디</td>
                <td><input type="text" id="orderId" name="orderId" placeholder="내용을 입력해주세요."></td>
            </tr>
            <tr>
                <td>주문 날짜</td>
                <td>
                    <input type="text" id="dateFrom" name="dateFrom" placeholder="날짜를 입력해주세요.">
                    <span style="margin: 0px 10px 0px 10px">-</span>
                    <input type="text" id="dateTo" name="dateTo" placeholder="날짜를 입력해주세요.">
                </td>
                <td>상태</td>
                <td>
	                <select name="deliverStatus" id="deliverStatus">
<%--                          <option value="" <c:if test="${searchCategory eq '소주'}">selected</c:if>>소주</option> --%>
                         <option value="" selected></option>
                         <option value="결제완료">결제완료</option>
                         <option value="배송중">배송중</option>
                         <option value="배송완료">배송완료</option>
                    </select>
                </td>                
            </tr>
        </table>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>순번</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>상품번호</th>
                    <th>상품이름</th>
                    <th>주문날짜</th>
                    <th>수량</th>
                    <th>총가격</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>test1</td>
                    <td>홍길동</td>
                    <td>product1</td>
                    <td>원소주</td>
                    <td>20200323</td>
                    <td>1개</td>
                    <td>15000원</td>
                    <td>결제완료</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>test2</td>
                    <td>이순신</td>
                    <td>product2</td>
                    <td>참이슬</td>
                    <td>20200324</td>
                    <td>20개</td>
                    <td>40000원</td>
                    <td>결제완료</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>test3</td>
                    <td>주다사</td>
                    <td>product3</td>
                    <td>카스</td>
                    <td>20200325</td>
                    <td>2개</td>
                    <td>10000원</td>
                    <td>결제완료</td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>test4</td>
                    <td>그리드</td>
                    <td>product4</td>
                    <td>예거</td>
                    <td>20200323</td>
                    <td>1개</td>
                    <td>45000원</td>
                    <td>결제완료</td>
                </tr>
            </tbody>
        </table>
        <nav aria-label="..." style="float: right;">
            <ul class="pagination">
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1"><</a>
                </li>
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item active">
                    <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
                </li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link" href="#">></a>
                </li>
            </ul>
        </nav>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>