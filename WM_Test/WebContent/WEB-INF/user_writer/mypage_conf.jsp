<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WM 웹 전시관</title>
 
    <style>
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
           margin-left: 40%;
           margin-top: 15%;
           font-size: 2em;
       }
       .main input {
           width: 40%;
           height: 1.5em;
           border-top: none;
            border-left: none;
            border-right: none;
            background-color: #F9F9F9;
            font-size: 1em;
       }
       .main button {
           width: 15%;
           height: 3em;
           background-color: #927E9C;
       }

    </style>
</head>
<body>
<jsp:include page="../../header.jsp"></jsp:include>
	<div id="container">
        <div id="contents">
            <div class="side">
                <ul type="none">
                    <a href="mypage-both-profile.html"><li>프로필 관리</li></a>                
                    <a href="mypage-artist-his.html"><li>나의 출품 목록</li></a>
                </ul>
            </div>
            <div class="main">
                    <label for="passCon">비밀번호 확인 : </label>
                    <input type="password" name="passCon" id="passCon">
                    <a href="mypage-both-profile.html"><button>확인</button></a>
            </div>
        </div>
        </div>
</body>
</html>