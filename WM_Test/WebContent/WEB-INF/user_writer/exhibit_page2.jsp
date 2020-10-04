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
	<!--<jsp:include page="../../header.jsp"></jsp:include>-->
	<div id="container">
		<div id="contents">
			<div id="my_exihibit">
				<div>
					<h2>나의 출품 목록</h2>
					<table>
						<tr>
							<td>${showParam.show_title}</td>
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
   

    /*작품정보를 받아와 콘텐츠영역안에 테이블을 생성하여 보여주는 함수*/
     // 출품한 작품목록
        function displayExhibitWorkInfo() {
    		var i = 0;
            var exhibitList = document.getElementById('exhibit_list');
            exhibitList.innerHTML = "";
            <c:forEach items="${workList}" var="item">
                var li = document.createElement('li');
                li.innerHTML = `<input type="hidden" id="i_work_idx_\${i}" name="i_work_idx_\${i}" value="${item.i_work}">
                <span style="cursor: default" id="work_title_idx_\${i}">\${i+1}.${item.work_title}</span><a id="mod_exhibit" style="cursor: pointer" onclick="modExhibit(\${i})">수정</a>
                <a id="del_exhibit" style="cursor: pointer" onclick="delExhibit(\${i})">삭제</a>`;
                exhibitList.append(li);
                i++;
            </c:forEach>
        }
    /*
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
    */

	/*출품신청 작품 수정/삭제 하는 함수*/
    function delExhibit(i){
    	var title = document.getElementById(`work_title_idx_\${i}`).innerHTML;
        if(confirm(`제목: \${title}\n삭제하시겠습니까?`)){
        	var form = document.createElement('form'); // 폼객체 생성
        	var objs;
        	objs = document.createElement('input'); // 값이 들어있는 녀석의 형식
        	objs.setAttribute('type', 'text'); // 값이 들어있는 녀석의 type
        	objs.setAttribute('name', 'i_work'); // 객체이름
        	objs.setAttribute('value', document.getElementById(`i_work_idx_\${i}`).value); //객체값
        	form.appendChild(objs);
        	var objs2;
        	objs2 = document.createElement('input'); // 값이 들어있는 녀석의 형식
        	objs2.setAttribute('type', 'text'); // 값이 들어있는 녀석의 type
        	objs2.setAttribute('name', 'i_show'); // 객체이름
        	objs2.setAttribute('value', ${showParam.i_show}); //객체값
        	form.appendChild(objs2);
        	form.setAttribute('method', 'post'); //get,post 가능
        	form.setAttribute('action', "/exhibit_page2"); //보내는 url
        	document.body.appendChild(form);
        	form.submit();
            
        }
    }

    function modExhibit(i){
        if(confirm('수정 페이지로 이동하시겠습니까?')){
        	var i_work = document.getElementById(`i_work_idx_\${i}`).value;
       
            location.href = "/exhibitRegPage?i_work=" + i_work;
        }
       
    }

    function movePage(idx) {
        alert('페이지 이동Index :' + idx);
    }

    displayExhibitWorkInfo();
    //displayExhibitionWorkInfo(exhibitionWorkInfoArr);
    </script>
</body>

</html>