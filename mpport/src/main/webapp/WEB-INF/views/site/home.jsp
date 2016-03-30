<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MP: EntryPoint</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/angular.js/1.3.16/angular.min.js"></script>
<script src="<c:url value="/resources/chart/Chart.min.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/main.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/chart/angular-chart.css" />">
<script src=<c:url value="/resources/chart/angular-chart.js" />></script>

<script src=<c:url value="/resources/js/port.js" />></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body data-ng-app="portApp">
<div class="wrapper">

<!--  navigation -->
	<div class="main-nav">
		<div class="logo">
			<img src="<c:url value="/resources/css/mp.png" />" class="logo-img" /><a href="" class="logo-text">ENTRYPOINT</a>
		</div>
		<div class="nav-entry-wrapper">
			<div class="nav-entry">
				<div class="selected"><div class="icon-class"><i class="material-icons md-18">dashboard</i></div><div class="entry-word">Dashboard</div></div>
			</div>
			<div class="nav-entry">
				<div class="selected"><div class="icon-class"><i class="material-icons md-18">view_carousel</i></div><div class="entry-word">Projects</div></div>
			</div>
			<div class="nav-entry">
				<div class="selected"><div class="icon-class"><i class="material-icons md-18">insert_chart</i></div><div class="entry-word">Performance</div></div>
			</div>
			<div class="nav-entry">
				<div class="selected"><div class="icon-class"><i class="material-icons md-18">assignment</i></div><div class="entry-word">Activity</div></div>
			</div>
			<div class="nav-entry">
				<div class="selected"><div class="icon-class"><i class="material-icons md-18">business_center</i></div><div class="entry-word">Company</div></div>
			</div>
			<div class="nav-entry">
				<div class="selected"><div class="icon-class"><i class="material-icons md-18">group</i></div><div class="entry-word">Peers</div></div>
			</div>
		</div>
		<div class="nav-corporate">
			<div class="selected-corporate"><div class="icon-class"><i class="material-icons md-18">copyright</i></div><div class="entry-word">MotionPoint</div></div>
		</div>
	</div>
	
