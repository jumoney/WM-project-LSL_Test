<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<work_title>전시회 관리 페이지</work_title>
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
#exhibit_list {
	width: 100%;
	margin: 5% auto;
}

#exhibit_list table {
	border-collapse: separate;
	width: 100%;
	height: 280px;
	margin-bottom: 5%;
}

#exhibit_list table:nth-last-child(1) {
	animation: fadeInDown;
	animation-duration: 1s;
}

#exhibit_list table tr:nth-child(1) td:nth-child(1) {
	width: 7%;
}

#exhibit_list table td:nth-child(1) button {
	border-style: none;
	background-color: rgb(241, 113, 113);
	color: white;
	font-weight: bold;
	text-align: center;
	font-size: 2em;
	padding-bottom: 10%;
	border-radius: 50%;
	cursor: pointer;
}

#exhibit_list table td:nth-child(1) button:hover {
	background-color: rgb(214, 18, 18);
	transition-duration: 0.7s;
}

#exhibit_list table td:nth-child(2) {
	position: relative;
	width: 25%;
}

#exhibit_list table td:nth-child(2) div {
	position: absolute;
	top: 0;
	width: 90%;
	height: 100%;
	background-size: 100% 100%;
	cursor: pointer;
	display: table;
}

#exhibit_list table td:nth-child(2) div:hover {
	opacity: 0.8;
	transition-duration: 0.5s;
}

#exhibit_list table td:nth-child(2) div span {
	text-align: center;
	display: table-cell;
	vertical-align: middle;
	font-size: 1.5em;
	font-weight: bold;
	color: black;
	opacity: 0%;
}

#exhibit_list table td:nth-child(2) div span:hover {
	text-align: center;
	display: table-cell;
	vertical-align: middle;
	font-size: 1.5em;
	font-weight: bold;
	color: black;
	opacity: 100%;
}

#exhibit_list table td:nth-child(3) {
	width: 12%;
	height: 5%;
	text-align: center;
	font-size: 1.2em;
	background-color: #DCD3C0;
	border: 0;
	margin: 0;
	font-weight: bolder;
}

#exhibit_list table td:nth-child(4) {
	position: relative;
	border: 0;
	width: 100%;
	background-color: rgba(235, 230, 230, 0.5);
}

#exhibit_list table td:nth-child(4) input {
	position: absolute;
	top: 0;
	left: 5%;
	border: 0;
	font-size: 1.5em;
	font-weight: bold;
	width: 90%;
	height: 100%;
	background-color: rgba(235, 230, 230, 0.5);
}

#exhibit_list table tr:nth-child(2) td:nth-child(1) {
	background-color: rgba(255, 255, 255, 0.37);
	text-align: center;
	font-size: 1.2em;
	font-weight: bold;
}

#exhibit_list table tr:nth-child(2) td:nth-child(2) {
	position: relative;
	background-color: #FAF7F1;
	width: 100%;
	height: 150px;
	font-weight: bold;
	border: 0;
	padding: 0;
}

#exhibit_list table tr:nth-child(2) td:nth-child(2) textarea {
	position: absolute;
	top: 5%;
	left: 5%;
	width: 90%;
	height: 90%;
	resize: none;
	background-color: #FAF7F1;
	font-weight: bolder;
	font-size: 2em;
	border: 0;
}

#add_work_btn {
	display: block;
	border: none;
	width: 85px;
	height: 85px;
	border-radius: 50%;
	background-color: #ACA6CF;
	font-size: 4.5em;
	color: white;
	margin: 0% auto;
	cursor: pointer;
}

#add_work_btn:hover {
	transition-duration: 0.7s;
	background-color: #5a5095;
}

#exhibit_work_btn {
	display: block;
	border: none;
	width: 150px;
	height: 65px;
	border-radius: 10px;
	background-color: #92809B;
	font-size: 140%;
	padding: 0% 0%;
	color: white;
	margin: 10% auto;
	cursor: pointer;
}

#exhibit_work_btn:hover {
	transition-duration: 0.7s;
	background-color: #70348e;
}

