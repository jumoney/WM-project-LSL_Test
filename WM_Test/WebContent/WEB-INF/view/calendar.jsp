<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	font-family: 'NanumBarunGothic', sans-serif;
	
	display: flex;
	width: 1000px;
	margin: 5px auto;
	justify-content: center;
	font-weight: 500;
}

#contents {
	position: relative;
	width: 900px;
	margin-top: 280px;
}

#schedua {
	display: flex;
	justify-content: space-between;

}

#schedua li {
	
	margin: 10px auto;
}
p{font-size: 20px; text-align: center}

#now, #coming_soon, #recruitment{width: 260px; text-align: center; padding: 10px;}
#now_schedua {
	background: #CBC5AC; padding:15px}
	
#coming_schedua{
background:rgba(224, 218, 200, 1);  padding:15px}

#recruitment_schedua{
background:#E5D8AE;  padding:15px}

.now {
	display: flex;
	flex-direction: column;
}

.title {
	ont-family:'Merriweather', serif;
	font-size:26px;
	font-weight:400;
	line-height: 42px;
	text-align: center;
	margin: 20px;
	text-decoration-line: underline;
	text-transform: capitalize;
	color: #7C6615;
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
								</p>
							</li>
							<li>2020. 09. 22 ~ 2020. 10. 22
								<p>현대미술
								</p>
							</li>
							<li>2020. 08. 22 ~ 2020. 09. 22
								<p>하이선</p>
							</li>
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
				</div>
				<div id="coming_soon">
					<div class="coming_soon">
						<p class="title">Coming Soon</p>
					</div>
					<div id="coming_schedua">
						<ul>
							<a href="/introduce"><li>2020. 08. 22 ~ 2020. 09. 22
									<p>고흐전
									</p>
							</li></a>
							<li>2020. 09. 22 ~ 2020. 10. 22
								<p>현대미술
								</p>
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
				</div>
			</div>

		</div>
	</div>

</body>
</html>