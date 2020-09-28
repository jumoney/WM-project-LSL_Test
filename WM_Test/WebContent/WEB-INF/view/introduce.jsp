<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WM 웹 전시관</title>
<jsp:include page="../../header.jsp"></jsp:include>
<style>

#footer {
	position: absolute;
	width: 1440px;
	height: 78px;
	left: 0px;
	top: 1740px;
}

#container {
	display: flex;
	width: 1000px;
	margin: 5px auto;
	justify-content: center;
	font-family: 'NanumBarunGothic';
	font-weight: 300;
}

#contents {
	position: relative;
	width: 900px;
	margin-top: 280px;
}

.main {
	width:900px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.poster {
	flex-direction: column;
	margin-left: 50px;
}

#poster {
	width: 625px;
	height: 299px;
	margin-bottom: 30px
}

.main #title {
	display: block;
	margin-bottom: 15px;
}

h3 {
	margin-bottom: 20px
}

.main p {line-height: 25px}

.introduction {
	flex-direction: column;
	margin-left: 50px;
	width: 430px
}

.exhibition {
	display: flex;
	width: 800px;
	flex-direction: column;
	margin-left: 50px;
}

.exhibition ul {
	display: flex;
	flex-wrap: wrap;
	list-style: none;
}


.exhibition ul li {
	flex: 1 1 40%;
	margin-bottom: 1em
}
</style>
</head>
<body>

	<div id="container">
		
		<div id="contents">

			<div class="main">
				<div class="poster">
					<h2 id="title">반고흐 특별전</h2>
					<img src="resource/main/images/main.png"
					id="poster">
				</div>
				<div class="introduction">
					<h3>전시소개</h3>
					<div id="introduction">
						<p>민주평화통일자문회의의 조직·직무범위 기타 필요한 사항은 법률로 정한다. 교육의 자주성·전문성·정치적 중립성
							및 대학의 자율성은 법률이 정하는 바에 의하여 보장된다. 모든 국민은 양심의 자유를 가진다. 제1항의 해임건의는
							국회재적의원 3분의 1 이상의 발의에 의하여 국회재적의원 과반수의 찬성이 있어야 한다.</p>
					</div>
				</div>
			</div>

			<div class="exhibition">
				<h3>전시작품 및 참여작가</h3>

				<div id="exhibition_items">
					<ul>
						<li>대통령이 궐위되거나 /사고로 인하여 직무를...</li>
						<li>헌법재판소의 조직과 운영 / 기타 필요한 사...</li>
						<li>대통령은 국가의 원수이며 / 외국에 대하여 ...</li>
						<li>환경권의 내용과 행사에 / 관하여는 법률로 ...</li>
						<li>누구든지 체포 또는 구속을 / 당한 때에는 적...</li>
						<li>선거와 국민투표의 공정한 / 관리 및 정당에 ...</li>
						<li>국가는 모성의 보호를 위하여 / 노력하여야 ...</li>
						<li>모든 국민은 헌법과 법률이 / 정한 법관에 의...</li>
						<li>이 헌법중 공무원의 임기 / 또는 중임제한에 ...</li>
						<li>대법관의 임기는 6년으로 하며, / 법률이 정...</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>