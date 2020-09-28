<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Main</title>

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
	font-family: 'RIDIBatang';
	font-weight: 300;
}

#contents {
	position: relative;
	width: 900px;
	margin-top: 280px;
}

.poster {
	display: flex;
	justify-content: center;
	align-items: center;
}

.poster img {
	margin: 10px auto;
}

#schedua li {
	font-size: 1.2em
}

.hr1_l {
	display: inline-block;
	width: 450px;
	height: 0px;
	border: 1px solid #7C6615;
	margin-left: 0;
}

.now {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 50px auto
}

#now p {
	margin: 10px;
	font-size: 28px;
}

.hr1_r {
	display: inline-block;
	width: 450px;
	height: 0px;
	border: 1px solid #7C6615;
}

#now_schedua {
	display: flex;
	justify-content: center;
}

#now_schedua ul {
	display: flex;
	width: 900px;
	justify-content: space-between;
	align-items: center;
	padding: 0;
	list-style: none;
}

#now_schedua li {
	justify-content: space-between;
}

#now_schedua p {
	margin: 0 auto;
	text-align: center;
}

.hr2_l {
	display: inline-block;
	width: 400px;
	height: 0px;
	border: 1px solid #7C6615;
	margin-left: 0;
}

.hr2_r {
	display: inline-block;
	width: 400px;
	height: 0px;
	border: 1px solid #7C6615;
}

.coming_soon {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 30px auto
}

#coming_soosn> p {
	margin: 10px;
	font-size: 28px;
}

#coming_schedua {
	display: flex;
	justify-content: center;
}

#coming_schedua ul {
	display: flex;
	width: 900px;
	justify-content: space-between;
	align-items: center;
	padding: 0;
	list-style: none;
}

#coming_schedua p {
	text-align: center;
	font-size: 28px;
}

.more a{display: flex;
	align-items:center;
	margin:30px 15px 3px 830px;
	height: 45px;
	color: #bbaf7f;} 
.more .t_more{font-size:12px}



.title {
	font-family:'Merriweather', serif;
	font-size:30px;
	font-weight:700;
	line-height: 42px;
	text-align: center;
	margin: 20px;
	text-decoration-line: underline;
	text-transform: capitalize;
	color: #7C6615;
}

.recruitment {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 50px auto
}

#recruitment p {
	margin: 10px;
	font-size: 28px;
}

#recruitment_schedua {
	display: flex;
	justify-content: center;
}

#recruitment_schedua ul {
	display: flex;
	width: 900px;
	justify-content: space-between;
	align-items: center;
	padding: 0;
	list-style: none;
}

#recruitment_schedua p {
	text-align: center;
}

</style>
</head>
<body>

	<div id="container">
		<jsp:include page="../../header.jsp"></jsp:include>
		<div id="contents">
			<div class="poster">
				<a href="/introduce"><img src="resource/main/images/main.png"
					id="main"></a>
			</div>
			<div id="schedua">
				<div id="now">
					<div class="now">
						<div class="hr1_l"></div>
						<p class="title">NOW</p>
						<div class="hr1_r"></div>
					</div>
					<div id="now_schedua">
						<ul>
							<li>2020. 08. 22 ~ 2020. 09. 22
								<p>고흐전
								</p>
							</li>
							<li>2020. 09. 22 ~ 2020. 10. 22
								<p>현대미술
								</p>
							</li>
							<li>2020. 08. 22 ~ 2020. 09. 22
								<p>하이선</p>
							</li>
						</ul>
					</div>
				<div class="more"><a href="/calendar">
					<span class="material-icons md-20">more_horiz</span><span class="t_mores">More</span></a></div>
				</div>
				</div>
				<div id="coming_soon">
					<div class="coming_soon">
						<div class="hr2_l"></div>
						<p class="title">Coming Soon</p>
						<div class="hr2_r"></div>
					</div>
					<div id="coming_schedua">
						<ul>
							<li>2020. 08. 22 ~ 2020. 09. 22
								<p>고흐전
								</p>
							</li>
							<li>2020. 09. 22 ~ 2020. 10. 22
								<p>현대미술
								</p>
							</li>
							<li>2020. 08. 22 ~ 2020. 09. 22
								<p>하이선</p>
							</li>
							
						</ul>
						
					</div>
				<div class="more"><a href="/calendar">
					<span class="material-icons md-20">more_horiz</span><span class="t_mores">More</span></a></div>
				</div>
				<div id="recruitment">
					<div class="recruitment">
						<div class="hr2_l"></div>
						<p class="title">Recruitment</p>
						<div class="hr2_r"></div>
					</div>
					<div id="recruitment_schedua">
						<ul>
							<li>2020. 08. 22 ~ 2020. 09. 22
								<p>고흐전
								</p>
							</li>
							<li>2020. 09. 22 ~ 2020. 10. 22
								<p>현대미술
								</p>
							</li>
							<li>2020. 08. 22 ~ 2020. 09. 22
								<p>하이선</p>
							</li>
						</ul>
					</div>
				<div class="more"><a href="/calendar">
					<span class="material-icons md-20">more_horiz</span><span class="t_mores">More</span></a></div>
				</div>
				</div>
			</div>

		</div>
	</div>

</body>
</html>