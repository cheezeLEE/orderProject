<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
   <title>아이디 찾기</title>
   <style>
      html {
         overflow:hidden;
      }
      body{
         width: 800px;
         height: 600px;
         margin: 10px 0px 0px 10px;
      }
      h3{
         margin: 10px 0px 20px 10px;
      } 
   </style>
</head>
<body>
   <h3><b>아이디 찾기</b></h3>
   <div>
      회원님의 아이디는 ${userId}입니다
   </div>
   <div>
      <input type="button" class="btn btn-info" value="로그인" onclick="window.close()"/>   
      <input type="button" class="btn btn-info" value="비밀번호 찾기" onclick="location.href='/searchPw'"/>
   </div>
   <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>