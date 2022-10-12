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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
    <title>회원정보 수정</title>
    <style>
        body{
            width: 800px;
            height: 600px;        
        }
        h3{
            margin: 10px 0px 20px 10px;
        } 
        table{
            margin : 10px;
            width: 100%;
        }
        table th,
        table td{
            padding-left: 10px;
        }        
        .join{
            margin-bottom: 10px;
        }
        #email_send, #sms_send, #searchAddr{
            margin-left: 5px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <h3><b>회원정보 수정</b></h3>
        </div>
        <form action="/modjoin" id="modjoinForm" method="POST"> 
            <div class="row">
                <label for="userId" class="col-3">아이디</label>
                <input type="text" name="userid" id="userid" value="${Member.userid}" class="col-7 join" readonly>
            </div>
            <div class="row">
                <label for="userId" class="col-3">비밀번호</label>
                <input type="password" name="userpw" id="userpw" class="col-7 join" placeholder="비밀번호를 입력하세요.">
            </div>
            <div class="row">
                <label for="userPw" class="col-3">비밀번호 확인</label>
                <input type="password" name="checkpw" id="checkpw" class="col-7 join" placeholder="비밀번호 확인.">
            </div>
            <div class="row">
                <label for="userName" class="col-3">이름</label>
                <input type="text" name="userName" id="userName" value="${Member.userName}" class="col-7 join" readonly>
            </div>
            <div class="row">
                <label for="addr1" class="col-3">우편번호</label>
                <input type="text" name="addr1" id="addr1" value="${Member.addr1}" class="col-7 join" readonly>
                <input type="button" name="searchAddr" id="searchAddr" class="join" value="찾기">
            </div>
            <div class="row">
                <label for="addr2" class="col-3">기본주소</label>
                <input type="text" name="addr2" id="addr2" value="${Member.addr2}" class="col-7 join" readonly>
            </div>
            <div class="row">
                <label for="addr3" class="col-3">상세주소</label>
                <input type="text" name="addr3" id="addr3" value="${Member.addr3}" class="col-7 join" placeholder="상세주소를 입력하세요.">
            </div>
            <div class="row">
                <label for="userEmail" class="col-3">이메일</label>
                <input type="email" name="userEmail" class="col-7 join" id="userEmail" value="${Member.userEmail}" placeholder="이메일을 입력하세요.">
                <input type="button" name="email_send" id="email_send" class="join changeEmail" value="인증" style="display: none;">
            </div>
            <div class="row">
                <label for="userTel" class="col-3">전화번호</label>
                <input type="tel" name="userTel" id="userTel" value="${Member.userTel}" class="col-7 join" placeholder="전화번호를 입력하세요.">
<!--                 <input type="button" name="sms_send" id="sms_send" class="join" value="인증"> -->
            </div>
            <div class="row changeEmail" id="changeEmail" style="display:none;">
                <label for="confirmCheck" class="col-3">인증번호</label>
                <input type="text" name="confirmCheck" id="confirmCheck" class="col-7 join" placeholder="인증번호를 입력하세요.">
                <span style="color: red; margin-left: 10px;">3:00</span>
            </div>
            <div class="row float-right">
                <input type="button" id="updateBtn" class="btn btn-info" value="수정"/>
                <input type="button" id="cancelBtn" class="btn btn-danger" value="취소" style="margin-left: 5px;"/>
            </div>        
   			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />  
        </form>
    </div>
	<script src="/resources/js/common.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
	    let code = "";
	    let chkValid = true;
	    let email, validCheck, inputCode, checkResult;
	    
	    let addr1, addr3, pwCheck;
    
	    $(function(){
	    	email = $("#userEmail").val();
	    });
	    
    	$("#cancelBtn").on("click", function(e){
    		e.preventDefault();
    		location.href = "/productList";
    	});
    
        $("#searchAddr").on("click", function(){
        	// 주소 api (daum)
            searchAddr();
        });
        
        $("#email_send").on("click", function(e){
        	e.preventDefault();
        	sendEmail();
			$("#changeEmail").css("display", "block");
        });
        
        /* 인증번호 비교 */
        $("#confirmCheck").blur(function(){
        	comfirmCheck();
        });
        
        // 이메일을 변경했을 경우 인증이 필수
        $("#userEmail").on("input", function(){
        	console.log($("#userEmail").val());
        	console.log(email);
        	if($("#userEmail").val() != email){
        		$("#email_send").css("display", "block");
        		chkValid = false;
        	}else{
        		$(".changeEmail").css("display", "none"); 
        		chkValid = true;
        	}
        });
        
        $("#updateBtn").on("click", function(e){
    		e.preventDefault();
    		addr1 = $("#addr1").val();
    		addr3 = $("#addr3").val();

    		if(chkValid = false){
    			alert("인증을 진행해주세요.");
    			return;
    		}
    		if(pwCheck === false){
       			alert("비밀번호를 확인해주세요.");
       			return;
       		}
       		if(addr1 === "" || addr1  === null){
       			alert("우편번호를 입력해주세요");
       			return;
       		}
       		if(addr3 === "" || addr3 === null){
       			alert("상세주소를 입력해주세요");
       			return;
       		}
       		$("#modjoinForm").submit();
       		alert('수정이 완료되었습니다.');
        });
    </script>
</body>
</html>