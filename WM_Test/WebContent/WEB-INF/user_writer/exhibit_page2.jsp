<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>등록 페이지2</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.0.0/animate.min.css" />
</head>
<style>
#container {
	width: 100%;
	margin: 0 auto;
	border: 1px solid black;
}

/*----------------------- 추가 사항 ----------------- */
#my_exihibit {
	width: 100%;
	margin: 0 auto;
}

#my_exihibit div:nth-child(1) {
	margin-bottom: 5%;
}

#my_exihibit div:nth-child(1) table {
	width: 100%;
}

#my_exihibit div:nth-child(1) table tr td:nth-child(1) {
	width: 30%;
	text-align: center;
	font-size: 150%;
	padding: 7%;
	padding-bottom: 30%;
	padding-top: 10%;
	font-weight: bold;
	background-color: #F7F9EE;
	;
}

#my_exihibit div:nth-child(1) table tr td:nth-child(2) {
	position: relative;
	padding: 0;
	margin: 0;
}

#my_exihibit div:nth-child(1) table tr td:nth-child(2) ul {
	position: absolute;
	top: 0;
	height: 100%;
	width: 100%;
	padding: 0;
	background-color: #DCD3C0;;
	margin: 0;
	list-style-type: none;
}

#my_exihibit div:nth-child(1) table tr td:nth-child(2) ul li {
	position: relative;
	font-weight: bold;
	font-size: 150%;
	margin: 0;
	padding: 2% 0;
	margin-top: 3%;
	padding-left: 2%;
	animation: fadeInDown;
	animation-duration: 1s;
}

#my_exihibit div:nth-child(1) table tr td:nth-child(2) ul li:hover {
	background-color: #C4C4C4;
	transition-duration: 1s;
}

#my_exihibit div:nth-child(1) table tr td:nth-child(2) ul li #mod_exhibit
	{
	position: absolute;
	right: 120px;
	top: 20%;
	font-size: 1em;
	height: 100%;
	border: 0;
	outline: 0;
}

#my_exihibit div:nth-child(1) table tr td:nth-child(2) ul li #del_exhibit
	{
	position: absolute;
	right: 20px;
	top: 20%;
	font-size: 1em;
	height: 100%;
	border: 0;
	outline: 0;
}

/* 두번째 테이블 */
#my_exihibit div:nth-child(2) {
	margin-bottom: 5%;
}

#my_exihibit div:nth-child(2) table {
	width: 100%;
}

#my_exihibit div:nth-child(2) table tr td:nth-child(1) {
	width: 30%;
	text-align: center;
	font-size: 150%;
	padding: 7%;
	padding-bottom: 15%;
	padding-top: 10%;
	font-weight: bold;
	background-color: #F7F9EE;
	;
}

#my_exihibit div:nth-child(2) table tr td:nth-child(2) {
	position: relative;
	padding: 0;
	margin: 0;
	background-color: #DCD3C0;
}

#my_exihibit div:nth-child(2) table tr td:nth-child(2) ul {
	top: 0%;
	height: 100%;
	width: 100%;
	padding: 0;
	margin: 0;
	list-style-type: none;
}

#my_exihibit div:nth-child(2) table tr td:nth-child(2) ul li {
	width: 96%;
	height: 100%;
	font-weight: bold;
	font-size: 150%;
	padding: 0.3% 2%;
	margin-top: 2%;
	animation: fadeInDown;
	animation-duration: 1s;
}

#my_exihibit div:nth-child(2) table tr td:nth-child(2) ul li:hover {
	background-color: #C4C4C4;
	cursor: pointer;
	transition-duration: 1s;
}

#my_exihibit div:nth-child(2) table tr td:nth-child(2) ul li span:nth-child(1)
	{
	float: left;
	width: 40%;
	margin-top: 4%;
}

#my_exihibit div:nth-child(2) table tr td:nth-child(2) ul li #cnt_div {
	margin-top: 3%;
	width: 100%
}
</style>

