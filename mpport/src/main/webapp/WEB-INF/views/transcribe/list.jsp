<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MP:Workbench</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/ttapi.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/loader.css" />">
<script src="//cdnjs.cloudflare.com/ajax/libs/angular.js/1.3.16/angular.min.js"></script>
<script src="<c:url value="/resources/js/ttapp.js" />"></script> 
<script src="<c:url value="/resources/js/ckeditor/ckeditor.js" />"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/textAngular/1.5.0/textAngular.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/textAngular/1.5.0/textAngular-rangy.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/textAngular/1.5.0/textAngular-sanitize.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/textAngular/1.5.0/textAngular.css">
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css">

    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css">

</head>
<body data-ng-app="ttApp">
<div class="ft-wrapper">
<div class="ft-top-nav">
	<div class="ft-top-logo"></div>
	<div class="title"> <a href="<c:url value="/" />"> IMAGEBENCH</a></div>
	
			<div class="account-box">
				<table><tr><td><img src="../resources/images/me.jpg" height="30" /></td><td>
				<a href=""><font color="#0099e0"> Matthew</font></a><br>
				MotionPoint<br/>
				</td></tr>
				</table>
			</div>
</div>

<div data-ng-controller="ApiController" data-ng-init="init('${apiLocation}/api/ft/start/0/end/25')" class="ft-container">
  <div ng-controller="FileController">
	<div class="ft-work-box" ng-show="showEditor">
		<div class="ft-work-image-box">
			<div class="ft-editor-loading" ng-show="editorLoading">
				<table width="100%" height="100%">
				<tr><td valign="center" align="center">
					<div class="loader">
						<div class="loader__bar"></div>
						<div class="loader__bar"></div>
						<div class="loader__bar"></div>
						<div class="loader__bar"></div>
						<div class="loader__bar"></div>
						<div class="loader__ball"></div>
					</div>
				</td></tr>
				<tr><td height="20%"></td></tr>
				</table>
			</div>
		<table width="100%" height="100%">
			<tr>
			<td valign="center">
				<img src="{{ imgUrl }}" class="ft-work-image" ng-click="showEditor = false">
			</td>
			</tr>
		</table>
		</div>
		<div class="ft-work-editors">
		 <div class="ft-detail-transcription">
			<textarea data-ng-model="transcriptionText" data-ck-editor></textarea>
			<div class="ft-button-wrapper">
				<div class="ft-glossary-box">GLOSSARY</div>
				<div class="ft-pad"></div>
				<button type="button" class="ts-button" ng-click="submitTranscription('<c:url value="${apiLocation}/api/transcription/create/" />', transcriptionId, transcriptionText, checksumId)">TRANSCRIPTION <font color="#b2c9de">EN</font></button>
				<div class="ft-pad"></div>
				<div class="ft-word-count-box">{{ transcriptionWordCount }} w</div>
			</div>
		</div>
		<div class="ft-detail-translation">
			<textarea data-ng-model="translationText" data-ck-editor></textarea>
			<div class="ft-button-wrapper">
				<div class="ft-glossary-box">RULES</div>
				<div class="ft-pad"></div>
				<button type="button" class="button-full" ng-click="submitTranslation('<c:url value="${apiLocation}/api/translation/create/" />', translationText, transcriptionId)">TRANSLATION <font color="#b2c9de">ES</font></button>
				<div class="ft-pad"></div>
				<div class="ft-word-count-box">{{ translationWordCount }} w</div>
			</div>
	  	</div>
		</div>
	</div>
<div class="ft-loading" ng-show="loading">
	<table width="100%" height="100%">
	<tr><td valign="center" align="center">
		<div class="loader">
			<div class="loader__bar"></div>
			<div class="loader__bar"></div>
			<div class="loader__bar"></div>
			<div class="loader__bar"></div>
			<div class="loader__bar"></div>
			<div class="loader__ball"></div>
		</div>
	</td></tr>
	<tr><td height="20%"></td></tr>
	</table>
