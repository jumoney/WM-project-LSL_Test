<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<work_title>등록 페이지1</work_title>
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
			<form action="/exhibit_page1" method="POST" name="exhibit_frm" enctype="multipart/form-data"
				accept-charset="UTF-8">
				<input type="hidden" name="exhibit_list_cnt" id="exhibit_list_cnt">
				<div id="exhibit_list">
				
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
		
		/*테스트를 위한 데이터(후에 서블릿에서 받아올 정보)
		<c:forEach items="${list}" var="item">
			workInfoArr.push(new WorkInfo('${i_work}', '${item.work_image}', '${item.work_title}', '${item.work_ctnt}'));
		</c:forEach>
		*/
		
        /*작품정보를 받아와 콘텐츠영역안에 테이블을 생성하여 보여주는 함수*/
        function displayWorkInfo() {
        	var i = 0;
            var exhibitList = document.getElementById('exhibit_list');
            exhibitList.innerHTML = "";
            <c:forEach items="${list}" var="item">
                var table = document.createElement('table');
                table.setAttribute('id', `idx_\${i}`);
                table.innerHTML = `<input id="i_work_idx_\${i}" type="text" value="${item.i_work}">
                <tr>
                <td rowspan="2">
                <button id="min_work_btn_\${i}" onclick="deleteWorkInfo(\${i}); return false;">－</button>
                </td>
                <td rowspan="2">
                <div id="input_painting_\${i}" onclick="document.all.file\${i}.click()" style="background-image:url(${item.work_image})">
                <input type="file" name="file\${i}" id="file\${i}" style="display:none" accept="image/*" onchange="updatePainting(\${i})">
                <span>이미지 등록/수정</span>
                </div>
                </td>
                <td>제목</td>
                <td>
                <input type="text" name="input_title_\${i}" id="input_title_\${i}" value="${item.work_title}"></td>
                </tr>
                <tr>
                <td>작품설명</td>
                <td><textarea name="input_comment_\${i}" id="input_comment_\${i}">${item.work_ctnt}</textarea></td>
                </tr>`;
                exhibitList.append(table);
                i++;
            </c:forEach>
            
        }
       
	
        /*현재 까지의 입력사항을 검사하는 함수
        function checkInput() {
            for (var i = 0; i < workInfoArr.length; i++) {
            	
            		var work_title = document.getElementById(`input_title_\${i}`).value;
                    var work_ctnt = document.getElementById(`input_comment_\${i}`).value;
                    workInfoArr[i].work_title = work_title;
                    workInfoArr[i].work_ctnt = work_ctnt;
            		//제목, 작품설명, 그림선택 등의 길이(공백미포함)가 0이라면
    				if(workInfoArr[i].work_title.replace(/\s| /gi, "").length == 0 || 
    				 workInfoArr[i].work_ctnt.replace(/\s| /gi, "").length == 0 || 
    				 workInfoArr[i].work_image.replace(/\s| /gi, "").length == 0){
                        return false;
                    }
            	
            }
            return true;
        }
		*/
        /*작품 목록을 지우는 함수
        function deleteWorkInfo(idx) {
            
         
            	/*지울 작품의 타이틀을 가져옴
                var work_title = document.getElementById(`input_title_\${idx}`).value;
            	
                if(confirm(`제목: \${work_title} \n삭제하시겠습니까?`))
                {
                	document.getElementById("idx_" + idx).remove();
                	
                	idx++;
                  	
                    for(var i=idx; i<workInfoArr.length; i++) {
                    	 var table = document.getElementById(`idx_\${i}`);
                         table.setAttribute('id', `idx_\${i - 1}`);
                         var button = document.getElementById(`min_work_btn_\${i}`);
                         button.setAttribute('id', `min_work_btn_\${i-1}`);
                         button.setAttribute('onclick', `deleteWorkInfo(\${i-1})`);
                         var div = document.getElementById(`input_painting_\${i}`);
                         div.setAttribute('id', `input_painting_\${i-1}`);
                         div.setAttribute('onclick', `document.all.file\${i-1}.click()`);
                         var file = document.getElementById(`file\${i}`);
                         file.setAttribute('id', `file\${i-1}`);
                         file.setAttribute('name', `file\${i-1}`);
                         file.setAttribute('onchange', `updatePainting(\${i-1})`);
                         var input = document.getElementById(`input_title_\${i}`);
                         input.setAttribute('id', `input_title_\${i-1}`);
                         input.setAttribute('name', `input_title_\${i-1}`);
                         var textarea =  document.getElementById(`input_comment_\${i}`);
                         textarea.setAttribute('id', `input_comment_\${i-1}`);
                         textarea.setAttribute('name', `input_comment_\${i-1}`);
                    }
                    workInfoArr.splice(idx-1, 1);
                    
                }
              
        }
		*/
        /*추가버튼을 눌렀을시 공백의 입력란을 만들어주는 함수*/
        function insertWorkInfo() { 
           
            var exhibitList = document.getElementById('exhibit_list');
            var listLastIndex = exhibitList.childElementCount;
            console.log(listLastIndex);
          
                var table = document.createElement('table');
                table.setAttribute('id', `idx_\${listLastIndex}`);
                table.innerHTML = `<input id="i_work_idx_\${listLastIndex}" type="text" value="">
                <tr>
                <td rowspan="2">
                <button id="min_work_btn_\${listLastIndex}" onclick="deleteWorkInfo(\${listLastIndex}); return false;">－</button>
                </td>
                <td rowspan="2">
                <div id="input_painting_\${listLastIndex}" onclick="document.all.file\${listLastIndex}.click()" style="background-image:url()">
                <input type="file" name="file\${listLastIndex}" id="file\${listLastIndex}" style="display:none" accept="image/*" onchange="updatePainting(\${listLastIndex})">
                <input type="hidden" name="input_image_\${listLastIndex}" id="input_image_\${listLastIndex}">
                <span>이미지 등록/수정</span>
                </div>
                </td>
                <td>제목</td>
                <td>
                <input type="text" name="input_title_\${listLastIndex}" id="input_title_\${listLastIndex}"></td>
                </tr>
                <tr>
                <td>작품설명</td>
                <td><textarea name="input_comment_\${listLastIndex}" id="input_comment_\${listLastIndex}"></textarea></td>
                </tr>`;
                exhibitList.append(table);
            
        }
		
        /*이미지 선택시 이미지 저장과 이미지 변경
        function updatePainting(idx) {
            var work_image = WORK_PATH + document.getElementById(`file\${idx}`).value.substring(document.getElementById(`file\${idx}`).value.lastIndexOf("\\") + 1);
			//work_image 맴버 변수에는 파일 이름만 들어간다.
			workInfoArr[idx].work_image = work_image;
            document.getElementById('input_painting_' + idx).setAttribute('style', `background-image:url(\${workInfoArr[idx].work_image})`);
            //displayWorkInfo(workInfoArr);
            var work_image = document.getElementById('file' + idx).files[0].name;
            document.getElementById(`input_image_\${idx}`).value = work_image;
            
        }
		*/
        /*출품하기 버튼 눌렀을때 페이지 이동하는 페이지*/
        function submitExihibit(){
        	
			if(workInfoArr.length > 0)
			{
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
			}else {
				alert('하나 이상의 작품을 출품해주세요.');
			}
        	
		}
        

        displayWorkInfo();
    </script>
</body>

</html>