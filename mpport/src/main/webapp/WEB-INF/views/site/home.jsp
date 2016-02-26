<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MP: EntryPoint</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/main.css" />">
<script src="//cdnjs.cloudflare.com/ajax/libs/angular.js/1.3.16/angular.min.js"></script>
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
			<div class="top-top-bar">
				<div class="top-bar-box">
					<div class="cb-box-wrapper">
						<div class="client-bar-box" style="background-image: url(<c:url value="/resources/images/logos/mp-ast.png" />)">
						</div>
						<div style="height: 20px">&nbsp;</div>
					</div>
				</div>
				<div class="top-bar-box">
					<div class="cb-box-wrapper">
						<div class="client-bar-box" style="background-image: url(http://morrisontool.com/wordpress/wp-content/uploads/logo-tesla.png)">
						</div>
						<div style="height: 20px">Tesla</div>
					</div>
				</div>
				<div class="top-bar-box" data-ng-repeat="entry in data">
					<div class="cb-box-wrapper">
						<div class="client-bar-box" style="background-image: url(<c:url value="/resources/images/logos/" />{{ entry.slug }}.png)">
							<a href="<c:url value="/transcribe/"/>{{ entry.slug }}"></a>
						</div>
					<div style="height: 20px">{{ entry.clientName }}</div>
				</div>
				</div>
			</div>
			<div class="top-account-bar">
				Account
			</div>
			
		</div>
		<div class="performance-container">
			<div class="pr-pie-box">
			</div>
			<div class="recent-task-box"></div>
			<div class="misc-box"></div>
			<div class="misc-box"></div>
		</div>
		
	</div>
</div>
</body>
</html>