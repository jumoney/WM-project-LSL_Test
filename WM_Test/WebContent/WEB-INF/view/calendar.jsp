<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WM 웹 전시관</title>
<style>
#container {
	display: flex;
	width: 1350px;
	height: 1356px;
	margin: 5px auto;
	justify-content: center;
}

#schedua {
	display: flex;
	justify-content: space-between;
	width: 1200px;
}

#schedua li {
	font-size: 1.2em
}

#now {
	background: cornflowerblue;
	padding: 10px;
}

.now {
	display: flex;
	flex-direction: column;
}

.now .title {
	text-align: center;
	font-size: 1.5em;
}

#now_schedua {
	
}

#now_schedua ul {
	list-style: none;
}

#now_schedua li {
	
}

#now_schedua p {
	
}
</style>
</head>
<body>
	<div id="container">
		<jsp:include page="../../header.jsp"></jsp:include>
		<div id="contents">
			<div id="schedua">
				<div id="now">
					<div class="now">
						<p class="title">NOW</p>
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
						<p class="title">Coming Soon</p>
					</div>
					<div id="coming_schedua">
						<ul>
							<a href="/introduce"><li>2020. 08. 22 ~ 2020. 09. 22
									<p>고흐전
									<p>
							</li></a>
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
						<p class="title">Recruitment</p>
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