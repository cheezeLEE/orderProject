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
    <title>회원가입</title>
    <style>
        body{
            width: 600px;
            height: 600px;
        }
        h3{
            margin-top: 10px;
        }
        table{
            margin : 10px;
            width: 100%;
        }
        table th,
        table td{
            padding-left: 10px;
        }
        .correct{
		    color : green;
		}
		.incorrect{
		    color : red;
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
        <h3><b>회원가입</b></h3>
        <form id="joinForm" action="/join" method="post"> 
            <div class="row">
                <label for="userid" class="col-3">아이디</label>
                <input type="text" name="userid" id="userid" placeholder="아이디를 입력하세요." class="col-7 join" required>
                <input type="button" name="idCheck" id="idCheck" class="join" value="중복확인" style="margin-left:5px;">
            </div>
            <div class="row">
                <labeL for="userpw" class="col-3">비밀번호</label>
                <input type="password" name="userpw" id="userpw" placeholder="비밀번호를 입력하세요." class="col-7 join" required>
            </div>                    
            <div class="row">
                <labeL for="checkPw" class="col-3">비밀번호 확인</label>
                <input type="password" name="checkPw" id="checkPw" placeholder="비밀번호 확인." class="col-7 join" required>
            </div>
            <div class="row">
                <label for="userName" class="col-3">이름</label>
                <input type="text" name="userName" id="userName" placeholder="이름을 입력하세요." class="col-7 join" required>
            </div>
            <div class="row">
                <label for="addr1" class="col-3">우편번호</label>
                <input type="text" name ="addr1" id="addr1" class="col-7 join" readonly required>
                <input type="button" name="searchAddr" id="searchAddr" class="join" value="찾기">
            </div>
            <div class="row">
                <label for="addr2" class="col-3">기본 주소</label>
                <input type="text" name="addr2" id="addr2" class="col-7 join" readonly required>
            </div>
                <div class="row">
                    <label for="addr3" class="col-3">상세 주소</label>
                    <input type="text" name="addr3" id="addr3" class="col-7 join" placeholder="상세주소를 입력하세요." required>
            </div>
            <div class="row">
                <label for="userEmail" class="col-3">이메일</label>
                <input type="email" name="userEmail" class="col-7 join" id="userEmail" placeholder="이메일을 입력하세요." required>
                <input type="button" name="email_send" id="email_send" class="join" value="인증">
            </div>
            <div class="row">
                <label for="userTel" class="col-3">전화번호</label>
                <input type="tel" name="userTel" class="col-7 join" id="userTel" placeholder="전화번호를 입력하세요." required>
            </div>
            <div class="row" id="validCheck">
                <label for="confirmCheck" class="col-3">인증번호</label>
                <input type="text" name="confirmCheck" class="col-7 join" id="confirmCheck" placeholder="인증번호를 입력하세요.">
                <span style="color: red; margin-left: 10px;">3:00</span>
                <div><span id="checkedValid"></span></div>
            </div>
            <div class="row float-right">
                <input type="button" id="joinBtn" class="btn btn-info" value="가입"/>
                <input type="button" class="btn btn-danger" value="취소" onclick="location.href='/login'" style="margin-left: 5px;"/>
            </div>
            <input type="hidden" name="auth" value="ROLE_MEMBER" />
   			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />         
        </form>
    </div>
    <script src="/resources/js/common.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
   		let idCheck = "";
        let pwCheck = false;
        let id, csrfToken, inputPw, checkPw, addr1, addr3;

        // 인증번호 전송 및 인증번호 비교시 사용하는 변수
        let code = "";
        let chkValid = false;
        let email, validCheck, inputCode, checkResult;
   
        $("#idCheck").on("click", function(e){
        	id = $("#userid").val();
        	if(id.trim() === "" || id === null){
        		alert("아이디를 입력해주세요.");
        		return;
        	}
        	$.ajax({
        		type : "POST",
        		url : "/idCheck",
        		data : {userid: id},
        		dataType : "JSON",
        		beforeSend : function(jqXHR, setting){
        			csrfToken = $("meta[name='_csrf']").attr("content");
        			jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
        		},
        		success : function(data){
        			if(data === true){
        				idCheck = false;
        				alert("이미 아이디가 존재합니다.");
        			} else{
        				idCheck = true;
        				alert("사용할 수 있는 아이디입니다.");
        			}
        		}, 
        		error : function(request,status,error){
        			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        		}
        	});
        });
        
        $("#userid").on("change", function(e){
        	idCheck = "";
        });
        
        $("#checkPw").on("blur", function(){
        	inputPw = $("#userpw").val();
        	checkPw = $("#checkPw").val();
        	if(inputPw === checkPw){
        		pwCheck = true
        	}
        })

       	$("#searchAddr").on("click", function(){
			// 주소 api (daum)
            searchAddr();
		});	

        
        $("#email_send").on("click", function(e){
        	e.preventDefault();
        	sendEmail();
        });
        
        /* 인증번호 비교 */
        $("#confirmCheck").blur(function(){
        	comfirmCheck();
        });
                
        $("#joinBtn").on("click", function(e){
    		e.preventDefault();
    		addr1 = $("#addr1").val();
    		addr3 = $("#addr3").val();
        	if(idCheck === true){
        		if(pwCheck === true){
            		if(chkValid != true){
            			alert("인증을 진행해주세요.");
            			return;
            		}        			
        		} else{
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
        		$("#joinForm").submit();
        		alert('가입이 완료되었습니다. \n로그인 후 사용해주세요');
        	} else{
        		alert("아이디 중복확인을 해주세요.");
        	}
        });
    </script>
</body>
</html>