<body>
	<jsp:include page="../../header.jsp"></jsp:include>
	<div id="container">
		<div id="contents">
			<div id="my_exihibit">
				<div>
					<h2>나의 출품 목록</h2>
					<table>
						<tr>
							<td>새로운 시선 2021.2(예정)</td>
							<td>
								<ul id="exhibit_list">

								</ul>
							</td>
						</tr>
					</table>
				</div>
				<div>
					<h2>전시 목록</h2>
					<table>
						<tr>
							<td>루브르전</td>
							<td>
								<ul id="exhibition_list">

								</ul>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div id="footer">
			<h3>푸터 영역</h3>
		</div>
	</div>
	<script>	
	/*작품 정보 생성자함수(자바의 클래스 개념) 선언*/
	/*출품신청 목록*/
    function ExhibitWorkInfo(title) {
        this.title = title;
    }
	/*전시 목록*/
    function ExhibitionWorkInfo(title, like_cnt, cmt_cnt) {
        this.title = title;
        this.like_cnt = like_cnt;
        this.cmt_cnt = cmt_cnt;
    }

    /*작품 정보 배열 생성(출품 목록, 전시 목록)*/
    var exhibitWorkInfoArr = [];
    var exhibitionWorkInfoArr = [];

    /*작품 정보 배열에 작품 정보 삽입(나중에 jsp에서 받아올 정보)*/
    <c:forEach items="${workList}" var="item">
		exhibitWorkInfoArr.push(new ExhibitWorkInfo('${item.title}'));
	</c:forEach>

	/*전시목록*/
    exhibitionWorkInfoArr.push(new ExhibitionWorkInfo("목련", 100, 100));
    exhibitionWorkInfoArr.push(new ExhibitionWorkInfo("모나미", 100, 100));

    /*작품정보를 받아와 콘텐츠영역안에 테이블을 생성하여 보여주는 함수*/
     // 출품한 작품목록
        function displayExhibitWorkInfo(paramArr) {
            var exhibitList = document.getElementById('exhibit_list');
            exhibitList.innerHTML = "";
            for (var i = 0; i < paramArr.length; i++) {
                var li = document.createElement('li');
                li.innerHTML = `<span style="cursor: default">\${i+1}.\${paramArr[i].title}</span><a id="mod_exhibit" style="cursor: pointer" onclick="modExhibit()">수정</a>
                <a id="del_exhibit" style="cursor: pointer" onclick="delExhibit(\${i})">삭제</a>`;
                exhibitList.append(li);
            }
        }
        // 전시한 작품목록
        function displayExhibitionWorkInfo(paramArr) {
            var exhibitionList = document.getElementById('exhibition_list');
            exhibitionList.innerHTML = "";
            for (var i = 0; i < paramArr.length; i++) {
                var li = document.createElement('li');
                li.setAttribute('onclick', `movePage(\${i})`);
                li.innerHTML = `<span>\${i+1}.\${paramArr[i].title}</span><div id="cnt_div"><img id="like_cnt_icon" src="/resource/user_writer/images/like_icon.png"><span id="like_cnt">\${paramArr[i].like_cnt}++</span>&nbsp&nbsp&nbsp&nbsp&nbsp<img id="cmt_cnt_icon" src="/resource/user_writer/images/cmt_icon.png"><span id="cmt_cnt">\${paramArr[i].cmt_cnt}++</span></div>`;
                exhibitionList.append(li);
            }
        }

	/*출품신청 작품 수정/삭제 하는 함수*/
    function delExhibit(i){
        if(confirm(`제목: \${exhibitWorkInfoArr[i].title}\n삭제하시겠습니까?`)){
            exhibitWorkInfoArr.splice(i, 1);
            alert('삭제 되었습니다.');
            displayExhibitWorkInfo(exhibitWorkInfoArr);
        }
    }

    function modExhibit(){
        if(confirm('수정 페이지로 이동하시겠습니까?')){
            location.href = "/writer/exhibit_page1";
        }
       
    }

    function movePage(idx) {
        alert('페이지 이동Index :' + idx);
    }

    displayExhibitWorkInfo(exhibitWorkInfoArr);
    displayExhibitionWorkInfo(exhibitionWorkInfoArr);
    </script>
</body>

</html>