</div>
  <div data-ng-show="data" class="ft-list" ng-class="{'has-editor': showEditor}">

  	<div data-ng-repeat="ft in data" class="ft-box" ng-click="setEditor('<c:url value="${apiLocation}/api/ic/get/transription/translation/" />', ft.checksumId, ft.originUrl, ft)">

  		<div class="ft-overlay"></div>

	  	<div ng-click="showDetails = !showDetails" class="ft-box-wrapper">
	  	<div ng-show="ft.hasTranscription && !ft.hasTranslation" class="ft-ts-ind"></div><div ng-show="ft.hasTranslation" class="ft-tl-ind"></div>
  			<table width="100%" height="100%" >
  				<tr>
  				<td valign="center">
  				<img ng-src="{{ ft.originUrl }}" class="ft-list-image"/>
  				</td>
  				</tr>
  			</table>
	  	</div>
  	</div>

  </div>


<div class="ft-bottom" ng-class="{'ft-admin-menu' : showAdminMenu }">
	<div class= "ft-bottom-top-bar">
	<button ng-click="enableAdminMenu()" class="button-bottom"><i class="material-icons" style="font-size: 23px;">&#xE5C7;</i></button>
	<button ng-click="loadMore('${apiLocation}', 25)" class="button-bottom"><i class="material-icons" style="font-size: 23px;">add_box</i></button>
	</div>
	<div style="padding: 50px; text-align: center; color: #f8f8f8;font-size: 18px;font-weight: 200;font-family: 'Roboto', sans-serif;" ng-show="showAdminMenu && assignedImages.length == 0">Please Select Images for Assignment</div>
	<div class="ft-bottom-bottom-bar" ng-show="showAdminMenu && assignedImages.length > 0">
		<div class="admin-image-list">
			<div ng-repeat="imgUrl in assignedImages" class="admin-image-entry" ng-click="removeImageUrl(imgUrl)">
				<img src="{{ imgUrl }}" class="admin-image">
			</div>
		</div>
		<div class="admin-options" ng-init="tab=0">
		<div class="tstl" ng-show="assignedImages.length > 0" ng-click="tab = 1" ng-class="{'option-active': tab == 1}">TRANSCRIBE</div>
		<div class="tstl" ng-show="assignedImages.length > 0" ng-click="tab = 2" ng-class="{'option-active': tab == 2}">TRANSLATE</div>
		
		</div>
		<div class="admin-users" ng-show="assignedImages.length > 0">
		<table height="100%" width="100%">
		<tr>
			<td>
			<a href="">Enrique Del Sol</a><br/>
			<a href="">Tom Shooter</a><br/>
			<a href="">Darrius Serval</a><br/>
			<a href="">Manuel Jimmies</a><br/>
			<a href="">Value Saucer</a><br/>
			<a href="">Meena Rlongname</a><br/>
			<a href="">Collin Kaepernick</a><br/>
			<a href="">Lester Parry</a><br/>
			</td>
			<td>
			<a href="">Todd Michelin</a><br/>
			<a href="">Nick Yin</a><br/>
			<a href="">Tim Yang</a><br/>
			<a href="">Brian Yoyo</a><br/>
			<a href="">Ashley Bubba</a><br/>
			<a href="">Jon Avast</a><br/>
			<a href="">Yonas Clipper</a><br/>
			<a href="">Kent Hovind</a><br/>
			</td>
			<td>
			<a href="">Benjamin Fold</a><br/>
			<a href="">Eric Field</a><br/>
			<a href="">Claudia Albatross</a><br/>
			<a href="">Dave Jukes</a><br/>
			<a href="">Ian Salisbury</a><br/>
			<a href="">Isa Isa</a><br/>
			<a href="">Brenda Frazier</a><br/>
			<a href="">Chip and Dale</a><br/>
			</td>
			
		</tr>
		</table>
		</div>
	</div>
</div>
</div>
</div>
</div>
</body>
</html>