<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="http://www.motionpoint.com/etc/images/ico/favicon.ico">
<title>MP: EntryPoint</title>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/angular.js/1.3.16/angular.min.js"></script>
<script src="<c:url value="/resources/chart/Chart.min.js" />"></script>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/main.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/chart/angular-chart.css" />">
<script src=<c:url value="/resources/chart/angular-chart.js" />></script>

<script src=<c:url value="/resources/js/port.js" />></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
	
</head>
<body data-ng-app="portApp">
	<div class="wrapper" data-ng-controller="portController"
		data-ng-init="init('<c:url value="/api/client/all" />'); expanded = false;">

		<!--  navigation -->
		<div class="main-nav" ng-class="{'main-nav-expanded' : expanded}">
			<div class="logo" ng-click="expanded = !expanded">
				<img src="<c:url value="/resources/css/mp.png" />" class="logo-img" /><a
					href="" class="logo-text">ENTRYPOINT</a>
			</div>
			<div class="nav-entry-wrapper">
				<div class="nav-entry">
					<div class="box-entry-img">
						<i class="material-icons" style="font-size: 36px;">translate</i>
					</div>
					<div class="app-entry-text">
						TRANSLATION DESK
						<div class="box-entry-img" style="float: none"
							ng-show="clientName != 'Zen Pencils'"></div>
					</div>
				</div>
				<div class="nav-entry">
					<div class="box-entry-img">
						<a target="_blank" href="transcribe/{{ selectedTab}}"><i class="material-icons" style="font-size: 36px;">insert_photo</i></a>
					</div>
					<div class="app-entry-text">
						<a target="_blank" href="transcribe/{{ selectedTab}}">IMAGE BENCH</a>
						
						<div class="box-entry-img" style="float: none"
							ng-show="clientName != 'Mizuno Golf'"></div>
					</div>
				</div>
				<div class="nav-entry" ng-show="clientName != 'Zen Pencils'">
					<div class="box-entry-img">
						<i class="material-icons" style="font-size: 36px;">insert_chart</i>
					</div>
					<div class="app-entry-text">
						GLOBAL GROWTH
						<div class="box-entry-img" style="float: none"
							ng-show="clientName == 'Mizuno Golf'"></div>
					</div>
				</div>
				<div class="nav-entry"
					ng-show="clientName != 'Zen Pencils' && clientName != 'Mizuno Golf'">
					<div class="box-entry-img">
						<i class="material-icons" style="font-size: 36px;">web</i>
					</div>
					<div class="app-entry-text">PUBLIC GRAB</div>
				</div>
				<div class="nav-entry"
					ng-show="clientName != 'Zen Pencils' && clientName != 'Mizuno Golf'">
					<div class="box-entry-img">
						<i class="material-icons" style="font-size: 36px;">camera</i>
					</div>
					<div class="app-entry-text">CLIENT PORTAL</div>
				</div>
			</div>
		</div>

		<!-- main page -->
		<div class="main-container" ng-class="{'main-container-expanded' : expanded}">
			<div class="top-bar">
				<div class="top-top-bar" ng-init="selectedTab = 'tesla'">
					<div class="top-bar-box">
						<div class="inactive"
							ng-class="{'active' : selectedTab == 'tesla'}"
							ng-click="selectedTab = 'tesla'; switchClient('tesla')">
							<div class="client-bar-box"
								style="background-image: url(<c:url value="/resources/images/logos/" />tesla.png)">
							</div>
						</div>
					</div>
					<div class="top-bar-box">
						<div class="inactive"
							ng-class="{'active' : selectedTab == 'mizuno-golf'}"
							ng-click="selectedTab = 'mizuno-golf'; switchClient('mizuno')">
							<div class="client-bar-box"
								style="background-image: url(<c:url value="/resources/images/logos/" />mizuno-golf.png)">
							</div>
						</div>
					</div>
					<div class="top-bar-box">
						<div class="inactive" ng-class="{'active' : selectedTab == 'zen-pencils'}"
							ng-click="selectedTab = 'zen-pencils'; switchClient('zen')">
							<div class="client-bar-box"
								style="background-image: url(<c:url value="/resources/images/logos/" />zen-pencils.png)">
							</div>
						</div>
					</div>
					
				</div>
				<div class="top-account-bar">
					<div class="account-box">
						<table>
							<tr>
								<td><img src="resources/images/me.jpg" height="50" /></td>
								<td><a href=""><font color="#0099ff"> Matthew</font></a><br>
									MotionPoint<br /> <a href="logout">Logout</a></td>
							</tr>
						</table>
					</div>
				</div>

			</div>

			<div class="performance-container">
				<div class="logo-box">
					<div class="misc-body"
						style="background-image: url({{ clientLogo }});">
						<div class="client-details" >{{ clientName }}</div>
				</div>
				</div>
				<div class="apps-box">
					<div class="box-head">Mission</div>
					<div class="box-whead" ng-show="selectedTab == 'tesla'">Our
						goal when we created Tesla a decade ago was the same as it is
						today: to accelerate the advent of sustainable transport by
						bringing compelling mass market electric cars to market as soon as
						possible. If we could have done that with our first product, we
						would have, but that was simply impossible to achieve for a
						startup company that had never built a car and that had one
						technology iteration and no economies of scale. Our first product
						was going to be expensive no matter what it looked like, so we
						decided to build a sports car, as that seemed like it had the best
						chance of being competitive with its gasoline alternatives.</div>
					<div class="box-whead" ng-show="selectedTab == 'zen-pencils'">I was
						working in the boring corporate graphic design industry for 8
						years before finally quitting at the end of 2011 to pursue my
						passion for illustration and cartooning. At my old job, when my
						boss wasnt looking, I would waste time reading Wikipedia pages,
						mainly biographies about people whose lives were a lot more
						interesting than mine. Their stories and quotes eventually
						inspired me to leave my job to focus on what I really wanted to
						do. The idea of taking these inspiring quotes, combining them with
						my love of drawing and sharing them with others led to the
						creation of Zen Pencils.</div>
					<div class="box-whead" ng-show="selectedTab == 'mizuno-golf'">Since
						our founding, we have taken special pride and pleasure in being
						able to participate in the exciting world of sports and providing
						sports equipment of the highest quality. Each and every one of us
						is guided by the ideal of true sportsmanship. That was true over
						100 years ago and is still true today. It is evident in our
						corporate philosophy which, simply stated, is "Contributing to
						society through the advancement of sporting goods and the
						promotion of sports." Our product development strategy is to
						create products with features that enhance athlete performance and
						are unique to only Mizuno. We believe in making products that work
						in harmony with your body, helping you to be the best athlete you
						can be.</div>
				</div>


				<div class="misc-box">
					<div class="box-head">Recent Actions</div>
					<div class="box-entry">
						<div class="box-entry-text">
							Translation completed for image: {{ imageNum }} <br> <font
								size="1" color="#d1d1d1">2-29-2016 16:31</font>
						</div>

					</div>
					<div class="box-entry">

						<div class="box-entry-text">
							Transcription completed for image: {{ imageNum }}<br> <font
								size="1" color="#d1d1d1">2-29-2016 16:29</font>
						</div>

					</div>
					<div class="box-entry">
						<div class="box-entry-text">
							<font color="#949FB1"><strong>Translation
									rejected for segment: {{ segThree }}</strong></font><br> <font size="1"
								color="#d1d1d1">2-28-2016 10:59</font>
						</div>
					</div>
					<div class="box-entry">
						<div class="box-entry-text">
							Translation completed for segment: {{ segOne }}<br> <font
								size="1" color="#d1d1d1">2-28-2016 11:12</font>
						</div>
					</div>
					<div class="box-entry">
						<div class="box-entry-text">
							Translation completed for segment: {{ segTwo }}<br> <font
								size="1" color="#d1d1d1">2-28-2016 11:03</font>
						</div>
					</div>

				</div>


				<div class="pr-pie-box" ng-controller="DoughnutCtrl">
					<div class="box-head">Performance</div>
					<div class="box-body">

						<canvas id="doughnut" class="chart chart-doughnut"
							chart-data="data" chart-labels="labels"></canvas>
						<div class="chart-data">
							<font color="#4D5360">Completed: {{ data[0] }}</font> <font
								color="#949FB1">Returned: {{ data[1] }}</font>
						</div>
					</div>
					<div class="box-foot">
						<button ng-click="twoWeeks()" class="chart-button">2
							Weeks</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button ng-click="allTime()" class="chart-button">All
							Time</button>
					</div>
				</div>



				<div class="line-chart-box" ng-controller="LineCtrl">
					<div class="box-head">Translation Index</div>
					<div class="box-whead" style="padding: 5px;">
						<canvas id="line" class="chart chart-line" chart-data="data"
							chart-labels="labels" chart-legend="false" chart-series="series"
							chart-click="onClick" height="85%"> </canvas>
					</div>
				</div>

			</div>
		</div>
		</div>
</body>
</html>