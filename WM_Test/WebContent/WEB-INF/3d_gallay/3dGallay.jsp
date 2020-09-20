<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang='en'>

<head>
    <link rel="stylesheet" type="text/css" href="/resource/3d_gallay/css/stylesheet.css" />
    <link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.0.0/animate.min.css" />
</head>

<body>
    <div id='container'></div>
    <div id="pointer" style="height: 2px; width: 2px; position: absolute; top: 50%; left: 50%; background-image: cover;"></div>
    <script src='/resource/3d_gallay/js/libs/three.js'></script>
    <script src="/resource/3d_gallay/js/controls/PointerLockControls.js"></script>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>

    <div id="blocker">

        <div id="instructions">
      <strong>전시회장에 오신걸 환영합니다!</br></br> 클릭으로 시작합니다.</strong> </br></br> W,A,S,D 또는 방향키 = 움직이기 </br></br><strong>Mouse = 주위둘러보기</strong>
        </div>

    </div>

    <div id="blocker2">
        <div id="left_div">
            <div id="painting_like_div">
                <p id="painting_like">1000++</p><img src="/resource/3d_gallay/images/icons/like_icon.png" alt="">
            </div>
            <img id="painting_div" src="/resource/3d_gallay/images/testImg1.png" alt="">
            <div id="painting_comment">
                <p id="painting_writer">작가: </p>
                <p id="painting_name">제목: </p>

                <p id="painting_commnets">작품설명</p>
                <p id="writer_comment"> </p>
            </div>

        </div>
        <div id="right_div">
            <div id="exit_btn" onclick="doExit()"><p>X</p></div>
            <div id="writer_profile">
               
                <div id="writer_info_div">
                    <img>
                    <p id="writer_name"> </p>
                    <p>URL: www.naver.com</p>
                    <p>국적: 네덜란드</p>
                </div>
            </div>
            <div  id="user_commnets_div">
                <div id="user_commnets">
                    <div id="nickname">
                        <p>모나리자</p>
                    </div>
                    <div id="comment">
                        <p>그림 너무 멋있어요!!</p>
                    </div>
                    <div id="like_cmt">
                        <img src="/resource/3d_gallay/images/icons/cmt_like_icon.png" alt="">
                        <p>100++</p>
                    </div>
                </div>
            </div>
            <div id="bottom_div">
                <div id="like_div">
                    <img src="/resource/3d_gallay/images/icons/empty_like_icon.png" alt="">
                    <p>좋아요</p>
                </div>
                <div id="input_comment_div">
                    <div><input type="text"></div>
                    <div><p>게시</p></div>
                </div>
            </div>
        </div>

    <script src="/resource/3d_gallay/js/main.js"></script>
</body>

</html>