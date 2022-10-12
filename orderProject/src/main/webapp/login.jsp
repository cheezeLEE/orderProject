<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
</head>
<body>
    <div class="login" style="margin-left:10px; width:250px; height:200px;">
        <h1>로그인</h1>
        <form id="loginform" action="/login" method="POST">
            <div class="form-group">
                <label for="userid" style="width:60px;">아이디</label>
                <input type="text" id="username" name="username" style="width:180px;">
            </div>
            <div class="form-group">
                <label for="userpw" style="width:60px;">비밀번호</label>
                <input type="password" id="password" name="password" style="width:180px;">
            </div>
            <div class="form-group">
                <a href="#" style="float:left" onclick="window.open('/searchId', '_blank', 'width=700px, height=300px');">아이디</a><a href="#" style="float:left" onclick="window.open('/searchPw', '_blank', 'width=700px, height=300px');">/비밀번호 찾기</a>
                <a href="/join" style="float:right">회원가입</a>
            </div>
            <div>
                <button id="loginbtn" class="btn btn-primary" style="width:100%">로그인</button>
            </div>
			<!-- csrf토큰을 hidden에 저장 : 사이트간 위조 방지 목적 -->
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </form>    
    </div>
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <script>
	    $("#loginbtn").on("click", function(e){
	        
	        e.preventDefault();
	        $("form").submit();
	        
	      });
    </script>
</body>
</html>