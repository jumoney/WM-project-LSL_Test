<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>등록 페이지1</title>
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
	/*background-image: url(/image/main.png);*/
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
<jsp:include page="../../header.jsp"></jsp:include>
	<div id="container">
		<div id="contents">
			<form action="/exhibit_page2" method="POST" name="exhibit_frm"
				accept-charset="UTF-8">
				<input type="hidden" name="exhibit_list_cnt" id="exhibit_list_cnt">
				<div id="exhibit_list">
					<table>
						<tr>
							<td rowspan="2"><button id="min_work_btn_">－</button></td>
							<td rowspan="2">
								<div id="input_painting_">
									<span>이미지 등록/수정</span>
								</div>
							</td>
							<td>제목</td>
							<td><input type="text" name="input_title_" id="input_title_"></td>
						</tr>
						<tr>
							<td>작품설명</td>
							<td><textarea name="input_comment_" id="input_comment_"></textarea></td>
						</tr>
					</table>
				</div>
				<button id="add_work_btn" onclick='insertWorkInfo();return false;'>+</button>
			</form>
			<button id="exhibit_work_btn" onclick="submitExihibit()">출품하기</button>
		</div>
		<div id="footer">
			<h3>푸터 영역</h3>
		</div>
	</div>
	<script>
    	
	/*작품 경로 상수*/
    const WORK_PATH = '/resource/user_writer/images/exhibition/';

    /*작품 정보 생성자 함수(자바로 치면 클래스) 선언*/
    function WorkInfo(painting, title, comment) {
        this.painting = painting;
        this.title = title;
        this.comment = comment;
    }

    /*작품 정보 배열 생성*/
    var workInfoArr = [];
        
        /*서블릿의 작품 리스트를 받아온다.*/
    	<c:forEach items="${workList}" var="item">
        	workInfoArr.push(new WorkInfo("${item.painting}", "${item.title}", "${item.comment}"));
		</c:forEach>
		
        /*작품정보를 받아와 콘텐츠영역안에 테이블을 생성하여 보여주는 함수*/
       function displayWorkInfo(paramArr) {
    	   var exhibitList = document.getElementById('exhibit_list');
    	   exhibitList.innerHTML = "";
            for (var i = 0; i < paramArr.length; i++) {
                var table = document.createElement('table');
                table.innerHTML = `<tr>
                <td rowspan="2">
                <button id="min_work_btn_\${i}" onclick="deleteWorkInfo(\${i}); return false;">－</button>
                </td>
                <td rowspan="2">
                <div id="input_painting_\${i}" onclick="document.all.file\${i}.click()" style="background-image:url(\${WORK_PATH}\${paramArr[i].painting})">
                <input type="file" name="file\${i}" id="file\${i}" style="display:none" accept="image/*" onchange="updatePainting(\${i})">
                <span>이미지 등록/수정</span>
                </div>
                </td>
                <td>제목</td>
                <td>
                <input type="text" name="input_title_\${i}" id="input_title_\${i}" value="\${paramArr[i].title}"></td>
                </tr>
                <tr>
                <td>작품설명</td>
                <td><textarea name="input_comment_\${i}" id="input_comment_\${i}">\${paramArr[i].comment}</textarea></td>
                </tr>`;
                exhibitList.append(table);
            }
        }

       /*현재 까지의 입력사항을 저장하는 함수*/
       function saveInput(paramArr) {
           for (var i = 0; i < paramArr.length; i++) {
               var title = document.getElementById(`input_title_\${i}`).value;
               var comment = document.getElementById(`input_comment_\${i}`).value;
               paramArr[i].title = title;
               paramArr[i].comment = comment;
           }
       }

       /*현재 까지의 입력사항을 검사하는 함수*/
       function checkInput() {
           //현재까지 입력사항 저장
           saveInput(workInfoArr);
           
           for (var i = 0; i < workInfoArr.length; i++) {
               //제목, 작품설명, 그림선택 등의 길이(공백미포함)가 0이라면
               if(workInfoArr[i].title.replace(/\s| /gi, "").length == 0 || 
                workInfoArr[i].comment.replace(/\s| /gi, "").length == 0 || 
                workInfoArr[i].painting.replace(/\s| /gi, "").length == 0){
                   return false;
               }
           }
           return true;
       }

       /*작품 목록을 지우는 함수*/
       function deleteWorkInfo(idx) {
           /*지울 작품의 타이틀을 가져옴*/
           var title = document.getElementById(`input_title_\${idx}`).value;
           /*삭제확인*/
           if(confirm(`제목: \${title} \n삭제하시겠습니까?`))
           {
               /*현재 까지의 입력 정보를 배열에 저장*/
               saveInput(workInfoArr);
               workInfoArr.splice(idx, 1);
               displayWorkInfo(workInfoArr);
           }
       }

       /*추가버튼을 눌렀을시 공백의 입력란을 만들어주는 함수*/
       function insertWorkInfo() {
           /*현재 까지의 입력 정보를 배열에 저장*/
           saveInput(workInfoArr);
           workInfoArr.push(new WorkInfo("", "", ""));
           displayWorkInfo(workInfoArr);
       }

       /*이미지 선택시 이미지 저장과 이미지 변경*/
       function updatePainting(idx) {
           var painting = document.getElementById(`file\${idx}`).value.substring(document.getElementById(`file\${idx}`).value.lastIndexOf("\\") + 1);
           //painting 맴버 변수에는 파일 이름만 들어간다.
           workInfoArr[idx].painting = painting;
           saveInput(workInfoArr);
           displayWorkInfo(workInfoArr);
       }

       /*출품하기 버튼 눌렀을때 페이지 이동하는 페이지*/
       function submitExihibit(){
           if(checkInput()){
               alert('출품완료');
               for(var i=0; i<workInfoArr.length; i++){
                console.log(workInfoArr[i]);
               }
               document.getElementById('exhibit_list_cnt').value = workInfoArr.length;
               alert('출품작 수 : ' + document.getElementById('exhibit_list_cnt').value + '개');
               document.exhibit_frm.submit();
           }else {
               alert('작성이 완전치 않은 테이블이 존재합니다.\n작성 혹은 삭제 해주세요.');
           }
       }

       displayWorkInfo(workInfoArr);
    </script>
</body>

</html>