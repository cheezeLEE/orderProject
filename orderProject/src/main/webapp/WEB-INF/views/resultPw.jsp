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
   <title>비밀번호 찾기</title>
   <style>
      html {
         overflow:hidden;
      }
      body{
         width: 100%;
         margin: 10px 0px 0px 10px;
      }
      .rpw{
         margin-top: 10px;
      }
   </style>
</head>
<body>
   <div class="container-fluid">
      <h3><b>비밀번호 찾기</b></h3>
      <form id="changePw">
      	<input type="hidden" name="userid" value='<c:out value="${userId}"/>'>
         <div class="row rpw">
            <label class="col-3">변경할 비밀번호 </label>
            <input type="password" name="userpw" class="col-7" id="userPw" placeholder="비밀번호를 입력하세요.">
         </div>
         <div class="row rpw">
            <label class="col-3">비밀번호 확인 </label>
            <input type="password" name="pwCheck" class="col-7" id="pwCheck" placeholder="비밀번호를 다시 입력 하세요.">
         </div>
         <div class="row float-right rpw" style="margin-right: 100px;">
            <button class="btn btn-info" id="chgBtn">변경</button>
            <input type="button" class="btn btn-danger" value="취소" onclick="window.close()" style="margin-left: 10px;"/>
         </div>
       </form>   
   </div>
   <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
   <script>
       let userid, userpw, csrfToken;
       
       $("#chgBtn").on("click", function(e){
    	   e.preventDefault();
       	   userid = $("input[name='userid']").val();
       	   userpw = $("input[name='userpw']").val();    	   
       	   console.log("userid: " + userid);
       	   console.log("userpw: " + userpw);
       	   
       	   $.ajax({
       		   url: "/resultPw",
       		   type: "post",
       		data : {userid: userid, userpw: userpw},
    		dataType : "JSON",
    		beforeSend : function(jqXHR, setting){
    			csrfToken = $("meta[name='_csrf']").attr("content");
    			jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
    		},
    		success : function(result){
    			if(result === 0){
    				alert("비밀번호 변경에 실패하였습니다..");
    				return;
    			} else if(result === 1){
    				alert("비밀번호를 성공적으로 변경하였습니다.");
    				window.close();
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