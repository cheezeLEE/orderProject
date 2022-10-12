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
    <title>아이디 찾기</title>
    <style>
        html {
            overflow:hidden;
        }
        body{
            width: 100%;
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
        #email_send, #sms_send{
            margin-left: 5px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <h3><b>아이디 찾기</b></h3>
        </div>
        <form id="searchForm" action="/searchId" method="POST"> 
            <div class="row">
                <label for="userName" class="col-2">이름</label>
                <input type="text" name="userName" id="userName" placeholder="이름을 입력하세요." class="col-7 join">
            </div>
            <div class="row">
                <label for="userEmail" class="col-2">이메일</label>
                <input type="text" name="userEmail" id="userEmail" placeholder="이메일을 입력하세요." class="col-7 join">
                <input type="button" name="email_send" id ="email_send" class="join" value="인증">
            </div>
            <div class="row" id="validNo" style='display: none'>
                <label for="confirmCheck" class="col-2">인증번호</label>
                <input type="text" name="confirmCheck" class="col-7 join" id="confirmCheck" placeholder="인증번호를 입력하세요.">
                <span style="color: red; margin-left: 10px;">3:00</span>
                <div><span id="checkedValid"></span></div>
            </div>
	        <div class="row float-right">
	            <button class="btn btn-info" id="searchIdBtn">찾기</button>
	            <input type="button" class="btn btn-danger" value="닫기" onclick="window.close()" style="margin-left: 5px; margin-right: 165px;"/>
	        </div>
   			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	    </form>
    </div>
    <script src="/resources/js/common.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>    
       	let code= "";
       	let chkValid = false;
       	let email, validCheck, inputCode, checkResult;
        let csrfToken;
    
    $("#email_send").on("click", function(e){
    	e.preventDefault();
    	sendEmail();
    });
    
    /* 인증번호 비교 */
    $("#confirmCheck").blur(function(){
    	comfirmCheck();
    });
    
    $("#searchIdBtn").on("click", function(e){
		e.preventDefault();
     		if(chkValid != true){
   			alert("인증을 진행해주세요.");
   			return;
   		} else{ 
   	   		let name1 = $("#userName").val();
   	   		let email1 = $("#userEmail").val();
   	   		$.ajax({
   	   			type: 'POST',
   	   			url: '/searchId',
   	   			data: {userName: name1, userEmail: email1},
   	   			dataType: 'text',
        		beforeSend : function(jqXHR, setting){
        			csrfToken = $("meta[name='_csrf']").attr("content");
        			jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
        		},
        		success : function(data){
        			console.log(data);
        			if(data == "fail"){
        				alert("일치하는 사용자가 없습니다.");
        				return;
        			} else{
        				console.log("data : " + data);
        				location.href="/resultId?userid="+data;
        			}
        		}, 
        		error : function(request,status,error){
        			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        		}

   	   		});
   		}
    });
    </script>
</body>
</html>