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
         margin: 10px 0px 0px 10px;
      }
      h3{
         margin: 10px 0px 20px 10px;
      } 
      .rpw{
         margin-top: 10px;
      }
   </style>
</head>
<body>
   <h3><b>회원정보 수정</b></h3>
   <form>   
	   <div class="row rpw">
	      <label class="col-2">비밀번호 </label>
	      <input type="password" name="userpw" id="userpw" class="col-5" placeholder="비밀번호를 입력하세요.">
	      <input type="hidden" name="userid" id="userid" value="${userId}">
	   </div>
	   <div class="row float-right rpw" style="margin-right: 330px;">
	      <button id="checkBtn" class="btn btn-info">확인</button>
	      <input type="button" id="cancelBtn" class="btn btn-danger" value="취소" style="margin-left: 10px;"/>
	   </div>
   </form>
   <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
   <script>
	   let userpw, userid, csrfToken;

	   $("#checkBtn").on("click", function(e){
    	   e.preventDefault();
    	   userpw = $("#userpw").val();
    	   userid = $("#userid").val();
    	   $.ajax({
    		  url : "/modCheck",
    		  type : "post",
    		  data : {userpw: userpw, userid: userid},
      		  dataType : "JSON",
      		  beforeSend : function(jqXHR, setting){
      			csrfToken = $("meta[name='_csrf']").attr("content");
      			jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
      		},
      		success : function(data){
    			if(data === true){
    				location.href = "/modjoin?userid="+userid;
    			} else{
    				alert("비밀번호가 일치하지 않습니다.");
    				return;
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