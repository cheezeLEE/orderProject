/**
 * javascript 공통코드
 */

// 주소검색 API 사용
function searchAddr(){
	new daum.Postcode({
	    oncomplete: function(data) {
	        let addr = '';
	        
	        if(data.userSelectedType === 'R'){ // 도로명주소
	        	addr = data.roadAddress;
	        } else{ // 지번주소
	        	addr = data.jibunAddress;
	        }
	        
	        $("#addr1").val(data.zonecode);
	        $("#addr2").val(addr);
	        
	        $("#addr3").focus();
	    }
	}).open();
}

// 이메일 전송
function sendEmail(){
	email = $("#userEmail").val();
	validCheck = $("#validCheck")
	if(email === null || email.trim() === ''){
		return;
	}
	$.ajax({
		type: 'GET',
		url:'mailCheck?email=' + email,
		success: function(data){
			validCheck.attr("disabled", false);
			code = data;
	    	$("#validNo").css("display","block");
			alert('인증번호를 전송하였습니다.');
		},
		error : function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

// 인증번호 비교
function comfirmCheck(){
    inputCode = $("#confirmCheck").val();        // 입력코드    
    checkResult = $("#checkedValid");    // 비교 결과   
    
    if(inputCode == code){                            // 일치할 경우
        checkResult.html("인증번호가 일치합니다.");
        checkResult.attr("class", "correct");
        chkValid = true;
    } else {                                            // 일치하지 않을 경우
        checkResult.html("인증번호를 다시 확인해주세요.");
        checkResult.attr("class", "incorrect");
        chkValid = false;
    }
}

