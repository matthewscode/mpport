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

</head>
<body data-ng-app="ttApp">
<div class="ft-wrapper">
<div class="ft-top-nav">
	<div class="ft-top-logo"></div>
	<div class="title"><a href="<c:url value="/" />">WORKBENCH</a></div>
</div>

<div data-ng-controller="ApiController" data-ng-init="init('${apiLocation}/api/ft/all')" class="ft-container">
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
				<button  type="button" class="ts-button" ng-click="submitTranscription('<c:url value="${apiLocation}/api/transcription/create/" />', transcriptionId, transcriptionText, checksumId)">TRANSCRIPTION <font color="#b2c9de">EN</font></button>
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
  <div data-ng-show="data" class="ft-list"  ng-class="{'has-editor': showEditor}">

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
</div>

<div class="ft-bottom">
	<center><button ng-click="loadMore(25)">load more</button>
	</center>
</div>
</div>
</div>
</body>
</html>