<!-- main page -->
	<div class="main-container" data-ng-controller="portController" data-ng-init="init('<c:url value="/api/client/all" />')">
		<div class="top-bar">
			<div class="top-top-bar" ng-init="selectedTab = 'tesla'">	
				<div class="top-bar-box">
					<div class="inactive" ng-class="{'active' : selectedTab == 'tesla'}" ng-click="selectedTab = 'tesla'; switchClient('tesla')">
						<div class="client-bar-box" style="background-image: url(http://morrisontool.com/wordpress/wp-content/uploads/logo-tesla.png)">
						</div>
						<div style="height: 20px">Tesla</div>
					</div>
				</div>
				<div class="top-bar-box">
					<div class="inactive" ng-class="{'active' : selectedTab == 'zen'}" ng-click="selectedTab = 'zen'; switchClient('zen')">
						<div class="client-bar-box" style="background-image: url(<c:url value="/resources/images/logos/" />zen-pencils.png)">
						</div>
						<div style="height: 20px">Zen Pencils</div>
					</div>
				</div>
				<div class="top-bar-box">
					<div class="inactive" ng-class="{'active' : selectedTab == 'mizuno'}" ng-click="selectedTab = 'mizuno'; switchClient('mizuno')">
						<div class="client-bar-box" style="background-image: url(<c:url value="/resources/images/logos/" />mizuno-golf.png)">
						</div>
						<div style="height: 20px">Mizuno Golf</div>
					</div>
				</div>
			</div>
			<div class="top-account-bar">
				<div class="account-box">
				<table><tr><td><img src="resources/images/me.jpg" height="50" /></td><td>
				<a href=""><font color="#0099e0"> Matthew</font></a><br>
				MotionPoint
				</td></tr>
				</table>
				</div>
			</div>
			
		</div>
		
		<div class="performance-container">
		<div class="logo-box">
		<div class="box-head">
				{{ clientName }}
				</div>
		<div class="misc-body" style="background-image: url({{ clientLogo }});">
		</div>
		</div>
		<div class="apps-box">
				<div class="box-head">
					Apps
				</div>
				<div class="misc-body">
				<div class="app-entry">
					<div class="box-entry-img">
						<i class="material-icons" style="font-size: 36px; color: #6c8895;">translate</i>
					</div>
					<div class="app-entry-text">TRANSLATION DESK <div class="new-badge">new</div><div class="box-entry-img" style="float: none" ng-show="clientName != 'Zen Pencils'">
						
					</div>
					</div>
				</div>
				<div class="app-entry">
					<div class="box-entry-img">
						<i class="material-icons" style="font-size: 36px; color: #cabba5;">insert_photo</i>
					</div>
					<div class="app-entry-text"> IMAGE WORKBENCH <div class="new-badge">new</div><div class="box-entry-img" style="float: none" ng-show="clientName != 'Mizuno Golf'">
						
					</div>
					</div>
				</div>
				<div class="app-entry" ng-show="clientName != 'Zen Pencils'">
					<div class="box-entry-img">
						<i class="material-icons" style="font-size: 36px; color: #d3dcbf">insert_chart</i>
					</div>
					<div class="app-entry-text"> GLOBAL GROWTH <div class="box-entry-img" style="float: none" ng-show="clientName == 'Mizuno Golf'">
						
					</div>
					</div>
				</div>
				<div class="app-entry" ng-show="clientName != 'Zen Pencils' && clientName != 'Mizuno Golf'">
					<div class="box-entry-img">
						<i class="material-icons" style="font-size: 36px; color: #94aeac;">web</i>
					</div>
					<div class="app-entry-text"> PUBLIC GRAB
					</div>
				</div>
				<div class="app-entry" ng-show="clientName != 'Zen Pencils' && clientName != 'Mizuno Golf'">
					<div class="box-entry-img" >
					<i class="material-icons" style="font-size: 36px; color: #544d56;">camera</i>
					</div>
					<div class="app-entry-text"> CLIENT PORTAL
					</div>
				</div>
				</div>
			</div>
			
			
						<div class="misc-box">
				<div class="box-head">
					Recent Actions
				</div>
				<div class="box-entry">
					<div class="box-entry-text" > Translation completed for image: {{ imageNum }} <br><font size="1" color="#d1d1d1">2-29-2016 16:31</font></div>
					
				</div>
				<div class="box-entry">
					
					<div class="box-entry-text" >Transcription completed for image: {{ imageNum }}<br><font size="1" color="#d1d1d1">2-29-2016 16:29</font></div>
					
				</div>
				<div class="box-entry">
					<div class="box-entry-text" ><font color="#949FB1"><strong>Translation rejected for segment: {{ segThree }}</strong></font><br><font size="1" color="#d1d1d1">2-28-2016 10:59</font></div>
				</div>
				<div class="box-entry">
					<div class="box-entry-text" >Translation completed for segment: {{ segOne }}<br><font size="1" color="#d1d1d1">2-28-2016 11:12</font></div>
				</div>
				<div class="box-entry">
					<div class="box-entry-text" >Translation completed for segment: {{ segTwo }}<br><font size="1" color="#d1d1d1">2-28-2016 11:03</font></div>
				</div>
				
			</div>
			
			
			<div class="pr-pie-box" ng-controller="DoughnutCtrl">
				<div class="box-head">
				Performance
				</div>
				<div class="box-body">

						 <canvas id="doughnut" class="chart chart-doughnut" chart-data="data" chart-labels="labels"></canvas>
						 <div class="chart-data">
							<font color="#4D5360">Completed: {{ data[0] }}</font>
							<font color="#949FB1">Returned: {{ data[1] }}</font>
						</div>
				</div>
				<div class="box-foot"><button ng-click="twoWeeks()" class="chart-button">2 Weeks</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <button ng-click="allTime()" class="chart-button">All Time</button></div>
			</div>
			

			
			<div class="line-chart-box"  ng-controller="LineCtrl">
				<div class="box-head">
					Translation Index
				</div>
				<div class="misc-body" style="padding: 5px;">
					<canvas id="line" class="chart chart-line" chart-data="data" 
						chart-labels="labels" chart-legend="false" 
							chart-series="series" chart-click="onClick" height="100%">
					</canvas>
				</div>
		</div>
		
	</div>
</div>
</body>
</html>