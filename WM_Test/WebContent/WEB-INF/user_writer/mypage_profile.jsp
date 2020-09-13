<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WM 웹 전시관</title>
    <style>

#container{
    position: relative;
    width: 1382px;
    height: 1356px;
    left: calc(50% - 1382px/2);
    top: calc(50% - 1356px/2 + 42px);
    
}

        .side {
            float: left;
            position: fixed;
            top: 40%;
        }
        .side li {
            color: black;
            width: 130%;
            margin-top: 50%;
            font-size: 1.5em;
            padding: 10%;
            text-align: center;
            border-radius: 50%;
        }
        .side li:hover {
            background-color: #927E9C;
            cursor: pointer;
        }
        .side a {
            text-decoration: none;
        }
        .main {
            float: left;
            margin-left: 40%;
            width: 50%;
        }
        .main input {
            float: left;
            border-top: none;
            border-left: none;
            border-right: none;
            width: 70%;
            background-color: #F9F9F9;
            font-size: 1em;
            height: 3em;
        }
        .main div {
            margin-top: 10%;
        }
        #nick {
            width: 50%;
        }
        #conf {
            width: 10%;
            height: 3em;
            margin-left: 5%;
            background-color: #927E9C;
            border-radius: 50%;
        }
        #btn {
            margin-left: 10%;
            width: 100%;
        }
        #btn button {
            margin-left: 20%;
            height: 3em;
            width: 10%;
            background-color: #927E9C;
        }
        #pro {
           background-color:  #927E9C;
       }
    </style>
</head>
<body>
    <jsp:include page="../../header.jsp"></jsp:include>
	<div id="container">
        <div id="contents">
            <div class="side">
                <ul type="none">
                    <a href="mypage-both-profile.html"><li id="pro">프로필 관리</li></a>                
                    <a href="mypage-artist-his.html"><li>나의 출품 목록</li></a>
                </ul>
            </div>
            <div class="main">
                <form>
                    <div>
                        <label for="email">이메일</label>  <br>
                        <input type="email" name="email" id="email"><br>
                    </div>
                    <div>
                        <label for="nick">닉네임</label> <br>
                        <input type="text" name="nick" id="nick"><button id="conf">중복확인</button>
                    </div>
                    <div>
                        <label for="pw">비밀번호</label><br>
                        <input type="password" name="pw" id="pw"><br>
                    </div>
                    <div>
                        <label for="pwc">비밀번호 확인</label><br>
                        <input type="password" name="pwc" id="pwc"><br>
                    </div>
                    <div id="btn">
                        <button>변경하기</button>
                    </div> 
                </form>
                 
            </div>
        </div>
    </div>
</body>
</html>