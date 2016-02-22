<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MotionPoint: Port</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/main.css" />">
<script src="//cdnjs.cloudflare.com/ajax/libs/angular.js/1.3.16/angular.min.js"></script>
<script src=<c:url value="/resources/js/port.js" />></script> 

</head>
<body data-ng-app="portApp">

<div data-ng-controller="portController" data-ng-init="init('<c:url value="/api/client/all" />')" class="ft-container">
		you have access to:
</div>

</body>
</html>