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
#container {
	display: flex;
	width: 1382px;
	height: 1356px;
	margin: 5px auto;
	justify-content: center;
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
	width: 480px;
	height: 0px;
	border: 1px solid #7C6615;
	margin-left: 0;
	margin-right: 50px:
}

.now {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 50px auto
}

#now p {
	margin: 10px;
	font-size: 1.5em;
}

.hr1_r {
	display: inline-block;
	width: 480px;
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
	width: 430px;
	height: 0px;
	border: 1px solid #7C6615;
	margin-left: 0;
	margin-right: 50px:
}

.hr2_r {
	display: inline-block;
	width: 430px;
	height: 0px;
	border: 1px solid #7C6615;
}

.coming_soon {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 50px auto
}

#coming_soon p {
	margin: 10px;
	font-size: 1.5em;
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
}

#schedua .title {
	font-style: normal;
	font-weight: normal;
	font-size: 30px;
	line-height: 42px;
	text-align: center;
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
	font-size: 1.5em;
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
}
</style>
</head>
<body>
	<jsp:include page="../../header.jsp"></jsp:include>
	<div id="container">
		<div id="contents">
			<div class="poster">
				<a href="/introduce"><img src="image/main.png" id="main"></a>
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
								<p>
							</li>
							<li>2020. 09. 22 ~ 2020. 10. 22
								<p>현대미술
								<p>
							</li>
							<li>2020. 08. 22 ~ 2020. 09. 22
								<p>하이선</p>
							</li>
						</ul>
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
								<p>
							</li>
							<li>2020. 09. 22 ~ 2020. 10. 22
								<p>현대미술
								<p>
							</li>
							<li>2020. 08. 22 ~ 2020. 09. 22
								<p>하이선</p>
							</li>
						</ul>
					</div>
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
								<p>
							</li>
							<li>2020. 09. 22 ~ 2020. 10. 22
								<p>현대미술
								<p>
							</li>
							<li>2020. 08. 22 ~ 2020. 09. 22
								<p>하이선</p>
							</li>
						</ul>
					</div>
				</div>
			</div>

		</div>
	</div>


</body>
</html>