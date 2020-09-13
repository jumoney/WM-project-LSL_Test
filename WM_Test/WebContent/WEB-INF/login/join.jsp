<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>

    <style>

#joinFrm {
    width: 100%;
    margin:5% auto;
    
 
}

label {
    padding-left: 1em;
    display: block;
    margin: 10px;
    font-size: 1.4em;
    font-size-adjust:0.6em
}

#pw_guide {
    display: block;
    padding-left: 2em;
    margin-bottom: 2em;
    font-size: 1em;
    color: rgb(170, 14, 14);
    font-size-adjust:0.6em
}

input {
    width: 55%;
    height: 2.5em;
    margin-left: 3%;
    margin-bottom: 2em;
    height: 1.8em;
    font-size: 1.2em;
    border-top: 0px;
    border-left: 0px;
    border-right: 0px;
    border-bottom: 1px solid black;
    background: #F9F9F9;
    padding-left: 1em;
    font-size-adjust:0.6em;
    cursor:pointer;
}

#birthday {
    padding-left: 1em;
    display: block;
    margin: 10px;
    font-size: 1.4em;
    font-size-adjust:0.6em
}

.birthday>label {
    display: inline-block;
    width: 5%;
    margin-right: 10px;
    padding-left: 0;
    font-size-adjust:0.6em
}

.birthday>input {
    width: 15%;

  
}

.birthday>#month, #date {
    width: 10%;
    margin-left: 3px;
    
}

#join_title{
    position: relative;
    color: #4C3C50;
    font-size:2em;
    margin: 1% 0% 10% 3%}

.nickname>input{width:45%}
.news{height: 10%;}
#user_pw{margin-bottom: 0.8em;}
#news {
    font-size:1.3em;
    height: 1em;
    width: 1.3em;
    margin-right: 0.5em;
}

#news_guide {
    font-size: 1.3em;
    
   
}

#double_check {
    display: inline-block;
    width: 13%;
    height: 2.5em;
    border: none;
    background: #544E57;
    border-radius:1em;
    font-size: 1em;
    padding:10px;
    color: white;

}

#submit_btn {
    display:block;
    margin: 4em auto;
    width: 60%;
    height:3.5em;
    background: #927E9C;
    border: none;
    border-radius:1em;
    font-size: 1em;
    padding:10px;
    color: white;

}
.msg {
	color: red;
}  
    </style>
</head>
<body>
 	
        <div id="contents">
            <h2 id="join_title">회원가입</h2>
            <form action="" id="joinFrm" method="post" onsubmit="return chk()">
               <div class="user_email"><label for="user_email">이메일</label>
                    <input type="email" name="user_email" id="user_email" required autofocus>
                     <input type="button" value="중복확인" id="double_check" onclick="chkEmail()">
                     <input type="hidden" name="idCheck" value="idUnCheck">
                     <div id="idChkResult" class="msg"></div>
                </div>
                <div class="nickname">
                    <label for="nickname">닉네임</label>
                    <input type="text" name="nickname" id="nickname" placeholder="5글자 이하">
                    <input type="button" value="중복확인" id="double_check" onclick="chkNickname()">
                    <input type="hidden" name="nicknameCheck" value="nicknameUnCheck">
                    <div id="nicknameChkResult" class="msg"></div>
                </div>
                <div class="user_pw"><label for="user_pw">비밀번호</label>
                    <input type="password" name="user_pw" id="user_pw" required>
                    <span id="pw_guide">8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.</span>
                </div>
                <div class="user_pwre"> <label for="user_pwre">비밀번호확인</label>
                    <input type="password" name="user_pwre" id="user_pwre"></label>
                </div>
                <div class="birthday">
                    <p id="birthday">생년월일</p>
                    <input type="text" name="user_year" id="year" placeholder="예)1990"><label for="year">년</label>
                    <input type="text" name="user_month" id="month" placeholder="예)12"><label for="month">월</label>
                    <input type="text" name="user_date" id="date" placeholder="예)1"><label for="date">일</label>
                </div>
                <div class="news">
                	<label id="news_guide" for="news"> <input type="checkbox" name="news" value="1" id="news">전시회 정보 및 소식 받기</label>
                </div> 
                <div class="submit_btn">
                    <input type="submit" value="가입하기" id="submit_btn" >
                </div>
             </form>
        </div>
        <div id="footer">
            <h3>푸터 영역</h3>
        </div>

		<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
		<script>
			function chk() {
				if (joinFrm.user_pw.value.length < 8) {
					alert("비밀번호는 8글자 이상이어야 합니다.")
					joinFrm.user_pw.focus()
					return false
				} else if (joinFrm.user_pw.value != joinFrm.user_pwre.value) {
					alert("비밀번호를 확인해주세요.")
					joinFrm.user_pw.focus()
					return false
				}
				
				if(joinFrm.idCheck.value != "idCheck") {
					alert('아이디 중복확인을 해주세요.')
					return false
				}
				if(joinFrm.nicknameCheck.value != "nicknameCheck") {
					alert('닉네임 중복확인을 해주세요.')
					return false
				}
				if(joinFrm.user_year.value == ''){
	                alert("년도를 입력하세요.");
	                return false;
	            }    
	            if(isNaN(joinFrm.user_year.value)){
	                alert("년도는 숫자만 입력가능합니다.");
	                return false;
	            }
	            if(joinFrm.user_month.value == ''){
	                alert("월을 입력하세요.");
	                return false;
	            }
	            
	            if(isNaN(joinFrm.user_month.value)){
	                alert("월은 숫자만 입력가능합니다.");
	                return false;
	            }
	            if(joinFrm.user_date.value == ''){
	                alert("일을 입력하세요.");
	                return false;
	            }
	            
	            if(isNaN(joinFrm.user_date.value)){
	                alert("일은 숫자만 입력가능합니다.");
	                return false;
	            }
				if (joinFrm.user_email.value.length > 0) {
					const email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i
					if (!email.test(frm.email.value)) {
						alert("이메일을 확인해 주세요.")
						joinFrm.nm.focus()
						return false
					}
				}
	
			}
			
			function chkEmail() {
				const user_email = joinFrm.user_email.value
				axios.get('/ajaxemail', {
					params: {
						user_email : user_email
					} 
				}).then(function(res) {
					console.log(res)
					if(joinFrm.user_email.value != '') {
						if(res.data == 3) { //아이디 없음
							idChkResult.innerText = '사용할 수 있는 아이디입니다.'
							joinFrm.idCheck.value = "idCheck"
						} else if(res.data == 2) { //아이디 중복됨
							idChkResult.innerText = '이미 사용중입니다.'
							joinFrm.idCheck.value = "idUnCheck"
						}
					} else {
						alert('아이디를 입력해주세요')
					}
					
				})
			}
			
			function chkNickname() {
				const nickname = joinFrm.nickname.value
				axios.get('/ajaxnickname', {
					params: {
						nickname : nickname
					} 
				}).then(function(res) {
					console.log(res)
					if(joinFrm.nickname.value != '') {
						if(res.data == 1) { //아이디 없음
							nicknameChkResult.innerText = '사용할 수 있는 닉네입니다.'
							joinFrm.nicknameCheck.value = "nicknameCheck"
						} else if(res.data == 0) { //아이디 중복됨
							nicknameChkResult.innerText = '이미 사용중입니다.'
							joinFrm.nicknameCheck.value = "nicknameUnCheck"
						}
					} else {
						alert('닉네임을 입력해주세요')
					}
					
				})
			}
		</script>

</body>
</html>