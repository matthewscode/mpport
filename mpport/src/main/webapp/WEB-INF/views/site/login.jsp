<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login MP:Workbench</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/main.css" />">
</head>
<body>
<c:url value="/login" var="loginUrl" />
<div class="login-bg" style="background: url(<c:url value="/resources/images/login-1.jpg" />)no-repeat center center fixed;">

</div>
<div class="login-wrapper">
	<div class="login-filler"></div>
	<div class="form-box">
		<form name="loginForm" action="<c:url value="j_spring_security_check" />" method="POST">
		<table cellspacing="0" cellpadding="0">
			<tr>
			<td>
			<table cellspacing="0" cellpadding="0">
			<tr><td>
			<input class="text-box" type='text' name='username' placeholder="username"></td>
			</tr>
			<tr><td>
			<input class="text-box" type='password' name='password' placeholder="password"/>
			</td></tr>
			</table>
			<td>
			<button type="submit" class="login-button"></button>
			</td>
			</tr>
		</table>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			
		</form>
	</div>
	<div class="login-filler"></div>
	
</div>
</body>
</html>