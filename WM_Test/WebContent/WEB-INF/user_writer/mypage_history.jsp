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
            margin-left: 30%;
        }
        .main img {
            width: 15%;
            float: left;
        }

        .main #detail {
            margin-left: 20%;
            margin-top: 10%;
        }
        .main button {
            margin-left: 10%;
            background-color: #AA6BBF;
            border-radius: 50%;
        }
        .hr {
            width: 100%;   
        }
        .color {
           background-color:  #927E9C;
       }
       #pro {
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
                    <a href="mypage-both-profile.html" ><li >프로필 관리</li></a>                
                    <a href="mypage-artist-his.html"><li id="pro">나의 출품 목록</li></a>
                </ul>
            </div>
            <div class="main">
                <ul type="none">
                    <li><img src="image/poster.jpeg"><div id="detail">고흐전 <br><br>관람작품 : 10개 <button>상세보기</button><br><br>좋아요 작품 : 5개<button>상세보기</button></div></li> <hr class="hr">    
                    <li><img src="image/poster.jpeg"><div id="detail">고흐전 <br><br>관람작품 : 10개 <button>상세보기</button><br><br>좋아요 작품 : 5개<button>상세보기</button></div></li> <hr class="hr">    
                    <li><img src="image/poster.jpeg"><div id="detail">고흐전 <br><br>관람작품 : 10개 <button>상세보기</button><br><br>좋아요 작품 : 5개<button>상세보기</button></div></li> <hr class="hr">    
                    <li><img src="image/poster.jpeg"><div id="detail">고흐전 <br><br>관람작품 : 10개 <button>상세보기</button><br><br>좋아요 작품 : 5개<button>상세보기</button></div></li> <hr class="hr">       
                </ul>
            </div>
        </div>  
        </div>
</body>
<script>
    
</script>
</html>