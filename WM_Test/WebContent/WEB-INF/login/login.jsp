<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>


    <style>

#loginFrm {
    width: 80%;
    margin:10% auto; 
    text-align: center;
 
}
label {
    margin-top: 1%;
    padding-left: 1em;
    margin-right: 2%;
    display:inline-block;
    margin-bottom: 3em;
    font-size: 1.4em;
    font-size-adjust:0.6em
}

input {
    width: 40%;

    margin-bottom: 3.5em;
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


#login_title{
    position: relative;
    color: #4C3C50;
    font-size:2em;
    text-align: center;}





#submit_btn {
    display:block;
    margin: 2em auto;
    width: 60%;
    height:3.5em;
    background: #927E9C;
    border: none;
    border-radius:1em;
    font-size: 1em;
    padding:10px;
    color: white;

}
    
    </style>
</head>
<body>
        <div id="contents">
            <h2 id="login_title">로그인</h2>
            <div>${msg}</div>
            <form action="/login" id="loginFrm" method="post" onsubmit="return chk()">      
               <div class="user_email"><label for="user_email">이메일</label>
                    <input type="email" name="user_email" id="user_email" value="${user_email}" required autofocus>
                </div>            
                <div class="user_pw"><label for="user_pw">비밀번호</label>
                    <input type="password" name="user_pw" id="user_pw" required>
                </div>
                <div class="submit_btn">
                    <input type="submit" value="로그인" id="submit_btn">
                </div>
                </form>
        </div>
        <div><a href="/join">회원가입</a></div>
        <div id="footer">
            <h3>푸터 영역</h3>        
        </div>
</body>
</html>