input:focus {
	outline: none;
}

textarea:focus {
	outline: none;
}

button:focus {
	outline: none;
}
</style>
<body>
	<div id="container">
		<div id="contents">
		<div>
		<img src="${imagePath}${data.show_poster}">
			<h1>전시회 제목: ${data.show_title}</h1>
			<h2>전시회 설명: ${data.show_ctnt}</h2>
			<h3>전시회 기간: ${data.start_dt} ~ ${data.end_dt} </h3>
			<h3>전시작개수: 25개 </h3>
			<h3>현재 전시신청중인 작품 수 :${fn:length(workList)}개</h3>
		</div>
		
			<form action="/exhibit_page1" method="POST" name="exhibit_frm" enctype="multipart/form-data"
				accept-charset="UTF-8">
				<!-- 어느 전시회인지를  POST로 보내주기 위해 i_show정보를 담아놓는다. -->
				<input type="hidden" name="i_show" id="i_show" value="${data.i_show}">
				<input type="hidden" name="list_cnt" id="list_cnt" value="">
				<div id="exhibit_list">
				
				</div>
			</form>
			
		</div>
		<div id="footer">
			<h3>푸터 영역</h3>
		</div>
	</div>
	<script>
        /*작품정보를 받아와 콘텐츠영역안에 테이블을 생성하여 보여주는 함수*/
        function displayWorkInfo() {
        	
            var exhibitList = document.getElementById('exhibit_list');
            exhibitList.innerHTML = "";
           var i = 0;
            <c:forEach var="item" items="${workList}">
            var table = document.createElement('table');
            table.setAttribute('id', `idx_\${i}`);

            table.innerHTML = `<input type="hidden" id="i_work_idx_\${i}" value="${item.i_work}">
            <tr>
            <td rowspan="2">
            <button id="min_work_btn_\${i}" onclick="deleteWorkInfo(\${i}); return false;">－</button>
            </td>
            <td rowspan="2">
            <div id="input_painting_\${i}" onclick="" style="background-image:url('${workImagePath}${item.i_user}/${item.work_image}')">
            <input type="file" name="file\${i}" id="file\${i}" style="display:none" accept="image/*" style="visibility:hidden">
            <input type="hidden" name="input_image_\${i}" id="input_image_\${i}">
            <span style="visibility:hidden">이미지 등록/수정</span>
            <input id="work_image_idx_\${i}" name="work_image_idx_\${i}" type="hidden" value="">
            </div>
            </td>
            <td>제목</td>
            <td>
            <input type="text" name="input_title_\${i}" id="input_title_\${i}" value="${item.work_title}" readonly></td>
            </tr>
            <tr>
            <td>작품설명</td>
            <td><textarea name="input_comment_\${i}" id="input_comment_\${i}" readonly>${item.work_ctnt}</textarea></td>
            </tr>`;
            exhibitList.append(table);
            i++;
            </c:forEach>
        }
		
        /*작품 목록을 지우는 함수*/
        function deleteWorkInfo(idx) {
         
            	/*지울 작품의 타이틀을 가져옴*/
                var work_title = document.getElementById(`input_title_\${idx}`).value;
            	
                if(confirm(`제목: \${work_title} \n삭제하시겠습니까?`))
                {
                    var form = document.createElement('form'); // 폼객체 생성
                    var objs;
                    objs = document.createElement('input'); // 값이 들어있는 녀석의 형식
                    objs.setAttribute('type', 'text'); // 값이 들어있는 녀석의 type
                    objs.setAttribute('name', 'i_work'); // 객체이름
                    objs.setAttribute('value', document.getElementById(`i_work_idx_\${idx}`).value); //객체값
                    form.setAttribute('method', 'post'); //get,post 가능
                    form.setAttribute('action', '/exhibitionManagementPage'); //보내는 url
                    form.appendChild(objs);
                    document.body.appendChild(form);
                    form.submit();
                 }
        }
			
        displayWorkInfo();
    </script>
</body>

</html>